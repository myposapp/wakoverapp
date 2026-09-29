// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'affiliate_code_model.dart';

class AffiliateProductMapper extends ClassMapperBase<AffiliateProduct> {
  AffiliateProductMapper._();

  static AffiliateProductMapper? _instance;
  static AffiliateProductMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AffiliateProductMapper._());
      ProductImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AffiliateProduct';

  static String? _$id(AffiliateProduct v) => v.id;
  static const Field<AffiliateProduct, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$name(AffiliateProduct v) => v.name;
  static const Field<AffiliateProduct, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static ProductImage? _$image(AffiliateProduct v) => v.image;
  static const Field<AffiliateProduct, ProductImage> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static num? _$price(AffiliateProduct v) => v.price;
  static const Field<AffiliateProduct, num> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );

  @override
  final MappableFields<AffiliateProduct> fields = const {
    #id: _f$id,
    #name: _f$name,
    #image: _f$image,
    #price: _f$price,
  };

  static AffiliateProduct _instantiate(DecodingData data) {
    return AffiliateProduct(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      image: data.dec(_f$image),
      price: data.dec(_f$price),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AffiliateProduct fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AffiliateProduct>(map);
  }

  static AffiliateProduct fromJson(String json) {
    return ensureInitialized().decodeJson<AffiliateProduct>(json);
  }
}

mixin AffiliateProductMappable {
  String toJson() {
    return AffiliateProductMapper.ensureInitialized()
        .encodeJson<AffiliateProduct>(this as AffiliateProduct);
  }

  Map<String, dynamic> toMap() {
    return AffiliateProductMapper.ensureInitialized()
        .encodeMap<AffiliateProduct>(this as AffiliateProduct);
  }

  AffiliateProductCopyWith<AffiliateProduct, AffiliateProduct, AffiliateProduct>
  get copyWith =>
      _AffiliateProductCopyWithImpl<AffiliateProduct, AffiliateProduct>(
        this as AffiliateProduct,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return AffiliateProductMapper.ensureInitialized().stringifyValue(
      this as AffiliateProduct,
    );
  }

  @override
  bool operator ==(Object other) {
    return AffiliateProductMapper.ensureInitialized().equalsValue(
      this as AffiliateProduct,
      other,
    );
  }

  @override
  int get hashCode {
    return AffiliateProductMapper.ensureInitialized().hashValue(
      this as AffiliateProduct,
    );
  }
}

extension AffiliateProductValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AffiliateProduct, $Out> {
  AffiliateProductCopyWith<$R, AffiliateProduct, $Out>
  get $asAffiliateProduct =>
      $base.as((v, t, t2) => _AffiliateProductCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AffiliateProductCopyWith<$R, $In extends AffiliateProduct, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ProductImageCopyWith<$R, ProductImage, ProductImage>? get image;
  $R call({String? id, String? name, ProductImage? image, num? price});
  AffiliateProductCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _AffiliateProductCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AffiliateProduct, $Out>
    implements AffiliateProductCopyWith<$R, AffiliateProduct, $Out> {
  _AffiliateProductCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AffiliateProduct> $mapper =
      AffiliateProductMapper.ensureInitialized();
  @override
  ProductImageCopyWith<$R, ProductImage, ProductImage>? get image =>
      $value.image?.copyWith.$chain((v) => call(image: v));
  @override
  $R call({
    Object? id = $none,
    Object? name = $none,
    Object? image = $none,
    Object? price = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != $none) #name: name,
      if (image != $none) #image: image,
      if (price != $none) #price: price,
    }),
  );
  @override
  AffiliateProduct $make(CopyWithData data) => AffiliateProduct(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    image: data.get(#image, or: $value.image),
    price: data.get(#price, or: $value.price),
  );

  @override
  AffiliateProductCopyWith<$R2, AffiliateProduct, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AffiliateProductCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class AffiliateCodeMapper extends ClassMapperBase<AffiliateCode> {
  AffiliateCodeMapper._();

  static AffiliateCodeMapper? _instance;
  static AffiliateCodeMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = AffiliateCodeMapper._());
      AffiliateProductMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'AffiliateCode';

  static String? _$id(AffiliateCode v) => v.id;
  static const Field<AffiliateCode, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$code(AffiliateCode v) => v.code;
  static const Field<AffiliateCode, String> _f$code = Field(
    'code',
    _$code,
    opt: true,
  );
  static String? _$name(AffiliateCode v) => v.name;
  static const Field<AffiliateCode, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$description(AffiliateCode v) => v.description;
  static const Field<AffiliateCode, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static String? _$status(AffiliateCode v) => v.status;
  static const Field<AffiliateCode, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static String? _$commType(AffiliateCode v) => v.commType;
  static const Field<AffiliateCode, String> _f$commType = Field(
    'commType',
    _$commType,
    key: r'comm_type',
    opt: true,
  );
  static num? _$commAmount(AffiliateCode v) => v.commAmount;
  static const Field<AffiliateCode, num> _f$commAmount = Field(
    'commAmount',
    _$commAmount,
    key: r'comm_amount',
    opt: true,
  );
  static num? _$commMax(AffiliateCode v) => v.commMax;
  static const Field<AffiliateCode, num> _f$commMax = Field(
    'commMax',
    _$commMax,
    key: r'comm_max',
    opt: true,
  );
  static num? _$totalEarning(AffiliateCode v) => v.totalEarning;
  static const Field<AffiliateCode, num> _f$totalEarning = Field(
    'totalEarning',
    _$totalEarning,
    key: r'total_earning',
    opt: true,
  );
  static List<AffiliateProduct>? _$blacklist(AffiliateCode v) => v.blacklist;
  static const Field<AffiliateCode, List<AffiliateProduct>> _f$blacklist =
      Field('blacklist', _$blacklist, opt: true);
  static List<AffiliateProduct>? _$whitelist(AffiliateCode v) => v.whitelist;
  static const Field<AffiliateCode, List<AffiliateProduct>> _f$whitelist =
      Field('whitelist', _$whitelist, opt: true);

  @override
  final MappableFields<AffiliateCode> fields = const {
    #id: _f$id,
    #code: _f$code,
    #name: _f$name,
    #description: _f$description,
    #status: _f$status,
    #commType: _f$commType,
    #commAmount: _f$commAmount,
    #commMax: _f$commMax,
    #totalEarning: _f$totalEarning,
    #blacklist: _f$blacklist,
    #whitelist: _f$whitelist,
  };

  static AffiliateCode _instantiate(DecodingData data) {
    return AffiliateCode(
      id: data.dec(_f$id),
      code: data.dec(_f$code),
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      status: data.dec(_f$status),
      commType: data.dec(_f$commType),
      commAmount: data.dec(_f$commAmount),
      commMax: data.dec(_f$commMax),
      totalEarning: data.dec(_f$totalEarning),
      blacklist: data.dec(_f$blacklist),
      whitelist: data.dec(_f$whitelist),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static AffiliateCode fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<AffiliateCode>(map);
  }

  static AffiliateCode fromJson(String json) {
    return ensureInitialized().decodeJson<AffiliateCode>(json);
  }
}

mixin AffiliateCodeMappable {
  String toJson() {
    return AffiliateCodeMapper.ensureInitialized().encodeJson<AffiliateCode>(
      this as AffiliateCode,
    );
  }

  Map<String, dynamic> toMap() {
    return AffiliateCodeMapper.ensureInitialized().encodeMap<AffiliateCode>(
      this as AffiliateCode,
    );
  }

  AffiliateCodeCopyWith<AffiliateCode, AffiliateCode, AffiliateCode>
  get copyWith => _AffiliateCodeCopyWithImpl<AffiliateCode, AffiliateCode>(
    this as AffiliateCode,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return AffiliateCodeMapper.ensureInitialized().stringifyValue(
      this as AffiliateCode,
    );
  }

  @override
  bool operator ==(Object other) {
    return AffiliateCodeMapper.ensureInitialized().equalsValue(
      this as AffiliateCode,
      other,
    );
  }

  @override
  int get hashCode {
    return AffiliateCodeMapper.ensureInitialized().hashValue(
      this as AffiliateCode,
    );
  }
}

extension AffiliateCodeValueCopy<$R, $Out>
    on ObjectCopyWith<$R, AffiliateCode, $Out> {
  AffiliateCodeCopyWith<$R, AffiliateCode, $Out> get $asAffiliateCode =>
      $base.as((v, t, t2) => _AffiliateCodeCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class AffiliateCodeCopyWith<$R, $In extends AffiliateCode, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    AffiliateProduct,
    AffiliateProductCopyWith<$R, AffiliateProduct, AffiliateProduct>
  >?
  get blacklist;
  ListCopyWith<
    $R,
    AffiliateProduct,
    AffiliateProductCopyWith<$R, AffiliateProduct, AffiliateProduct>
  >?
  get whitelist;
  $R call({
    String? id,
    String? code,
    String? name,
    String? description,
    String? status,
    String? commType,
    num? commAmount,
    num? commMax,
    num? totalEarning,
    List<AffiliateProduct>? blacklist,
    List<AffiliateProduct>? whitelist,
  });
  AffiliateCodeCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _AffiliateCodeCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, AffiliateCode, $Out>
    implements AffiliateCodeCopyWith<$R, AffiliateCode, $Out> {
  _AffiliateCodeCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<AffiliateCode> $mapper =
      AffiliateCodeMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    AffiliateProduct,
    AffiliateProductCopyWith<$R, AffiliateProduct, AffiliateProduct>
  >?
  get blacklist => $value.blacklist != null
      ? ListCopyWith(
          $value.blacklist!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(blacklist: v),
        )
      : null;
  @override
  ListCopyWith<
    $R,
    AffiliateProduct,
    AffiliateProductCopyWith<$R, AffiliateProduct, AffiliateProduct>
  >?
  get whitelist => $value.whitelist != null
      ? ListCopyWith(
          $value.whitelist!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(whitelist: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    Object? code = $none,
    Object? name = $none,
    Object? description = $none,
    Object? status = $none,
    Object? commType = $none,
    Object? commAmount = $none,
    Object? commMax = $none,
    Object? totalEarning = $none,
    Object? blacklist = $none,
    Object? whitelist = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (code != $none) #code: code,
      if (name != $none) #name: name,
      if (description != $none) #description: description,
      if (status != $none) #status: status,
      if (commType != $none) #commType: commType,
      if (commAmount != $none) #commAmount: commAmount,
      if (commMax != $none) #commMax: commMax,
      if (totalEarning != $none) #totalEarning: totalEarning,
      if (blacklist != $none) #blacklist: blacklist,
      if (whitelist != $none) #whitelist: whitelist,
    }),
  );
  @override
  AffiliateCode $make(CopyWithData data) => AffiliateCode(
    id: data.get(#id, or: $value.id),
    code: data.get(#code, or: $value.code),
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    status: data.get(#status, or: $value.status),
    commType: data.get(#commType, or: $value.commType),
    commAmount: data.get(#commAmount, or: $value.commAmount),
    commMax: data.get(#commMax, or: $value.commMax),
    totalEarning: data.get(#totalEarning, or: $value.totalEarning),
    blacklist: data.get(#blacklist, or: $value.blacklist),
    whitelist: data.get(#whitelist, or: $value.whitelist),
  );

  @override
  AffiliateCodeCopyWith<$R2, AffiliateCode, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _AffiliateCodeCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

