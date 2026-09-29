import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/models/booking_model.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/shopper/widgets/hub/status_badge.dart';
import 'package:wakover/theme/app_theme.dart';

import 'booking_visitors_sheet.dart';

/// "12 Oct 2026, 2:00 PM" for slot bookings, or the stay range with the
/// branch's check-in/out times.
String bookingSchedule(Booking booking) {
  if (booking.dateTime != null) return formatDateTime(booking.dateTime);
  final start = booking.startDate;
  final end = booking.endDate;
  if (start == null) return '';
  if (end == null || start == end) return formatDate(start);

  final branch = booking.merchant?.branch;
  String withTime(String date, String? time) =>
      time == null ? formatDate(date) : formatDateTime('$date $time');
  return '${withTime(start, branch?.checkin)}  →  '
      '${withTime(end, branch?.checkout)}';
}

class BookingCard extends StatelessWidget {
  const BookingCard({
    super.key,
    required this.booking,
    required this.onVisitorsChanged,
  });

  final Booking booking;
  final ValueChanged<List<BookingVisitor>> onVisitorsChanged;

  @override
  Widget build(BuildContext context) {
    final items = booking.bookedItems;
    final visitorCount = booking.visitors?.length ?? 0;

    return HubCard(
      padding: EdgeInsets.zero,
      onTap: () => showBookingDetailSheet(context, booking),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Schedule header
          Container(
            padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
            decoration: BoxDecoration(
              color: hubTint(context),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(18),
              ),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.calendar_month_rounded,
                  size: 16,
                  color: AppTheme.primaryBlue,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    bookingSchedule(booking),
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                StatusBadge(status: booking.status),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (final item in items.take(3))
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Row(
                      children: [
                        HubImage(
                          path: item.images?.firstOrNull?.url,
                          size: 44,
                          fallbackIcon: Icons.meeting_room_outlined,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            item.name ?? 'Booking',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                Row(
                  children: [
                    Expanded(
                      child: _BookingCodeChip(code: booking.bookingCode),
                    ),
                    const SizedBox(width: 8),
                    if (booking.canManageVisitors) ...[
                      Badge(
                        isLabelVisible: visitorCount > 0,
                        label: Text('$visitorCount'),
                        backgroundColor: AppTheme.primaryBlue,
                        child: HubIconAction(
                          icon: Icons.group_add_outlined,
                          tooltip: 'Visitors',
                          onTap: () => showBookingVisitorsSheet(
                            context,
                            booking: booking,
                            onChanged: onVisitorsChanged,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    HubIconAction(
                      icon: Icons.visibility_outlined,
                      tooltip: 'View detail',
                      onTap: () => showBookingDetailSheet(context, booking),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BookingCodeChip extends StatelessWidget {
  const _BookingCodeChip({required this.code});

  final String? code;

  @override
  Widget build(BuildContext context) {
    final code = this.code;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Booking Code',
          style: TextStyle(fontSize: 10, color: hubMutedText(context)),
        ),
        InkWell(
          onTap: code == null
              ? null
              : () {
                  Clipboard.setData(ClipboardData(text: code));
                  showHubSnack(context, 'Booking code copied');
                },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                code ?? '—',
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              if (code != null) ...[
                const SizedBox(width: 6),
                const Icon(
                  Icons.copy_rounded,
                  size: 13,
                  color: AppTheme.primaryBlue,
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

Future<void> showBookingDetailSheet(BuildContext context, Booking booking) {
  return showHubSheet(
    context,
    title: 'Booking Detail',
    child: _BookingDetail(booking: booking),
  );
}

class _BookingDetail extends StatelessWidget {
  const _BookingDetail({required this.booking});

  final Booking booking;

  @override
  Widget build(BuildContext context) {
    final origin = context.read<NetworkProvider>().storeOrigin;
    final canCompletePayment =
        booking.status == 'pending-payment' &&
        booking.paymentReference != null &&
        origin != null;
    final phone = booking.merchant?.branch?.phone;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'BOOKING CODE',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.8,
                    ),
                  ),
                  const Spacer(),
                  StatusBadge(status: booking.status),
                ],
              ),
              const SizedBox(height: 6),
              SelectableText(
                booking.bookingCode ?? '—',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 3,
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month_rounded,
                    size: 14,
                    color: AppTheme.accentCyan,
                  ),
                  const SizedBox(width: 6),
                  Expanded(
                    child: Text(
                      bookingSchedule(booking),
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const HubSectionTitle('Booked'),
        for (final item in booking.bookedItems)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                HubImage(
                  path: item.images?.firstOrNull?.url,
                  size: 56,
                  fallbackIcon: Icons.meeting_room_outlined,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    item.name ?? 'Booking',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        if (booking.visitors?.isNotEmpty == true)
          HubInfoRow(label: 'Visitors', value: '${booking.visitors!.length}'),
        if (booking.createdAt != null)
          HubInfoRow(
            label: 'Booked on',
            value: formatDateTime(booking.createdAt),
          ),
        if (booking.paymentReference != null)
          HubInfoRow(label: 'Reference', value: booking.paymentReference!),
        const SizedBox(height: 20),
        if (canCompletePayment)
          HubPrimaryButton(
            label: 'Complete Payment',
            icon: Icons.open_in_new_rounded,
            expand: true,
            onPressed: () => openExternalUrl(
              context,
              '$origin/book-now/payment/${booking.paymentReference}',
            ),
          ),
        if (phone != null && phone.isNotEmpty) ...[
          const SizedBox(height: 10),
          OutlinedButton.icon(
            onPressed: () => contactBusiness(context, phone),
            style: OutlinedButton.styleFrom(
              minimumSize: const Size.fromHeight(46),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            icon: const Icon(Icons.chat_outlined, size: 16),
            label: const Text('Contact business'),
          ),
        ],
      ],
    );
  }
}
