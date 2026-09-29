import 'package:flutter/material.dart';
import 'package:wakover/shopper/models/store_order_model.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/status_badge.dart';
import 'package:wakover/theme/app_theme.dart';

import 'order_detail_sheet.dart';
import 'write_review_sheet.dart';

class StoreOrderCard extends StatelessWidget {
  const StoreOrderCard({
    super.key,
    required this.order,
    required this.onReviewed,
  });

  final StoreOrder order;

  /// Called with the product id and the created review after posting one.
  final void Function(String productId, dynamic review) onReviewed;

  static const _previewCount = 2;

  bool get _canReview =>
      order.status == 'delivered' || order.status == 'complete';

  @override
  Widget build(BuildContext context) {
    final items = order.items ?? const <StoreOrderItem>[];
    final phone = order.merchant?.branch?.phone;

    return HubCard(
      onTap: () => showOrderDetailSheet(context, order),
      child: Column(
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
          const SizedBox(height: 12),
          for (final item in items.take(_previewCount))
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: _OrderItemRow(
                item: item,
                showReview: _canReview && item.review == null,
                onReview: () => _writeReview(context, item),
              ),
            ),
          if (items.length > _previewCount)
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Text(
                '+${items.length - _previewCount} more item'
                '${items.length - _previewCount == 1 ? '' : 's'}',
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.primaryBlue,
                ),
              ),
            ),
          Divider(height: 1, color: hubBorder(context)),
          const SizedBox(height: 10),
          Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Total',
                    style: TextStyle(
                      fontSize: 10,
                      color: hubMutedText(context),
                    ),
                  ),
                  Text(
                    formatNaira(order.itemsTotal + sumFees(order.fees)),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              if (phone != null && phone.isNotEmpty) ...[
                HubIconAction(
                  icon: Icons.chat_outlined,
                  tooltip: 'Contact business',
                  onTap: () => contactBusiness(context, phone),
                ),
                const SizedBox(width: 8),
              ],
              HubIconAction(
                icon: Icons.visibility_outlined,
                tooltip: 'View detail',
                onTap: () => showOrderDetailSheet(context, order),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _writeReview(BuildContext context, StoreOrderItem item) async {
    final productId = item.productId;
    if (productId == null) return;
    final result = await showWriteReviewSheet(
      context,
      productId: productId,
      productName: item.name ?? 'this product',
    );
    if (result != null) onReviewed(productId, result.review);
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({
    required this.item,
    required this.showReview,
    required this.onReview,
  });

  final StoreOrderItem item;
  final bool showReview;
  final VoidCallback onReview;

  @override
  Widget build(BuildContext context) {
    final quantity = item.isDigital
        ? '${item.files?.length ?? 0} files'
        : '${item.qty ?? 1} ${item.unit ?? ''}'.trim();

    return Row(
      children: [
        HubImage(path: item.image?.url, size: 44),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                item.name ?? 'Item',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                quantity,
                style: TextStyle(fontSize: 11, color: hubMutedText(context)),
              ),
            ],
          ),
        ),
        if (showReview)
          TextButton.icon(
            onPressed: onReview,
            style: TextButton.styleFrom(
              visualDensity: VisualDensity.compact,
              textStyle: const TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
            icon: const Icon(Icons.rate_review_outlined, size: 14),
            label: const Text('Review'),
          )
        else
          Text(
            formatNaira(item.lineTotal),
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
      ],
    );
  }
}
