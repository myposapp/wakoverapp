import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class MerchantBottomNavBar extends StatelessWidget {
  final String activeRoute;

  const MerchantBottomNavBar({super.key, required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(color: Colors.black.withOpacity(0.06)),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildItem(
                context,
                icon: Icons.dashboard_rounded,
                label: 'Dashboard',
                isActive: activeRoute == 'merchant_dashboard',
                onTap: () => provider.navigateTo('merchant_dashboard'),
              ),
              _buildItem(
                context,
                icon: Icons.inventory_2_rounded,
                label: 'Inventory',
                isActive: activeRoute == 'merchant_inventory',
                onTap: () => provider.navigateTo('merchant_inventory'),
              ),
              _buildItem(
                context,
                icon: Icons.receipt_long_rounded,
                label: 'Orders',
                isActive: activeRoute == 'merchant_orders',
                onTap: () => provider.navigateTo('merchant_orders'),
              ),
              _buildItem(
                context,
                icon: Icons.campaign_rounded,
                label: 'Campaigns',
                isActive: activeRoute == 'merchant_campaigns',
                onTap: () => provider.navigateTo('merchant_campaigns'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final color = isActive ? AppTheme.primaryBlue : Colors.grey.shade500;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuyerBottomNavBar extends StatelessWidget {
  final String activeRoute;

  const BuyerBottomNavBar({super.key, required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(
          top: BorderSide(color: Colors.black.withOpacity(0.06)),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildItem(
                context,
                icon: Icons.language_rounded,
                label: 'Web',
                isActive: activeRoute == 'buyer_web',
                onTap: () => provider.navigateTo('buyer_web'),
              ),
              _buildItem(
                context,
                icon: Icons.grid_view_rounded,
                label: 'Catalog',
                isActive: activeRoute == 'buyer_storefront',
                onTap: () => provider.navigateTo('buyer_storefront'),
              ),
              _buildItem(
                context,
                icon: Icons.build_rounded,
                label: 'Utility',
                isActive: activeRoute == 'buyer_utility',
                onTap: () => provider.navigateTo('buyer_utility'),
              ),
              _buildItem(
                context,
                icon: Icons.dashboard_customize_rounded,
                label: 'Hub',
                isActive: activeRoute == 'buyer_hub',
                onTap: () => provider.navigateTo('buyer_hub'),
              ),
              _buildItem(
                context,
                icon: Icons.person_outline_rounded,
                label: 'Account',
                isActive: activeRoute == 'buyer_account',
                onTap: () => provider.navigateTo('buyer_account'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    final color = isActive ? AppTheme.primaryBlue : Colors.grey.shade500;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(height: 3),
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 10,
                fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CartSheet extends StatelessWidget {
  const CartSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Apex Retail Bag',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '${provider.cartCount} items',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: provider.cart.isEmpty
                ? const Center(
                    child: Text('Your bag is currently empty.'),
                  )
                : ListView.separated(
                    itemCount: provider.cart.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, idx) {
                      final item = provider.cart[idx];
                      return Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                item.product.image,
                                width: 50,
                                height: 50,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                  Text(
                                    '\$${item.product.price.toStringAsFixed(2)}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 16),
                                  onPressed: () => provider.updateCartQuantity(
                                      item.product.id, item.quantity - 1),
                                ),
                                Text('${item.quantity}',
                                    style: const TextStyle(fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 16),
                                  onPressed: () => provider.updateCartQuantity(
                                      item.product.id, item.quantity + 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          if (provider.cart.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal', style: TextStyle(fontSize: 14)),
                Text(
                  '\$${provider.cartTotal.toStringAsFixed(2)}',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  provider.clearCart();
                  Navigator.pop(context);
                  provider.showToast('Payment Escrow secured • Order confirmed!');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text('Checkout • \$${provider.cartTotal.toStringAsFixed(2)}'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
