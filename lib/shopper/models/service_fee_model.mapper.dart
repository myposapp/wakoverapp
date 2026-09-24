// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'service_fee_model.dart';

class ServiceFeeResultMapper extends ClassMapperBase<ServiceFeeResult> {
  ServiceFeeResultMapper._();

  static ServiceFeeResultMapper? _instance;
  static ServiceFeeResultMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ServiceFeeResultMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ServiceFeeResult';

  static num? _$amount(ServiceFeeResult v) => v.amount;
  static const Field<ServiceFeeResult, num> _f$amount = Field(
    'amount',
    _$amount,
    opt: true,
  );
  static num? _$serviceFee(ServiceFeeResult v) => v.serviceFee;
  static const Field<ServiceFeeResult, num> _f$serviceFee = Field(
    'serviceFee',
    _$serviceFee,
    key: r'service_fee',
    opt: true,
  );

  @override
  final MappableFields<ServiceFeeResult> fields = const {
    #amount: _f$amount,
    #serviceFee: _f$serviceFee,
  };

  static ServiceFeeResult _instantiate(DecodingData data) {
    return ServiceFeeResult(
      amount: data.dec(_f$amount),
      serviceFee: data.dec(_f$serviceFee),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ServiceFeeResult fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ServiceFeeResult>(map);
  }

  static ServiceFeeResult fromJson(String json) {
    return ensureInitialized().decodeJson<ServiceFeeResult>(json);
  }
}

mixin ServiceFeeResultMappable {
  String toJson() {
    return ServiceFeeResultMapper.ensureInitialized()
        .encodeJson<ServiceFeeResult>(this as ServiceFeeResult);
  }

  Map<String, dynamic> toMap() {
    return ServiceFeeResultMapper.ensureInitialized()
        .encodeMap<ServiceFeeResult>(this as ServiceFeeResult);
  }

  ServiceFeeResultCopyWith<ServiceFeeResult, ServiceFeeResult, ServiceFeeResult>
  get copyWith =>
      _ServiceFeeResultCopyWithImpl<ServiceFeeResult, ServiceFeeResult>(
        this as ServiceFeeResult,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ServiceFeeResultMapper.ensureInitialized().stringifyValue(
      this as ServiceFeeResult,
    );
  }

  @override
  bool operator ==(Object other) {
    return ServiceFeeResultMapper.ensureInitialized().equalsValue(
      this as ServiceFeeResult,
      other,
    );
  }

  @override
  int get hashCode {
    return ServiceFeeResultMapper.ensureInitialized().hashValue(
      this as ServiceFeeResult,
    );
  }
}

extension ServiceFeeResultValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ServiceFeeResult, $Out> {
  ServiceFeeResultCopyWith<$R, ServiceFeeResult, $Out>
  get $asServiceFeeResult =>
      $base.as((v, t, t2) => _ServiceFeeResultCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ServiceFeeResultCopyWith<$R, $In extends ServiceFeeResult, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({num? amount, num? serviceFee});
  ServiceFeeResultCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ServiceFeeResultCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ServiceFeeResult, $Out>
    implements ServiceFeeResultCopyWith<$R, ServiceFeeResult, $Out> {
  _ServiceFeeResultCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ServiceFeeResult> $mapper =
      ServiceFeeResultMapper.ensureInitialized();
  @override
  $R call({Object? amount = $none, Object? serviceFee = $none}) => $apply(
    FieldCopyWithData({
      if (amount != $none) #amount: amount,
      if (serviceFee != $none) #serviceFee: serviceFee,
    }),
  );
  @override
  ServiceFeeResult $make(CopyWithData data) => ServiceFeeResult(
    amount: data.get(#amount, or: $value.amount),
    serviceFee: data.get(#serviceFee, or: $value.serviceFee),
  );

  @override
  ServiceFeeResultCopyWith<$R2, ServiceFeeResult, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ServiceFeeResultCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

