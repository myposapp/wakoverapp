import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakover/shopper/widgets/bottom_nav_bar.dart';
import 'package:wakover/shopper/widgets/cart.dart';
import '../../providers/app_provider.dart';
import '../../theme/app_theme.dart';

class _HubAction {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final int? badgeCount;

  _HubAction({
    required this.label,
    required this.icon,
    required this.onTap,
    this.badgeCount,
  });
}

class BuyerHubScreen extends StatelessWidget {
  const BuyerHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    final actions = <_HubAction>[
      _HubAction(
        label: 'Saved',
        icon: Icons.bookmark_border_rounded,
        onTap: () => provider.showToast('Saved is not available yet.'),
      ),
      _HubAction(
        label: 'Cart',
        icon: Icons.shopping_bag_outlined,
        badgeCount: provider.cartCount,
        onTap: () => _openCart(context),
      ),
      _HubAction(
        label: 'Orders',
        icon: Icons.receipt_long_rounded,
        onTap: () => provider.showToast('Orders is not available yet.'),
      ),
      _HubAction(
        label: 'Bookings',
        icon: Icons.event_available_rounded,
        onTap: () => provider.showToast('Bookings is not available yet.'),
      ),
      _HubAction(
        label: 'Payment',
        icon: Icons.credit_card_rounded,
        onTap: () => provider.showToast('Payment is not available yet.'),
      ),
      _HubAction(
        label: 'Affiliate Codes',
        icon: Icons.percent_rounded,
        onTap: () =>
            provider.showToast('Affiliate Codes is not available yet.'),
      ),
      _HubAction(
        label: 'Transactions',
        icon: Icons.swap_horiz_rounded,
        onTap: () => provider.showToast('Transactions is not available yet.'),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Hub')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Banner
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.navyDark,
                      Color(0xFF102468),
                      AppTheme.primaryBlue,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white12,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.apps_rounded,
                            size: 12,
                            color: AppTheme.accentCyan,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'YOUR HUB',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 9,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Everything Buyer, In One Place',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Manage your saved items, orders, bookings and payments for this merchant.',
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: actions.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.35,
                ),
                itemBuilder: (context, idx) =>
                    _buildHubCard(context, actions[idx]),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BuyerBottomNavBar(activeRoute: 'buyer_hub'),
    );
  }

  Widget _buildHubCard(BuildContext context, _HubAction action) {
    return InkWell(
      onTap: action.onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.black.withValues(alpha: .06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Badge(
                isLabelVisible: (action.badgeCount ?? 0) > 0,
                label: Text('${action.badgeCount}'),
                backgroundColor: AppTheme.primaryBlue,
                child: Icon(action.icon, color: AppTheme.primaryBlue, size: 20),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              action.label,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  void _openCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const CartSheet(),
    );
  }
}
