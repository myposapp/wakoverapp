import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wakover/router/app_router.dart';
import '../../theme/app_theme.dart';

class MerchantBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MerchantBottomNavBar({super.key, required this.navigationShell});

  // Tapping the current tab again pops it back to its first page.
  void _select(int tab) => navigationShell.goBranch(
    tab,
    initialLocation: tab == navigationShell.currentIndex,
  );

  @override
  Widget build(BuildContext context) {
    final activeTab = navigationShell.currentIndex;
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
                isActive: activeTab == MerchantTab.dashboard,
                onTap: () => _select(MerchantTab.dashboard),
              ),
              _buildItem(
                context,
                icon: Icons.inventory_2_rounded,
                label: 'Inventory',
                isActive: activeTab == MerchantTab.inventory,
                onTap: () => _select(MerchantTab.inventory),
              ),
              _buildItem(
                context,
                icon: Icons.receipt_long_rounded,
                label: 'Orders',
                isActive: activeTab == MerchantTab.orders,
                onTap: () => _select(MerchantTab.orders),
              ),
              _buildItem(
                context,
                icon: Icons.campaign_rounded,
                label: 'Campaigns',
                isActive: activeTab == MerchantTab.campaigns,
                onTap: () => _select(MerchantTab.campaigns),
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
