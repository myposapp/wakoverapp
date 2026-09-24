// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cart_model.dart';

class CartMapper extends ClassMapperBase<Cart> {
  CartMapper._();

  static CartMapper? _instance;
  static CartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Cart';

  static String? _$id(Cart v) => v.id;
  static const Field<Cart, String> _f$id = Field('id', _$id, opt: true);
  static String? _$branchId(Cart v) => v.branchId;
  static const Field<Cart, String> _f$branchId = Field(
    'branchId',
    _$branchId,
    key: r'branch_id',
    opt: true,
  );
  static List<dynamic>? _$items(Cart v) => v.items;
  static const Field<Cart, List<dynamic>> _f$items = Field(
    'items',
    _$items,
    opt: true,
  );

  @override
  final MappableFields<Cart> fields = const {
    #id: _f$id,
    #branchId: _f$branchId,
    #items: _f$items,
  };

  static Cart _instantiate(DecodingData data) {
    return Cart(
      id: data.dec(_f$id),
      branchId: data.dec(_f$branchId),
      items: data.dec(_f$items),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Cart fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Cart>(map);
  }

  static Cart fromJson(String json) {
    return ensureInitialized().decodeJson<Cart>(json);
  }
}

mixin CartMappable {
  String toJson() {
    return CartMapper.ensureInitialized().encodeJson<Cart>(this as Cart);
  }

  Map<String, dynamic> toMap() {
    return CartMapper.ensureInitialized().encodeMap<Cart>(this as Cart);
  }

  CartCopyWith<Cart, Cart, Cart> get copyWith =>
      _CartCopyWithImpl<Cart, Cart>(this as Cart, $identity, $identity);
  @override
  String toString() {
    return CartMapper.ensureInitialized().stringifyValue(this as Cart);
  }

  @override
  bool operator ==(Object other) {
    return CartMapper.ensureInitialized().equalsValue(this as Cart, other);
  }

  @override
  int get hashCode {
    return CartMapper.ensureInitialized().hashValue(this as Cart);
  }
}

extension CartValueCopy<$R, $Out> on ObjectCopyWith<$R, Cart, $Out> {
  CartCopyWith<$R, Cart, $Out> get $asCart =>
      $base.as((v, t, t2) => _CartCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartCopyWith<$R, $In extends Cart, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get items;
  $R call({String? id, String? branchId, List<dynamic>? items});
  CartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CartCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Cart, $Out>
    implements CartCopyWith<$R, Cart, $Out> {
  _CartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Cart> $mapper = CartMapper.ensureInitialized();
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get items =>
      $value.items != null
      ? ListCopyWith(
          $value.items!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(items: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    Object? branchId = $none,
    Object? items = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (branchId != $none) #branchId: branchId,
      if (items != $none) #items: items,
    }),
  );
  @override
  Cart $make(CopyWithData data) => Cart(
    id: data.get(#id, or: $value.id),
    branchId: data.get(#branchId, or: $value.branchId),
    items: data.get(#items, or: $value.items),
  );

  @override
  CartCopyWith<$R2, Cart, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _CartCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

