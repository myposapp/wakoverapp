import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wakover/router/app_router.dart';
import '../../theme/app_theme.dart';

class BuyerBottomNavBar extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const BuyerBottomNavBar({super.key, required this.navigationShell});

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
        border: Border(
          top: BorderSide(color: Colors.black.withValues(alpha: 0.06)),
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
                isActive: activeTab == BuyerTab.web,
                onTap: () => _select(BuyerTab.web),
              ),
              _buildItem(
                context,
                icon: Icons.grid_view_rounded,
                label: 'Catalog',
                isActive: activeTab == BuyerTab.catalog,
                onTap: () => _select(BuyerTab.catalog),
              ),
              /*_buildItem(
                context,
                icon: Icons.build_rounded,
                label: 'Utility',
                isActive: activeTab == BuyerTab.utility,
                onTap: () => _select(BuyerTab.utility),
              ),*/
              _buildItem(
                context,
                icon: Icons.dashboard_customize_rounded,
                label: 'Hub',
                isActive: activeTab == BuyerTab.hub,
                onTap: () => _select(BuyerTab.hub),
              ),
              _buildItem(
                context,
                icon: Icons.person_outline_rounded,
                label: 'Account',
                isActive: activeTab == BuyerTab.account,
                onTap: () => _select(BuyerTab.account),
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
