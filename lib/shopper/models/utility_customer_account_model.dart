import 'package:dart_mappable/dart_mappable.dart';

part 'utility_customer_account_model.mapper.dart';

@MappableClass()
class UtilityCustomerAccount with UtilityCustomerAccountMappable {
  const UtilityCustomerAccount({
    this.meterNo,
    this.meterType,
    this.provider,
    this.name,
    this.address,
    this.outstanding,
    this.minAmount,
    this.maxAmount,
  });

  @MappableField(key: 'meter_no')
  final String? meterNo;
  @MappableField(key: 'meter_type')
  final String? meterType;
  final String? provider;
  final String? name;
  final String? address;
  final num? outstanding;
  @MappableField(key: 'min_amount')
  final num? minAmount;
  @MappableField(key: 'max_amount')
  final num? maxAmount;

  static final fromMap = UtilityCustomerAccountMapper.fromMap;
  static final fromJson = UtilityCustomerAccountMapper.fromJson;
}
