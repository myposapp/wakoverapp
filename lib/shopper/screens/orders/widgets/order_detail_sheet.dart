import 'package:flutter/material.dart';
import 'package:wakover/shopper/models/store_order_model.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/status_badge.dart';
import 'package:wakover/theme/app_theme.dart';

Future<void> showOrderDetailSheet(BuildContext context, StoreOrder order) {
  return showHubSheet(
    context,
    title: 'Order Detail',
    child: _OrderDetail(order: order),
  );
}

class _OrderDetail extends StatelessWidget {
  const _OrderDetail({required this.order});

  final StoreOrder order;

  @override
  Widget build(BuildContext context) {
    final items = order.items ?? const <StoreOrderItem>[];
    final fees = order.fees is Map
        ? (order.fees as Map).entries.where((e) => e.value is num).toList()
        : const <MapEntry>[];
    final address = order.shippingDetail?.address;
    final deliveries = order.deliveryStatus ?? const <DeliveryStatus>[];
    final digitalFiles = items
        .where((i) => i.isDigital)
        .expand((i) => i.files ?? const [])
        .whereType<Map>()
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
        const HubSectionTitle('Items'),
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              children: [
                HubImage(path: item.image?.url, size: 52),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.name ?? 'Item',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        item.isDigital
                            ? '${item.files?.length ?? 0} files'
                            : '${item.qty ?? 1} ${item.unit ?? ''} × '
                                  '${formatNaira(item.unitPrice)}',
                        style: TextStyle(
                          fontSize: 11,
                          color: hubMutedText(context),
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  formatNaira(item.lineTotal),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        const HubSectionTitle('Summary'),
        HubInfoRow(label: 'Items', value: formatNaira(order.itemsTotal)),
        for (final fee in fees)
          HubInfoRow(
            label: humanizeKey('${fee.key}'),
            value: formatNaira(fee.value as num),
          ),
        const Divider(),
        HubInfoRow(
          label: 'Total',
          value: formatNaira(order.itemsTotal + sumFees(order.fees)),
          isEmphasized: true,
        ),
        if (order.id != null) HubInfoRow(label: 'Order ID', value: order.id!),
        if (address != null) ...[
          const HubSectionTitle('Delivery Address'),
          _AddressCard(address: address),
        ],
        if (digitalFiles.isNotEmpty) ...[
          const HubSectionTitle('Files'),
          for (final (index, file) in digitalFiles.indexed)
            ListTile(
              dense: true,
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(
                radius: 14,
                backgroundColor: hubTint(context),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppTheme.primaryBlue,
                  ),
                ),
              ),
              title: Text('${file['name'] ?? 'File'}'),
              subtitle: file['type'] == null ? null : Text('${file['type']}'),
            ),
          Text(
            'Downloads are available from the store website.',
            style: TextStyle(fontSize: 11, color: hubMutedText(context)),
          ),
        ],
        if (deliveries.isNotEmpty) ...[
          const HubSectionTitle('Delivery Updates'),
          _DeliveryTimeline(entries: deliveries),
        ],
      ],
    );
  }
}

class _AddressCard extends StatelessWidget {
  const _AddressCard({required this.address});

  final ShippingAddress address;

  @override
  Widget build(BuildContext context) {
    final location = [
      address.address,
      address.address2,
      address.city,
      address.state,
      address.country,
    ].where((part) => part != null && part.isNotEmpty).join(', ');

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: hubTint(context),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_on_outlined,
            color: AppTheme.primaryBlue,
            size: 20,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (address.name != null)
                  Text(
                    address.name!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                for (final line in [address.phone, address.email, location])
                  if (line != null && line.isNotEmpty)
                    Text(line, style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DeliveryTimeline extends StatelessWidget {
  const _DeliveryTimeline({required this.entries});

  final List<DeliveryStatus> entries;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final (index, entry) in entries.indexed)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  width: 24,
                  child: Column(
                    children: [
                      Container(
                        width: 12,
                        height: 12,
                        margin: const EdgeInsets.only(top: 3),
                        decoration: BoxDecoration(
                          color: index == 0
                              ? AppTheme.primaryBlue
                              : hubTint(context),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppTheme.primaryBlue,
                            width: 2,
                          ),
                        ),
                      ),
                      if (index < entries.length - 1)
                        Expanded(
                          child: Container(
                            width: 2,
                            color: AppTheme.primaryBlue.withValues(alpha: 0.2),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.status ?? '',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (entry.note != null && entry.note!.isNotEmpty)
                          Text(
                            entry.note!,
                            style: const TextStyle(fontSize: 12),
                          ),
                        Text(
                          formatDateTime(entry.dateTime),
                          style: TextStyle(
                            fontSize: 11,
                            color: hubMutedText(context),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
