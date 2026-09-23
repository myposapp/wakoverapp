import 'package:flutter/material.dart';
import 'package:wakover/shopper/widgets/bottom_nav_bar.dart';
import '../../theme/app_theme.dart';

class ComingSoonScreen extends StatelessWidget {
  final String activeRoute;
  final String title;
  final String subtitle;
  final IconData icon;

  const ComingSoonScreen({
    super.key,
    required this.activeRoute,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 36, color: AppTheme.primaryBlue),
                ),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: AppTheme.navyDark,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'COMING SOON',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.grey.shade600,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BuyerBottomNavBar(activeRoute: activeRoute),
    );
  }
}
