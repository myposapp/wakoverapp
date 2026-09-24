// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bank_model.dart';

class BankMapper extends ClassMapperBase<Bank> {
  BankMapper._();

  static BankMapper? _instance;
  static BankMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BankMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Bank';

  static String? _$name(Bank v) => v.name;
  static const Field<Bank, String> _f$name = Field('name', _$name, opt: true);
  static String? _$code(Bank v) => v.code;
  static const Field<Bank, String> _f$code = Field('code', _$code, opt: true);

  @override
  final MappableFields<Bank> fields = const {#name: _f$name, #code: _f$code};

  static Bank _instantiate(DecodingData data) {
    return Bank(name: data.dec(_f$name), code: data.dec(_f$code));
  }

  @override
  final Function instantiate = _instantiate;

  static Bank fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Bank>(map);
  }

  static Bank fromJson(String json) {
    return ensureInitialized().decodeJson<Bank>(json);
  }
}

mixin BankMappable {
  String toJson() {
    return BankMapper.ensureInitialized().encodeJson<Bank>(this as Bank);
  }

  Map<String, dynamic> toMap() {
    return BankMapper.ensureInitialized().encodeMap<Bank>(this as Bank);
  }

  BankCopyWith<Bank, Bank, Bank> get copyWith =>
      _BankCopyWithImpl<Bank, Bank>(this as Bank, $identity, $identity);
  @override
  String toString() {
    return BankMapper.ensureInitialized().stringifyValue(this as Bank);
  }

  @override
  bool operator ==(Object other) {
    return BankMapper.ensureInitialized().equalsValue(this as Bank, other);
  }

  @override
  int get hashCode {
    return BankMapper.ensureInitialized().hashValue(this as Bank);
  }
}

extension BankValueCopy<$R, $Out> on ObjectCopyWith<$R, Bank, $Out> {
  BankCopyWith<$R, Bank, $Out> get $asBank =>
      $base.as((v, t, t2) => _BankCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BankCopyWith<$R, $In extends Bank, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? code});
  BankCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BankCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Bank, $Out>
    implements BankCopyWith<$R, Bank, $Out> {
  _BankCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Bank> $mapper = BankMapper.ensureInitialized();
  @override
  $R call({Object? name = $none, Object? code = $none}) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (code != $none) #code: code,
    }),
  );
  @override
  Bank $make(CopyWithData data) => Bank(
    name: data.get(#name, or: $value.name),
    code: data.get(#code, or: $value.code),
  );

  @override
  BankCopyWith<$R2, Bank, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BankCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

