import 'package:dart_mappable/dart_mappable.dart';
import 'merchant_info_model.dart';
import 'product_image_model.dart';

part 'store_product_model.mapper.dart';

@MappableClass()
class ProductVariant with ProductVariantMappable {
  const ProductVariant({
    this.id,
    this.name,
    this.price,
    this.stock,
    this.image,
  });

  final String? id;
  final String? name;
  // Added on top of the product's base price.
  final num? price;
  final num? stock;
  final dynamic image;

  static final fromMap = ProductVariantMapper.fromMap;
  static final fromJson = ProductVariantMapper.fromJson;
}

@MappableClass()
class ProductDiscount with ProductDiscountMappable {
  const ProductDiscount({this.discountType, this.discountAmount});

  // 'flat' or 'percent'.
  @MappableField(key: 'discount_type')
  final String? discountType;
  @MappableField(key: 'discount_amount')
  final num? discountAmount;

  static final fromMap = ProductDiscountMapper.fromMap;
  static final fromJson = ProductDiscountMapper.fromJson;
}

@MappableClass()
class ProductReviewSummary with ProductReviewSummaryMappable {
  const ProductReviewSummary({this.rating, this.totalReviews});

  final num? rating;
  @MappableField(key: 'total_reviews')
  final num? totalReviews;

  static final fromMap = ProductReviewSummaryMapper.fromMap;
  static final fromJson = ProductReviewSummaryMapper.fromJson;
}

/// A file or item bundled with a digital product.
@MappableClass()
class ProductBoxItem with ProductBoxItemMappable {
  const ProductBoxItem({this.id, this.name, this.type});

  final String? id;
  final String? name;
  final String? type;

  static final fromMap = ProductBoxItemMapper.fromMap;
  static final fromJson = ProductBoxItemMapper.fromJson;
}

@MappableClass()
class StoreProduct with StoreProductMappable {
  const StoreProduct({
    this.id,
    this.name,
    this.description,
    this.images,
    this.price,
    this.unit,
    this.productType,
    this.purchaseOptions,
    this.manageStock,
    this.stock,
    this.status,
    this.variants,
    this.discounts,
    this.items,
    this.review,
    this.merchant,
    this.tags,
    this.createdAt,
  });

  final String? id;
  final String? name;
  // Markdown.
  final String? description;
  final List<ProductImage>? images;
  final num? price;
  final String? unit;
  // 'product', 'digital' or 'service'.
  @MappableField(key: 'product_type')
  final String? productType;
  // Any of 'in_store', 'delivery' and 'booking'.
  @MappableField(key: 'purchase_options')
  final List<String>? purchaseOptions;
  @MappableField(key: 'manage_stock')
  final bool? manageStock;
  final num? stock;
  final String? status;
  final List<ProductVariant>? variants;
  final List<ProductDiscount>? discounts;
  final List<ProductBoxItem>? items;
  final ProductReviewSummary? review;
  // Only on the single-product endpoint.
  final MerchantInfo? merchant;
  final List<String>? tags;
  final String? createdAt;

  String? get coverImage => images?.firstOrNull?.url;

  bool get canBook => (purchaseOptions ?? const []).contains('booking');

  /// Booking-only products are reserved rather than added to the cart.
  bool get canAddToCart {
    final options = purchaseOptions ?? const [];
    return options.isEmpty || options.any((o) => o != 'booking');
  }

  bool get hasVariants => (variants?.length ?? 0) > 1;

  ProductVariant? get defaultVariant => variants?.firstOrNull;

  /// Units left for [variant] (or the product), or null when stock isn't
  /// tracked.
  num? stockFor(ProductVariant? variant) {
    if (manageStock != true) return null;
    return variant != null ? variant.stock : stock;
  }

  bool isSoldOut(ProductVariant? variant) {
    final left = stockFor(variant);
    return left != null && left <= 0;
  }

  /// Price before discounts: base price plus the variant's surcharge.
  num listPrice(ProductVariant? variant) =>
      (price ?? 0) + (variant?.price ?? 0);

  /// Mirrors the storefront: each discount is capped at the list price and
  /// the result never goes below zero.
  num salePrice(ProductVariant? variant) {
    final list = listPrice(variant);
    final discount = (discounts ?? const <ProductDiscount>[]).fold<num>(0, (
      sum,
      d,
    ) {
      final amount = d.discountAmount ?? 0;
      final off = d.discountType == 'flat' ? amount : list / 100 * amount;
      return sum + (off < list ? off : list);
    });
    final result = list - discount;
    return result > 0 ? num.parse(result.toStringAsFixed(2)) : 0;
  }

  static final fromMap = StoreProductMapper.fromMap;
  static final fromJson = StoreProductMapper.fromJson;
}
