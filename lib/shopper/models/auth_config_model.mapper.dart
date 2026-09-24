// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'auth_config_model.dart';

class AuthConfigDataMapper extends ClassMapperBase<AuthConfigData> {
  AuthConfigDataMapper._();

  static AuthConfigDataMapper? _instance;
  static AuthConfigDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AuthConfigDataMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'AuthConfigData';

  static String? _$id(AuthConfigData v) => v.id;
  static const Field<AuthConfigData, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static bool? _$showMerchantCampaigns(AuthConfigData v) =>
      v.showMerchantCampaigns;
  static const Field<AuthConfigData, bool> _f$showMerchantCampaigns = Field(
    'showMerchantCampaigns',
    _$showMerchantCampaigns,
    key: r'show_merchant_campaigns',
    opt: true,
  );

  @override
  final MappableFields<AuthConfigData> fields = const {
    #id: _f$id,
    #showMerchantCampaigns: _f$showMerchantCampaigns,
  };

  static AuthConfigData _instantiate(DecodingData data) {
    return AuthConfigData(
      id: data.dec(_f$id),
      showMerchantCampaigns: data.dec(_f$showMerchantCampaigns),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AuthConfigData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AuthConfigData>(map);
  }

  static AuthConfigData fromJson(String json) {
    return ensureInitialized().decodeJson<AuthConfigData>(json);
  }
}

mixin AuthConfigDataMappable {
  String toJson() {
    return AuthConfigDataMapper.ensureInitialized().encodeJson<AuthConfigData>(
      this as AuthConfigData,
    );
  }

  Map<String, dynamic> toMap() {
    return AuthConfigDataMapper.ensureInitialized().encodeMap<AuthConfigData>(
      this as AuthConfigData,
    );
  }

  AuthConfigDataCopyWith<AuthConfigData, AuthConfigData, AuthConfigData>
  get copyWith => _AuthConfigDataCopyWithImpl<AuthConfigData, AuthConfigData>(
    this as AuthConfigData,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return AuthConfigDataMapper.ensureInitialized().stringifyValue(
      this as AuthConfigData,
    );
  }

  @override
  bool operator ==(Object other) {
    return AuthConfigDataMapper.ensureInitialized().equalsValue(
      this as AuthConfigData,
      other,
    );
  }

  @override
  int get hashCode {
    return AuthConfigDataMapper.ensureInitialized().hashValue(
      this as AuthConfigData,
    );
  }
}

extension AuthConfigDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AuthConfigData, $Out> {
  AuthConfigDataCopyWith<$R, AuthConfigData, $Out> get $asAuthConfigData =>
      $base.as((v, t, t2) => _AuthConfigDataCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AuthConfigDataCopyWith<$R, $In extends AuthConfigData, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, bool? showMerchantCampaigns});
  AuthConfigDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AuthConfigDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AuthConfigData, $Out>
    implements AuthConfigDataCopyWith<$R, AuthConfigData, $Out> {
  _AuthConfigDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AuthConfigData> $mapper =
      AuthConfigDataMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, Object? showMerchantCampaigns = $none}) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (showMerchantCampaigns != $none)
            #showMerchantCampaigns: showMerchantCampaigns,
        }),
      );
  @override
  AuthConfigData $make(CopyWithData data) => AuthConfigData(
    id: data.get(#id, or: $value.id),
    showMerchantCampaigns: data.get(
      #showMerchantCampaigns,
      or: $value.showMerchantCampaigns,
    ),
  );

  @override
  AuthConfigDataCopyWith<$R2, AuthConfigData, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AuthConfigDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

