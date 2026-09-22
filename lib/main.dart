import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/app_provider.dart';
import 'theme/app_theme.dart';
import 'screens/splash_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/role_select_screen.dart';
import 'screens/connect_store_screen.dart';
import 'screens/merchant_dashboard_screen.dart';
import 'screens/merchant_inventory_screen.dart';
import 'screens/merchant_orders_screen.dart';
import 'screens/merchant_campaigns_screen.dart';
import 'screens/buyer_marketplace_screen.dart';
import 'screens/buyer_storefront_screen.dart';
import 'screens/buyer_hub_screen.dart';
import 'screens/buyer_account_screen.dart';
import 'screens/user_settings_screen.dart';
import 'screens/coming_soon_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: const WakoverCommerceApp(),
    ),
  );
}

class WakoverCommerceApp extends StatelessWidget {
  const WakoverCommerceApp({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return MaterialApp(
      title: 'Wakover Commerce',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: Scaffold(
        body: Stack(
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 260),
              switchInCurve: Curves.easeOutCubic,
              switchOutCurve: Curves.easeInCubic,
              transitionBuilder: (child, animation) {
                return FadeTransition(
                  opacity: animation,
                  child: SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(0, 0.04),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  ),
                );
              },
              child: _buildScreen(provider.currentRoute),
            ),

            // Top Toast Notification Banner
            if (provider.toastMessage != null)
              Positioned(
                top: 50,
                left: 20,
                right: 20,
                child: TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 250),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, (1 - value) * -20),
                        child: child,
                      ),
                    );
                  },
                  child: Material(
                    elevation: 8,
                    borderRadius: BorderRadius.circular(16),
                    color: AppTheme.navyDark,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      child: Row(
                        children: [
                          const Icon(Icons.check_circle_rounded,
                              color: AppTheme.accentCyan, size: 20),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              provider.toastMessage!,
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
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildScreen(String route) {
    switch (route) {
      case 'splash':
        return const SplashScreen(key: ValueKey('splash'));
      case 'onboarding':
        return const OnboardingScreen(key: ValueKey('onboarding'));
      case 'role_select':
        return const RoleSelectScreen(key: ValueKey('role_select'));
      case 'connect_store':
        return const ConnectStoreScreen(key: ValueKey('connect_store'));
      case 'merchant_dashboard':
        return const MerchantDashboardScreen(
            key: ValueKey('merchant_dashboard'));
      case 'merchant_inventory':
        return const MerchantInventoryScreen(
            key: ValueKey('merchant_inventory'));
      case 'merchant_orders':
        return const MerchantOrdersScreen(key: ValueKey('merchant_orders'));
      case 'merchant_campaigns':
        return const MerchantCampaignsScreen(
            key: ValueKey('merchant_campaigns'));
      case 'buyer_marketplace':
        return const BuyerMarketplaceScreen(
            key: ValueKey('buyer_marketplace'));
      case 'buyer_storefront':
        return const BuyerStorefrontScreen(key: ValueKey('buyer_storefront'));
      case 'buyer_hub':
        return const BuyerHubScreen(key: ValueKey('buyer_hub'));
      case 'buyer_web':
        return const ComingSoonScreen(
          key: ValueKey('buyer_web'),
          activeRoute: 'buyer_web',
          title: 'Web',
          subtitle: 'Your branded storefront website is on its way.',
          icon: Icons.language_rounded,
        );
      case 'buyer_utility':
        return const ComingSoonScreen(
          key: ValueKey('buyer_utility'),
          activeRoute: 'buyer_utility',
          title: 'Utility',
          subtitle: 'Handy merchant utility tools are on their way.',
          icon: Icons.build_rounded,
        );
      case 'buyer_account':
        return const BuyerAccountScreen(key: ValueKey('buyer_account'));
      case 'user_settings':
        return const UserSettingsScreen(key: ValueKey('user_settings'));
      default:
        return const SplashScreen(key: ValueKey('splash_default'));
    }
  }
}
