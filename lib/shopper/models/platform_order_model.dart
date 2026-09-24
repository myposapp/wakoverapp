import 'package:dart_mappable/dart_mappable.dart';
import 'product_category_model.dart';

part 'platform_order_model.mapper.dart';

@MappableClass()
class PlatformOrderProduct with PlatformOrderProductMappable {
  const PlatformOrderProduct({this.id, this.name, this.image, this.category});

  final String? id;
  final String? name;
  final String? image;
  final ProductCategory? category;

  static final fromMap = PlatformOrderProductMapper.fromMap;
  static final fromJson = PlatformOrderProductMapper.fromJson;
}

@MappableClass()
class PlatformOrder with PlatformOrderMappable {
  const PlatformOrder({
    this.id,
    this.purchaseDetail,
    this.fees,
    this.transactionId,
    this.companyId,
    this.merchantId,
    this.userId,
    this.productId,
    this.paymentReference,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.product,
    this.merchant,
    this.user,
  });

  final String? id;
  // Shape varies by product/category (airtime vs. utility bill vs. data), so
  // it is kept dynamic rather than modeled.
  @MappableField(key: 'purchase_detail')
  final dynamic purchaseDetail;
  final dynamic fees;
  @MappableField(key: 'transaction_id')
  final String? transactionId;
  @MappableField(key: 'company_id')
  final String? companyId;
  @MappableField(key: 'merchant_id')
  final String? merchantId;
  @MappableField(key: 'user_id')
  final String? userId;
  @MappableField(key: 'product_id')
  final String? productId;
  @MappableField(key: 'payment_reference')
  final String? paymentReference;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final PlatformOrderProduct? product;
  // Only present on the single-order detail endpoint, not the list endpoint.
  final dynamic merchant;
  final dynamic user;

  static final fromMap = PlatformOrderMapper.fromMap;
  static final fromJson = PlatformOrderMapper.fromJson;
}
