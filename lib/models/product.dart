class Product {
  final String id;
  final String name;
  final String sku;
  final String category;
  final double price;
  final double? originalPrice;
  int stock;
  final int targetStock;
  final String image;
  String status; // 'in_stock', 'low_stock', 'out_of_stock'
  final String? badge;
  final int salesCount;
  final double revenue;

  Product({
    required this.id,
    required this.name,
    required this.sku,
    required this.category,
    required this.price,
    this.originalPrice,
    required this.stock,
    required this.targetStock,
    required this.image,
    required this.status,
    this.badge,
    this.salesCount = 0,
    this.revenue = 0.0,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      sku: json['sku'] as String,
      category: json['category'] as String,
      price: (json['price'] as num).toDouble(),
      originalPrice: json['originalPrice'] != null
          ? (json['originalPrice'] as num).toDouble()
          : null,
      stock: json['stock'] as int,
      targetStock: json['targetStock'] as int,
      image: json['image'] as String,
      status: json['status'] as String,
      badge: json['badge'] as String?,
      salesCount: (json['salesCount'] as int?) ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'sku': sku,
      'category': category,
      'price': price,
      'originalPrice': originalPrice,
      'stock': stock,
      'targetStock': targetStock,
      'image': image,
      'status': status,
      'badge': badge,
      'salesCount': salesCount,
      'revenue': revenue,
    };
  }

  Product copyWith({
    int? stock,
    String? status,
  }) {
    return Product(
      id: id,
      name: name,
      sku: sku,
      category: category,
      price: price,
      originalPrice: originalPrice,
      stock: stock ?? this.stock,
      targetStock: targetStock,
      image: image,
      status: status ?? this.status,
      badge: badge,
      salesCount: salesCount,
      revenue: revenue,
    );
  }
}
