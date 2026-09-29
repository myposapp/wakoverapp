import 'package:flutter/material.dart';
import 'package:wakover/shopper/models/platform_order_model.dart';
import 'package:wakover/shopper/models/store_order_model.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/shopper/widgets/hub/paged_list_view.dart';

import 'widgets/platform_order_card.dart';
import 'widgets/store_order_card.dart';

/// The shopper's store orders plus their utility (digital goods) purchases,
/// which the API tracks separately as platform orders.
class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: initialTab,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          bottom: TabBar(
            labelColor: Theme.of(context).primaryColor,
            indicatorColor: Theme.of(context).primaryColor,
            indicatorSize: TabBarIndicatorSize.label,
            labelStyle: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            tabs: const [
              Tab(text: 'Store Orders'),
              Tab(text: 'Utility'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(children: [_StoreOrdersTab(), _UtilityOrdersTab()]),
        ),
      ),
    );
  }
}

class _StoreOrdersTab extends StatefulWidget {
  @override
  State<_StoreOrdersTab> createState() => _StoreOrdersTabState();
}

// Kept alive so switching tabs doesn't refetch.
class _StoreOrdersTabState extends State<_StoreOrdersTab>
    with AutomaticKeepAliveClientMixin {
  final _listKey = GlobalKey<PagedListViewState<StoreOrder>>();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PagedListView<StoreOrder>(
      key: _listKey,
      feature: 'orders',
      fetchPage: (repo, page) => repo.getOrders(page: page),
      emptyState: const HubMessage(
        icon: Icons.receipt_long_rounded,
        title: 'No orders yet',
        message: 'Your orders from this store will appear here.',
      ),
      itemBuilder: (context, order) => StoreOrderCard(
        order: order,
        onReviewed: (productId, review) => _listKey.currentState?.updateWhere(
          (o) => (o.items ?? []).any((i) => i.productId == productId),
          (o) => o.copyWith(
            items: o.items
                ?.map(
                  (i) => i.productId == productId
                      ? i.copyWith(review: review ?? true)
                      : i,
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}

class _UtilityOrdersTab extends StatefulWidget {
  @override
  State<_UtilityOrdersTab> createState() => _UtilityOrdersTabState();
}

class _UtilityOrdersTabState extends State<_UtilityOrdersTab>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return PagedListView<PlatformOrder>(
      feature: 'utility purchases',
      fetchPage: (repo, page) => repo.getPlatformOrders(page: page),
      emptyState: const HubMessage(
        icon: Icons.bolt_rounded,
        title: 'No utility purchases',
        message:
            'Airtime, data and electricity you buy from this store will '
            'appear here.',
      ),
      itemBuilder: (context, order) => PlatformOrderCard(order: order),
    );
  }
}
