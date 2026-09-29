import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/router/app_routes.dart';
import 'package:wakover/shopper/models/merchant_info_model.dart';
import 'package:wakover/shopper/models/site_config_model.dart';
import 'package:wakover/shopper/models/site_content_model.dart';
import 'package:wakover/shopper/models/store_product_model.dart';
import 'package:wakover/shopper/providers/cart_provider.dart';
import 'package:wakover/shopper/repositories/saved_items_repository.dart';
import 'package:wakover/shopper/widgets/cart.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/theme/app_theme.dart';

import 'widgets/product_widgets.dart';

enum _SortOption {
  newest('newest', 'Newest'),
  priceAsc('price-asc', 'Affordable'),
  priceDesc('price-dsc', 'Premium');

  const _SortOption(this.value, this.label);

  final String value;
  final String label;
}

/// The connected store's catalog: its banner, highlights and products.
class BuyerStorefrontScreen extends StatefulWidget {
  const BuyerStorefrontScreen({super.key});

  @override
  State<BuyerStorefrontScreen> createState() => _BuyerStorefrontScreenState();
}

class _BuyerStorefrontScreenState extends State<BuyerStorefrontScreen> {
  // Ids of products saved for the current user and store.
  late Stream<Set<String>> _savedIds = _watchSavedIds();
  late final ValueNotifier<String?> _originListenable = context
      .read<NetworkProvider>()
      .storeOriginListenable;

  final _searchController = TextEditingController();
  Timer? _searchDebounce;

  SiteConfig? _config;
  SiteContent? _content;
  List<StoreProduct>? _products;
  String? _productsError;
  bool _isLoadingProducts = false;
  String _search = '';
  _SortOption _sort = _SortOption.newest;

  String? get _origin => context.read<NetworkProvider>().storeOrigin;

  @override
  void initState() {
    super.initState();
    _originListenable.addListener(_onStoreChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) => _refresh());
  }

  @override
  void dispose() {
    _originListenable.removeListener(_onStoreChanged);
    _searchDebounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  Stream<Set<String>> _watchSavedIds() => context
      .read<SavedItemsRepository>()
      .watchSavedItems()
      .map((items) => items.map((item) => item.productId).toSet());

  /// This tab stays alive in the shell, so reset when another store is
  /// connected.
  void _onStoreChanged() {
    _searchDebounce?.cancel();
    _searchController.clear();
    setState(() {
      _config = null;
      _content = null;
      _products = null;
      _productsError = null;
      _search = '';
      _sort = _SortOption.newest;
      _savedIds = _watchSavedIds();
    });
    _refresh();
  }

  Future<void> _refresh() async {
    if (_origin == null) return;
    context.read<CartProvider>().load();
    await Future.wait([_loadStore(), _loadProducts()]);
  }

  Future<void> _loadStore() async {
    final repo = context.read<NetworkProvider>().shopperNetworkRepo;
    try {
      final (config, content) = await (
        repo.getSiteConfig(),
        repo.getSiteContent(),
      ).wait;
      if (!mounted) return;
      setState(() {
        _config = config.data ?? _config;
        _content = content.data ?? _content;
      });
    } catch (_) {
      // The header falls back to the store address; products still load.
    }
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoadingProducts = true;
      _productsError = null;
    });
    final search = _search;
    final sort = _sort;
    try {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final response = await repo.getProducts(
        pageSize: 100,
        search: search.isEmpty ? null : search,
        sort: sort.value,
      );
      // Drop responses for a search/sort the user has since changed.
      if (!mounted || search != _search || sort != _sort) return;
      setState(() {
        if (response.success == true) {
          _products = response.data ?? [];
        } else {
          _productsError = response.message ?? 'Could not load products.';
        }
      });
    } catch (e) {
      if (mounted) setState(() => _productsError = e.toString());
    } finally {
      if (mounted) setState(() => _isLoadingProducts = false);
    }
  }

  void _onSearchChanged(String value) {
    _searchDebounce?.cancel();
    _searchDebounce = Timer(const Duration(milliseconds: 400), () {
      if (value.trim() == _search) return;
      setState(() => _search = value.trim());
      _loadProducts();
    });
  }

  void _onSortChanged(_SortOption sort) {
    if (sort == _sort) return;
    setState(() => _sort = sort);
    _loadProducts();
  }

  void _openProduct(StoreProduct product) {
    final id = product.id;
    if (id != null) context.go(AppRoutes.product(id), extra: product);
  }

  MerchantBranch? get _branch {
    final branches = _config?.branches;
    if (branches == null || branches.isEmpty || branches.first is! Map) {
      return null;
    }
    return MerchantBranchMapper.fromMap(
      Map<String, dynamic>.from(branches.first as Map),
    );
  }

  String get _storeName {
    final name = (_config?.storeName ?? _content?.config?.storeName)?.trim();
    if (name != null && name.isNotEmpty) return name;
    return Uri.tryParse(_origin ?? '')?.host ?? 'Store';
  }

  @override
  Widget build(BuildContext context) {
    final origin = _origin;
    if (origin == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Catalog')),
        body: HubMessage(
          icon: Icons.storefront_outlined,
          title: 'No store connected',
          message: 'Scan a store QR code or enter its web address to browse.',
          actionLabel: 'Find a store',
          onAction: () => context.push(AppRoutes.marketplace),
        ),
      );
    }

    final cartCount = context.select<CartProvider, int>((c) => c.itemCount);
    final host = Uri.tryParse(origin)?.host ?? origin;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => context.push(AppRoutes.marketplace),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: hubTint(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.lock_rounded, size: 12, color: Colors.green),
                const SizedBox(width: 4),
                Flexible(
                  child: Text(
                    host,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(Icons.expand_more_rounded, size: 14),
              ],
            ),
          ),
        ),
        actions: [
          IconButton(
            tooltip: 'Your bag',
            icon: Badge(
              isLabelVisible: cartCount > 0,
              label: Text('$cartCount'),
              backgroundColor: AppTheme.primaryBlue,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            onPressed: () => showCartSheet(context),
          ),
        ],
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: _refresh,
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: _StoreHeader(
                  storeName: _storeName,
                  slides: _content?.heroSlides ?? const [],
                  branch: _branch,
                  productCount: _config?.totalProducts,
                  onShare: () => _copyLink(context, origin),
                ),
              ),
              if (_content?.promoBanner?.title != null)
                SliverToBoxAdapter(
                  child: _PromoBanner(banner: _content!.promoBanner!),
                ),
              if (_content?.specialPicks?.isNotEmpty == true)
                SliverToBoxAdapter(
                  child: _SpecialPicks(picks: _content!.specialPicks!),
                ),
              SliverToBoxAdapter(child: _buildSearchAndSort()),
              _buildProducts(),
              const SliverToBoxAdapter(child: SizedBox(height: 24)),
            ],
          ),
        ),
      ),
    );
  }

  void _copyLink(BuildContext context, String origin) {
    Clipboard.setData(ClipboardData(text: origin));
    showHubSnack(context, 'Store link copied');
  }

  Widget _buildSearchAndSort() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Products',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 8),
              if (_products != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 7,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: hubTint(context),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    '${_products!.length}',
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryBlue,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: hubBorder(context)),
            ),
            child: Row(
              children: [
                const Icon(Icons.search_rounded, size: 20, color: Colors.grey),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onChanged: _onSearchChanged,
                    textInputAction: TextInputAction.search,
                    decoration: const InputDecoration(
                      hintText: 'Search this store...',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                if (_searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      _searchController.clear();
                      _onSearchChanged('');
                      setState(() {});
                    },
                    child: const Icon(
                      Icons.close_rounded,
                      size: 18,
                      color: Colors.grey,
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            children: [
              for (final option in _SortOption.values)
                ChoiceChip(
                  label: Text(option.label),
                  selected: _sort == option,
                  onSelected: (_) => _onSortChanged(option),
                  showCheckmark: false,
                  labelStyle: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: _sort == option ? Colors.white : null,
                  ),
                  selectedColor: AppTheme.navyDark,
                  backgroundColor: Theme.of(context).cardColor,
                  side: BorderSide(color: hubBorder(context)),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProducts() {
    final products = _products;

    if (products == null && _productsError != null) {
      return SliverToBoxAdapter(
        child: HubErrorState(message: _productsError!, onRetry: _loadProducts),
      );
    }
    if (products == null || (_isLoadingProducts && products.isEmpty)) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(48),
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    if (products.isEmpty) {
      return SliverToBoxAdapter(
        child: HubMessage(
          icon: Icons.inventory_2_outlined,
          title: _search.isEmpty ? 'No products yet' : 'No matches',
          message: _search.isEmpty
              ? 'This store hasn\'t listed any products.'
              : 'Nothing matches "$_search". Try another search.',
        ),
      );
    }

    return StreamBuilder<Set<String>>(
      stream: _savedIds,
      builder: (context, snapshot) {
        final savedIds = snapshot.data ?? const <String>{};
        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverGrid.builder(
            itemCount: products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.56,
            ),
            itemBuilder: (context, index) {
              final product = products[index];
              return AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: _isLoadingProducts ? 0.5 : 1,
                child: ProductCard(
                  product: product,
                  isSaved: savedIds.contains(product.id),
                  onTap: () => _openProduct(product),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _StoreHeader extends StatelessWidget {
  const _StoreHeader({
    required this.storeName,
    required this.slides,
    required this.branch,
    required this.productCount,
    required this.onShare,
  });

  final String storeName;
  final List<HeroSlide> slides;
  final MerchantBranch? branch;
  final int? productCount;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    final initial = storeName.isNotEmpty ? storeName[0].toUpperCase() : 'W';
    final phone = branch?.phone;
    final address = branch?.address;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: SizedBox(
                  height: 168,
                  width: double.infinity,
                  child: slides.isEmpty
                      ? _GradientBanner(initial: initial)
                      : _HeroCarousel(slides: slides),
                ),
              ),
              Positioned(
                bottom: -30,
                left: 18,
                child: Container(
                  width: 68,
                  height: 68,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppTheme.navyDark,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      initial,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 38),
          Row(
            children: [
              Flexible(
                child: Text(
                  storeName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.verified_rounded,
                size: 18,
                color: AppTheme.primaryBlue,
              ),
            ],
          ),
          if (address != null && address.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(
                  Icons.location_on_outlined,
                  size: 14,
                  color: hubMutedText(context),
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    address,
                    style: TextStyle(
                      fontSize: 12,
                      color: hubMutedText(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: hubTint(context),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _Stat(
                  icon: Icons.inventory_2_outlined,
                  value: '${productCount ?? '—'}',
                  label: 'Products',
                ),
                const _StatDivider(),
                _Stat(
                  icon: Icons.chat_outlined,
                  value: phone == null ? '—' : 'Chat',
                  label: 'Contact',
                  onTap: phone == null
                      ? null
                      : () => contactBusiness(context, phone),
                ),
                const _StatDivider(),
                _Stat(
                  icon: Icons.ios_share_rounded,
                  value: 'Share',
                  label: 'Store link',
                  onTap: onShare,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GradientBanner extends StatelessWidget {
  const _GradientBanner({required this.initial});

  final String initial;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.navyDark, Color(0xFF102468), AppTheme.primaryBlue],
        ),
      ),
      alignment: Alignment.center,
      child: Text(
        initial,
        style: TextStyle(
          color: Colors.white.withValues(alpha: .08),
          fontSize: 110,
          fontWeight: FontWeight.w900,
        ),
      ),
    );
  }
}

/// Auto-advancing hero slides with a caption and page dots.
class _HeroCarousel extends StatefulWidget {
  const _HeroCarousel({required this.slides});

  final List<HeroSlide> slides;

  @override
  State<_HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<_HeroCarousel> {
  final _controller = PageController();
  Timer? _timer;
  int _page = 0;

  @override
  void initState() {
    super.initState();
    if (widget.slides.length > 1) {
      _timer = Timer.periodic(const Duration(seconds: 5), (_) {
        if (!_controller.hasClients) return;
        final next = (_page + 1) % widget.slides.length;
        _controller.animateToPage(
          next,
          duration: const Duration(milliseconds: 450),
          curve: Curves.easeOutCubic,
        );
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          controller: _controller,
          itemCount: widget.slides.length,
          onPageChanged: (page) => setState(() => _page = page),
          itemBuilder: (context, index) {
            final slide = widget.slides[index];
            return Stack(
              fit: StackFit.expand,
              children: [
                LayoutBuilder(
                  builder: (context, constraints) => HubImage(
                    path: slide.image,
                    size: constraints.maxWidth,
                    height: constraints.maxHeight,
                    radius: 0,
                    fallbackIcon: Icons.storefront_rounded,
                  ),
                ),
                const DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Color(0xCC0B1948)],
                      stops: [0.35, 1],
                    ),
                  ),
                ),
                if (slide.title != null)
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (slide.eyebrow != null)
                          Text(
                            slide.eyebrow!.toUpperCase(),
                            style: const TextStyle(
                              color: AppTheme.accentCyan,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        Text(
                          slide.title!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            );
          },
        ),
        if (widget.slides.length > 1)
          Positioned(
            right: 14,
            bottom: 10,
            child: Row(
              children: [
                for (var i = 0; i < widget.slides.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.only(left: 4),
                    width: i == _page ? 16 : 6,
                    height: 6,
                    decoration: BoxDecoration(
                      color: i == _page ? Colors.white : Colors.white38,
                      borderRadius: BorderRadius.circular(3),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Stat extends StatelessWidget {
  const _Stat({
    required this.icon,
    required this.value,
    required this.label,
    this.onTap,
  });

  final IconData icon;
  final String value;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            Icon(icon, size: 16, color: AppTheme.primaryBlue),
            const SizedBox(height: 4),
            Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 9, color: hubMutedText(context)),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(width: 1, height: 30, color: hubBorder(context));
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner({required this.banner});

  final PromoBanner banner;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: () => showHubSheet(
          context,
          title: banner.title ?? '',
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (banner.image != null)
                LayoutBuilder(
                  builder: (context, constraints) => HubImage(
                    path: banner.image,
                    size: constraints.maxWidth,
                    height: 180,
                    radius: 16,
                  ),
                ),
              const SizedBox(height: 14),
              Text(
                banner.description ?? '',
                style: const TextStyle(fontSize: 13, height: 1.5),
              ),
            ],
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: Theme.of(context).brightness == Brightness.dark
                  ? [
                      AppTheme.accentBlue.withValues(alpha: 0.22),
                      AppTheme.accentBlue.withValues(alpha: 0.1),
                    ]
                  : const [Color(0xFFDCE1FF), Color(0xFFEFF4FF)],
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          child: Row(
            children: [
              HubImage(
                path: banner.image,
                size: 56,
                radius: 12,
                fallbackIcon: Icons.stars_rounded,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      banner.title!,
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      banner.description ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: 11,
                        color: hubMutedText(context),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                color: AppTheme.primaryBlue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SpecialPicks extends StatelessWidget {
  const _SpecialPicks({required this.picks});

  final List<SpecialPick> picks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 20, 16, 10),
          child: Text(
            'Special Picks',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          height: 150,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: picks.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (context, index) {
              final pick = picks[index];
              return InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => showHubSheet(
                  context,
                  title: pick.title ?? 'Special Pick',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) => HubImage(
                          path: pick.image,
                          size: constraints.maxWidth,
                          height: 200,
                          radius: 16,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        pick.description ?? '',
                        style: const TextStyle(fontSize: 13, height: 1.5),
                      ),
                    ],
                  ),
                ),
                child: SizedBox(
                  width: 220,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        HubImage(
                          path: pick.image,
                          size: 220,
                          height: 150,
                          radius: 0,
                        ),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [Colors.transparent, Color(0xCC0B1948)],
                              stops: [0.4, 1],
                            ),
                          ),
                        ),
                        Positioned(
                          left: 12,
                          right: 12,
                          bottom: 10,
                          child: Text(
                            pick.title ?? '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
