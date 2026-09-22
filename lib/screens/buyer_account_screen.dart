import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav.dart';

class BuyerAccountScreen extends StatelessWidget {
  const BuyerAccountScreen({super.key});

  static const _userName = 'Jordan Blake';
  static const _userId = 'Wakover ID • WK-10293847';

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.navyDark,
                      Color(0xFF102468),
                      AppTheme.primaryBlue,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => provider.showToast('Profile editing is not available yet.'),
                  child: Row(
                    children: [
                      Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white24, width: 2),
                        ),
                        child: const Center(
                          child: Text(
                            'J',
                            style: TextStyle(
                              color: AppTheme.navyDark,
                              fontSize: 26,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 14),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _userName,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 3),
                            Text(
                              _userId,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right_rounded, color: Colors.white70),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              _buildSectionLabel('My Wakover'),
              const SizedBox(height: 8),
              _buildGroup(context, [
                _ProfileTile(
                  icon: Icons.location_on_outlined,
                  label: 'Address',
                  onTap: () => provider.showToast('Address is not available yet.'),
                ),
                _ProfileTile(
                  icon: Icons.confirmation_num_outlined,
                  label: 'My Vouchers',
                  onTap: () => provider.showToast('My Vouchers is not available yet.'),
                ),
              ]),
              const SizedBox(height: 20),

              _buildSectionLabel('Preferences & Support'),
              const SizedBox(height: 8),
              _buildGroup(context, [
                _ProfileTile(
                  icon: Icons.notifications_none_rounded,
                  label: 'Notifications',
                  onTap: () => provider.showToast('Notifications is not available yet.'),
                ),
                _ProfileTile(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () => provider.navigateTo('user_settings'),
                ),
                _ProfileTile(
                  icon: Icons.person_add_alt_1_outlined,
                  label: 'Invite Friends',
                  onTap: () => provider.showToast('Invite Friends is not available yet.'),
                ),
                _ProfileTile(
                  icon: Icons.headset_mic_outlined,
                  label: 'Support',
                  onTap: () => provider.showToast('Support is not available yet.'),
                ),
              ]),
              const SizedBox(height: 20),

              _buildSectionLabel('Session'),
              const SizedBox(height: 8),
              _buildGroup(context, [
                _ProfileTile(
                  icon: Icons.logout_rounded,
                  label: 'Logout',
                  onTap: () => _confirmLogout(context, provider),
                ),
                _ProfileTile(
                  icon: Icons.delete_outline_rounded,
                  label: 'Delete Account',
                  isDestructive: true,
                  onTap: () => _confirmDelete(context, provider),
                ),
              ]),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BuyerBottomNavBar(activeRoute: 'buyer_account'),
    );
  }

  Widget _buildSectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.6,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  Widget _buildGroup(BuildContext context, List<_ProfileTile> tiles) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < tiles.length; i++) ...[
            tiles[i],
            if (i != tiles.length - 1)
              Divider(height: 1, indent: 62, color: Colors.black.withOpacity(0.06)),
          ],
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, AppProvider provider) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Log out?'),
        content: const Text('You\'ll need to select your role again to continue.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.navyDark,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              provider.logout();
              provider.showToast('Logged out.');
            },
            child: const Text('Log Out'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, AppProvider provider) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Delete your account?'),
        content: const Text(
          'This clears your bag, wishlist, and connected merchant vault from this device. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade600,
              foregroundColor: Colors.white,
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop();
              provider.deleteAccount();
              provider.showToast('Your account has been deleted.');
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isDestructive;

  const _ProfileTile({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final color = isDestructive ? Colors.red.shade600 : AppTheme.primaryBlue;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: isDestructive ? Colors.red.shade50 : const Color(0xFFEFF4FF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 18, color: color),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: isDestructive ? Colors.red.shade600 : null,
                ),
              ),
            ),
            Icon(Icons.chevron_right_rounded, color: Colors.grey.shade400, size: 20),
          ],
        ),
      ),
    );
  }
}
