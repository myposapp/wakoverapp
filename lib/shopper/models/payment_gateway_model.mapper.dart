// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'payment_gateway_model.dart';

class PaymentGatewayFeeMapper extends ClassMapperBase<PaymentGatewayFee> {
  PaymentGatewayFeeMapper._();

  static PaymentGatewayFeeMapper? _instance;
  static PaymentGatewayFeeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PaymentGatewayFeeMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PaymentGatewayFee';

  static String? _$method(PaymentGatewayFee v) => v.method;
  static const Field<PaymentGatewayFee, String> _f$method = Field(
    'method',
    _$method,
    opt: true,
  );
  static String? _$feeAmountType(PaymentGatewayFee v) => v.feeAmountType;
  static const Field<PaymentGatewayFee, String> _f$feeAmountType = Field(
    'feeAmountType',
    _$feeAmountType,
    opt: true,
  );
  static num? _$feeAmount(PaymentGatewayFee v) => v.feeAmount;
  static const Field<PaymentGatewayFee, num> _f$feeAmount = Field(
    'feeAmount',
    _$feeAmount,
    opt: true,
  );

  @override
  final MappableFields<PaymentGatewayFee> fields = const {
    #method: _f$method,
    #feeAmountType: _f$feeAmountType,
    #feeAmount: _f$feeAmount,
  };

  static PaymentGatewayFee _instantiate(DecodingData data) {
    return PaymentGatewayFee(
      method: data.dec(_f$method),
      feeAmountType: data.dec(_f$feeAmountType),
      feeAmount: data.dec(_f$feeAmount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PaymentGatewayFee fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PaymentGatewayFee>(map);
  }

  static PaymentGatewayFee fromJson(String json) {
    return ensureInitialized().decodeJson<PaymentGatewayFee>(json);
  }
}

mixin PaymentGatewayFeeMappable {
  String toJson() {
    return PaymentGatewayFeeMapper.ensureInitialized()
        .encodeJson<PaymentGatewayFee>(this as PaymentGatewayFee);
  }

  Map<String, dynamic> toMap() {
    return PaymentGatewayFeeMapper.ensureInitialized()
        .encodeMap<PaymentGatewayFee>(this as PaymentGatewayFee);
  }

  PaymentGatewayFeeCopyWith<
    PaymentGatewayFee,
    PaymentGatewayFee,
    PaymentGatewayFee
  >
  get copyWith =>
      _PaymentGatewayFeeCopyWithImpl<PaymentGatewayFee, PaymentGatewayFee>(
        this as PaymentGatewayFee,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return PaymentGatewayFeeMapper.ensureInitialized().stringifyValue(
      this as PaymentGatewayFee,
    );
  }

  @override
  bool operator ==(Object other) {
    return PaymentGatewayFeeMapper.ensureInitialized().equalsValue(
      this as PaymentGatewayFee,
      other,
    );
  }

  @override
  int get hashCode {
    return PaymentGatewayFeeMapper.ensureInitialized().hashValue(
      this as PaymentGatewayFee,
    );
  }
}

extension PaymentGatewayFeeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PaymentGatewayFee, $Out> {
  PaymentGatewayFeeCopyWith<$R, PaymentGatewayFee, $Out>
  get $asPaymentGatewayFee => $base.as(
    (v, t, t2) => _PaymentGatewayFeeCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PaymentGatewayFeeCopyWith<
  $R,
  $In extends PaymentGatewayFee,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? method, String? feeAmountType, num? feeAmount});
  PaymentGatewayFeeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PaymentGatewayFeeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PaymentGatewayFee, $Out>
    implements PaymentGatewayFeeCopyWith<$R, PaymentGatewayFee, $Out> {
  _PaymentGatewayFeeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PaymentGatewayFee> $mapper =
      PaymentGatewayFeeMapper.ensureInitialized();
  @override
  $R call({
    Object? method = $none,
    Object? feeAmountType = $none,
    Object? feeAmount = $none,
  }) => $apply(
    FieldCopyWithData({
      if (method != $none) #method: method,
      if (feeAmountType != $none) #feeAmountType: feeAmountType,
      if (feeAmount != $none) #feeAmount: feeAmount,
    }),
  );
  @override
  PaymentGatewayFee $make(CopyWithData data) => PaymentGatewayFee(
    method: data.get(#method, or: $value.method),
    feeAmountType: data.get(#feeAmountType, or: $value.feeAmountType),
    feeAmount: data.get(#feeAmount, or: $value.feeAmount),
  );

  @override
  PaymentGatewayFeeCopyWith<$R2, PaymentGatewayFee, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PaymentGatewayFeeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PaymentGatewayMapper extends ClassMapperBase<PaymentGateway> {
  PaymentGatewayMapper._();

  static PaymentGatewayMapper? _instance;
  static PaymentGatewayMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PaymentGatewayMapper._());
      PaymentGatewayFeeMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PaymentGateway';

  static String? _$id(PaymentGateway v) => v.id;
  static const Field<PaymentGateway, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static List<PaymentGatewayFee>? _$fees(PaymentGateway v) => v.fees;
  static const Field<PaymentGateway, List<PaymentGatewayFee>> _f$fees = Field(
    'fees',
    _$fees,
    opt: true,
  );

  @override
  final MappableFields<PaymentGateway> fields = const {
    #id: _f$id,
    #fees: _f$fees,
  };

  static PaymentGateway _instantiate(DecodingData data) {
    return PaymentGateway(id: data.dec(_f$id), fees: data.dec(_f$fees));
  }

  @override
  final Function instantiate = _instantiate;

  static PaymentGateway fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PaymentGateway>(map);
  }

  static PaymentGateway fromJson(String json) {
    return ensureInitialized().decodeJson<PaymentGateway>(json);
  }
}

mixin PaymentGatewayMappable {
  String toJson() {
    return PaymentGatewayMapper.ensureInitialized().encodeJson<PaymentGateway>(
      this as PaymentGateway,
    );
  }

  Map<String, dynamic> toMap() {
    return PaymentGatewayMapper.ensureInitialized().encodeMap<PaymentGateway>(
      this as PaymentGateway,
    );
  }

  PaymentGatewayCopyWith<PaymentGateway, PaymentGateway, PaymentGateway>
  get copyWith => _PaymentGatewayCopyWithImpl<PaymentGateway, PaymentGateway>(
    this as PaymentGateway,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PaymentGatewayMapper.ensureInitialized().stringifyValue(
      this as PaymentGateway,
    );
  }

  @override
  bool operator ==(Object other) {
    return PaymentGatewayMapper.ensureInitialized().equalsValue(
      this as PaymentGateway,
      other,
    );
  }

  @override
  int get hashCode {
    return PaymentGatewayMapper.ensureInitialized().hashValue(
      this as PaymentGateway,
    );
  }
}

extension PaymentGatewayValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PaymentGateway, $Out> {
  PaymentGatewayCopyWith<$R, PaymentGateway, $Out> get $asPaymentGateway =>
      $base.as((v, t, t2) => _PaymentGatewayCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PaymentGatewayCopyWith<$R, $In extends PaymentGateway, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    PaymentGatewayFee,
    PaymentGatewayFeeCopyWith<$R, PaymentGatewayFee, PaymentGatewayFee>
  >?
  get fees;
  $R call({String? id, List<PaymentGatewayFee>? fees});
  PaymentGatewayCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PaymentGatewayCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PaymentGateway, $Out>
    implements PaymentGatewayCopyWith<$R, PaymentGateway, $Out> {
  _PaymentGatewayCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PaymentGateway> $mapper =
      PaymentGatewayMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    PaymentGatewayFee,
    PaymentGatewayFeeCopyWith<$R, PaymentGatewayFee, PaymentGatewayFee>
  >?
  get fees => $value.fees != null
      ? ListCopyWith(
          $value.fees!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(fees: v),
        )
      : null;
  @override
  $R call({Object? id = $none, Object? fees = $none}) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (fees != $none) #fees: fees,
    }),
  );
  @override
  PaymentGateway $make(CopyWithData data) => PaymentGateway(
    id: data.get(#id, or: $value.id),
    fees: data.get(#fees, or: $value.fees),
  );

  @override
  PaymentGatewayCopyWith<$R2, PaymentGateway, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PaymentGatewayCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

