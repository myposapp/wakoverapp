import 'package:dart_mappable/dart_mappable.dart';
import 'product_image_model.dart';

part 'affiliate_code_model.mapper.dart';

@MappableClass()
class AffiliateProduct with AffiliateProductMappable {
  const AffiliateProduct({this.id, this.name, this.image, this.price});

  final String? id;
  final String? name;
  final ProductImage? image;
  final num? price;

  static final fromMap = AffiliateProductMapper.fromMap;
  static final fromJson = AffiliateProductMapper.fromJson;
}

@MappableClass()
class AffiliateCode with AffiliateCodeMappable {
  const AffiliateCode({
    this.id,
    this.code,
    this.name,
    this.description,
    this.status,
    this.commType,
    this.commAmount,
    this.commMax,
    this.totalEarning,
    this.blacklist,
    this.whitelist,
  });

  final String? id;
  final String? code;
  final String? name;
  final String? description;
  final String? status;
  // 'percent' or 'flat'.
  @MappableField(key: 'comm_type')
  final String? commType;
  @MappableField(key: 'comm_amount')
  final num? commAmount;
  @MappableField(key: 'comm_max')
  final num? commMax;
  @MappableField(key: 'total_earning')
  final num? totalEarning;
  // Products the code can't be used on.
  final List<AffiliateProduct>? blacklist;
  // Products the code is limited to.
  final List<AffiliateProduct>? whitelist;

  static final fromMap = AffiliateCodeMapper.fromMap;
  static final fromJson = AffiliateCodeMapper.fromJson;
}
