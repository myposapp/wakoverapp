import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wakover/shopper/models/store_product_model.dart';
import 'package:wakover/shopper/providers/cart_provider.dart';
import 'package:wakover/shopper/repositories/saved_items_repository.dart';
import 'package:wakover/shopper/screens/saved/saved_items_screen.dart';
import 'package:wakover/shopper/widgets/cart.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/theme/app_theme.dart';

/// Sale price with the list price struck through when discounted.
class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,
    required this.product,
    this.variant,
    this.fontSize = 13,
  });

  final StoreProduct product;
  final ProductVariant? variant;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    final sale = product.salePrice(variant);
    final list = product.listPrice(variant);
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.end,
      spacing: 6,
      children: [
        Text(
          formatNaira(sale),
          style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.w800),
        ),
        if (sale < list)
          Text(
            formatNaira(list),
            style: TextStyle(
              fontSize: fontSize * 0.75,
              color: hubMutedText(context),
              decoration: TextDecoration.lineThrough,
            ),
          ),
      ],
    );
  }
}

/// "-20%" when the product is discounted, otherwise null.
String? discountLabel(StoreProduct product, [ProductVariant? variant]) {
  final list = product.listPrice(variant);
  final sale = product.salePrice(variant);
  if (list <= 0 || sale >= list) return null;
  return '-${((list - sale) / list * 100).round()}%';
}

class RatingStars extends StatelessWidget {
  const RatingStars({super.key, required this.rating, this.size = 14});

  final num rating;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (var i = 1; i <= 5; i++)
          Icon(
            rating >= i
                ? Icons.star_rounded
                : rating >= i - 0.5
                ? Icons.star_half_rounded
                : Icons.star_outline_rounded,
            size: size,
            color: Colors.amber,
          ),
      ],
    );
  }
}

/// Snapshot stored in the on-device saved list.
SavedProductSnapshot snapshotOf(StoreProduct product) => (
  productId: product.id ?? '',
  name: product.name ?? 'Product',
  image: product.coverImage,
  category: product.unit,
  price: product.salePrice(null).toDouble(),
);

/// Adds [product] to the bag and confirms with a "View bag" shortcut.
Future<void> addProductToBag(
  BuildContext context,
  StoreProduct product, {
  ProductVariant? variant,
}) async {
  final error = await context.read<CartProvider>().add(
    product.id ?? '',
    variantId: variant?.id,
  );
  if (!context.mounted) return;
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(error ?? 'Added ${product.name} to your bag'),
        action: error == null
            ? SnackBarAction(
                label: 'View bag',
                onPressed: () => showCartSheet(context),
              )
            : null,
      ),
    );
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.isSaved,
    required this.onTap,
  });

  final StoreProduct product;
  final bool isSaved;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final productId = product.id ?? '';
    final isBusy = cart.busyProductId == productId;
    final inBag = cart.quantityOf(productId);
    final soldOut = product.isSoldOut(product.defaultVariant);
    final discount = discountLabel(product);
    final reviews = product.review?.totalReviews ?? 0;
    // Variants and bookings need choices made on the product page.
    final needsDetail = product.hasVariants || !product.canAddToCart;

    return Material(
      color: Theme.of(context).cardColor,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: hubBorder(context)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Hero(
                    tag: 'product-image-$productId',
                    child: LayoutBuilder(
                      builder: (context, constraints) => HubImage(
                        path: product.coverImage,
                        size: constraints.maxWidth,
                        height: 118,
                        radius: 14,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: _SaveButton(product: product, isSaved: isSaved),
                  ),
                  if (discount != null || !product.canAddToCart)
                    Positioned(
                      bottom: 6,
                      left: 6,
                      child: _Tag(
                        label: discount ?? 'Book',
                        color: discount != null
                            ? const Color(0xFFC53030)
                            : AppTheme.primaryBlue,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                product.name ?? '',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
              const SizedBox(height: 3),
              if (reviews > 0)
                Row(
                  children: [
                    RatingStars(rating: product.review?.rating ?? 0, size: 11),
                    const SizedBox(width: 3),
                    Text(
                      '($reviews)',
                      style: TextStyle(
                        fontSize: 9,
                        color: hubMutedText(context),
                      ),
                    ),
                  ],
                )
              else if (product.unit?.isNotEmpty == true)
                Text(
                  'Per ${product.unit!.toLowerCase()}',
                  style: TextStyle(fontSize: 10, color: hubMutedText(context)),
                ),
              const Spacer(),
              ProductPrice(product: product),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 34,
                child: ElevatedButton(
                  onPressed: soldOut || isBusy
                      ? null
                      : needsDetail
                      ? onTap
                      : () => addProductToBag(context, product),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.navyDark,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: hubTint(context),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isBusy
                      ? const SizedBox(
                          width: 16,
                          height: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          soldOut
                              ? 'Sold Out'
                              : needsDetail
                              ? (product.canAddToCart ? 'Choose' : 'Book')
                              : inBag > 0
                              ? 'Add another · $inBag'
                              : 'Add to Bag',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SaveButton extends StatelessWidget {
  const _SaveButton({required this.product, required this.isSaved});

  final StoreProduct product;
  final bool isSaved;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white.withValues(alpha: 0.92),
      shape: const CircleBorder(),
      child: InkWell(
        customBorder: const CircleBorder(),
        onTap: () => toggleSavedItem(context, snapshotOf(product)),
        child: Padding(
          padding: const EdgeInsets.all(6),
          child: Icon(
            isSaved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            size: 16,
            color: isSaved ? AppTheme.primaryBlue : AppTheme.navyDark,
          ),
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
