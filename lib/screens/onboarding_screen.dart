import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _slides = [
    {
      'badge': 'Direct Ecosystem',
      'title': 'One Platform, Endless Commerce',
      'description':
          'Experience fluid exchange across local merchants, verified suppliers, and retail consumers with institutional escrow trust.',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBgKpJapAlxpgKNYCVC7M8Bj93QRMz9IKmUBu4E5vLCz5KrvZnzhJEdScDtz9kICS4BwmAZJk6O0cd50J5_mNpE2Nxe08sZNsXB7WdrDb4AYvWCXKkO2J6ZFJjXFTYX-eRGhT2J_abbUgpOwzjQqPulVNIkngw1sQHBwbAJWtw5XQLXK_68lk0DzQWcAf8P7_rZpSxMXqM2VwI-a3BEgKS4paTHTQea7G9hAE8S79-U9bW8n4r3Vop0qQ',
    },
    {
      'badge': 'Verified Merchant Rail',
      'title': 'Powering Verified Sellers',
      'description':
          'Automated multi-tier pricing, live warehouse inventory sync, and direct payouts with zero intermediary delay.',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDwVkUEUFzDVlUO0QbQkqPu2fVO7DIwVp0Ng_Z2l3gmr8vTAJYUiqhUktm2wOymXQwp5wwaviqYPt-rYekzuyc9SWhTkO-RxEJ-cO6V_foYS7FvcdJEOVEwXlm5fdA3Oz3S6KVs3sRFoXHgspfsdHPKgcvUho1BZBijTY6xsBsXDCIJioBzCx2aW4lBzP-zm19D4_cNWnOtka0iwGBUAmCWx3zNzZkXZN7khMckzrL31Wu2T7tqdyBMIw',
    },
    {
      'badge': 'Frictionless Payments',
      'title': 'Frictionless Ordering',
      'description':
          'Scan physical storefront QR codes or jump directly into private merchant vaults with buyer protection guaranteed.',
      'image':
          'https://lh3.googleusercontent.com/aida-public/AB6AXuABqoiuaf4dca2WbribmY55zE3J0Zyyb6ZNlP-YI5FRK8tgxREEtzBJOSU2jG9B7iusMsEb2GbhBbu5LvBlxbt6S5-cwtcZiAEpAVwATUShGNg7llyOp0f74rrlpwhpemQ_s3VQmIfzzj6cQnuIrFwTcFMFavwLbASBhDiNl_VlUcR8DY2qUudkE3iL9XRHDK_hXZj9dL8Hj92zWnvnmmINiIQ_CzYocNRIMXRGsQxdzN9LVOBtrm5JNw',
    },
  ];

  void _onNext() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.read<AppProvider>().navigateTo('role_select');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wakover'),
        actions: [
          TextButton(
            onPressed: () {
              context.read<AppProvider>().navigateTo('role_select');
            },
            child: const Text('Skip'),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 12),
          child: Column(
            children: [
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (idx) => setState(() => _currentPage = idx),
                  itemCount: _slides.length,
                  itemBuilder: (context, idx) {
                    final slide = _slides[idx];
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Slide badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF4FF),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            slide['badge']!,
                            style: const TextStyle(
                              color: AppTheme.primaryBlue,
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Image card
                        Container(
                          width: double.infinity,
                          height: 260,
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF4FF),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          padding: const EdgeInsets.all(20),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.network(
                              slide['image']!,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Title & Description
                        Text(
                          slide['title']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.5,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: Text(
                            slide['description']!,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.grey.shade600,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Page Indicators & Active Step
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _slides.length,
                  (index) => AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? AppTheme.navyDark
                          : const Color(0xFFDCE1FF),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Active ${_currentPage + 1}/${_slides.length}',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey.shade400,
                ),
              ),
              const SizedBox(height: 20),

              // Next CTA
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onNext,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _currentPage == _slides.length - 1
                        ? AppTheme.primaryBlue
                        : AppTheme.navyDark,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _currentPage == _slides.length - 1
                            ? 'Get Started'
                            : 'Next',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield_outlined, size: 12, color: Colors.grey),
                  SizedBox(width: 4),
                  Text(
                    'Wakover Direct Commerce Guarantee • SSL Secured',
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
