// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'product_review_model.dart';

class ProductReviewMapper extends ClassMapperBase<ProductReview> {
  ProductReviewMapper._();

  static ProductReviewMapper? _instance;
  static ProductReviewMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ProductReviewMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ProductReview';

  static String? _$id(ProductReview v) => v.id;
  static const Field<ProductReview, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static num? _$rating(ProductReview v) => v.rating;
  static const Field<ProductReview, num> _f$rating = Field(
    'rating',
    _$rating,
    opt: true,
  );
  static String? _$comment(ProductReview v) => v.comment;
  static const Field<ProductReview, String> _f$comment = Field(
    'comment',
    _$comment,
    opt: true,
  );
  static String? _$name(ProductReview v) => v.name;
  static const Field<ProductReview, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static dynamic _$user(ProductReview v) => v.user;
  static const Field<ProductReview, dynamic> _f$user = Field(
    'user',
    _$user,
    opt: true,
  );
  static String? _$createdAt(ProductReview v) => v.createdAt;
  static const Field<ProductReview, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );

  @override
  final MappableFields<ProductReview> fields = const {
    #id: _f$id,
    #rating: _f$rating,
    #comment: _f$comment,
    #name: _f$name,
    #user: _f$user,
    #createdAt: _f$createdAt,
  };

  static ProductReview _instantiate(DecodingData data) {
    return ProductReview(
      id: data.dec(_f$id),
      rating: data.dec(_f$rating),
      comment: data.dec(_f$comment),
      name: data.dec(_f$name),
      user: data.dec(_f$user),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ProductReview fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ProductReview>(map);
  }

  static ProductReview fromJson(String json) {
    return ensureInitialized().decodeJson<ProductReview>(json);
  }
}

mixin ProductReviewMappable {
  String toJson() {
    return ProductReviewMapper.ensureInitialized().encodeJson<ProductReview>(
      this as ProductReview,
    );
  }

  Map<String, dynamic> toMap() {
    return ProductReviewMapper.ensureInitialized().encodeMap<ProductReview>(
      this as ProductReview,
    );
  }

  ProductReviewCopyWith<ProductReview, ProductReview, ProductReview>
  get copyWith => _ProductReviewCopyWithImpl<ProductReview, ProductReview>(
    this as ProductReview,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ProductReviewMapper.ensureInitialized().stringifyValue(
      this as ProductReview,
    );
  }

  @override
  bool operator ==(Object other) {
    return ProductReviewMapper.ensureInitialized().equalsValue(
      this as ProductReview,
      other,
    );
  }

  @override
  int get hashCode {
    return ProductReviewMapper.ensureInitialized().hashValue(
      this as ProductReview,
    );
  }
}

extension ProductReviewValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ProductReview, $Out> {
  ProductReviewCopyWith<$R, ProductReview, $Out> get $asProductReview =>
      $base.as((v, t, t2) => _ProductReviewCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ProductReviewCopyWith<$R, $In extends ProductReview, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    num? rating,
    String? comment,
    String? name,
    dynamic user,
    String? createdAt,
  });
  ProductReviewCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ProductReviewCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ProductReview, $Out>
    implements ProductReviewCopyWith<$R, ProductReview, $Out> {
  _ProductReviewCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ProductReview> $mapper =
      ProductReviewMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? rating = $none,
    Object? comment = $none,
    Object? name = $none,
    Object? user = $none,
    Object? createdAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (rating != $none) #rating: rating,
      if (comment != $none) #comment: comment,
      if (name != $none) #name: name,
      if (user != $none) #user: user,
      if (createdAt != $none) #createdAt: createdAt,
    }),
  );
  @override
  ProductReview $make(CopyWithData data) => ProductReview(
    id: data.get(#id, or: $value.id),
    rating: data.get(#rating, or: $value.rating),
    comment: data.get(#comment, or: $value.comment),
    name: data.get(#name, or: $value.name),
    user: data.get(#user, or: $value.user),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  ProductReviewCopyWith<$R2, ProductReview, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ProductReviewCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

