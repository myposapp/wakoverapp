// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'platform_order_model.dart';

class PlatformOrderProductMapper extends ClassMapperBase<PlatformOrderProduct> {
  PlatformOrderProductMapper._();

  static PlatformOrderProductMapper? _instance;
  static PlatformOrderProductMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlatformOrderProductMapper._());
      ProductCategoryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PlatformOrderProduct';

  static String? _$id(PlatformOrderProduct v) => v.id;
  static const Field<PlatformOrderProduct, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$name(PlatformOrderProduct v) => v.name;
  static const Field<PlatformOrderProduct, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$image(PlatformOrderProduct v) => v.image;
  static const Field<PlatformOrderProduct, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static ProductCategory? _$category(PlatformOrderProduct v) => v.category;
  static const Field<PlatformOrderProduct, ProductCategory> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );

  @override
  final MappableFields<PlatformOrderProduct> fields = const {
    #id: _f$id,
    #name: _f$name,
    #image: _f$image,
    #category: _f$category,
  };

  static PlatformOrderProduct _instantiate(DecodingData data) {
    return PlatformOrderProduct(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      image: data.dec(_f$image),
      category: data.dec(_f$category),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PlatformOrderProduct fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PlatformOrderProduct>(map);
  }

  static PlatformOrderProduct fromJson(String json) {
    return ensureInitialized().decodeJson<PlatformOrderProduct>(json);
  }
}

mixin PlatformOrderProductMappable {
  String toJson() {
    return PlatformOrderProductMapper.ensureInitialized()
        .encodeJson<PlatformOrderProduct>(this as PlatformOrderProduct);
  }

  Map<String, dynamic> toMap() {
    return PlatformOrderProductMapper.ensureInitialized()
        .encodeMap<PlatformOrderProduct>(this as PlatformOrderProduct);
  }

  PlatformOrderProductCopyWith<
    PlatformOrderProduct,
    PlatformOrderProduct,
    PlatformOrderProduct
  >
  get copyWith =>
      _PlatformOrderProductCopyWithImpl<
        PlatformOrderProduct,
        PlatformOrderProduct
      >(this as PlatformOrderProduct, $identity, $identity);
  @override
  String toString() {
    return PlatformOrderProductMapper.ensureInitialized().stringifyValue(
      this as PlatformOrderProduct,
    );
  }

  @override
  bool operator ==(Object other) {
    return PlatformOrderProductMapper.ensureInitialized().equalsValue(
      this as PlatformOrderProduct,
      other,
    );
  }

  @override
  int get hashCode {
    return PlatformOrderProductMapper.ensureInitialized().hashValue(
      this as PlatformOrderProduct,
    );
  }
}

extension PlatformOrderProductValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PlatformOrderProduct, $Out> {
  PlatformOrderProductCopyWith<$R, PlatformOrderProduct, $Out>
  get $asPlatformOrderProduct => $base.as(
    (v, t, t2) => _PlatformOrderProductCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class PlatformOrderProductCopyWith<
  $R,
  $In extends PlatformOrderProduct,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ProductCategoryCopyWith<$R, ProductCategory, ProductCategory>? get category;
  $R call({String? id, String? name, String? image, ProductCategory? category});
  PlatformOrderProductCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PlatformOrderProductCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PlatformOrderProduct, $Out>
    implements PlatformOrderProductCopyWith<$R, PlatformOrderProduct, $Out> {
  _PlatformOrderProductCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PlatformOrderProduct> $mapper =
      PlatformOrderProductMapper.ensureInitialized();
  @override
  ProductCategoryCopyWith<$R, ProductCategory, ProductCategory>? get category =>
      $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  $R call({
    Object? id = $none,
    Object? name = $none,
    Object? image = $none,
    Object? category = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != $none) #name: name,
      if (image != $none) #image: image,
      if (category != $none) #category: category,
    }),
  );
  @override
  PlatformOrderProduct $make(CopyWithData data) => PlatformOrderProduct(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    image: data.get(#image, or: $value.image),
    category: data.get(#category, or: $value.category),
  );

  @override
  PlatformOrderProductCopyWith<$R2, PlatformOrderProduct, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PlatformOrderProductCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PlatformOrderMapper extends ClassMapperBase<PlatformOrder> {
  PlatformOrderMapper._();

  static PlatformOrderMapper? _instance;
  static PlatformOrderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PlatformOrderMapper._());
      PlatformOrderProductMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PlatformOrder';

  static String? _$id(PlatformOrder v) => v.id;
  static const Field<PlatformOrder, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static dynamic _$purchaseDetail(PlatformOrder v) => v.purchaseDetail;
  static const Field<PlatformOrder, dynamic> _f$purchaseDetail = Field(
    'purchaseDetail',
    _$purchaseDetail,
    key: r'purchase_detail',
    opt: true,
  );
  static dynamic _$fees(PlatformOrder v) => v.fees;
  static const Field<PlatformOrder, dynamic> _f$fees = Field(
    'fees',
    _$fees,
    opt: true,
  );
  static String? _$transactionId(PlatformOrder v) => v.transactionId;
  static const Field<PlatformOrder, String> _f$transactionId = Field(
    'transactionId',
    _$transactionId,
    key: r'transaction_id',
    opt: true,
  );
  static String? _$companyId(PlatformOrder v) => v.companyId;
  static const Field<PlatformOrder, String> _f$companyId = Field(
    'companyId',
    _$companyId,
    key: r'company_id',
    opt: true,
  );
  static String? _$merchantId(PlatformOrder v) => v.merchantId;
  static const Field<PlatformOrder, String> _f$merchantId = Field(
    'merchantId',
    _$merchantId,
    key: r'merchant_id',
    opt: true,
  );
  static String? _$userId(PlatformOrder v) => v.userId;
  static const Field<PlatformOrder, String> _f$userId = Field(
    'userId',
    _$userId,
    key: r'user_id',
    opt: true,
  );
  static String? _$productId(PlatformOrder v) => v.productId;
  static const Field<PlatformOrder, String> _f$productId = Field(
    'productId',
    _$productId,
    key: r'product_id',
    opt: true,
  );
  static String? _$paymentReference(PlatformOrder v) => v.paymentReference;
  static const Field<PlatformOrder, String> _f$paymentReference = Field(
    'paymentReference',
    _$paymentReference,
    key: r'payment_reference',
    opt: true,
  );
  static String? _$status(PlatformOrder v) => v.status;
  static const Field<PlatformOrder, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static String? _$createdAt(PlatformOrder v) => v.createdAt;
  static const Field<PlatformOrder, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static String? _$updatedAt(PlatformOrder v) => v.updatedAt;
  static const Field<PlatformOrder, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );
  static PlatformOrderProduct? _$product(PlatformOrder v) => v.product;
  static const Field<PlatformOrder, PlatformOrderProduct> _f$product = Field(
    'product',
    _$product,
    opt: true,
  );
  static dynamic _$merchant(PlatformOrder v) => v.merchant;
  static const Field<PlatformOrder, dynamic> _f$merchant = Field(
    'merchant',
    _$merchant,
    opt: true,
  );
  static dynamic _$user(PlatformOrder v) => v.user;
  static const Field<PlatformOrder, dynamic> _f$user = Field(
    'user',
    _$user,
    opt: true,
  );

  @override
  final MappableFields<PlatformOrder> fields = const {
    #id: _f$id,
    #purchaseDetail: _f$purchaseDetail,
    #fees: _f$fees,
    #transactionId: _f$transactionId,
    #companyId: _f$companyId,
    #merchantId: _f$merchantId,
    #userId: _f$userId,
    #productId: _f$productId,
    #paymentReference: _f$paymentReference,
    #status: _f$status,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #product: _f$product,
    #merchant: _f$merchant,
    #user: _f$user,
  };

  static PlatformOrder _instantiate(DecodingData data) {
    return PlatformOrder(
      id: data.dec(_f$id),
      purchaseDetail: data.dec(_f$purchaseDetail),
      fees: data.dec(_f$fees),
      transactionId: data.dec(_f$transactionId),
      companyId: data.dec(_f$companyId),
      merchantId: data.dec(_f$merchantId),
      userId: data.dec(_f$userId),
      productId: data.dec(_f$productId),
      paymentReference: data.dec(_f$paymentReference),
      status: data.dec(_f$status),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      product: data.dec(_f$product),
      merchant: data.dec(_f$merchant),
      user: data.dec(_f$user),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PlatformOrder fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PlatformOrder>(map);
  }

  static PlatformOrder fromJson(String json) {
    return ensureInitialized().decodeJson<PlatformOrder>(json);
  }
}

mixin PlatformOrderMappable {
  String toJson() {
    return PlatformOrderMapper.ensureInitialized().encodeJson<PlatformOrder>(
      this as PlatformOrder,
    );
  }

  Map<String, dynamic> toMap() {
    return PlatformOrderMapper.ensureInitialized().encodeMap<PlatformOrder>(
      this as PlatformOrder,
    );
  }

  PlatformOrderCopyWith<PlatformOrder, PlatformOrder, PlatformOrder>
  get copyWith => _PlatformOrderCopyWithImpl<PlatformOrder, PlatformOrder>(
    this as PlatformOrder,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PlatformOrderMapper.ensureInitialized().stringifyValue(
      this as PlatformOrder,
    );
  }

  @override
  bool operator ==(Object other) {
    return PlatformOrderMapper.ensureInitialized().equalsValue(
      this as PlatformOrder,
      other,
    );
  }

  @override
  int get hashCode {
    return PlatformOrderMapper.ensureInitialized().hashValue(
      this as PlatformOrder,
    );
  }
}

extension PlatformOrderValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PlatformOrder, $Out> {
  PlatformOrderCopyWith<$R, PlatformOrder, $Out> get $asPlatformOrder =>
      $base.as((v, t, t2) => _PlatformOrderCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PlatformOrderCopyWith<$R, $In extends PlatformOrder, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  PlatformOrderProductCopyWith<$R, PlatformOrderProduct, PlatformOrderProduct>?
  get product;
  $R call({
    String? id,
    dynamic purchaseDetail,
    dynamic fees,
    String? transactionId,
    String? companyId,
    String? merchantId,
    String? userId,
    String? productId,
    String? paymentReference,
    String? status,
    String? createdAt,
    String? updatedAt,
    PlatformOrderProduct? product,
    dynamic merchant,
    dynamic user,
  });
  PlatformOrderCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PlatformOrderCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PlatformOrder, $Out>
    implements PlatformOrderCopyWith<$R, PlatformOrder, $Out> {
  _PlatformOrderCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PlatformOrder> $mapper =
      PlatformOrderMapper.ensureInitialized();
  @override
  PlatformOrderProductCopyWith<$R, PlatformOrderProduct, PlatformOrderProduct>?
  get product => $value.product?.copyWith.$chain((v) => call(product: v));
  @override
  $R call({
    Object? id = $none,
    Object? purchaseDetail = $none,
    Object? fees = $none,
    Object? transactionId = $none,
    Object? companyId = $none,
    Object? merchantId = $none,
    Object? userId = $none,
    Object? productId = $none,
    Object? paymentReference = $none,
    Object? status = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
    Object? product = $none,
    Object? merchant = $none,
    Object? user = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (purchaseDetail != $none) #purchaseDetail: purchaseDetail,
      if (fees != $none) #fees: fees,
      if (transactionId != $none) #transactionId: transactionId,
      if (companyId != $none) #companyId: companyId,
      if (merchantId != $none) #merchantId: merchantId,
      if (userId != $none) #userId: userId,
      if (productId != $none) #productId: productId,
      if (paymentReference != $none) #paymentReference: paymentReference,
      if (status != $none) #status: status,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
      if (product != $none) #product: product,
      if (merchant != $none) #merchant: merchant,
      if (user != $none) #user: user,
    }),
  );
  @override
  PlatformOrder $make(CopyWithData data) => PlatformOrder(
    id: data.get(#id, or: $value.id),
    purchaseDetail: data.get(#purchaseDetail, or: $value.purchaseDetail),
    fees: data.get(#fees, or: $value.fees),
    transactionId: data.get(#transactionId, or: $value.transactionId),
    companyId: data.get(#companyId, or: $value.companyId),
    merchantId: data.get(#merchantId, or: $value.merchantId),
    userId: data.get(#userId, or: $value.userId),
    productId: data.get(#productId, or: $value.productId),
    paymentReference: data.get(#paymentReference, or: $value.paymentReference),
    status: data.get(#status, or: $value.status),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    product: data.get(#product, or: $value.product),
    merchant: data.get(#merchant, or: $value.merchant),
    user: data.get(#user, or: $value.user),
  );

  @override
  PlatformOrderCopyWith<$R2, PlatformOrder, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PlatformOrderCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

