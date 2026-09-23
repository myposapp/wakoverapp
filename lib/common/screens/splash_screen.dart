import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../theme/app_theme.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _progressAnimation;
  String _appVersion = '1.0';

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _progressAnimation = Tween<double>(
      begin: 0.2,
      end: 0.85,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));
    _controller.forward();
    PackageInfo.fromPlatform().then((info) {
      if (mounted) setState(() => _appVersion = info.version);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onGetStarted() {
    _controller
        .animateTo(1.0, duration: const Duration(milliseconds: 400))
        .then((_) {
          context.read<AppProvider>().navigateTo('onboarding');
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [AppTheme.navyDark, Color(0xFF09153D), AppTheme.navyDeep],
            ),
          ),
          child: Column(
            children: [
              // Main Splash Card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 32,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Center Logo & Headlines
                      Column(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryBlue.withValues(
                                    alpha: .4,
                                  ),
                                  blurRadius: 30,
                                  spreadRadius: 5,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Image.network(
                              'https://lh3.googleusercontent.com/aida-public/AB6AXuA4BohYmV3GnUJ6qWc7okvkJtR_KsqYMfRoNe8M8gtgLmu_IYf-os4qQZ-CoxiritV2EKCZCMQOngo9ggYRr9udf8Sgx_2JHCdxn7bAC_6S_l8JIgP6vkrzzl8FSAAD8b5EbFc_I0CYxN3abZ4D_J_OTFwo15Wc1gfLqmcQcFNKfQUyfLjS12Kbc4gVT1MOzc83TwSNQ3n_EUfi9H6RgXsLwBqyMI6esrxzdM-jYt7XO_4hWV9zuDLFuOBd2C5E8Hbqc0Q',
                              errorBuilder: (_, _, _) => const Center(
                                child: Text(
                                  'W',
                                  style: TextStyle(
                                    fontSize: 48,
                                    fontWeight: FontWeight.w900,
                                    color: AppTheme.navyDark,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'WAKOVER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 32,
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          const Text(
                            'OPPORTUNITIES. VALUES. WONDERS.',
                            style: TextStyle(
                              color: Color(0xFFDCE1FF),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          const SizedBox(height: 12),
                          const Text(
                            'High-trust B2B and retail commercial\nexchange ecosystem',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),

                      // Progress & Action Button
                      Column(
                        children: [
                          AnimatedBuilder(
                            animation: _progressAnimation,
                            builder: (context, _) => Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 180,
                                    height: 5,
                                    color: Colors.white12,
                                    child: FractionallySizedBox(
                                      alignment: Alignment.centerLeft,
                                      widthFactor: _progressAnimation.value,
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              AppTheme.accentBlue,
                                              AppTheme.accentCyan,
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                const Text(
                                  'Securing encrypted session...',
                                  style: TextStyle(
                                    color: Colors.white60,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: _onGetStarted,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.primaryBlue,
                                foregroundColor: Colors.white,
                                elevation: 8,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(26),
                                ),
                              ),
                              child: const Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Get Started',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Icon(Icons.arrow_forward_rounded, size: 18),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Wakover Commerce v$_appVersion',
                            style: const TextStyle(
                              color: Colors.white38,
                              fontSize: 10,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              // Trust Badges Row
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(28),
                    topRight: Radius.circular(28),
                  ),
                  color: AppTheme.canvasLight,
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 14, 16, 16),
                  child: Row(
                    children: [
                      _buildTrustCard(
                        Icons.security_rounded,
                        'Tier-1 Trust',
                        'Escrow backed',
                      ),
                      const SizedBox(width: 10),
                      _buildTrustCard(
                        Icons.bolt_rounded,
                        'Swift Pay',
                        'Instant liquidity',
                      ),
                      const SizedBox(width: 10),
                      _buildTrustCard(
                        Icons.hub_rounded,
                        'B2B & Retail',
                        'Dual ecosystem',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTrustCard(IconData icon, String title, String subtitle) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primaryBlue, size: 20),
            const SizedBox(height: 4),
            Text(
              title,
              style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
            ),
          ],
        ),
      ),
    );
  }
}
