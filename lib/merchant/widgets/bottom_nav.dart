import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../theme/app_theme.dart';

class MerchantBottomNavBar extends StatelessWidget {
  final String activeRoute;

  const MerchantBottomNavBar({super.key, required this.activeRoute});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(top: BorderSide(color: Colors.black.withOpacity(0.06))),
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
