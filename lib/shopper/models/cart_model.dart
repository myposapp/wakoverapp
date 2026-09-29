import 'package:dart_mappable/dart_mappable.dart';

part 'cart_model.mapper.dart';

@MappableClass()
class CartItem with CartItemMappable {
  const CartItem({
    this.id,
    this.productId,
    this.variantId,
    this.name,
    this.qty,
    this.price,
    this.originalPrice,
    this.unit,
    this.image,
    this.images,
    this.variant,
  });

  // The cart line's own id; use [productId] for cart operations.
  final String? id;
  @MappableField(key: 'product_id')
  final String? productId;
  @MappableField(key: 'variant_id')
  final String? variantId;
  final String? name;
  final num? qty;
  // Unit price after discounts.
  final num? price;
  // Unit price before discounts.
  @MappableField(key: 'original_price')
  final num? originalPrice;
  final String? unit;
  final dynamic image;
  final dynamic images;
  final dynamic variant;

  String? get variantName =>
      variant is Map ? variant['name']?.toString() : null;

  num get unitPrice => price ?? 0;

  num get lineTotal => unitPrice * (qty ?? 1);

  /// The first image path, whichever shape the API used.
  String? get imagePath {
    String? pathOf(dynamic value) {
      if (value is String) return value;
      if (value is Map) return value['url']?.toString();
      return null;
    }

    if (images is List && (images as List).isNotEmpty) {
      return pathOf((images as List).first);
    }
    return pathOf(image);
  }

  static final fromMap = CartItemMapper.fromMap;
  static final fromJson = CartItemMapper.fromJson;
}

@MappableClass()
class Cart with CartMappable {
  const Cart({this.id, this.branchId, this.items});

  final String? id;
  @MappableField(key: 'branch_id')
  final String? branchId;
  final List<CartItem>? items;

  int get itemCount =>
      (items ?? const []).fold<int>(0, (sum, i) => sum + (i.qty ?? 0).toInt());

  num get subtotal =>
      (items ?? const []).fold<num>(0, (sum, i) => sum + i.lineTotal);

  static final fromMap = CartMapper.fromMap;
  static final fromJson = CartMapper.fromJson;
}
