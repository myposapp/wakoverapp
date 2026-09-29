import 'package:dart_mappable/dart_mappable.dart';
import 'merchant_info_model.dart';
import 'product_image_model.dart';

part 'payment_model.mapper.dart';

@MappableClass()
class PaymentProductSummary with PaymentProductSummaryMappable {
  const PaymentProductSummary({this.id, this.name, this.image});

  final String? id;
  final String? name;
  final ProductImage? image;

  static final fromMap = PaymentProductSummaryMapper.fromMap;
  static final fromJson = PaymentProductSummaryMapper.fromJson;
}

/// A payment made against one of the store's payment products.
@MappableClass()
class StorePayment with StorePaymentMappable {
  const StorePayment({
    this.id,
    this.status,
    this.amount,
    this.fees,
    this.remark,
    this.paymentReference,
    this.product,
    this.merchant,
    this.createdAt,
  });

  final String? id;
  final String? status;
  final num? amount;
  // A map of fee name to amount.
  final dynamic fees;
  final String? remark;
  @MappableField(key: 'payment_reference')
  final String? paymentReference;
  final PaymentProductSummary? product;
  final MerchantInfo? merchant;
  final String? createdAt;

  static final fromMap = StorePaymentMapper.fromMap;
  static final fromJson = StorePaymentMapper.fromJson;
}
