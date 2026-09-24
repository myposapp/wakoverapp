// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'utility_customer_account_model.dart';

class UtilityCustomerAccountMapper
    extends ClassMapperBase<UtilityCustomerAccount> {
  UtilityCustomerAccountMapper._();

  static UtilityCustomerAccountMapper? _instance;
  static UtilityCustomerAccountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = UtilityCustomerAccountMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'UtilityCustomerAccount';

  static String? _$meterNo(UtilityCustomerAccount v) => v.meterNo;
  static const Field<UtilityCustomerAccount, String> _f$meterNo = Field(
    'meterNo',
    _$meterNo,
    key: r'meter_no',
    opt: true,
  );
  static String? _$meterType(UtilityCustomerAccount v) => v.meterType;
  static const Field<UtilityCustomerAccount, String> _f$meterType = Field(
    'meterType',
    _$meterType,
    key: r'meter_type',
    opt: true,
  );
  static String? _$provider(UtilityCustomerAccount v) => v.provider;
  static const Field<UtilityCustomerAccount, String> _f$provider = Field(
    'provider',
    _$provider,
    opt: true,
  );
  static String? _$name(UtilityCustomerAccount v) => v.name;
  static const Field<UtilityCustomerAccount, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$address(UtilityCustomerAccount v) => v.address;
  static const Field<UtilityCustomerAccount, String> _f$address = Field(
    'address',
    _$address,
    opt: true,
  );
  static num? _$outstanding(UtilityCustomerAccount v) => v.outstanding;
  static const Field<UtilityCustomerAccount, num> _f$outstanding = Field(
    'outstanding',
    _$outstanding,
    opt: true,
  );
  static num? _$minAmount(UtilityCustomerAccount v) => v.minAmount;
  static const Field<UtilityCustomerAccount, num> _f$minAmount = Field(
    'minAmount',
    _$minAmount,
    key: r'min_amount',
    opt: true,
  );
  static num? _$maxAmount(UtilityCustomerAccount v) => v.maxAmount;
  static const Field<UtilityCustomerAccount, num> _f$maxAmount = Field(
    'maxAmount',
    _$maxAmount,
    key: r'max_amount',
    opt: true,
  );

  @override
  final MappableFields<UtilityCustomerAccount> fields = const {
    #meterNo: _f$meterNo,
    #meterType: _f$meterType,
    #provider: _f$provider,
    #name: _f$name,
    #address: _f$address,
    #outstanding: _f$outstanding,
    #minAmount: _f$minAmount,
    #maxAmount: _f$maxAmount,
  };

  static UtilityCustomerAccount _instantiate(DecodingData data) {
    return UtilityCustomerAccount(
      meterNo: data.dec(_f$meterNo),
      meterType: data.dec(_f$meterType),
      provider: data.dec(_f$provider),
      name: data.dec(_f$name),
      address: data.dec(_f$address),
      outstanding: data.dec(_f$outstanding),
      minAmount: data.dec(_f$minAmount),
      maxAmount: data.dec(_f$maxAmount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static UtilityCustomerAccount fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<UtilityCustomerAccount>(map);
  }

  static UtilityCustomerAccount fromJson(String json) {
    return ensureInitialized().decodeJson<UtilityCustomerAccount>(json);
  }
}

mixin UtilityCustomerAccountMappable {
  String toJson() {
    return UtilityCustomerAccountMapper.ensureInitialized()
        .encodeJson<UtilityCustomerAccount>(this as UtilityCustomerAccount);
  }

  Map<String, dynamic> toMap() {
    return UtilityCustomerAccountMapper.ensureInitialized()
        .encodeMap<UtilityCustomerAccount>(this as UtilityCustomerAccount);
  }

  UtilityCustomerAccountCopyWith<
    UtilityCustomerAccount,
    UtilityCustomerAccount,
    UtilityCustomerAccount
  >
  get copyWith =>
      _UtilityCustomerAccountCopyWithImpl<
        UtilityCustomerAccount,
        UtilityCustomerAccount
      >(this as UtilityCustomerAccount, $identity, $identity);
  @override
  String toString() {
    return UtilityCustomerAccountMapper.ensureInitialized().stringifyValue(
      this as UtilityCustomerAccount,
    );
  }

  @override
  bool operator ==(Object other) {
    return UtilityCustomerAccountMapper.ensureInitialized().equalsValue(
      this as UtilityCustomerAccount,
      other,
    );
  }

  @override
  int get hashCode {
    return UtilityCustomerAccountMapper.ensureInitialized().hashValue(
      this as UtilityCustomerAccount,
    );
  }
}

extension UtilityCustomerAccountValueCopy<$R, $Out>
    on ObjectCopyWith<$R, UtilityCustomerAccount, $Out> {
  UtilityCustomerAccountCopyWith<$R, UtilityCustomerAccount, $Out>
  get $asUtilityCustomerAccount => $base.as(
    (v, t, t2) => _UtilityCustomerAccountCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class UtilityCustomerAccountCopyWith<
  $R,
  $In extends UtilityCustomerAccount,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? meterNo,
    String? meterType,
    String? provider,
    String? name,
    String? address,
    num? outstanding,
    num? minAmount,
    num? maxAmount,
  });
  UtilityCustomerAccountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _UtilityCustomerAccountCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, UtilityCustomerAccount, $Out>
    implements
        UtilityCustomerAccountCopyWith<$R, UtilityCustomerAccount, $Out> {
  _UtilityCustomerAccountCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<UtilityCustomerAccount> $mapper =
      UtilityCustomerAccountMapper.ensureInitialized();
  @override
  $R call({
    Object? meterNo = $none,
    Object? meterType = $none,
    Object? provider = $none,
    Object? name = $none,
    Object? address = $none,
    Object? outstanding = $none,
    Object? minAmount = $none,
    Object? maxAmount = $none,
  }) => $apply(
    FieldCopyWithData({
      if (meterNo != $none) #meterNo: meterNo,
      if (meterType != $none) #meterType: meterType,
      if (provider != $none) #provider: provider,
      if (name != $none) #name: name,
      if (address != $none) #address: address,
      if (outstanding != $none) #outstanding: outstanding,
      if (minAmount != $none) #minAmount: minAmount,
      if (maxAmount != $none) #maxAmount: maxAmount,
    }),
  );
  @override
  UtilityCustomerAccount $make(CopyWithData data) => UtilityCustomerAccount(
    meterNo: data.get(#meterNo, or: $value.meterNo),
    meterType: data.get(#meterType, or: $value.meterType),
    provider: data.get(#provider, or: $value.provider),
    name: data.get(#name, or: $value.name),
    address: data.get(#address, or: $value.address),
    outstanding: data.get(#outstanding, or: $value.outstanding),
    minAmount: data.get(#minAmount, or: $value.minAmount),
    maxAmount: data.get(#maxAmount, or: $value.maxAmount),
  );

  @override
  UtilityCustomerAccountCopyWith<$R2, UtilityCustomerAccount, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _UtilityCustomerAccountCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

