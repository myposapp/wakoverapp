import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/database/app_database.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:go_router/go_router.dart';
import 'package:wakover/router/app_routes.dart';
import 'package:wakover/shopper/providers/cart_provider.dart';
import 'package:wakover/shopper/repositories/saved_items_repository.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/theme/app_theme.dart';

class SavedItemsScreen extends StatefulWidget {
  const SavedItemsScreen({super.key});

  @override
  State<SavedItemsScreen> createState() => _SavedItemsScreenState();
}

class _SavedItemsScreenState extends State<SavedItemsScreen> {
  late final Stream<List<SavedItem>> _savedItems = context
      .read<SavedItemsRepository>()
      .watchSavedItems();

  SavedItemsRepository get _repo => context.read<SavedItemsRepository>();

  Future<void> _remove(SavedItem item) async {
    await _repo.remove(item.productId);
    if (!mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text('Removed ${item.name}'),
          action: SnackBarAction(
            label: 'Undo',
            onPressed: () => _repo.toggle((
              productId: item.productId,
              name: item.name,
              image: item.image,
              category: item.category,
              price: item.price,
            )),
          ),
        ),
      );
  }

  Future<void> _clearAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear saved items?'),
        content: const Text(
          'This removes everything you saved from this store on this device.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (confirmed == true) await _repo.clear();
  }

  @override
  Widget build(BuildContext context) {
    final origin = context.read<NetworkProvider>().storeOrigin;

    return StreamBuilder<List<SavedItem>>(
      stream: _savedItems,
      builder: (context, snapshot) {
        final items = snapshot.data ?? const <SavedItem>[];

        return Scaffold(
          appBar: AppBar(
            title: const Text('Saved'),
            actions: [
              if (items.isNotEmpty)
                IconButton(
                  tooltip: 'Clear all',
                  icon: const Icon(Icons.delete_sweep_outlined),
                  onPressed: _clearAll,
                ),
            ],
          ),
          body: SafeArea(
            child: Builder(
              builder: (context) {
                if (origin == null) return const HubNoStoreState();
                if (snapshot.hasError) {
                  return HubErrorState(message: '${snapshot.error}');
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (items.isEmpty) {
                  return const HubMessage(
                    icon: Icons.bookmark_border_rounded,
                    title: 'Nothing saved yet',
                    message:
                        'Tap the bookmark on any catalog item to keep it '
                        'here for later.',
                  );
                }
                return _SavedGrid(
                  items: items,
                  storeHost: Uri.tryParse(origin)?.host ?? origin,
                  onRemove: _remove,
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _SavedGrid extends StatelessWidget {
  const _SavedGrid({
    required this.items,
    required this.storeHost,
    required this.onRemove,
  });

  final List<SavedItem> items;
  final String storeHost;
  final ValueChanged<SavedItem> onRemove;

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          sliver: SliverToBoxAdapter(
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: hubTint(context),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.storefront_rounded,
                        size: 14,
                        color: AppTheme.primaryBlue,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        storeHost,
                        style: const TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  '${items.length} saved · on this device',
                  style: TextStyle(fontSize: 11, color: hubMutedText(context)),
                ),
              ],
            ),
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
          sliver: SliverGrid.builder(
            itemCount: items.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.64,
            ),
            itemBuilder: (context, index) => _SavedItemCard(
              item: items[index],
              onRemove: () => onRemove(items[index]),
            ),
          ),
        ),
      ],
    );
  }
}

class _SavedItemCard extends StatelessWidget {
  const _SavedItemCard({required this.item, required this.onRemove});

  final SavedItem item;
  final VoidCallback onRemove;

  Future<void> _addToBag(BuildContext context) async {
    final error = await context.read<CartProvider>().add(item.productId);
    if (context.mounted) {
      showHubSnack(context, error ?? 'Added ${item.name} to your bag');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isBusy = context.select<CartProvider, bool>(
      (cart) => cart.busyProductId == item.productId,
    );

    return GestureDetector(
      onTap: () => context.go(AppRoutes.product(item.productId)),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: hubBorder(context)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                LayoutBuilder(
                  builder: (context, constraints) => HubImage(
                    path: item.image,
                    size: constraints.maxWidth,
                    height: 110,
                    radius: 14,
                  ),
                ),
                Positioned(
                  top: 6,
                  right: 6,
                  child: Material(
                    color: Colors.white.withValues(alpha: 0.9),
                    shape: const CircleBorder(),
                    child: InkWell(
                      customBorder: const CircleBorder(),
                      onTap: onRemove,
                      child: const Padding(
                        padding: EdgeInsets.all(6),
                        child: Icon(
                          Icons.bookmark_rounded,
                          size: 16,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              item.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
            if (item.category != null)
              Text(
                item.category!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 10, color: hubMutedText(context)),
              ),
            const Spacer(),
            if (item.price != null)
              Text(
                formatNaira(item.price),
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
              ),
            const SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              height: 34,
              child: ElevatedButton(
                onPressed: isBusy ? null : () => _addToBag(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.navyDark,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Add to Bag',
                  style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Toggles [snapshot] in the saved list and shows the outcome.
Future<void> toggleSavedItem(
  BuildContext context,
  SavedProductSnapshot snapshot,
) async {
  try {
    final isSaved = await context.read<SavedItemsRepository>().toggle(snapshot);
    if (!context.mounted) return;
    showHubSnack(
      context,
      isSaved ? 'Saved ${snapshot.name}' : 'Removed ${snapshot.name}',
    );
  } on NoStoreConnectedException catch (e) {
    if (context.mounted) showHubSnack(context, e.toString());
  }
}
