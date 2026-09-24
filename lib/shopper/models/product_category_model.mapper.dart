// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_category_model.dart';

class ProductCategoryMapper extends ClassMapperBase<ProductCategory> {
  ProductCategoryMapper._();

  static ProductCategoryMapper? _instance;
  static ProductCategoryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductCategoryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProductCategory';

  static String? _$id(ProductCategory v) => v.id;
  static const Field<ProductCategory, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$name(ProductCategory v) => v.name;
  static const Field<ProductCategory, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$image(ProductCategory v) => v.image;
  static const Field<ProductCategory, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static int? _$displayOrder(ProductCategory v) => v.displayOrder;
  static const Field<ProductCategory, int> _f$displayOrder = Field(
    'displayOrder',
    _$displayOrder,
    key: r'display_order',
    opt: true,
  );

  @override
  final MappableFields<ProductCategory> fields = const {
    #id: _f$id,
    #name: _f$name,
    #image: _f$image,
    #displayOrder: _f$displayOrder,
  };

  static ProductCategory _instantiate(DecodingData data) {
    return ProductCategory(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      image: data.dec(_f$image),
      displayOrder: data.dec(_f$displayOrder),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductCategory fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductCategory>(map);
  }

  static ProductCategory fromJson(String json) {
    return ensureInitialized().decodeJson<ProductCategory>(json);
  }
}

mixin ProductCategoryMappable {
  String toJson() {
    return ProductCategoryMapper.ensureInitialized()
        .encodeJson<ProductCategory>(this as ProductCategory);
  }

  Map<String, dynamic> toMap() {
    return ProductCategoryMapper.ensureInitialized().encodeMap<ProductCategory>(
      this as ProductCategory,
    );
  }

  ProductCategoryCopyWith<ProductCategory, ProductCategory, ProductCategory>
  get copyWith =>
      _ProductCategoryCopyWithImpl<ProductCategory, ProductCategory>(
        this as ProductCategory,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProductCategoryMapper.ensureInitialized().stringifyValue(
      this as ProductCategory,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProductCategoryMapper.ensureInitialized().equalsValue(
      this as ProductCategory,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductCategoryMapper.ensureInitialized().hashValue(
      this as ProductCategory,
    );
  }
}

extension ProductCategoryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductCategory, $Out> {
  ProductCategoryCopyWith<$R, ProductCategory, $Out> get $asProductCategory =>
      $base.as((v, t, t2) => _ProductCategoryCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductCategoryCopyWith<$R, $In extends ProductCategory, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? image, int? displayOrder});
  ProductCategoryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProductCategoryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductCategory, $Out>
    implements ProductCategoryCopyWith<$R, ProductCategory, $Out> {
  _ProductCategoryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductCategory> $mapper =
      ProductCategoryMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? name = $none,
    Object? image = $none,
    Object? displayOrder = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != $none) #name: name,
      if (image != $none) #image: image,
      if (displayOrder != $none) #displayOrder: displayOrder,
    }),
  );
  @override
  ProductCategory $make(CopyWithData data) => ProductCategory(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    image: data.get(#image, or: $value.image),
    displayOrder: data.get(#displayOrder, or: $value.displayOrder),
  );

  @override
  ProductCategoryCopyWith<$R2, ProductCategory, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProductCategoryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

