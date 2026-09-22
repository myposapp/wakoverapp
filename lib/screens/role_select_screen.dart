import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';

class RoleSelectScreen extends StatefulWidget {
  const RoleSelectScreen({super.key});

  @override
  State<RoleSelectScreen> createState() => _RoleSelectScreenState();
}

class _RoleSelectScreenState extends State<RoleSelectScreen> {
  UserRole _selected = UserRole.buyer;

  void _onContinue() {
    final provider = context.read<AppProvider>();
    provider.setRole(_selected);
    if (_selected == UserRole.merchant) {
      provider.navigateTo('connect_store');
    } else {
      provider.navigateTo('buyer_marketplace');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wakover'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Step Badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCE9FF),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.auto_awesome, size: 12, color: AppTheme.primaryBlue),
                    SizedBox(width: 4),
                    Text(
                      'STEP 1 OF 3 • WELCOME',
                      style: TextStyle(
                        color: AppTheme.primaryBlue,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'How will you use Wakover?',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Choose your account experience to personalize your workspace.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),

              // Role Card: Buyer
              _buildRoleCard(
                role: UserRole.buyer,
                tag: 'DISCOVER & BUY',
                title: 'I am a Shopper / Buyer',
                subtitle: 'Discover unique local brands and track consumer orders seamlessly.',
                icon: Icons.shopping_bag_outlined,
                bullets: [
                  'Direct retail marketplace & brand discovery',
                  'One-tap order history & shipment updates',
                  'Access merchant stores directly via private links',
                ],
                trustTag: 'Buyer Protection',
              ),
              const SizedBox(height: 16),

              // Role Card: Merchant
              _buildRoleCard(
                role: UserRole.merchant,
                tag: 'SELL & MANAGE',
                title: 'I am a Business / Merchant',
                subtitle: 'Turn store inventory into high-conversion digital commerce.',
                icon: Icons.storefront_rounded,
                bullets: [
                  'Automated inventory & multi-tier pricing',
                  'Full fulfillment routing & live order tracking',
                  'Custom storefront URL & merchant portal',
                ],
                trustTag: 'Verified Payouts',
              ),
              const SizedBox(height: 24),

              // Bottom Continue Button
              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.navyDark,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26),
                    ),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Continue to Setup',
                        style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward_rounded, size: 18),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'You can add business accounts later under Settings',
                style: TextStyle(fontSize: 11, color: Colors.grey.shade400),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRoleCard({
    required UserRole role,
    required String tag,
    required String title,
    required String subtitle,
    required IconData icon,
    required List<String> bullets,
    required String trustTag,
  }) {
    final isSelected = _selected == role;
    return GestureDetector(
      onTap: () => setState(() => _selected = role),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFFDCE9FF).withOpacity(0.5) : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppTheme.primaryBlue : Colors.black.withOpacity(0.06),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryBlue.withOpacity(0.12),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEFF4FF),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(icon, color: AppTheme.navyDark, size: 24),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: AppTheme.navyDark,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          tag,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppTheme.navyDark : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppTheme.navyDark : Colors.grey.shade400,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(Icons.check, size: 16, color: Colors.white)
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              subtitle,
              style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 12),

            // Bullets
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: bullets
                    .map(
                      (b) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 3.0),
                        child: Row(
                          children: [
                            const Icon(Icons.check_circle_outline,
                                size: 14, color: AppTheme.primaryBlue),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                b,
                                style: const TextStyle(fontSize: 11),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
