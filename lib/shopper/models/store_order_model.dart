import 'package:dart_mappable/dart_mappable.dart';
import 'merchant_info_model.dart';
import 'product_image_model.dart';

part 'store_order_model.mapper.dart';

@MappableClass()
class StoreOrderItem with StoreOrderItemMappable {
  const StoreOrderItem({
    this.id,
    this.productId,
    this.name,
    this.image,
    this.productType,
    this.qty,
    this.unit,
    this.price,
    this.variant,
    this.files,
    this.review,
  });

  final String? id;
  @MappableField(key: 'product_id')
  final String? productId;
  final String? name;
  final ProductImage? image;
  // 'product' for physical goods, 'digital' for downloadable files.
  @MappableField(key: 'product_type')
  final String? productType;
  final num? qty;
  final String? unit;
  final num? price;
  final dynamic variant;
  final List<dynamic>? files;
  final dynamic review;

  bool get isDigital => productType == 'digital';

  num get unitPrice {
    final variantPrice = variant is Map ? variant['price'] : null;
    return (price ?? 0) + (variantPrice is num ? variantPrice : 0);
  }

  num get lineTotal => unitPrice * (qty ?? 1);

  static final fromMap = StoreOrderItemMapper.fromMap;
  static final fromJson = StoreOrderItemMapper.fromJson;
}

@MappableClass()
class ShippingAddress with ShippingAddressMappable {
  const ShippingAddress({
    this.name,
    this.phone,
    this.email,
    this.address,
    this.address2,
    this.city,
    this.county,
    this.state,
    this.country,
  });

  final String? name;
  final String? phone;
  final String? email;
  final String? address;
  final String? address2;
  final String? city;
  final String? county;
  final String? state;
  final String? country;

  static final fromMap = ShippingAddressMapper.fromMap;
  static final fromJson = ShippingAddressMapper.fromJson;
}

@MappableClass()
class ShippingDetail with ShippingDetailMappable {
  const ShippingDetail({this.contact, this.address});

  final ShippingAddress? contact;
  final ShippingAddress? address;

  static final fromMap = ShippingDetailMapper.fromMap;
  static final fromJson = ShippingDetailMapper.fromJson;
}

@MappableClass()
class DeliveryStatus with DeliveryStatusMappable {
  const DeliveryStatus({this.id, this.status, this.note, this.dateTime});

  final String? id;
  final String? status;
  final String? note;
  @MappableField(key: 'date_time')
  final String? dateTime;

  static final fromMap = DeliveryStatusMapper.fromMap;
  static final fromJson = DeliveryStatusMapper.fromJson;
}

/// An order placed through the store's cart checkout.
@MappableClass()
class StoreOrder with StoreOrderMappable {
  const StoreOrder({
    this.id,
    this.status,
    this.items,
    this.fees,
    this.shippingDetail,
    this.deliveryStatus,
    this.merchant,
    this.paymentReference,
    this.createdAt,
    this.updatedAt,
  });

  final String? id;
  final String? status;
  final List<StoreOrderItem>? items;
  // A map of fee name to amount, e.g. {"transaction_fee": 200}.
  final dynamic fees;
  @MappableField(key: 'shipping_detail')
  final ShippingDetail? shippingDetail;
  @MappableField(key: 'delivery_status')
  final List<DeliveryStatus>? deliveryStatus;
  final MerchantInfo? merchant;
  @MappableField(key: 'payment_reference')
  final String? paymentReference;
  final String? createdAt;
  final String? updatedAt;

  num get itemsTotal =>
      (items ?? const []).fold<num>(0, (sum, item) => sum + item.lineTotal);

  static final fromMap = StoreOrderMapper.fromMap;
  static final fromJson = StoreOrderMapper.fromJson;
}
