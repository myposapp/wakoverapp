import 'package:dart_mappable/dart_mappable.dart';

part 'auth_config_model.mapper.dart';

@MappableClass()
class AuthConfigData with AuthConfigDataMappable {
  const AuthConfigData({this.id, this.showMerchantCampaigns});

  final String? id;
  @MappableField(key: 'show_merchant_campaigns')
  final bool? showMerchantCampaigns;

  static final fromMap = AuthConfigDataMapper.fromMap;
  static final fromJson = AuthConfigDataMapper.fromJson;
}
