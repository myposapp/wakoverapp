// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'payment_model.dart';

class PaymentProductSummaryMapper
    extends ClassMapperBase<PaymentProductSummary> {
  PaymentProductSummaryMapper._();

  static PaymentProductSummaryMapper? _instance;
  static PaymentProductSummaryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PaymentProductSummaryMapper._());
      ProductImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PaymentProductSummary';

  static String? _$id(PaymentProductSummary v) => v.id;
  static const Field<PaymentProductSummary, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$name(PaymentProductSummary v) => v.name;
  static const Field<PaymentProductSummary, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static ProductImage? _$image(PaymentProductSummary v) => v.image;
  static const Field<PaymentProductSummary, ProductImage> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );

  @override
  final MappableFields<PaymentProductSummary> fields = const {
    #id: _f$id,
    #name: _f$name,
    #image: _f$image,
  };

  static PaymentProductSummary _instantiate(DecodingData data) {
    return PaymentProductSummary(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      image: data.dec(_f$image),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PaymentProductSummary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PaymentProductSummary>(map);
  }

  static PaymentProductSummary fromJson(String json) {
    return ensureInitialized().decodeJson<PaymentProductSummary>(json);
  }
}

mixin PaymentProductSummaryMappable {
  String toJson() {
    return PaymentProductSummaryMapper.ensureInitialized()
        .encodeJson<PaymentProductSummary>(this as PaymentProductSummary);
  }

  Map<String, dynamic> toMap() {
    return PaymentProductSummaryMapper.ensureInitialized()
        .encodeMap<PaymentProductSummary>(this as PaymentProductSummary);
  }

  PaymentProductSummaryCopyWith<
    PaymentProductSummary,
    PaymentProductSummary,
    PaymentProductSummary
  >
  get copyWith =>
      _PaymentProductSummaryCopyWithImpl<
        PaymentProductSummary,
        PaymentProductSummary
      >(this as PaymentProductSummary, $identity, $identity);
  @override
  String toString() {
    return PaymentProductSummaryMapper.ensureInitialized().stringifyValue(
      this as PaymentProductSummary,
    );
  }

  @override
  bool operator ==(Object other) {
    return PaymentProductSummaryMapper.ensureInitialized().equalsValue(
      this as PaymentProductSummary,
      other,
    );
  }

  @override
  int get hashCode {
    return PaymentProductSummaryMapper.ensureInitialized().hashValue(
      this as PaymentProductSummary,
    );
  }
}

extension PaymentProductSummaryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PaymentProductSummary, $Out> {
  PaymentProductSummaryCopyWith<$R, PaymentProductSummary, $Out>
  get $asPaymentProductSummary => $base.as(
    (v, t, t2) => _PaymentProductSummaryCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PaymentProductSummaryCopyWith<
  $R,
  $In extends PaymentProductSummary,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ProductImageCopyWith<$R, ProductImage, ProductImage>? get image;
  $R call({String? id, String? name, ProductImage? image});
  PaymentProductSummaryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PaymentProductSummaryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PaymentProductSummary, $Out>
    implements PaymentProductSummaryCopyWith<$R, PaymentProductSummary, $Out> {
  _PaymentProductSummaryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PaymentProductSummary> $mapper =
      PaymentProductSummaryMapper.ensureInitialized();
  @override
  ProductImageCopyWith<$R, ProductImage, ProductImage>? get image =>
      $value.image?.copyWith.$chain((v) => call(image: v));
  @override
  $R call({Object? id = $none, Object? name = $none, Object? image = $none}) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (name != $none) #name: name,
          if (image != $none) #image: image,
        }),
      );
  @override
  PaymentProductSummary $make(CopyWithData data) => PaymentProductSummary(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    image: data.get(#image, or: $value.image),
  );

  @override
  PaymentProductSummaryCopyWith<$R2, PaymentProductSummary, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PaymentProductSummaryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class StorePaymentMapper extends ClassMapperBase<StorePayment> {
  StorePaymentMapper._();

  static StorePaymentMapper? _instance;
  static StorePaymentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StorePaymentMapper._());
      PaymentProductSummaryMapper.ensureInitialized();
      MerchantInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StorePayment';

  static String? _$id(StorePayment v) => v.id;
  static const Field<StorePayment, String> _f$id = Field('id', _$id, opt: true);
  static String? _$status(StorePayment v) => v.status;
  static const Field<StorePayment, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static num? _$amount(StorePayment v) => v.amount;
  static const Field<StorePayment, num> _f$amount = Field(
    'amount',
    _$amount,
    opt: true,
  );
  static dynamic _$fees(StorePayment v) => v.fees;
  static const Field<StorePayment, dynamic> _f$fees = Field(
    'fees',
    _$fees,
    opt: true,
  );
  static String? _$remark(StorePayment v) => v.remark;
  static const Field<StorePayment, String> _f$remark = Field(
    'remark',
    _$remark,
    opt: true,
  );
  static String? _$paymentReference(StorePayment v) => v.paymentReference;
  static const Field<StorePayment, String> _f$paymentReference = Field(
    'paymentReference',
    _$paymentReference,
    key: r'payment_reference',
    opt: true,
  );
  static PaymentProductSummary? _$product(StorePayment v) => v.product;
  static const Field<StorePayment, PaymentProductSummary> _f$product = Field(
    'product',
    _$product,
    opt: true,
  );
  static MerchantInfo? _$merchant(StorePayment v) => v.merchant;
  static const Field<StorePayment, MerchantInfo> _f$merchant = Field(
    'merchant',
    _$merchant,
    opt: true,
  );
  static String? _$createdAt(StorePayment v) => v.createdAt;
  static const Field<StorePayment, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );

  @override
  final MappableFields<StorePayment> fields = const {
    #id: _f$id,
    #status: _f$status,
    #amount: _f$amount,
    #fees: _f$fees,
    #remark: _f$remark,
    #paymentReference: _f$paymentReference,
    #product: _f$product,
    #merchant: _f$merchant,
    #createdAt: _f$createdAt,
  };

  static StorePayment _instantiate(DecodingData data) {
    return StorePayment(
      id: data.dec(_f$id),
      status: data.dec(_f$status),
      amount: data.dec(_f$amount),
      fees: data.dec(_f$fees),
      remark: data.dec(_f$remark),
      paymentReference: data.dec(_f$paymentReference),
      product: data.dec(_f$product),
      merchant: data.dec(_f$merchant),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StorePayment fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StorePayment>(map);
  }

  static StorePayment fromJson(String json) {
    return ensureInitialized().decodeJson<StorePayment>(json);
  }
}

mixin StorePaymentMappable {
  String toJson() {
    return StorePaymentMapper.ensureInitialized().encodeJson<StorePayment>(
      this as StorePayment,
    );
  }

  Map<String, dynamic> toMap() {
    return StorePaymentMapper.ensureInitialized().encodeMap<StorePayment>(
      this as StorePayment,
    );
  }

  StorePaymentCopyWith<StorePayment, StorePayment, StorePayment> get copyWith =>
      _StorePaymentCopyWithImpl<StorePayment, StorePayment>(
        this as StorePayment,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return StorePaymentMapper.ensureInitialized().stringifyValue(
      this as StorePayment,
    );
  }

  @override
  bool operator ==(Object other) {
    return StorePaymentMapper.ensureInitialized().equalsValue(
      this as StorePayment,
      other,
    );
  }

  @override
  int get hashCode {
    return StorePaymentMapper.ensureInitialized().hashValue(
      this as StorePayment,
    );
  }
}

extension StorePaymentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StorePayment, $Out> {
  StorePaymentCopyWith<$R, StorePayment, $Out> get $asStorePayment =>
      $base.as((v, t, t2) => _StorePaymentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StorePaymentCopyWith<$R, $In extends StorePayment, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PaymentProductSummaryCopyWith<
    $R,
    PaymentProductSummary,
    PaymentProductSummary
  >?
  get product;
  MerchantInfoCopyWith<$R, MerchantInfo, MerchantInfo>? get merchant;
  $R call({
    String? id,
    String? status,
    num? amount,
    dynamic fees,
    String? remark,
    String? paymentReference,
    PaymentProductSummary? product,
    MerchantInfo? merchant,
    String? createdAt,
  });
  StorePaymentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StorePaymentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StorePayment, $Out>
    implements StorePaymentCopyWith<$R, StorePayment, $Out> {
  _StorePaymentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StorePayment> $mapper =
      StorePaymentMapper.ensureInitialized();
  @override
  PaymentProductSummaryCopyWith<
    $R,
    PaymentProductSummary,
    PaymentProductSummary
  >?
  get product => $value.product?.copyWith.$chain((v) => call(product: v));
  @override
  MerchantInfoCopyWith<$R, MerchantInfo, MerchantInfo>? get merchant =>
      $value.merchant?.copyWith.$chain((v) => call(merchant: v));
  @override
  $R call({
    Object? id = $none,
    Object? status = $none,
    Object? amount = $none,
    Object? fees = $none,
    Object? remark = $none,
    Object? paymentReference = $none,
    Object? product = $none,
    Object? merchant = $none,
    Object? createdAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (status != $none) #status: status,
      if (amount != $none) #amount: amount,
      if (fees != $none) #fees: fees,
      if (remark != $none) #remark: remark,
      if (paymentReference != $none) #paymentReference: paymentReference,
      if (product != $none) #product: product,
      if (merchant != $none) #merchant: merchant,
      if (createdAt != $none) #createdAt: createdAt,
    }),
  );
  @override
  StorePayment $make(CopyWithData data) => StorePayment(
    id: data.get(#id, or: $value.id),
    status: data.get(#status, or: $value.status),
    amount: data.get(#amount, or: $value.amount),
    fees: data.get(#fees, or: $value.fees),
    remark: data.get(#remark, or: $value.remark),
    paymentReference: data.get(#paymentReference, or: $value.paymentReference),
    product: data.get(#product, or: $value.product),
    merchant: data.get(#merchant, or: $value.merchant),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  StorePaymentCopyWith<$R2, StorePayment, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StorePaymentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

