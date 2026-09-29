import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wakover/common/screens/onboarding_screen.dart';
import 'package:wakover/common/screens/role_select_screen.dart';
import 'package:wakover/common/screens/splash_screen.dart';
import 'package:wakover/merchant/screens/connect_store_screen.dart';
import 'package:wakover/merchant/screens/merchant_campaigns_screen.dart';
import 'package:wakover/merchant/screens/merchant_dashboard_screen.dart';
import 'package:wakover/merchant/screens/merchant_inventory_screen.dart';
import 'package:wakover/merchant/screens/merchant_orders_screen.dart';
import 'package:wakover/merchant/widgets/bottom_nav.dart';
import 'package:wakover/providers/app_provider.dart';
import 'package:wakover/shopper/screens/account/buyer_account_screen.dart';
import 'package:wakover/shopper/screens/account/user_settings_screen.dart';
import 'package:wakover/shopper/screens/auth/auth_screen.dart';
import 'package:wakover/shopper/screens/storefront/product_detail_screen.dart';
import 'package:wakover/shopper/models/store_product_model.dart';
import 'package:wakover/shopper/screens/affiliate_codes/affiliate_codes_screen.dart';
import 'package:wakover/shopper/screens/bookings/bookings_screen.dart';
import 'package:wakover/shopper/screens/coming_soon/coming_soon_screen.dart';
import 'package:wakover/shopper/screens/hub/buyer_hub_screen.dart';
import 'package:wakover/shopper/screens/marketplace/buyer_marketplace_screen.dart';
import 'package:wakover/shopper/screens/orders/orders_screen.dart';
import 'package:wakover/shopper/screens/payments/payments_screen.dart';
import 'package:wakover/shopper/screens/saved/saved_items_screen.dart';
import 'package:wakover/shopper/screens/storefront/buyer_storefront_screen.dart';
import 'package:wakover/shopper/screens/transactions/transactions_screen.dart';
import 'package:wakover/shopper/widgets/bottom_nav_bar.dart';

import 'app_routes.dart';

/// Branch order of the buyer tab shell. The bottom bar maps its items to
/// these indices.
abstract final class BuyerTab {
  static const web = 0;
  static const catalog = 1;
  static const hub = 2;
  static const account = 3;
  static const utility = 4;
}

abstract final class MerchantTab {
  static const dashboard = 0;
  static const inventory = 1;
  static const orders = 2;
  static const campaigns = 3;
}

GoRouter createAppRouter(AppProvider appProvider) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    // Re-run the redirect once saved preferences have loaded.
    refreshListenable: appProvider,
    redirect: (context, state) => _startupRedirect(appProvider, state),
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.roleSelect,
        builder: (context, state) => const RoleSelectScreen(),
      ),
      GoRoute(
        path: AppRoutes.connectStore,
        builder: (context, state) => const ConnectStoreScreen(),
      ),
      GoRoute(
        path: AppRoutes.marketplace,
        builder: (context, state) => const BuyerMarketplaceScreen(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => AuthScreen(
          initialMode: state.uri.queryParameters['mode'] == 'sign-up'
              ? AuthMode.signUp
              : AuthMode.signIn,
        ),
      ),
      _merchantShell(),
      _buyerShell(),
    ],
  );
}

/// Returning users skip the splash and land on their home screen once
/// preferences have loaded. Every other location is left alone.
String? _startupRedirect(AppProvider appProvider, GoRouterState state) {
  if (state.matchedLocation != AppRoutes.splash) return null;
  if (!appProvider.hasLoadedPreferences || !appProvider.hasCompletedIntro) {
    return null;
  }
  return homeRouteFor(appProvider);
}

/// Where a user who has finished onboarding starts.
String homeRouteFor(AppProvider appProvider) {
  if (appProvider.role == UserRole.merchant) return AppRoutes.connectStore;
  return appProvider.selectedStoreId != null
      ? AppRoutes.buyerCatalog
      : AppRoutes.marketplace;
}

StatefulShellRoute _merchantShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, shell) => _TabShell(
      shell: shell,
      homeIndex: MerchantTab.dashboard,
      bottomBar: MerchantBottomNavBar(navigationShell: shell),
    ),
    branches: [
      _branch(AppRoutes.merchantDashboard, const MerchantDashboardScreen()),
      _branch(AppRoutes.merchantInventory, const MerchantInventoryScreen()),
      _branch(AppRoutes.merchantOrders, const MerchantOrdersScreen()),
      _branch(AppRoutes.merchantCampaigns, const MerchantCampaignsScreen()),
    ],
  );
}

StatefulShellRoute _buyerShell() {
  return StatefulShellRoute.indexedStack(
    builder: (context, state, shell) => _TabShell(
      shell: shell,
      homeIndex: BuyerTab.catalog,
      bottomBar: BuyerBottomNavBar(navigationShell: shell),
    ),
    branches: [
      _branch(
        AppRoutes.buyerWeb,
        const ComingSoonScreen(
          title: 'Web',
          subtitle: 'Your branded storefront website is on its way.',
          icon: Icons.language_rounded,
        ),
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.buyerCatalog,
            builder: (context, state) => const BuyerStorefrontScreen(),
            routes: [
              GoRoute(
                path: 'product/:productId',
                // The catalog passes the product it already has so the
                // page renders instantly while details load.
                builder: (context, state) => ProductDetailScreen(
                  productId: state.pathParameters['productId']!,
                  initialProduct: state.extra is StoreProduct
                      ? state.extra as StoreProduct
                      : null,
                ),
              ),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.buyerHub,
            builder: (context, state) => const BuyerHubScreen(),
            routes: [
              _child(AppRoutes.hubOrders, const OrdersScreen()),
              _child(AppRoutes.hubBookings, const BookingsScreen()),
              _child(AppRoutes.hubPayments, const PaymentsScreen()),
              _child(AppRoutes.hubTransactions, const TransactionsScreen()),
              _child(AppRoutes.hubSaved, const SavedItemsScreen()),
              _child(AppRoutes.hubAffiliateCodes, const AffiliateCodesScreen()),
            ],
          ),
        ],
      ),
      StatefulShellBranch(
        routes: [
          GoRoute(
            path: AppRoutes.buyerAccount,
            builder: (context, state) => const BuyerAccountScreen(),
            routes: [
              _child(AppRoutes.userSettings, const UserSettingsScreen()),
            ],
          ),
        ],
      ),
      // Not in the bottom bar yet; kept so the tab can be switched back on.
      _branch(
        AppRoutes.buyerUtility,
        const ComingSoonScreen(
          title: 'Utility',
          subtitle: 'Handy merchant utility tools are on their way.',
          icon: Icons.build_rounded,
        ),
      ),
    ],
  );
}

StatefulShellBranch _branch(String path, Widget screen) {
  return StatefulShellBranch(
    routes: [GoRoute(path: path, builder: (context, state) => screen)],
  );
}

/// A route nested under a tab. GoRoute child paths are relative, so the
/// parent segment is stripped from the full [AppRoutes] path.
GoRoute _child(String fullPath, Widget screen) {
  return GoRoute(
    path: fullPath.substring(fullPath.lastIndexOf('/') + 1),
    builder: (context, state) => screen,
  );
}

/// Hosts a tab shell's bottom bar. Back on a tab other than [homeIndex]
/// returns to the home tab instead of closing the app; nested pages inside
/// a tab are popped by their branch navigator before this is reached.
class _TabShell extends StatelessWidget {
  const _TabShell({
    required this.shell,
    required this.homeIndex,
    required this.bottomBar,
  });

  final StatefulNavigationShell shell;
  final int homeIndex;
  final Widget bottomBar;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: shell.currentIndex == homeIndex,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) shell.goBranch(homeIndex);
      },
      child: Scaffold(body: shell, bottomNavigationBar: bottomBar),
    );
  }
}
