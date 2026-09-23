import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../theme/app_theme.dart';

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
