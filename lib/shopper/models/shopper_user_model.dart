import 'package:dart_mappable/dart_mappable.dart';

part 'shopper_user_model.mapper.dart';

@MappableClass()
class Kyc with KycMappable {
  const Kyc({
    this.id,
    this.completion,
    this.status,
    this.userId,
    this.createdAt,
    this.updatedAt,
    this.docs,
  });

  final String? id;
  final num? completion;
  final String? status;
  @MappableField(key: 'user_id')
  final String? userId;
  final String? createdAt;
  final String? updatedAt;
  final List<dynamic>? docs;

  static final fromMap = KycMapper.fromMap;
  static final fromJson = KycMapper.fromJson;
}

@MappableClass()
class ShopperUser with ShopperUserMappable {
  const ShopperUser({
    this.id,
    this.name,
    this.phone,
    this.email,
    this.photo,
    this.userType,
    this.userLevel,
    this.sessionId,
    this.walletId,
    this.walletBalance,
    this.points,
    this.kyc,
    this.config,
  });

  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? photo;
  @MappableField(key: 'user_type')
  final String? userType;
  // The API returns this as an int on sign-in but as a string on sign-up.
  @MappableField(key: 'user_level')
  final dynamic userLevel;
  @MappableField(key: 'session_id')
  final String? sessionId;
  @MappableField(key: 'wallet_id')
  final String? walletId;
  @MappableField(key: 'wallet_balance')
  final num? walletBalance;
  final num? points;
  final Kyc? kyc;
  final dynamic config;

  static final fromMap = ShopperUserMapper.fromMap;
  static final fromJson = ShopperUserMapper.fromJson;
}
