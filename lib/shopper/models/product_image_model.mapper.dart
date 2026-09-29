// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_image_model.dart';

class ProductImageMapper extends ClassMapperBase<ProductImage> {
  ProductImageMapper._();

  static ProductImageMapper? _instance;
  static ProductImageMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductImageMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProductImage';

  static String? _$url(ProductImage v) => v.url;
  static const Field<ProductImage, String> _f$url = Field(
    'url',
    _$url,
    opt: true,
  );
  static String? _$mime(ProductImage v) => v.mime;
  static const Field<ProductImage, String> _f$mime = Field(
    'mime',
    _$mime,
    opt: true,
  );
  static num? _$size(ProductImage v) => v.size;
  static const Field<ProductImage, num> _f$size = Field(
    'size',
    _$size,
    opt: true,
  );
  static String? _$name(ProductImage v) => v.name;
  static const Field<ProductImage, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );

  @override
  final MappableFields<ProductImage> fields = const {
    #url: _f$url,
    #mime: _f$mime,
    #size: _f$size,
    #name: _f$name,
  };

  static ProductImage _instantiate(DecodingData data) {
    return ProductImage(
      url: data.dec(_f$url),
      mime: data.dec(_f$mime),
      size: data.dec(_f$size),
      name: data.dec(_f$name),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductImage fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductImage>(map);
  }

  static ProductImage fromJson(String json) {
    return ensureInitialized().decodeJson<ProductImage>(json);
  }
}

mixin ProductImageMappable {
  String toJson() {
    return ProductImageMapper.ensureInitialized().encodeJson<ProductImage>(
      this as ProductImage,
    );
  }

  Map<String, dynamic> toMap() {
    return ProductImageMapper.ensureInitialized().encodeMap<ProductImage>(
      this as ProductImage,
    );
  }

  ProductImageCopyWith<ProductImage, ProductImage, ProductImage> get copyWith =>
      _ProductImageCopyWithImpl<ProductImage, ProductImage>(
        this as ProductImage,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProductImageMapper.ensureInitialized().stringifyValue(
      this as ProductImage,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProductImageMapper.ensureInitialized().equalsValue(
      this as ProductImage,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductImageMapper.ensureInitialized().hashValue(
      this as ProductImage,
    );
  }
}

extension ProductImageValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductImage, $Out> {
  ProductImageCopyWith<$R, ProductImage, $Out> get $asProductImage =>
      $base.as((v, t, t2) => _ProductImageCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductImageCopyWith<$R, $In extends ProductImage, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? url, String? mime, num? size, String? name});
  ProductImageCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProductImageCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductImage, $Out>
    implements ProductImageCopyWith<$R, ProductImage, $Out> {
  _ProductImageCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductImage> $mapper =
      ProductImageMapper.ensureInitialized();
  @override
  $R call({
    Object? url = $none,
    Object? mime = $none,
    Object? size = $none,
    Object? name = $none,
  }) => $apply(
    FieldCopyWithData({
      if (url != $none) #url: url,
      if (mime != $none) #mime: mime,
      if (size != $none) #size: size,
      if (name != $none) #name: name,
    }),
  );
  @override
  ProductImage $make(CopyWithData data) => ProductImage(
    url: data.get(#url, or: $value.url),
    mime: data.get(#mime, or: $value.mime),
    size: data.get(#size, or: $value.size),
    name: data.get(#name, or: $value.name),
  );

  @override
  ProductImageCopyWith<$R2, ProductImage, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProductImageCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

