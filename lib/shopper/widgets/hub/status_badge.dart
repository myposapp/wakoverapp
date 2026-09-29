import 'package:flutter/material.dart';
import 'package:wakover/theme/app_theme.dart';

/// Visual treatment for the order/booking/payment statuses the API returns.
class StatusStyle {
  const StatusStyle(this.label, this.color, this.icon);

  final String label;
  final Color color;
  final IconData icon;

  static const _amber = Color(0xFFB7791F);
  static const _green = Color(0xFF2F855A);
  static const _red = Color(0xFFC53030);
  static const _grey = Color(0xFF718096);
  static const _purple = Color(0xFF805AD5);
  static const _indigo = Color(0xFF4C51BF);

  static StatusStyle of(String? status) {
    switch (status) {
      case 'pending-payment':
        return const StatusStyle(
          'Payment Pending',
          _amber,
          Icons.hourglass_top_rounded,
        );
      case 'pending':
        return const StatusStyle('Pending', _amber, Icons.schedule_rounded);
      case 'expired':
        return const StatusStyle('Expired', _grey, Icons.history_rounded);
      case 'failed':
        return const StatusStyle('Failed', _red, Icons.error_outline_rounded);
      case 'cancelled':
        return const StatusStyle('Cancelled', _red, Icons.cancel_outlined);
      case 'approved':
        return const StatusStyle(
          'Approved',
          AppTheme.primaryBlue,
          Icons.thumb_up_alt_outlined,
        );
      case 'upcoming':
        return const StatusStyle(
          'Upcoming',
          AppTheme.primaryBlue,
          Icons.event_rounded,
        );
      case 'active':
        return const StatusStyle(
          'Active',
          AppTheme.primaryBlue,
          Icons.bolt_rounded,
        );
      case 'readyForPickup':
        return const StatusStyle(
          'Ready for Pickup',
          _purple,
          Icons.inventory_2_outlined,
        );
      case 'pickedUp':
        return const StatusStyle(
          'Picked Up',
          _indigo,
          Icons.local_shipping_outlined,
        );
      case 'delivered':
        return const StatusStyle(
          'Delivered',
          _green,
          Icons.check_circle_outline_rounded,
        );
      case 'complete':
      case 'success':
        return const StatusStyle(
          'Complete',
          _green,
          Icons.check_circle_outline_rounded,
        );
      default:
        return StatusStyle(
          _titleCase(status ?? 'Unknown'),
          _grey,
          Icons.info_outline_rounded,
        );
    }
  }

  static String _titleCase(String value) {
    final words = value.replaceAll(RegExp(r'[-_]'), ' ').trim();
    if (words.isEmpty) return value;
    return words[0].toUpperCase() + words.substring(1);
  }

  Color background(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return color.withValues(alpha: isDark ? 0.22 : 0.1);
  }
}

class StatusBadge extends StatelessWidget {
  const StatusBadge({super.key, required this.status});

  final String? status;

  @override
  Widget build(BuildContext context) {
    final style = StatusStyle.of(status);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: style.background(context),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(style.icon, size: 12, color: style.color),
          const SizedBox(width: 4),
          Text(
            style.label,
            style: TextStyle(
              color: style.color,
              fontSize: 10,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
