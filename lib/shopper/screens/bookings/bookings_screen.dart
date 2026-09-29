import 'package:flutter/material.dart';
import 'package:wakover/shopper/models/booking_model.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/shopper/widgets/hub/paged_list_view.dart';

import 'widgets/booking_card.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  final _listKey = GlobalKey<PagedListViewState<Booking>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Bookings')),
      body: SafeArea(
        child: PagedListView<Booking>(
          key: _listKey,
          feature: 'bookings',
          fetchPage: (repo, page) => repo.getBookings(page: page),
          emptyState: const HubMessage(
            icon: Icons.event_available_rounded,
            title: 'No bookings yet',
            message:
                'Reservations and appointments you make with this store '
                'will appear here.',
          ),
          itemBuilder: (context, booking) => BookingCard(
            booking: booking,
            onVisitorsChanged: (visitors) => _listKey.currentState?.updateWhere(
              (b) => b.id == booking.id,
              (b) => b.copyWith(visitors: visitors),
            ),
          ),
        ),
      ),
    );
  }
}
