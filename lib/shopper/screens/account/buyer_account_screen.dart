import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wakover/router/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:wakover/providers/app_provider.dart';
import 'package:wakover/shopper/models/shopper_user_model.dart';
import 'package:wakover/shopper/providers/user_session_provider.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/theme/app_theme.dart';

class BuyerAccountScreen extends StatelessWidget {
  const BuyerAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<AppProvider>();
    final session = context.watch<UserSessionProvider>();
    final user = session.user;

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (user != null)
                _ProfileHeader(user: user)
              else if (session.isSignedIn && session.isRestoring)
                const _ProfileHeaderSkeleton()
              else
                const _SignInPrompt(),
              const SizedBox(height: 20),

              _buildSectionLabel('My Wakover'),
              const SizedBox(height: 8),
              _buildGroup(context, [
                _ProfileTile(
                  icon: Icons.location_on_outlined,
                  label: 'Address',
                  onTap: () =>
                      provider.showToast('Address is not available yet.'),
                ),
                _ProfileTile(
                  icon: Icons.confirmation_num_outlined,
                  label: 'My Vouchers',
                  onTap: () =>
                      provider.showToast('My Vouchers is not available yet.'),
                ),
              ]),
              const SizedBox(height: 20),

              _buildSectionLabel('Preferences & Support'),
              const SizedBox(height: 8),
              _buildGroup(context, [
                _ProfileTile(
                  icon: Icons.notifications_none_rounded,
                  label: 'Notifications',
                  onTap: () =>
                      provider.showToast('Notifications is not available yet.'),
                ),
                _ProfileTile(
                  icon: Icons.settings_outlined,
                  label: 'Settings',
                  onTap: () => context.go(AppRoutes.userSettings),
                ),
                _ProfileTile(
                  icon: Icons.person_add_alt_1_outlined,
                  label: 'Invite Friends',
                  onTap: () => provider.showToast(
                    'Invite Friends is not available yet.',
                  ),
                ),
                _ProfileTile(
                  icon: Icons.headset_mic_outlined,
                  label: 'Support',
                  onTap: () =>
                      provider.showToast('Support is not available yet.'),
                ),
              ]),
              const SizedBox(height: 20),

              _buildSectionLabel('Session'),
              const SizedBox(height: 8),
              _buildGroup(context, [
                if (session.isSignedIn)
                  _ProfileTile(
                    icon: Icons.logout_rounded,
                    label: 'Sign out',
                    onTap: () => _confirmSignOut(context),
                  ),
                _ProfileTile(
                  icon: Icons.swap_horiz_rounded,
                  label: 'Switch role',
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
        border: Border.all(color: Colors.black.withValues(alpha: 0.06)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < tiles.length; i++) ...[
            tiles[i],
            if (i != tiles.length - 1)
              Divider(
                height: 1,
                indent: 62,
                color: Colors.black.withValues(alpha: .06),
              ),
          ],
        ],
      ),
    );
  }

  void _confirmSignOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Sign out?'),
        content: const Text(
          'You can keep browsing stores. Orders, bookings and your wallet '
          'need you to sign in again.',
        ),
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
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await context.read<UserSessionProvider>().signOut();
              if (context.mounted) {
                context.read<AppProvider>().showToast('Signed out.');
              }
            },
            child: const Text('Sign Out'),
          ),
        ],
      ),
    );
  }

  void _confirmLogout(BuildContext context, AppProvider provider) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Switch role?'),
        content: const Text(
          'You\'ll need to select your role again to continue.',
        ),
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
              context.go(AppRoutes.roleSelect);
            },
            child: const Text('Switch'),
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
              context.read<UserSessionProvider>().signOut();
              provider.deleteAccount();
              context.go(AppRoutes.splash);
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
                color: isDestructive
                    ? Colors.red.shade50
                    : const Color(0xFFEFF4FF),
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
            Icon(
              Icons.chevron_right_rounded,
              color: Colors.grey.shade400,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}

const _headerGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [AppTheme.navyDark, Color(0xFF102468), AppTheme.primaryBlue],
);

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final ShopperUser user;

  @override
  Widget build(BuildContext context) {
    final name = user.name?.trim().isNotEmpty == true
        ? user.name!.trim()
        : 'Shopper';
    final contact = [
      user.email,
      user.phone,
    ].whereType<String>().where((c) => c.isNotEmpty).join(' • ');

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: _headerGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24, width: 2),
                ),
                alignment: Alignment.center,
                child: Text(
                  name[0].toUpperCase(),
                  style: const TextStyle(
                    color: AppTheme.navyDark,
                    fontSize: 26,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      contact,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet_rounded,
                  size: 18,
                  color: AppTheme.accentCyan,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Wallet balance',
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                      ),
                      Text(
                        formatNaira(user.walletBalance),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                if (user.walletId != null)
                  Text(
                    'ID ${user.walletId}',
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      letterSpacing: 0.5,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileHeaderSkeleton extends StatelessWidget {
  const _ProfileHeaderSkeleton();

  @override
  Widget build(BuildContext context) {
    Widget bar(double width) => Container(
      width: width,
      height: 12,
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(6),
      ),
    );

    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: _headerGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white24,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 14),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [bar(140), bar(100)],
          ),
        ],
      ),
    );
  }
}

class _SignInPrompt extends StatelessWidget {
  const _SignInPrompt();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: _headerGradient,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.white12,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.person_rounded,
                  size: 12,
                  color: AppTheme.accentCyan,
                ),
                SizedBox(width: 4),
                Text(
                  'GUEST',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 9,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Sign in to do more',
            style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Track orders and bookings, use your wallet and earn as an '
            'affiliate. You can keep browsing without an account.',
            style: TextStyle(color: Colors.white70, fontSize: 11, height: 1.4),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () => context.push(AppRoutes.auth),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.navyDark,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.push(AppRoutes.signUp),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text(
                    'Create account',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
