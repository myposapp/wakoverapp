// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'store_product_model.dart';

class ProductVariantMapper extends ClassMapperBase<ProductVariant> {
  ProductVariantMapper._();

  static ProductVariantMapper? _instance;
  static ProductVariantMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductVariantMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProductVariant';

  static String? _$id(ProductVariant v) => v.id;
  static const Field<ProductVariant, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$name(ProductVariant v) => v.name;
  static const Field<ProductVariant, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static num? _$price(ProductVariant v) => v.price;
  static const Field<ProductVariant, num> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );
  static num? _$stock(ProductVariant v) => v.stock;
  static const Field<ProductVariant, num> _f$stock = Field(
    'stock',
    _$stock,
    opt: true,
  );
  static dynamic _$image(ProductVariant v) => v.image;
  static const Field<ProductVariant, dynamic> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );

  @override
  final MappableFields<ProductVariant> fields = const {
    #id: _f$id,
    #name: _f$name,
    #price: _f$price,
    #stock: _f$stock,
    #image: _f$image,
  };

  static ProductVariant _instantiate(DecodingData data) {
    return ProductVariant(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      price: data.dec(_f$price),
      stock: data.dec(_f$stock),
      image: data.dec(_f$image),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductVariant fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductVariant>(map);
  }

  static ProductVariant fromJson(String json) {
    return ensureInitialized().decodeJson<ProductVariant>(json);
  }
}

mixin ProductVariantMappable {
  String toJson() {
    return ProductVariantMapper.ensureInitialized().encodeJson<ProductVariant>(
      this as ProductVariant,
    );
  }

  Map<String, dynamic> toMap() {
    return ProductVariantMapper.ensureInitialized().encodeMap<ProductVariant>(
      this as ProductVariant,
    );
  }

  ProductVariantCopyWith<ProductVariant, ProductVariant, ProductVariant>
  get copyWith => _ProductVariantCopyWithImpl<ProductVariant, ProductVariant>(
    this as ProductVariant,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ProductVariantMapper.ensureInitialized().stringifyValue(
      this as ProductVariant,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProductVariantMapper.ensureInitialized().equalsValue(
      this as ProductVariant,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductVariantMapper.ensureInitialized().hashValue(
      this as ProductVariant,
    );
  }
}

extension ProductVariantValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductVariant, $Out> {
  ProductVariantCopyWith<$R, ProductVariant, $Out> get $asProductVariant =>
      $base.as((v, t, t2) => _ProductVariantCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductVariantCopyWith<$R, $In extends ProductVariant, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, num? price, num? stock, dynamic image});
  ProductVariantCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProductVariantCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductVariant, $Out>
    implements ProductVariantCopyWith<$R, ProductVariant, $Out> {
  _ProductVariantCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductVariant> $mapper =
      ProductVariantMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? name = $none,
    Object? price = $none,
    Object? stock = $none,
    Object? image = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != $none) #name: name,
      if (price != $none) #price: price,
      if (stock != $none) #stock: stock,
      if (image != $none) #image: image,
    }),
  );
  @override
  ProductVariant $make(CopyWithData data) => ProductVariant(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    price: data.get(#price, or: $value.price),
    stock: data.get(#stock, or: $value.stock),
    image: data.get(#image, or: $value.image),
  );

  @override
  ProductVariantCopyWith<$R2, ProductVariant, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProductVariantCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProductDiscountMapper extends ClassMapperBase<ProductDiscount> {
  ProductDiscountMapper._();

  static ProductDiscountMapper? _instance;
  static ProductDiscountMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductDiscountMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProductDiscount';

  static String? _$discountType(ProductDiscount v) => v.discountType;
  static const Field<ProductDiscount, String> _f$discountType = Field(
    'discountType',
    _$discountType,
    key: r'discount_type',
    opt: true,
  );
  static num? _$discountAmount(ProductDiscount v) => v.discountAmount;
  static const Field<ProductDiscount, num> _f$discountAmount = Field(
    'discountAmount',
    _$discountAmount,
    key: r'discount_amount',
    opt: true,
  );

  @override
  final MappableFields<ProductDiscount> fields = const {
    #discountType: _f$discountType,
    #discountAmount: _f$discountAmount,
  };

  static ProductDiscount _instantiate(DecodingData data) {
    return ProductDiscount(
      discountType: data.dec(_f$discountType),
      discountAmount: data.dec(_f$discountAmount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductDiscount fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductDiscount>(map);
  }

  static ProductDiscount fromJson(String json) {
    return ensureInitialized().decodeJson<ProductDiscount>(json);
  }
}

mixin ProductDiscountMappable {
  String toJson() {
    return ProductDiscountMapper.ensureInitialized()
        .encodeJson<ProductDiscount>(this as ProductDiscount);
  }

  Map<String, dynamic> toMap() {
    return ProductDiscountMapper.ensureInitialized().encodeMap<ProductDiscount>(
      this as ProductDiscount,
    );
  }

  ProductDiscountCopyWith<ProductDiscount, ProductDiscount, ProductDiscount>
  get copyWith =>
      _ProductDiscountCopyWithImpl<ProductDiscount, ProductDiscount>(
        this as ProductDiscount,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ProductDiscountMapper.ensureInitialized().stringifyValue(
      this as ProductDiscount,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProductDiscountMapper.ensureInitialized().equalsValue(
      this as ProductDiscount,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductDiscountMapper.ensureInitialized().hashValue(
      this as ProductDiscount,
    );
  }
}

extension ProductDiscountValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductDiscount, $Out> {
  ProductDiscountCopyWith<$R, ProductDiscount, $Out> get $asProductDiscount =>
      $base.as((v, t, t2) => _ProductDiscountCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductDiscountCopyWith<$R, $In extends ProductDiscount, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? discountType, num? discountAmount});
  ProductDiscountCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProductDiscountCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductDiscount, $Out>
    implements ProductDiscountCopyWith<$R, ProductDiscount, $Out> {
  _ProductDiscountCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductDiscount> $mapper =
      ProductDiscountMapper.ensureInitialized();
  @override
  $R call({Object? discountType = $none, Object? discountAmount = $none}) =>
      $apply(
        FieldCopyWithData({
          if (discountType != $none) #discountType: discountType,
          if (discountAmount != $none) #discountAmount: discountAmount,
        }),
      );
  @override
  ProductDiscount $make(CopyWithData data) => ProductDiscount(
    discountType: data.get(#discountType, or: $value.discountType),
    discountAmount: data.get(#discountAmount, or: $value.discountAmount),
  );

  @override
  ProductDiscountCopyWith<$R2, ProductDiscount, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProductDiscountCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProductReviewSummaryMapper extends ClassMapperBase<ProductReviewSummary> {
  ProductReviewSummaryMapper._();

  static ProductReviewSummaryMapper? _instance;
  static ProductReviewSummaryMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductReviewSummaryMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProductReviewSummary';

  static num? _$rating(ProductReviewSummary v) => v.rating;
  static const Field<ProductReviewSummary, num> _f$rating = Field(
    'rating',
    _$rating,
    opt: true,
  );
  static num? _$totalReviews(ProductReviewSummary v) => v.totalReviews;
  static const Field<ProductReviewSummary, num> _f$totalReviews = Field(
    'totalReviews',
    _$totalReviews,
    key: r'total_reviews',
    opt: true,
  );

  @override
  final MappableFields<ProductReviewSummary> fields = const {
    #rating: _f$rating,
    #totalReviews: _f$totalReviews,
  };

  static ProductReviewSummary _instantiate(DecodingData data) {
    return ProductReviewSummary(
      rating: data.dec(_f$rating),
      totalReviews: data.dec(_f$totalReviews),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductReviewSummary fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductReviewSummary>(map);
  }

  static ProductReviewSummary fromJson(String json) {
    return ensureInitialized().decodeJson<ProductReviewSummary>(json);
  }
}

mixin ProductReviewSummaryMappable {
  String toJson() {
    return ProductReviewSummaryMapper.ensureInitialized()
        .encodeJson<ProductReviewSummary>(this as ProductReviewSummary);
  }

  Map<String, dynamic> toMap() {
    return ProductReviewSummaryMapper.ensureInitialized()
        .encodeMap<ProductReviewSummary>(this as ProductReviewSummary);
  }

  ProductReviewSummaryCopyWith<
    ProductReviewSummary,
    ProductReviewSummary,
    ProductReviewSummary
  >
  get copyWith =>
      _ProductReviewSummaryCopyWithImpl<
        ProductReviewSummary,
        ProductReviewSummary
      >(this as ProductReviewSummary, $identity, $identity);
  @override
  String toString() {
    return ProductReviewSummaryMapper.ensureInitialized().stringifyValue(
      this as ProductReviewSummary,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProductReviewSummaryMapper.ensureInitialized().equalsValue(
      this as ProductReviewSummary,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductReviewSummaryMapper.ensureInitialized().hashValue(
      this as ProductReviewSummary,
    );
  }
}

extension ProductReviewSummaryValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductReviewSummary, $Out> {
  ProductReviewSummaryCopyWith<$R, ProductReviewSummary, $Out>
  get $asProductReviewSummary => $base.as(
    (v, t, t2) => _ProductReviewSummaryCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ProductReviewSummaryCopyWith<
  $R,
  $In extends ProductReviewSummary,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({num? rating, num? totalReviews});
  ProductReviewSummaryCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProductReviewSummaryCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductReviewSummary, $Out>
    implements ProductReviewSummaryCopyWith<$R, ProductReviewSummary, $Out> {
  _ProductReviewSummaryCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductReviewSummary> $mapper =
      ProductReviewSummaryMapper.ensureInitialized();
  @override
  $R call({Object? rating = $none, Object? totalReviews = $none}) => $apply(
    FieldCopyWithData({
      if (rating != $none) #rating: rating,
      if (totalReviews != $none) #totalReviews: totalReviews,
    }),
  );
  @override
  ProductReviewSummary $make(CopyWithData data) => ProductReviewSummary(
    rating: data.get(#rating, or: $value.rating),
    totalReviews: data.get(#totalReviews, or: $value.totalReviews),
  );

  @override
  ProductReviewSummaryCopyWith<$R2, ProductReviewSummary, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ProductReviewSummaryCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ProductBoxItemMapper extends ClassMapperBase<ProductBoxItem> {
  ProductBoxItemMapper._();

  static ProductBoxItemMapper? _instance;
  static ProductBoxItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductBoxItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProductBoxItem';

  static String? _$id(ProductBoxItem v) => v.id;
  static const Field<ProductBoxItem, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$name(ProductBoxItem v) => v.name;
  static const Field<ProductBoxItem, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$type(ProductBoxItem v) => v.type;
  static const Field<ProductBoxItem, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
  );

  @override
  final MappableFields<ProductBoxItem> fields = const {
    #id: _f$id,
    #name: _f$name,
    #type: _f$type,
  };

  static ProductBoxItem _instantiate(DecodingData data) {
    return ProductBoxItem(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      type: data.dec(_f$type),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductBoxItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductBoxItem>(map);
  }

  static ProductBoxItem fromJson(String json) {
    return ensureInitialized().decodeJson<ProductBoxItem>(json);
  }
}

mixin ProductBoxItemMappable {
  String toJson() {
    return ProductBoxItemMapper.ensureInitialized().encodeJson<ProductBoxItem>(
      this as ProductBoxItem,
    );
  }

  Map<String, dynamic> toMap() {
    return ProductBoxItemMapper.ensureInitialized().encodeMap<ProductBoxItem>(
      this as ProductBoxItem,
    );
  }

  ProductBoxItemCopyWith<ProductBoxItem, ProductBoxItem, ProductBoxItem>
  get copyWith => _ProductBoxItemCopyWithImpl<ProductBoxItem, ProductBoxItem>(
    this as ProductBoxItem,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ProductBoxItemMapper.ensureInitialized().stringifyValue(
      this as ProductBoxItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProductBoxItemMapper.ensureInitialized().equalsValue(
      this as ProductBoxItem,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductBoxItemMapper.ensureInitialized().hashValue(
      this as ProductBoxItem,
    );
  }
}

extension ProductBoxItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductBoxItem, $Out> {
  ProductBoxItemCopyWith<$R, ProductBoxItem, $Out> get $asProductBoxItem =>
      $base.as((v, t, t2) => _ProductBoxItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductBoxItemCopyWith<$R, $In extends ProductBoxItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? type});
  ProductBoxItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ProductBoxItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductBoxItem, $Out>
    implements ProductBoxItemCopyWith<$R, ProductBoxItem, $Out> {
  _ProductBoxItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductBoxItem> $mapper =
      ProductBoxItemMapper.ensureInitialized();
  @override
  $R call({Object? id = $none, Object? name = $none, Object? type = $none}) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (name != $none) #name: name,
          if (type != $none) #type: type,
        }),
      );
  @override
  ProductBoxItem $make(CopyWithData data) => ProductBoxItem(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    type: data.get(#type, or: $value.type),
  );

  @override
  ProductBoxItemCopyWith<$R2, ProductBoxItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProductBoxItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class StoreProductMapper extends ClassMapperBase<StoreProduct> {
  StoreProductMapper._();

  static StoreProductMapper? _instance;
  static StoreProductMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StoreProductMapper._());
      ProductImageMapper.ensureInitialized();
      ProductVariantMapper.ensureInitialized();
      ProductDiscountMapper.ensureInitialized();
      ProductBoxItemMapper.ensureInitialized();
      ProductReviewSummaryMapper.ensureInitialized();
      MerchantInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StoreProduct';

  static String? _$id(StoreProduct v) => v.id;
  static const Field<StoreProduct, String> _f$id = Field('id', _$id, opt: true);
  static String? _$name(StoreProduct v) => v.name;
  static const Field<StoreProduct, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$description(StoreProduct v) => v.description;
  static const Field<StoreProduct, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static List<ProductImage>? _$images(StoreProduct v) => v.images;
  static const Field<StoreProduct, List<ProductImage>> _f$images = Field(
    'images',
    _$images,
    opt: true,
  );
  static num? _$price(StoreProduct v) => v.price;
  static const Field<StoreProduct, num> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );
  static String? _$unit(StoreProduct v) => v.unit;
  static const Field<StoreProduct, String> _f$unit = Field(
    'unit',
    _$unit,
    opt: true,
  );
  static String? _$productType(StoreProduct v) => v.productType;
  static const Field<StoreProduct, String> _f$productType = Field(
    'productType',
    _$productType,
    key: r'product_type',
    opt: true,
  );
  static List<String>? _$purchaseOptions(StoreProduct v) => v.purchaseOptions;
  static const Field<StoreProduct, List<String>> _f$purchaseOptions = Field(
    'purchaseOptions',
    _$purchaseOptions,
    key: r'purchase_options',
    opt: true,
  );
  static bool? _$manageStock(StoreProduct v) => v.manageStock;
  static const Field<StoreProduct, bool> _f$manageStock = Field(
    'manageStock',
    _$manageStock,
    key: r'manage_stock',
    opt: true,
  );
  static num? _$stock(StoreProduct v) => v.stock;
  static const Field<StoreProduct, num> _f$stock = Field(
    'stock',
    _$stock,
    opt: true,
  );
  static String? _$status(StoreProduct v) => v.status;
  static const Field<StoreProduct, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static List<ProductVariant>? _$variants(StoreProduct v) => v.variants;
  static const Field<StoreProduct, List<ProductVariant>> _f$variants = Field(
    'variants',
    _$variants,
    opt: true,
  );
  static List<ProductDiscount>? _$discounts(StoreProduct v) => v.discounts;
  static const Field<StoreProduct, List<ProductDiscount>> _f$discounts = Field(
    'discounts',
    _$discounts,
    opt: true,
  );
  static List<ProductBoxItem>? _$items(StoreProduct v) => v.items;
  static const Field<StoreProduct, List<ProductBoxItem>> _f$items = Field(
    'items',
    _$items,
    opt: true,
  );
  static ProductReviewSummary? _$review(StoreProduct v) => v.review;
  static const Field<StoreProduct, ProductReviewSummary> _f$review = Field(
    'review',
    _$review,
    opt: true,
  );
  static MerchantInfo? _$merchant(StoreProduct v) => v.merchant;
  static const Field<StoreProduct, MerchantInfo> _f$merchant = Field(
    'merchant',
    _$merchant,
    opt: true,
  );
  static List<String>? _$tags(StoreProduct v) => v.tags;
  static const Field<StoreProduct, List<String>> _f$tags = Field(
    'tags',
    _$tags,
    opt: true,
  );
  static String? _$createdAt(StoreProduct v) => v.createdAt;
  static const Field<StoreProduct, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );

  @override
  final MappableFields<StoreProduct> fields = const {
    #id: _f$id,
    #name: _f$name,
    #description: _f$description,
    #images: _f$images,
    #price: _f$price,
    #unit: _f$unit,
    #productType: _f$productType,
    #purchaseOptions: _f$purchaseOptions,
    #manageStock: _f$manageStock,
    #stock: _f$stock,
    #status: _f$status,
    #variants: _f$variants,
    #discounts: _f$discounts,
    #items: _f$items,
    #review: _f$review,
    #merchant: _f$merchant,
    #tags: _f$tags,
    #createdAt: _f$createdAt,
  };

  static StoreProduct _instantiate(DecodingData data) {
    return StoreProduct(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      description: data.dec(_f$description),
      images: data.dec(_f$images),
      price: data.dec(_f$price),
      unit: data.dec(_f$unit),
      productType: data.dec(_f$productType),
      purchaseOptions: data.dec(_f$purchaseOptions),
      manageStock: data.dec(_f$manageStock),
      stock: data.dec(_f$stock),
      status: data.dec(_f$status),
      variants: data.dec(_f$variants),
      discounts: data.dec(_f$discounts),
      items: data.dec(_f$items),
      review: data.dec(_f$review),
      merchant: data.dec(_f$merchant),
      tags: data.dec(_f$tags),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StoreProduct fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StoreProduct>(map);
  }

  static StoreProduct fromJson(String json) {
    return ensureInitialized().decodeJson<StoreProduct>(json);
  }
}

mixin StoreProductMappable {
  String toJson() {
    return StoreProductMapper.ensureInitialized().encodeJson<StoreProduct>(
      this as StoreProduct,
    );
  }

  Map<String, dynamic> toMap() {
    return StoreProductMapper.ensureInitialized().encodeMap<StoreProduct>(
      this as StoreProduct,
    );
  }

  StoreProductCopyWith<StoreProduct, StoreProduct, StoreProduct> get copyWith =>
      _StoreProductCopyWithImpl<StoreProduct, StoreProduct>(
        this as StoreProduct,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return StoreProductMapper.ensureInitialized().stringifyValue(
      this as StoreProduct,
    );
  }

  @override
  bool operator ==(Object other) {
    return StoreProductMapper.ensureInitialized().equalsValue(
      this as StoreProduct,
      other,
    );
  }

  @override
  int get hashCode {
    return StoreProductMapper.ensureInitialized().hashValue(
      this as StoreProduct,
    );
  }
}

extension StoreProductValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StoreProduct, $Out> {
  StoreProductCopyWith<$R, StoreProduct, $Out> get $asStoreProduct =>
      $base.as((v, t, t2) => _StoreProductCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StoreProductCopyWith<$R, $In extends StoreProduct, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ProductImage,
    ProductImageCopyWith<$R, ProductImage, ProductImage>
  >?
  get images;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get purchaseOptions;
  ListCopyWith<
    $R,
    ProductVariant,
    ProductVariantCopyWith<$R, ProductVariant, ProductVariant>
  >?
  get variants;
  ListCopyWith<
    $R,
    ProductDiscount,
    ProductDiscountCopyWith<$R, ProductDiscount, ProductDiscount>
  >?
  get discounts;
  ListCopyWith<
    $R,
    ProductBoxItem,
    ProductBoxItemCopyWith<$R, ProductBoxItem, ProductBoxItem>
  >?
  get items;
  ProductReviewSummaryCopyWith<$R, ProductReviewSummary, ProductReviewSummary>?
  get review;
  MerchantInfoCopyWith<$R, MerchantInfo, MerchantInfo>? get merchant;
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get tags;
  $R call({
    String? id,
    String? name,
    String? description,
    List<ProductImage>? images,
    num? price,
    String? unit,
    String? productType,
    List<String>? purchaseOptions,
    bool? manageStock,
    num? stock,
    String? status,
    List<ProductVariant>? variants,
    List<ProductDiscount>? discounts,
    List<ProductBoxItem>? items,
    ProductReviewSummary? review,
    MerchantInfo? merchant,
    List<String>? tags,
    String? createdAt,
  });
  StoreProductCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StoreProductCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StoreProduct, $Out>
    implements StoreProductCopyWith<$R, StoreProduct, $Out> {
  _StoreProductCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StoreProduct> $mapper =
      StoreProductMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ProductImage,
    ProductImageCopyWith<$R, ProductImage, ProductImage>
  >?
  get images => $value.images != null
      ? ListCopyWith(
          $value.images!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(images: v),
        )
      : null;
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>?
  get purchaseOptions => $value.purchaseOptions != null
      ? ListCopyWith(
          $value.purchaseOptions!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(purchaseOptions: v),
        )
      : null;
  @override
  ListCopyWith<
    $R,
    ProductVariant,
    ProductVariantCopyWith<$R, ProductVariant, ProductVariant>
  >?
  get variants => $value.variants != null
      ? ListCopyWith(
          $value.variants!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(variants: v),
        )
      : null;
  @override
  ListCopyWith<
    $R,
    ProductDiscount,
    ProductDiscountCopyWith<$R, ProductDiscount, ProductDiscount>
  >?
  get discounts => $value.discounts != null
      ? ListCopyWith(
          $value.discounts!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(discounts: v),
        )
      : null;
  @override
  ListCopyWith<
    $R,
    ProductBoxItem,
    ProductBoxItemCopyWith<$R, ProductBoxItem, ProductBoxItem>
  >?
  get items => $value.items != null
      ? ListCopyWith(
          $value.items!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(items: v),
        )
      : null;
  @override
  ProductReviewSummaryCopyWith<$R, ProductReviewSummary, ProductReviewSummary>?
  get review => $value.review?.copyWith.$chain((v) => call(review: v));
  @override
  MerchantInfoCopyWith<$R, MerchantInfo, MerchantInfo>? get merchant =>
      $value.merchant?.copyWith.$chain((v) => call(merchant: v));
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get tags =>
      $value.tags != null
      ? ListCopyWith(
          $value.tags!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(tags: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    Object? name = $none,
    Object? description = $none,
    Object? images = $none,
    Object? price = $none,
    Object? unit = $none,
    Object? productType = $none,
    Object? purchaseOptions = $none,
    Object? manageStock = $none,
    Object? stock = $none,
    Object? status = $none,
    Object? variants = $none,
    Object? discounts = $none,
    Object? items = $none,
    Object? review = $none,
    Object? merchant = $none,
    Object? tags = $none,
    Object? createdAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != $none) #name: name,
      if (description != $none) #description: description,
      if (images != $none) #images: images,
      if (price != $none) #price: price,
      if (unit != $none) #unit: unit,
      if (productType != $none) #productType: productType,
      if (purchaseOptions != $none) #purchaseOptions: purchaseOptions,
      if (manageStock != $none) #manageStock: manageStock,
      if (stock != $none) #stock: stock,
      if (status != $none) #status: status,
      if (variants != $none) #variants: variants,
      if (discounts != $none) #discounts: discounts,
      if (items != $none) #items: items,
      if (review != $none) #review: review,
      if (merchant != $none) #merchant: merchant,
      if (tags != $none) #tags: tags,
      if (createdAt != $none) #createdAt: createdAt,
    }),
  );
  @override
  StoreProduct $make(CopyWithData data) => StoreProduct(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    description: data.get(#description, or: $value.description),
    images: data.get(#images, or: $value.images),
    price: data.get(#price, or: $value.price),
    unit: data.get(#unit, or: $value.unit),
    productType: data.get(#productType, or: $value.productType),
    purchaseOptions: data.get(#purchaseOptions, or: $value.purchaseOptions),
    manageStock: data.get(#manageStock, or: $value.manageStock),
    stock: data.get(#stock, or: $value.stock),
    status: data.get(#status, or: $value.status),
    variants: data.get(#variants, or: $value.variants),
    discounts: data.get(#discounts, or: $value.discounts),
    items: data.get(#items, or: $value.items),
    review: data.get(#review, or: $value.review),
    merchant: data.get(#merchant, or: $value.merchant),
    tags: data.get(#tags, or: $value.tags),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  StoreProductCopyWith<$R2, StoreProduct, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StoreProductCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

