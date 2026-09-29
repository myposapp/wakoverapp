import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/models/payment_model.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/status_badge.dart';
import 'package:wakover/theme/app_theme.dart';

class PaymentCard extends StatelessWidget {
  const PaymentCard({super.key, required this.payment});

  final StorePayment payment;

  num get _total => (payment.amount ?? 0) + sumFees(payment.fees);

  @override
  Widget build(BuildContext context) {
    final origin = context.read<NetworkProvider>().storeOrigin;
    final phone = payment.merchant?.branch?.phone;
    final canCheckout =
        payment.status == 'pending-payment' &&
        payment.paymentReference != null &&
        origin != null;
    final fees = sumFees(payment.fees);

    return HubCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              StatusBadge(status: payment.status),
              const Spacer(),
              Text(
                formatDateTime(payment.createdAt),
                style: TextStyle(fontSize: 11, color: hubMutedText(context)),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              HubImage(
                path: payment.product?.image?.url,
                size: 46,
                fallbackIcon: Icons.receipt_rounded,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      payment.product?.name ?? 'Payment',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (payment.remark?.isNotEmpty == true)
                      Text(
                        payment.remark!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 11,
                          color: hubMutedText(context),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Divider(height: 1, color: hubBorder(context)),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    formatNaira(_total),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (fees > 0)
                    Text(
                      'incl. ${formatNaira(fees)} fees',
                      style: TextStyle(
                        fontSize: 10,
                        color: hubMutedText(context),
                      ),
                    ),
                ],
              ),
              const Spacer(),
              if (phone != null && phone.isNotEmpty)
                HubIconAction(
                  icon: Icons.chat_outlined,
                  tooltip: 'Contact business',
                  onTap: () => contactBusiness(context, phone),
                ),
              if (canCheckout) ...[
                const SizedBox(width: 8),
                FilledButton.icon(
                  onPressed: () => openExternalUrl(
                    context,
                    '$origin/payments/payment/${payment.paymentReference}',
                  ),
                  style: FilledButton.styleFrom(
                    backgroundColor: AppTheme.navyDark,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  icon: const Icon(Icons.lock_outline_rounded, size: 14),
                  label: const Text(
                    'Checkout',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
