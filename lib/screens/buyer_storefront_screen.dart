import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';
import '../theme/app_theme.dart';
import '../models/product.dart';
import '../models/store_hub.dart';
import '../widgets/custom_bottom_nav.dart';

class BuyerStorefrontScreen extends StatelessWidget {
  const BuyerStorefrontScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final store = provider.selectedStore ??
        (provider.stores.isNotEmpty ? provider.stores.first : null);

    if (store == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Storefront')),
        body: const Center(
          child: Text('No merchant vault selected yet.'),
        ),
        bottomNavigationBar:
            const BuyerBottomNavBar(activeRoute: 'buyer_storefront'),
      );
    }

    final filteredProducts = provider.products;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: const Color(0xFFEFF4FF),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.lock_rounded, size: 12, color: Colors.green),
              const SizedBox(width: 4),
              Text(
                store.handle,
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Badge(
              isLabelVisible: provider.cartCount > 0,
              label: Text('${provider.cartCount}'),
              backgroundColor: AppTheme.primaryBlue,
              child: const Icon(Icons.shopping_bag_outlined),
            ),
            onPressed: () => _openCart(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context, provider, store),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 14),

                    // Promo Banner
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFDCE1FF), Color(0xFFEFF4FF)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.stars_rounded, color: AppTheme.primaryBlue),
                          const SizedBox(width: 10),
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '20% OFF Orders Over \$100',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.navyDark,
                                  ),
                                ),
                                Text(
                                  'Use code FLASH20 at checkout',
                                  style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue),
                                ),
                              ],
                            ),
                          ),
                          TextButton(
                            onPressed: () => provider.showToast('Coupon FLASH20 applied!'),
                            child: const Text('Apply', style: TextStyle(fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    // 2-Column Product Grid
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredProducts.length,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 0.68,
                      ),
                      itemBuilder: (context, idx) {
                        final product = filteredProducts[idx];
                        return _buildProductCard(context, product);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar:
          const BuyerBottomNavBar(activeRoute: 'buyer_storefront'),
    );
  }

  Widget _buildHeader(BuildContext context, AppProvider provider, StoreHub store) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Banner with overlapping store icon
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: double.infinity,
                height: 132,
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
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          store.name.isNotEmpty ? store.name[0] : 'W',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.08),
                            fontSize: 96,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 12,
                      left: 12,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.white12,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          store.category.toUpperCase(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: _CircleIconButton(
                        icon: Icons.share_outlined,
                        onTap: () =>
                            provider.showToast('Copied direct storefront link.'),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -30,
                left: 18,
                child: Container(
                  width: 68,
                  height: 68,
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shape: BoxShape.circle,
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: AppTheme.navyDark,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        store.name.isNotEmpty ? store.name[0] : 'W',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 38),

          // Name + verified + location
          Row(
            children: [
              Flexible(
                child: Text(
                  store.name,
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              if (store.isVerified) ...[
                const SizedBox(width: 4),
                const Icon(Icons.verified_rounded, size: 18, color: AppTheme.primaryBlue),
              ],
            ],
          ),
          const SizedBox(height: 2),
          Text(
            store.location,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
          ),
          const SizedBox(height: 12),
          Text(
            store.description,
            style: TextStyle(fontSize: 12, color: Colors.grey.shade700, height: 1.4),
          ),
          const SizedBox(height: 14),

          // Stats Row
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFFEFF4FF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              children: [
                _buildStat(
                  Icons.star_rounded,
                  '${store.rating}',
                  '${store.reviewCount} Reviews',
                ),
                const _StatDivider(),
                _buildStat(
                  Icons.verified_user_rounded,
                  store.isVerified ? 'Verified' : 'Unverified',
                  'Seller Status',
                ),
                const _StatDivider(),
                _buildStat(
                  Icons.category_rounded,
                  store.category,
                  'Category',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStat(IconData icon, String value, String label) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 16, color: AppTheme.primaryBlue),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
          ),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 9, color: Colors.grey.shade600),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Product product) {
    final provider = context.read<AppProvider>();
    final isSaved = provider.wishlist.contains(product.id);
    final isSoldOut = product.status == 'out_of_stock';

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withOpacity(0.06)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Image with Wishlist Button
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(14),
                child: Image.network(
                  product.image,
                  width: double.infinity,
                  height: 110,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 4,
                right: 4,
                child: GestureDetector(
                  onTap: () => provider.toggleWishlist(product.id),
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.white70,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      isSaved ? Icons.bookmark : Icons.bookmark_border,
                      size: 16,
                      color: isSaved ? AppTheme.primaryBlue : Colors.black87,
                    ),
                  ),
                ),
              ),
              if (product.badge != null)
                Positioned(
                  bottom: 4,
                  left: 4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.black87,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      product.badge!,
                      style: const TextStyle(color: Colors.white, fontSize: 8),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),

          // Title & Price
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                product.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 2),
              Row(
                children: [
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                  ),
                  if (product.originalPrice != null) ...[
                    const SizedBox(width: 4),
                    Text(
                      '\$${product.originalPrice!.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 10,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),

          // Action Button
          SizedBox(
            width: double.infinity,
            height: 36,
            child: ElevatedButton(
              onPressed: isSoldOut ? null : () => provider.addToCart(product),
              style: ElevatedButton.styleFrom(
                backgroundColor: isSoldOut ? Colors.grey.shade200 : AppTheme.navyDark,
                foregroundColor: Colors.white,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                isSoldOut ? 'Sold Out' : 'Add to Bag',
                style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _openCart(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const CartSheet(),
    );
  }
}

class _CircleIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 32,
        height: 32,
        decoration: const BoxDecoration(
          color: Colors.white24,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 16, color: Colors.white),
      ),
    );
  }
}

class _StatDivider extends StatelessWidget {
  const _StatDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 30,
      color: Colors.black.withOpacity(0.08),
    );
  }
}
