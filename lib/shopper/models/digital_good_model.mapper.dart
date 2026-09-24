// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'digital_good_model.dart';

class DigitalGoodMapper extends ClassMapperBase<DigitalGood> {
  DigitalGoodMapper._();

  static DigitalGoodMapper? _instance;
  static DigitalGoodMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DigitalGoodMapper._());
      ProductCategoryMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'DigitalGood';

  static String? _$id(DigitalGood v) => v.id;
  static const Field<DigitalGood, String> _f$id = Field('id', _$id, opt: true);
  static String? _$name(DigitalGood v) => v.name;
  static const Field<DigitalGood, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$image(DigitalGood v) => v.image;
  static const Field<DigitalGood, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static num? _$price(DigitalGood v) => v.price;
  static const Field<DigitalGood, num> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );
  static String? _$unit(DigitalGood v) => v.unit;
  static const Field<DigitalGood, String> _f$unit = Field(
    'unit',
    _$unit,
    opt: true,
  );
  static ProductCategory? _$category(DigitalGood v) => v.category;
  static const Field<DigitalGood, ProductCategory> _f$category = Field(
    'category',
    _$category,
    opt: true,
  );

  @override
  final MappableFields<DigitalGood> fields = const {
    #id: _f$id,
    #name: _f$name,
    #image: _f$image,
    #price: _f$price,
    #unit: _f$unit,
    #category: _f$category,
  };

  static DigitalGood _instantiate(DecodingData data) {
    return DigitalGood(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      image: data.dec(_f$image),
      price: data.dec(_f$price),
      unit: data.dec(_f$unit),
      category: data.dec(_f$category),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DigitalGood fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DigitalGood>(map);
  }

  static DigitalGood fromJson(String json) {
    return ensureInitialized().decodeJson<DigitalGood>(json);
  }
}

mixin DigitalGoodMappable {
  String toJson() {
    return DigitalGoodMapper.ensureInitialized().encodeJson<DigitalGood>(
      this as DigitalGood,
    );
  }

  Map<String, dynamic> toMap() {
    return DigitalGoodMapper.ensureInitialized().encodeMap<DigitalGood>(
      this as DigitalGood,
    );
  }

  DigitalGoodCopyWith<DigitalGood, DigitalGood, DigitalGood> get copyWith =>
      _DigitalGoodCopyWithImpl<DigitalGood, DigitalGood>(
        this as DigitalGood,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return DigitalGoodMapper.ensureInitialized().stringifyValue(
      this as DigitalGood,
    );
  }

  @override
  bool operator ==(Object other) {
    return DigitalGoodMapper.ensureInitialized().equalsValue(
      this as DigitalGood,
      other,
    );
  }

  @override
  int get hashCode {
    return DigitalGoodMapper.ensureInitialized().hashValue(this as DigitalGood);
  }
}

extension DigitalGoodValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DigitalGood, $Out> {
  DigitalGoodCopyWith<$R, DigitalGood, $Out> get $asDigitalGood =>
      $base.as((v, t, t2) => _DigitalGoodCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DigitalGoodCopyWith<$R, $In extends DigitalGood, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ProductCategoryCopyWith<$R, ProductCategory, ProductCategory>? get category;
  $R call({
    String? id,
    String? name,
    String? image,
    num? price,
    String? unit,
    ProductCategory? category,
  });
  DigitalGoodCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _DigitalGoodCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DigitalGood, $Out>
    implements DigitalGoodCopyWith<$R, DigitalGood, $Out> {
  _DigitalGoodCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DigitalGood> $mapper =
      DigitalGoodMapper.ensureInitialized();
  @override
  ProductCategoryCopyWith<$R, ProductCategory, ProductCategory>? get category =>
      $value.category?.copyWith.$chain((v) => call(category: v));
  @override
  $R call({
    Object? id = $none,
    Object? name = $none,
    Object? image = $none,
    Object? price = $none,
    Object? unit = $none,
    Object? category = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != $none) #name: name,
      if (image != $none) #image: image,
      if (price != $none) #price: price,
      if (unit != $none) #unit: unit,
      if (category != $none) #category: category,
    }),
  );
  @override
  DigitalGood $make(CopyWithData data) => DigitalGood(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    image: data.get(#image, or: $value.image),
    price: data.get(#price, or: $value.price),
    unit: data.get(#unit, or: $value.unit),
    category: data.get(#category, or: $value.category),
  );

  @override
  DigitalGoodCopyWith<$R2, DigitalGood, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DigitalGoodCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

