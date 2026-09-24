import 'package:dart_mappable/dart_mappable.dart';

part 'payment_gateway_model.mapper.dart';

@MappableClass()
class PaymentGatewayFee with PaymentGatewayFeeMappable {
  const PaymentGatewayFee({this.method, this.feeAmountType, this.feeAmount});

  final String? method;
  final String? feeAmountType;
  final num? feeAmount;

  static final fromMap = PaymentGatewayFeeMapper.fromMap;
  static final fromJson = PaymentGatewayFeeMapper.fromJson;
}

@MappableClass()
class PaymentGateway with PaymentGatewayMappable {
  const PaymentGateway({this.id, this.fees});

  final String? id;
  final List<PaymentGatewayFee>? fees;

  static final fromMap = PaymentGatewayMapper.fromMap;
  static final fromJson = PaymentGatewayMapper.fromJson;
}
