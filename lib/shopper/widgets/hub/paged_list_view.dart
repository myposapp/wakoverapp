import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/model/paginated_response.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/network/network_repo.dart';

import 'hub_states.dart';

typedef PageFetcher<T> =
    Future<PaginatedResponse<T>> Function(ShopperNetworkRepo repo, int page);

/// An infinitely scrolling, pull-to-refresh list over one of the store's
/// paginated endpoints (pages are 0-indexed). Handles the signed-out,
/// no-store, empty and error states so each hub screen only renders items.
class PagedListView<T> extends StatefulWidget {
  const PagedListView({
    super.key,
    required this.fetchPage,
    required this.itemBuilder,
    required this.emptyState,
    required this.feature,
    this.header,
    this.requiresSignIn = true,
    this.pageSize = 10,
  });

  final PageFetcher<T> fetchPage;
  final Widget Function(BuildContext context, T item) itemBuilder;
  final Widget emptyState;

  /// Plural noun for the signed-out message, e.g. "orders".
  final String feature;

  /// Scrolls with the list, above the items (and above the empty state).
  final Widget? header;
  final bool requiresSignIn;
  final int pageSize;

  @override
  State<PagedListView<T>> createState() => PagedListViewState<T>();
}

class PagedListViewState<T> extends State<PagedListView<T>> {
  final _scrollController = ScrollController();
  final List<T> _items = [];
  int _nextPage = 0;
  bool _hasMore = true;
  bool _isLoading = false;
  bool _isSignedOut = false;
  String? _error;

  List<T> get items => List.unmodifiable(_items);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    WidgetsBinding.instance.addPostFrameCallback((_) => refresh());
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 240) _loadNextPage();
  }

  Future<void> refresh() async {
    setState(() {
      _items.clear();
      _nextPage = 0;
      _hasMore = true;
      _error = null;
      _isSignedOut = false;
    });
    await _loadNextPage();
  }

  /// Replaces items in place after a local change (e.g. a posted review).
  void updateWhere(bool Function(T item) test, T Function(T item) update) {
    setState(() {
      for (var i = 0; i < _items.length; i++) {
        if (test(_items[i])) _items[i] = update(_items[i]);
      }
    });
  }

  Future<void> _loadNextPage() async {
    if (_isLoading || !_hasMore) return;

    final network = context.read<NetworkProvider>();
    if (network.storeOrigin == null) return;
    if (widget.requiresSignIn && !network.isSignedIn) {
      setState(() => _isSignedOut = true);
      return;
    }

    setState(() => _isLoading = true);
    try {
      final response = await widget.fetchPage(
        network.shopperNetworkRepo,
        _nextPage,
      );
      if (!mounted) return;

      if (response.success != true) {
        setState(() {
          if (_isAuthError(response.message)) {
            _isSignedOut = true;
          } else {
            _error = response.message ?? 'Failed to load ${widget.feature}.';
          }
        });
        return;
      }

      final data = response.data ?? [];
      final totalPages = response.metaData?.totalPages;
      setState(() {
        _items.addAll(data);
        _nextPage++;
        _hasMore = totalPages != null
            ? _nextPage < totalPages
            : data.length >= widget.pageSize;
      });
    } catch (e) {
      if (mounted) setState(() => _error = e.toString());
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  static bool _isAuthError(String? message) {
    final text = message?.toLowerCase() ?? '';
    return text.contains('no token') ||
        text.contains('unauthori') ||
        text.contains('token expired') ||
        text.contains('invalid token');
  }

  @override
  Widget build(BuildContext context) {
    final network = context.read<NetworkProvider>();
    final header = widget.header;

    Widget? fullState;
    if (network.storeOrigin == null) {
      fullState = const HubNoStoreState();
    } else if (_isSignedOut) {
      fullState = HubSignedOutState(
        feature: widget.feature,
        onSignedIn: refresh,
      );
    } else if (_error != null && _items.isEmpty) {
      fullState = HubErrorState(message: _error!, onRetry: refresh);
    } else if (_items.isEmpty && !_hasMore && !_isLoading) {
      fullState = widget.emptyState;
    } else if (_items.isEmpty) {
      fullState = const Padding(
        padding: EdgeInsets.all(48),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final itemCount =
        (header != null ? 1 : 0) +
        (fullState != null ? 1 : _items.length) +
        (fullState == null && (_hasMore || _error != null) ? 1 : 0);

    return RefreshIndicator(
      onRefresh: refresh,
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (header != null) {
            if (index == 0) return header;
            index--;
          }
          if (fullState != null) return fullState;
          if (index < _items.length) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: widget.itemBuilder(context, _items[index]),
            );
          }
          // A short first page can't be scrolled, so reaching the footer is
          // what triggers the next load.
          if (_error == null && !_isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _loadNextPage();
            });
          }
          return _buildFooter();
        },
      ),
    );
  }

  Widget _buildFooter() {
    if (_error != null) {
      return Center(
        child: TextButton.icon(
          onPressed: () {
            setState(() => _error = null);
            _loadNextPage();
          },
          icon: const Icon(Icons.refresh_rounded, size: 16),
          label: const Text('Couldn\'t load more. Tap to retry.'),
        ),
      );
    }
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2),
        ),
      ),
    );
  }
}
