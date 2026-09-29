import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/models/product_review_model.dart';
import 'package:wakover/shopper/models/store_product_model.dart';
import 'package:wakover/shopper/providers/cart_provider.dart';
import 'package:wakover/shopper/repositories/saved_items_repository.dart';
import 'package:wakover/shopper/screens/saved/saved_items_screen.dart';
import 'package:wakover/shopper/widgets/cart.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/theme/app_theme.dart';

import 'widgets/product_widgets.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({
    super.key,
    required this.productId,
    this.initialProduct,
  });

  final String productId;

  /// The catalog's copy, shown while the full details load.
  final StoreProduct? initialProduct;

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  late StoreProduct? _product = widget.initialProduct;
  late ProductVariant? _variant = widget.initialProduct?.defaultVariant;
  String? _error;
  List<ProductReview>? _reviews;
  int _totalReviews = 0;

  late final Stream<bool> _isSaved = context
      .read<SavedItemsRepository>()
      .watchSavedItems()
      .map((items) => items.any((i) => i.productId == widget.productId));

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _load();
      _loadReviews();
    });
  }

  Future<void> _load() async {
    setState(() => _error = null);
    try {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final response = await repo.getProduct(widget.productId);
      if (!mounted) return;
      setState(() {
        if (response.success == true && response.data != null) {
          final product = response.data!;
          _product = product;
          // Keep the chosen variant if it still exists.
          _variant =
              product.variants?.firstWhere(
                (v) => v.id == _variant?.id,
                orElse: () => product.variants!.first,
              ) ??
              product.defaultVariant;
        } else if (_product == null) {
          _error = response.message ?? 'Could not load this product.';
        }
      });
    } catch (e) {
      if (mounted && _product == null) setState(() => _error = e.toString());
    }
  }

  Future<void> _loadReviews() async {
    try {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final response = await repo.getProductReviews(
        widget.productId,
        pageSize: 5,
      );
      if (!mounted || response.success != true) return;
      setState(() {
        _reviews = response.data ?? [];
        _totalReviews = response.metaData?.totalRecords ?? _reviews!.length;
      });
    } catch (_) {
      // Reviews are optional on this page.
    }
  }

  String? get _productUrl {
    final origin = context.read<NetworkProvider>().storeOrigin;
    return origin == null ? null : '$origin/product/${widget.productId}';
  }

  @override
  Widget build(BuildContext context) {
    final product = _product;
    if (product == null) {
      return Scaffold(
        appBar: AppBar(),
        body: _error != null
            ? HubErrorState(message: _error!, onRetry: _load)
            : const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () => Future.wait([_load(), _loadReviews()]),
        child: CustomScrollView(
          slivers: [
            _buildGalleryAppBar(product),
            SliverToBoxAdapter(child: _buildDetails(product)),
          ],
        ),
      ),
      bottomNavigationBar: _BuyBar(
        product: product,
        variant: _variant,
        productUrl: _productUrl,
      ),
    );
  }

  SliverAppBar _buildGalleryAppBar(StoreProduct product) {
    final images = product.images ?? const [];
    Widget roundButton(IconData icon, String tooltip, VoidCallback onTap) {
      return Padding(
        padding: const EdgeInsets.all(6),
        child: Material(
          color: Colors.white.withValues(alpha: 0.92),
          shape: const CircleBorder(),
          child: IconButton(
            tooltip: tooltip,
            iconSize: 20,
            color: AppTheme.navyDark,
            icon: Icon(icon),
            onPressed: onTap,
          ),
        ),
      );
    }

    return SliverAppBar(
      expandedHeight: 340,
      pinned: true,
      stretch: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      leading: roundButton(
        Icons.arrow_back_rounded,
        'Back',
        () => Navigator.of(context).maybePop(),
      ),
      actions: [
        if (_productUrl != null)
          roundButton(Icons.ios_share_rounded, 'Copy link', () {
            Clipboard.setData(ClipboardData(text: _productUrl!));
            showHubSnack(context, 'Product link copied');
          }),
        StreamBuilder<bool>(
          stream: _isSaved,
          builder: (context, snapshot) {
            final saved = snapshot.data ?? false;
            return roundButton(
              saved ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
              saved ? 'Remove from saved' : 'Save',
              () => toggleSavedItem(context, snapshotOf(product)),
            );
          },
        ),
        const SizedBox(width: 4),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'product-image-${widget.productId}',
          child: _Gallery(images: images.map((i) => i.url).toList()),
        ),
      ),
    );
  }

  Widget _buildDetails(StoreProduct product) {
    final variant = _variant;
    final discount = discountLabel(product, variant);
    final rating = product.review?.rating ?? 0;
    final reviewCount = product.review?.totalReviews ?? 0;
    final stockLeft = product.stockFor(variant);
    final branch = product.merchant?.branch;
    final boxItems = product.items ?? const [];

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (product.tags?.isNotEmpty == true) ...[
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: [for (final tag in product.tags!) _Chip(label: tag)],
            ),
            const SizedBox(height: 10),
          ],
          Text(
            product.name ?? '',
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              RatingStars(rating: rating, size: 16),
              const SizedBox(width: 6),
              Text(
                reviewCount > 0
                    ? '$rating · $reviewCount review${reviewCount == 1 ? '' : 's'}'
                    : 'No reviews yet',
                style: TextStyle(fontSize: 12, color: hubMutedText(context)),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: ProductPrice(
                  product: product,
                  variant: variant,
                  fontSize: 24,
                ),
              ),
              if (discount != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFC53030).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '$discount off',
                    style: const TextStyle(
                      color: Color(0xFFC53030),
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
          if (product.unit?.isNotEmpty == true)
            Text(
              'Per ${product.unit!.toLowerCase()}',
              style: TextStyle(fontSize: 12, color: hubMutedText(context)),
            ),
          if (stockLeft != null && stockLeft > 0 && stockLeft <= 5) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                const Icon(
                  Icons.local_fire_department_rounded,
                  size: 16,
                  color: Color(0xFFB7791F),
                ),
                const SizedBox(width: 4),
                Text(
                  'Only $stockLeft left',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFB7791F),
                  ),
                ),
              ],
            ),
          ],
          if (product.hasVariants) ...[
            const HubSectionTitle('Options'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in product.variants!)
                  ChoiceChip(
                    label: Text(option.name ?? 'Option'),
                    selected: option.id == variant?.id,
                    onSelected: (_) => setState(() => _variant = option),
                    showCheckmark: false,
                    labelStyle: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: option.id == variant?.id ? Colors.white : null,
                    ),
                    selectedColor: AppTheme.navyDark,
                    backgroundColor: Theme.of(context).cardColor,
                    side: BorderSide(color: hubBorder(context)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
              ],
            ),
          ],
          if (product.productType == 'digital' && boxItems.isNotEmpty) ...[
            const HubSectionTitle('What\'s in the box'),
            for (final (index, item) in boxItems.indexed)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: hubTint(context),
                      child: Text(
                        '${index + 1}',
                        style: const TextStyle(
                          fontSize: 10,
                          color: AppTheme.primaryBlue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        item.name ?? '',
                        style: const TextStyle(fontSize: 13),
                      ),
                    ),
                    if (item.type != null)
                      Text(
                        item.type!,
                        style: TextStyle(
                          fontSize: 11,
                          color: hubMutedText(context),
                        ),
                      ),
                  ],
                ),
              ),
          ],
          if (product.purchaseOptions?.isNotEmpty == true) ...[
            const HubSectionTitle('Ways to get it'),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final option in product.purchaseOptions!)
                  _PurchaseOption(option: option),
              ],
            ),
          ],
          if (branch?.name != null || branch?.address != null) ...[
            const HubSectionTitle('Sold by'),
            HubCard(
              child: Row(
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: hubTint(context),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.storefront_rounded,
                      color: AppTheme.primaryBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (branch?.name != null)
                          Text(
                            branch!.name!.trim(),
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        if (branch?.address != null)
                          Text(
                            branch!.address!,
                            style: TextStyle(
                              fontSize: 11,
                              color: hubMutedText(context),
                            ),
                          ),
                      ],
                    ),
                  ),
                  if (branch?.phone != null)
                    HubIconAction(
                      icon: Icons.chat_outlined,
                      tooltip: 'Chat with the store',
                      onTap: () => contactBusiness(context, branch!.phone!),
                    ),
                ],
              ),
            ),
          ],
          if (product.description?.trim().isNotEmpty == true) ...[
            const HubSectionTitle('About this product'),
            _Description(markdown: product.description!),
          ],
          const HubSectionTitle('Reviews'),
          _Reviews(reviews: _reviews, total: _totalReviews, rating: rating),
        ],
      ),
    );
  }
}

class _Gallery extends StatefulWidget {
  const _Gallery({required this.images});

  final List<String?> images;

  @override
  State<_Gallery> createState() => _GalleryState();
}

class _GalleryState extends State<_Gallery> {
  int _page = 0;

  @override
  Widget build(BuildContext context) {
    final images = widget.images.isEmpty ? [null] : widget.images;
    return Stack(
      fit: StackFit.expand,
      children: [
        PageView.builder(
          itemCount: images.length,
          onPageChanged: (page) => setState(() => _page = page),
          itemBuilder: (context, index) => LayoutBuilder(
            builder: (context, constraints) => HubImage(
              path: images[index],
              size: constraints.maxWidth,
              height: constraints.maxHeight,
              radius: 0,
            ),
          ),
        ),
        if (images.length > 1)
          Positioned(
            bottom: 14,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < images.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    margin: const EdgeInsets.symmetric(horizontal: 3),
                    width: i == _page ? 18 : 7,
                    height: 7,
                    decoration: BoxDecoration(
                      color: i == _page
                          ? AppTheme.navyDark
                          : AppTheme.navyDark.withValues(alpha: 0.25),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
              ],
            ),
          ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: hubTint(context),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: AppTheme.primaryBlue,
        ),
      ),
    );
  }
}

class _PurchaseOption extends StatelessWidget {
  const _PurchaseOption({required this.option});

  final String option;

  @override
  Widget build(BuildContext context) {
    final (icon, label) = switch (option) {
      'delivery' => (Icons.local_shipping_outlined, 'Delivery'),
      'in_store' => (Icons.storefront_outlined, 'In-store pickup'),
      'booking' => (Icons.event_available_outlined, 'Booking'),
      _ => (Icons.check_circle_outline_rounded, humanizeKey(option)),
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: hubBorder(context)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: AppTheme.primaryBlue),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

/// Markdown description, collapsed to a preview when long.
class _Description extends StatefulWidget {
  const _Description({required this.markdown});

  final String markdown;

  @override
  State<_Description> createState() => _DescriptionState();
}

class _DescriptionState extends State<_Description> {
  static const _collapsedHeight = 220.0;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final text = widget.markdown.replaceAll(RegExp(r'\r\n|\r'), '\n');
    final isLong = text.length > 400;
    final body = MarkdownBody(
      data: text,
      styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(context)).copyWith(
        p: const TextStyle(fontSize: 13, height: 1.55),
        listBullet: const TextStyle(fontSize: 13),
      ),
    );

    if (!isLong) return body;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          alignment: Alignment.topCenter,
          child: _expanded
              ? body
              : SizedBox(
                  height: _collapsedHeight,
                  child: ShaderMask(
                    shaderCallback: (rect) => const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.black, Colors.transparent],
                      stops: [0.6, 1],
                    ).createShader(rect),
                    blendMode: BlendMode.dstIn,
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: body,
                    ),
                  ),
                ),
        ),
        TextButton.icon(
          onPressed: () => setState(() => _expanded = !_expanded),
          icon: Icon(
            _expanded
                ? Icons.keyboard_arrow_up_rounded
                : Icons.keyboard_arrow_down_rounded,
          ),
          label: Text(_expanded ? 'Show less' : 'Read more'),
        ),
      ],
    );
  }
}

class _Reviews extends StatelessWidget {
  const _Reviews({
    required this.reviews,
    required this.total,
    required this.rating,
  });

  final List<ProductReview>? reviews;
  final int total;
  final num rating;

  @override
  Widget build(BuildContext context) {
    final reviews = this.reviews;
    if (reviews == null) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
      );
    }
    if (reviews.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: hubTint(context),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          children: [
            const Icon(Icons.rate_review_outlined, color: AppTheme.primaryBlue),
            const SizedBox(height: 6),
            const Text(
              'No reviews yet',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
            Text(
              'Buyers can review this product after their order is delivered.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: hubMutedText(context)),
            ),
          ],
        ),
      );
    }

    return Column(
      children: [
        Row(
          children: [
            Text(
              rating.toStringAsFixed(1),
              style: const TextStyle(fontSize: 28, fontWeight: FontWeight.w900),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RatingStars(rating: rating, size: 16),
                Text(
                  '$total review${total == 1 ? '' : 's'}',
                  style: TextStyle(fontSize: 11, color: hubMutedText(context)),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (final review in reviews)
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: HubCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: hubTint(context),
                        child: Text(
                          review.authorName[0].toUpperCase(),
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryBlue,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          review.authorName,
                          style: const TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      RatingStars(rating: review.rating ?? 0, size: 12),
                    ],
                  ),
                  if (review.comment?.isNotEmpty == true) ...[
                    const SizedBox(height: 8),
                    Text(
                      review.comment!,
                      style: const TextStyle(fontSize: 12, height: 1.4),
                    ),
                  ],
                  if (review.createdAt != null) ...[
                    const SizedBox(height: 6),
                    Text(
                      formatDate(review.createdAt),
                      style: TextStyle(
                        fontSize: 10,
                        color: hubMutedText(context),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
      ],
    );
  }
}

/// Sticky bottom bar with the price and the primary action.
class _BuyBar extends StatelessWidget {
  const _BuyBar({
    required this.product,
    required this.variant,
    required this.productUrl,
  });

  final StoreProduct product;
  final ProductVariant? variant;
  final String? productUrl;

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final productId = product.id ?? '';
    final inBag = cart.quantityOf(productId, variantId: variant?.id);
    final soldOut = product.isSoldOut(variant);
    final isBusy = cart.busyProductId == productId;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        border: Border(top: BorderSide(color: hubBorder(context))),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    inBag > 0 ? '$inBag in your bag' : 'Price',
                    style: TextStyle(
                      fontSize: 11,
                      color: inBag > 0
                          ? AppTheme.primaryBlue
                          : hubMutedText(context),
                      fontWeight: inBag > 0 ? FontWeight.bold : null,
                    ),
                  ),
                  Text(
                    formatNaira(product.salePrice(variant)),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ],
              ),
            ),
            if (inBag > 0) ...[
              HubIconAction(
                icon: Icons.shopping_bag_outlined,
                tooltip: 'View bag',
                onTap: () => showCartSheet(context),
              ),
              const SizedBox(width: 10),
            ],
            if (product.canAddToCart)
              HubPrimaryButton(
                label: soldOut ? 'Sold Out' : 'Add to Bag',
                icon: soldOut ? null : Icons.add_shopping_cart_rounded,
                isBusy: isBusy,
                onPressed: soldOut
                    ? null
                    : () => addProductToBag(context, product, variant: variant),
              )
            else
              // Date and slot selection for bookings lives on the store
              // website for now.
              HubPrimaryButton(
                label: 'Book on website',
                icon: Icons.open_in_new_rounded,
                onPressed: productUrl == null
                    ? null
                    : () => openExternalUrl(context, productUrl!),
              ),
          ],
        ),
      ),
    );
  }
}
