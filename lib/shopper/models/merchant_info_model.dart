import 'package:dart_mappable/dart_mappable.dart';

part 'merchant_info_model.mapper.dart';

@MappableClass()
class MerchantBranch with MerchantBranchMappable {
  const MerchantBranch({
    this.id,
    this.name,
    this.phone,
    this.address,
    this.checkin,
    this.checkout,
  });

  final String? id;
  final String? name;
  final String? phone;
  final String? address;
  final String? checkin;
  final String? checkout;

  static final fromMap = MerchantBranchMapper.fromMap;
  static final fromJson = MerchantBranchMapper.fromJson;
}

/// The merchant summary embedded in orders, bookings and payments.
@MappableClass()
class MerchantInfo with MerchantInfoMappable {
  const MerchantInfo({this.id, this.name, this.branch});

  final String? id;
  final String? name;
  final MerchantBranch? branch;

  static final fromMap = MerchantInfoMapper.fromMap;
  static final fromJson = MerchantInfoMapper.fromJson;
}
