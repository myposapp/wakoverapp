import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakover/shopper/models/cart_model.dart';
import 'package:wakover/shopper/providers/cart_provider.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import '../../theme/app_theme.dart';

Future<void> showCartSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (ctx) => const CartSheet(),
  );
}

class CartSheet extends StatefulWidget {
  const CartSheet({super.key});

  @override
  State<CartSheet> createState() => _CartSheetState();
}

class _CartSheetState extends State<CartSheet> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<CartProvider>().load(),
    );
  }

  Future<void> _run(Future<String?> action) async {
    final error = await action;
    if (error != null && mounted) showHubSnack(context, error);
  }

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Your Bag',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Text(
                '${cart.itemCount} item${cart.itemCount == 1 ? '' : 's'}',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: cart.isLoading && cart.cart == null
                ? const Center(child: CircularProgressIndicator())
                : items.isEmpty
                ? const HubMessage(
                    icon: Icons.shopping_bag_outlined,
                    title: 'Your bag is empty',
                    message: 'Items you add from the catalog will show here.',
                  )
                : ListView.separated(
                    itemCount: items.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 12),
                    itemBuilder: (context, idx) => _CartLine(
                      item: items[idx],
                      isBusy: cart.busyProductId == items[idx].id,
                      onIncrease: () => _run(
                        cart.add(
                          items[idx].id ?? '',
                          variantId: items[idx].variantId,
                        ),
                      ),
                      onDecrease: () => _run(
                        cart.remove(
                          items[idx].id ?? '',
                          variantId: items[idx].variantId,
                        ),
                      ),
                      onRemove: () => _run(
                        cart.remove(
                          items[idx].id ?? '',
                          variantId: items[idx].variantId,
                          removeAll: true,
                        ),
                      ),
                    ),
                  ),
          ),
          if (items.isNotEmpty) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Subtotal', style: TextStyle(fontSize: 14)),
                Text(
                  formatNaira(cart.subtotal),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                // Checkout (shipping, payment) isn't built in the app yet.
                onPressed: () =>
                    showHubSnack(context, 'Checkout is coming soon.'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: Text('Checkout • ${formatNaira(cart.subtotal)}'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CartLine extends StatelessWidget {
  const _CartLine({
    required this.item,
    required this.isBusy,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  final CartItem item;
  final bool isBusy;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final variantName = item.variantName;

    return Dismissible(
      key: ValueKey('${item.id}-${item.variantId}'),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onRemove(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: Colors.red.shade400,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: hubBorder(context)),
        ),
        child: Row(
          children: [
            HubImage(path: item.imagePath, size: 52),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name ?? 'Item',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  if (variantName != null)
                    Text(
                      variantName,
                      style: TextStyle(
                        fontSize: 11,
                        color: hubMutedText(context),
                      ),
                    ),
                  Text(
                    formatNaira(item.unitPrice),
                    style: TextStyle(
                      color: hubMutedText(context),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (isBusy)
              const Padding(
                padding: EdgeInsets.all(12),
                child: SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            else
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      (item.qty ?? 1) <= 1
                          ? Icons.delete_outline_rounded
                          : Icons.remove,
                      size: 16,
                    ),
                    onPressed: onDecrease,
                  ),
                  Text(
                    '${item.qty ?? 1}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.add, size: 16),
                    onPressed: onIncrease,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
