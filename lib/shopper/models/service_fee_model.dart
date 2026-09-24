import 'package:dart_mappable/dart_mappable.dart';

part 'service_fee_model.mapper.dart';

@MappableClass()
class ServiceFeeResult with ServiceFeeResultMappable {
  const ServiceFeeResult({this.amount, this.serviceFee});

  final num? amount;
  @MappableField(key: 'service_fee')
  final num? serviceFee;

  static final fromMap = ServiceFeeResultMapper.fromMap;
  static final fromJson = ServiceFeeResultMapper.fromJson;
}
