@MappableLib(generateInitializerForScope: InitializerScope.package)
library;

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:dart_mappable/dart_mappable.dart';
import 'package:wakover/common/database/app_database.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/common/providers/preferences_provider.dart';
import 'package:wakover/shopper/providers/cart_provider.dart';
import 'package:wakover/shopper/providers/user_session_provider.dart';
import 'package:wakover/shopper/repositories/saved_items_repository.dart';
import 'package:go_router/go_router.dart';
import 'package:wakover/router/app_router.dart';
import 'providers/app_provider.dart';
import 'theme/app_theme.dart';

import 'main.init.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeMappers();

  if (kReleaseMode) {
    debugPrint = (String? message, {int? wrapWidth}) {};
  }

  final prefProvider = await PreferenceProvider.create();
  final appProvider = AppProvider();
  final router = createAppRouter(appProvider);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: appProvider),
        Provider(create: (_) => NetworkProvider(prefProvider), lazy: false),
        Provider.value(value: prefProvider),
        ChangeNotifierProvider(
          create: (context) =>
              UserSessionProvider(context.read<NetworkProvider>()),
          lazy: false,
        ),
        ChangeNotifierProvider(
          create: (context) => CartProvider(context.read<NetworkProvider>()),
        ),
        Provider(create: (_) => AppDatabase(), dispose: (_, db) => db.close()),
        ProxyProvider2<AppDatabase, NetworkProvider, SavedItemsRepository>(
          update: (_, db, network, previous) =>
              previous ?? SavedItemsRepository(db, network),
        ),
      ],
      child: WakoverCommerceApp(router: router),
    ),
  );
}

class WakoverCommerceApp extends StatelessWidget {
  const WakoverCommerceApp({super.key, required this.router});

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();

    return MaterialApp.router(
      title: 'Wakover Commerce',
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: provider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
      // Overlays the toast banner above every route.
      builder: (context, child) => Stack(
        children: [
          child!,

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
                      horizontal: 16,
                      vertical: 12,
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.check_circle_rounded,
                          color: AppTheme.accentCyan,
                          size: 20,
                        ),
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
    );
  }
}
