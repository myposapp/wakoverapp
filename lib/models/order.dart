class OrderItemDetail {
  final String productId;
  final String name;
  final int quantity;
  final double price;

  OrderItemDetail({
    required this.productId,
    required this.name,
    required this.quantity,
    required this.price,
  });

  factory OrderItemDetail.fromJson(Map<String, dynamic> json) {
    return OrderItemDetail(
      productId: json['productId'] as String,
      name: json['name'] as String,
      quantity: json['quantity'] as int,
      price: (json['price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'productId': productId,
      'name': name,
      'quantity': quantity,
      'price': price,
    };
  }
}

class Order {
  final String id;
  final String customerName;
  final double total;
  final String date;
  String status; // 'processing', 'shipped', 'delivered'
  final int itemsCount;
  final bool escrowSecured;
  String? trackingNumber;
  final List<OrderItemDetail> items;

  Order({
    required this.id,
    required this.customerName,
    required this.total,
    required this.date,
    required this.status,
    required this.itemsCount,
    required this.escrowSecured,
    this.trackingNumber,
    required this.items,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'] as String,
      customerName: json['customerName'] as String,
      total: (json['total'] as num).toDouble(),
      date: json['date'] as String,
      status: json['status'] as String,
      itemsCount: json['itemsCount'] as int,
      escrowSecured: json['escrowSecured'] as bool,
      trackingNumber: json['trackingNumber'] as String?,
      items: (json['items'] as List)
          .map((i) => OrderItemDetail.fromJson(i as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'customerName': customerName,
      'total': total,
      'date': date,
      'status': status,
      'itemsCount': itemsCount,
      'escrowSecured': escrowSecured,
      'trackingNumber': trackingNumber,
      'items': items.map((i) => i.toJson()).toList(),
    };
  }
}
