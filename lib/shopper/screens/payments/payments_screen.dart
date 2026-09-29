import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/models/payment_model.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/shopper/widgets/hub/paged_list_view.dart';
import 'package:wakover/theme/app_theme.dart';

import 'widgets/payment_card.dart';

class PaymentsScreen extends StatefulWidget {
  const PaymentsScreen({super.key});

  @override
  State<PaymentsScreen> createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  // Whether the store accepts direct payments; only then is "Make a Payment"
  // offered.
  bool _acceptsPayments = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadSiteConfig());
  }

  Future<void> _loadSiteConfig() async {
    final network = context.read<NetworkProvider>();
    if (network.storeOrigin == null) return;
    try {
      final response = await network.shopperNetworkRepo.getSiteConfig();
      if (mounted && response.data?.payments == true) {
        setState(() => _acceptsPayments = true);
      }
    } catch (_) {
      // The banner is optional; the payment history still loads.
    }
  }

  void _makePayment() {
    final origin = context.read<NetworkProvider>().storeOrigin;
    if (origin != null) openExternalUrl(context, '$origin/payments');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Payments')),
      body: SafeArea(
        child: PagedListView<StorePayment>(
          feature: 'payments',
          fetchPage: (repo, page) => repo.getPayments(page: page),
          header: _acceptsPayments
              ? _MakePaymentBanner(onTap: _makePayment)
              : null,
          emptyState: HubMessage(
            icon: Icons.credit_card_rounded,
            title: 'No payments yet',
            message: 'Payments you make to this store will appear here.',
            actionLabel: _acceptsPayments ? 'Make a Payment' : null,
            onAction: _acceptsPayments ? _makePayment : null,
          ),
          itemBuilder: (context, payment) => PaymentCard(payment: payment),
        ),
      ),
    );
  }
}

class _MakePaymentBanner extends StatelessWidget {
  const _MakePaymentBanner({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
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
          child: const Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white12,
                child: Icon(
                  Icons.payments_outlined,
                  color: AppTheme.accentCyan,
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Make a Payment',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Pay this store directly for a service or invoice.',
                      style: TextStyle(color: Colors.white70, fontSize: 11),
                    ),
                  ],
                ),
              ),
              Icon(Icons.open_in_new_rounded, color: Colors.white, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
