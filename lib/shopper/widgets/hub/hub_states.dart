import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wakover/router/app_routes.dart';
import 'package:wakover/theme/app_theme.dart';

import 'hub_image.dart';

/// A centered illustration-style message used for empty, error and gated
/// states across the hub screens.
class HubMessage extends StatelessWidget {
  const HubMessage({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
    this.isBusy = false,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final bool isBusy;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: hubTint(context),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 34, color: AppTheme.primaryBlue),
            ),
            const SizedBox(height: 18),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                height: 1.4,
                color: hubMutedText(context),
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(height: 20),
              HubPrimaryButton(
                label: actionLabel!,
                onPressed: onAction,
                isBusy: isBusy,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class HubSignedOutState extends StatelessWidget {
  const HubSignedOutState({super.key, required this.feature, this.onSignedIn});

  /// What the user is trying to see, e.g. "orders".
  final String feature;

  /// Called after the user signs in from here, e.g. to reload the list.
  final VoidCallback? onSignedIn;

  @override
  Widget build(BuildContext context) {
    return HubMessage(
      icon: Icons.lock_outline_rounded,
      title: 'Sign in required',
      message: 'Sign in to your account to see your $feature for this store.',
      actionLabel: 'Sign in',
      onAction: () async {
        final signedIn = await context.push<bool>(AppRoutes.auth);
        if (signedIn == true) onSignedIn?.call();
      },
    );
  }
}

class HubNoStoreState extends StatelessWidget {
  const HubNoStoreState({super.key});

  @override
  Widget build(BuildContext context) {
    return const HubMessage(
      icon: Icons.storefront_outlined,
      title: 'No store connected',
      message:
          'Scan a store QR code or enter its web address in the marketplace '
          'to connect.',
    );
  }
}

class HubErrorState extends StatelessWidget {
  const HubErrorState({super.key, required this.message, this.onRetry});

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return HubMessage(
      icon: Icons.cloud_off_rounded,
      title: 'Something went wrong',
      message: message,
      actionLabel: onRetry == null ? null : 'Try again',
      onAction: onRetry,
    );
  }
}

/// The navy pill button used for primary actions throughout the app.
class HubPrimaryButton extends StatelessWidget {
  const HubPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.isBusy = false,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isBusy;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final child = isBusy
        ? const SizedBox(
            width: 18,
            height: 18,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: Colors.white,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 16),
                const SizedBox(width: 6),
              ],
              Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          );

    return SizedBox(
      width: expand ? double.infinity : null,
      height: 46,
      child: ElevatedButton(
        onPressed: isBusy ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.navyDark,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppTheme.navyDark.withValues(alpha: 0.6),
          padding: const EdgeInsets.symmetric(horizontal: 22),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: child,
      ),
    );
  }
}
