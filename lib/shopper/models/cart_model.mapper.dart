// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'cart_model.dart';

class CartItemMapper extends ClassMapperBase<CartItem> {
  CartItemMapper._();

  static CartItemMapper? _instance;
  static CartItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartItemMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'CartItem';

  static String? _$id(CartItem v) => v.id;
  static const Field<CartItem, String> _f$id = Field('id', _$id, opt: true);
  static String? _$name(CartItem v) => v.name;
  static const Field<CartItem, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static num? _$qty(CartItem v) => v.qty;
  static const Field<CartItem, num> _f$qty = Field('qty', _$qty, opt: true);
  static num? _$price(CartItem v) => v.price;
  static const Field<CartItem, num> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );
  static String? _$unit(CartItem v) => v.unit;
  static const Field<CartItem, String> _f$unit = Field(
    'unit',
    _$unit,
    opt: true,
  );
  static dynamic _$images(CartItem v) => v.images;
  static const Field<CartItem, dynamic> _f$images = Field(
    'images',
    _$images,
    opt: true,
  );
  static dynamic _$image(CartItem v) => v.image;
  static const Field<CartItem, dynamic> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static dynamic _$variant(CartItem v) => v.variant;
  static const Field<CartItem, dynamic> _f$variant = Field(
    'variant',
    _$variant,
    opt: true,
  );

  @override
  final MappableFields<CartItem> fields = const {
    #id: _f$id,
    #name: _f$name,
    #qty: _f$qty,
    #price: _f$price,
    #unit: _f$unit,
    #images: _f$images,
    #image: _f$image,
    #variant: _f$variant,
  };

  static CartItem _instantiate(DecodingData data) {
    return CartItem(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      qty: data.dec(_f$qty),
      price: data.dec(_f$price),
      unit: data.dec(_f$unit),
      images: data.dec(_f$images),
      image: data.dec(_f$image),
      variant: data.dec(_f$variant),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static CartItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<CartItem>(map);
  }

  static CartItem fromJson(String json) {
    return ensureInitialized().decodeJson<CartItem>(json);
  }
}

mixin CartItemMappable {
  String toJson() {
    return CartItemMapper.ensureInitialized().encodeJson<CartItem>(
      this as CartItem,
    );
  }

  Map<String, dynamic> toMap() {
    return CartItemMapper.ensureInitialized().encodeMap<CartItem>(
      this as CartItem,
    );
  }

  CartItemCopyWith<CartItem, CartItem, CartItem> get copyWith =>
      _CartItemCopyWithImpl<CartItem, CartItem>(
        this as CartItem,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CartItemMapper.ensureInitialized().stringifyValue(this as CartItem);
  }

  @override
  bool operator ==(Object other) {
    return CartItemMapper.ensureInitialized().equalsValue(
      this as CartItem,
      other,
    );
  }

  @override
  int get hashCode {
    return CartItemMapper.ensureInitialized().hashValue(this as CartItem);
  }
}

extension CartItemValueCopy<$R, $Out> on ObjectCopyWith<$R, CartItem, $Out> {
  CartItemCopyWith<$R, CartItem, $Out> get $asCartItem =>
      $base.as((v, t, t2) => _CartItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CartItemCopyWith<$R, $In extends CartItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    num? qty,
    num? price,
    String? unit,
    dynamic images,
    dynamic image,
    dynamic variant,
  });
  CartItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CartItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, CartItem, $Out>
    implements CartItemCopyWith<$R, CartItem, $Out> {
  _CartItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<CartItem> $mapper =
      CartItemMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? name = $none,
    Object? qty = $none,
    Object? price = $none,
    Object? unit = $none,
    Object? images = $none,
    Object? image = $none,
    Object? variant = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != $none) #name: name,
      if (qty != $none) #qty: qty,
      if (price != $none) #price: price,
      if (unit != $none) #unit: unit,
      if (images != $none) #images: images,
      if (image != $none) #image: image,
      if (variant != $none) #variant: variant,
    }),
  );
  @override
  CartItem $make(CopyWithData data) => CartItem(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    qty: data.get(#qty, or: $value.qty),
    price: data.get(#price, or: $value.price),
    unit: data.get(#unit, or: $value.unit),
    images: data.get(#images, or: $value.images),
    image: data.get(#image, or: $value.image),
    variant: data.get(#variant, or: $value.variant),
  );

  @override
  CartItemCopyWith<$R2, CartItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CartItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CartMapper extends ClassMapperBase<Cart> {
  CartMapper._();

  static CartMapper? _instance;
  static CartMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CartMapper._());
      CartItemMapper.ensureInitialized();
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
  static List<CartItem>? _$items(Cart v) => v.items;
  static const Field<Cart, List<CartItem>> _f$items = Field(
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
  ListCopyWith<$R, CartItem, CartItemCopyWith<$R, CartItem, CartItem>>?
  get items;
  $R call({String? id, String? branchId, List<CartItem>? items});
  CartCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CartCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Cart, $Out>
    implements CartCopyWith<$R, Cart, $Out> {
  _CartCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Cart> $mapper = CartMapper.ensureInitialized();
  @override
  ListCopyWith<$R, CartItem, CartItemCopyWith<$R, CartItem, CartItem>>?
  get items => $value.items != null
      ? ListCopyWith(
          $value.items!,
          (v, t) => v.copyWith.$chain(t),
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

