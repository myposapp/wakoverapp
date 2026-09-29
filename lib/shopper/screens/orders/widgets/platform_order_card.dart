import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/models/platform_order_model.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/shopper/widgets/hub/status_badge.dart';
import 'package:wakover/theme/app_theme.dart';

/// Reads the fields the utility screens care about from the untyped
/// purchase_detail, whose shape depends on the product category.
extension on PlatformOrder {
  Map get detail => purchaseDetail is Map ? purchaseDetail as Map : const {};

  num get amount => detail['amount'] is num ? detail['amount'] as num : 0;

  num get total => amount + sumFees(fees);

  String? get meterNo => (detail['meter'] ?? detail['meter_no'])?.toString();

  String? get token => detail['meter_recharge_token']?.toString();

  /// The phone number or meter the purchase was for.
  String? get recipient => meterNo ?? detail['phone']?.toString();
}

class PlatformOrderCard extends StatelessWidget {
  const PlatformOrderCard({super.key, required this.order});

  final PlatformOrder order;

  @override
  Widget build(BuildContext context) {
    final product = order.product;
    final token = order.token;

    return HubCard(
      onTap: () => _showDetail(context, order),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              HubImage(
                path: product?.image,
                size: 46,
                fallbackIcon: Icons.bolt_rounded,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product?.name ?? 'Utility purchase',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      [
                        product?.category?.name,
                        order.recipient,
                      ].whereType<String>().join(' • '),
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
              Text(
                formatNaira(order.total),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          if (token != null && token.isNotEmpty) ...[
            const SizedBox(height: 10),
            _TokenChip(token: token),
          ],
          const SizedBox(height: 10),
          Row(
            children: [
              StatusBadge(status: order.status),
              const Spacer(),
              Text(
                formatDateTime(order.createdAt),
                style: TextStyle(fontSize: 11, color: hubMutedText(context)),
              ),
            ],
          ),
        ],
      ),
    );
  }

  static void _showDetail(BuildContext context, PlatformOrder order) {
    showHubSheet(
      context,
      title: 'Purchase Detail',
      child: _PlatformOrderDetail(order: order),
    );
  }
}

class _TokenChip extends StatelessWidget {
  const _TokenChip({required this.token});

  final String token;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        Clipboard.setData(ClipboardData(text: token));
        showHubSnack(context, 'Token copied');
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: hubTint(context),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.key_rounded,
              size: 16,
              color: AppTheme.primaryBlue,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                token,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            const Icon(
              Icons.copy_rounded,
              size: 14,
              color: AppTheme.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}

class _PlatformOrderDetail extends StatelessWidget {
  const _PlatformOrderDetail({required this.order});

  final PlatformOrder order;

  @override
  Widget build(BuildContext context) {
    final detail = order.detail;
    final fees = order.fees is Map
        ? (order.fees as Map).entries.where((e) => e.value is num).toList()
        : const <MapEntry>[];
    final token = order.token;
    final origin = context.read<NetworkProvider>().storeOrigin;
    final canCompletePayment =
        order.status == 'pending-payment' &&
        order.paymentReference != null &&
        origin != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            HubImage(
              path: order.product?.image,
              size: 56,
              fallbackIcon: Icons.bolt_rounded,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    order.product?.name ?? 'Utility purchase',
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    order.product?.category?.name ?? '',
                    style: TextStyle(
                      fontSize: 12,
                      color: hubMutedText(context),
                    ),
                  ),
                ],
              ),
            ),
            StatusBadge(status: order.status),
          ],
        ),
        if (token != null && token.isNotEmpty) ...[
          const HubSectionTitle('Recharge Token'),
          _TokenChip(token: token),
        ],
        const HubSectionTitle('Details'),
        if (detail['phone'] != null)
          HubInfoRow(label: 'Phone', value: '${detail['phone']}'),
        if (order.meterNo != null)
          HubInfoRow(label: 'Meter No', value: order.meterNo!),
        if (detail['vendType'] != null)
          HubInfoRow(label: 'Meter Type', value: '${detail['vendType']}'),
        if (detail['name'] != null)
          HubInfoRow(label: 'Customer', value: '${detail['name']}'),
        if (detail['package'] != null)
          HubInfoRow(label: 'Package', value: '${detail['package']}'),
        if (detail['number_of_pins'] != null)
          HubInfoRow(label: 'Pins', value: '${detail['number_of_pins']}'),
        HubInfoRow(label: 'Date', value: formatDateTime(order.createdAt)),
        if (order.id != null) HubInfoRow(label: 'Order ID', value: order.id!),
        if (order.paymentReference != null)
          HubInfoRow(label: 'Reference', value: order.paymentReference!),
        const HubSectionTitle('Payment'),
        HubInfoRow(label: 'Amount', value: formatNaira(order.amount)),
        for (final fee in fees)
          HubInfoRow(
            label: humanizeKey('${fee.key}'),
            value: formatNaira(fee.value as num),
          ),
        const Divider(),
        HubInfoRow(
          label: 'Total',
          value: formatNaira(order.total),
          isEmphasized: true,
        ),
        if (canCompletePayment) ...[
          const SizedBox(height: 20),
          HubPrimaryButton(
            label: 'Complete Payment',
            icon: Icons.open_in_new_rounded,
            expand: true,
            onPressed: () => openExternalUrl(
              context,
              '$origin/digital-goods/payment/${order.paymentReference}',
            ),
          ),
        ],
      ],
    );
  }
}
