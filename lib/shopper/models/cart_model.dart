import 'package:dart_mappable/dart_mappable.dart';

part 'cart_model.mapper.dart';

@MappableClass()
class CartItem with CartItemMappable {
  const CartItem({
    this.id,
    this.name,
    this.qty,
    this.price,
    this.unit,
    this.images,
    this.image,
    this.variant,
  });

  // The product id.
  final String? id;
  final String? name;
  final num? qty;
  final num? price;
  final String? unit;
  final dynamic images;
  final dynamic image;
  final dynamic variant;

  String? get variantId => variant is Map ? variant['id']?.toString() : null;

  String? get variantName =>
      variant is Map ? variant['name']?.toString() : null;

  num get unitPrice {
    final variantPrice = variant is Map ? variant['price'] : null;
    return (price ?? 0) + (variantPrice is num ? variantPrice : 0);
  }

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
