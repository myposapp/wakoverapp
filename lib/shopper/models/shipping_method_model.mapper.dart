// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'shipping_method_model.dart';

class ShippingMethodMapper extends ClassMapperBase<ShippingMethod> {
  ShippingMethodMapper._();

  static ShippingMethodMapper? _instance;
  static ShippingMethodMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShippingMethodMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ShippingMethod';

  static String? _$id(ShippingMethod v) => v.id;
  static const Field<ShippingMethod, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$title(ShippingMethod v) => v.title;
  static const Field<ShippingMethod, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
  );
  static String? _$description(ShippingMethod v) => v.description;
  static const Field<ShippingMethod, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static num? _$price(ShippingMethod v) => v.price;
  static const Field<ShippingMethod, num> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );

  @override
  final MappableFields<ShippingMethod> fields = const {
    #id: _f$id,
    #title: _f$title,
    #description: _f$description,
    #price: _f$price,
  };

  static ShippingMethod _instantiate(DecodingData data) {
    return ShippingMethod(
      id: data.dec(_f$id),
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      price: data.dec(_f$price),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShippingMethod fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShippingMethod>(map);
  }

  static ShippingMethod fromJson(String json) {
    return ensureInitialized().decodeJson<ShippingMethod>(json);
  }
}

mixin ShippingMethodMappable {
  String toJson() {
    return ShippingMethodMapper.ensureInitialized().encodeJson<ShippingMethod>(
      this as ShippingMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return ShippingMethodMapper.ensureInitialized().encodeMap<ShippingMethod>(
      this as ShippingMethod,
    );
  }

  ShippingMethodCopyWith<ShippingMethod, ShippingMethod, ShippingMethod>
  get copyWith => _ShippingMethodCopyWithImpl<ShippingMethod, ShippingMethod>(
    this as ShippingMethod,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ShippingMethodMapper.ensureInitialized().stringifyValue(
      this as ShippingMethod,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShippingMethodMapper.ensureInitialized().equalsValue(
      this as ShippingMethod,
      other,
    );
  }

  @override
  int get hashCode {
    return ShippingMethodMapper.ensureInitialized().hashValue(
      this as ShippingMethod,
    );
  }
}

extension ShippingMethodValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShippingMethod, $Out> {
  ShippingMethodCopyWith<$R, ShippingMethod, $Out> get $asShippingMethod =>
      $base.as((v, t, t2) => _ShippingMethodCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ShippingMethodCopyWith<$R, $In extends ShippingMethod, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? title, String? description, num? price});
  ShippingMethodCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ShippingMethodCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShippingMethod, $Out>
    implements ShippingMethodCopyWith<$R, ShippingMethod, $Out> {
  _ShippingMethodCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShippingMethod> $mapper =
      ShippingMethodMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? title = $none,
    Object? description = $none,
    Object? price = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (title != $none) #title: title,
      if (description != $none) #description: description,
      if (price != $none) #price: price,
    }),
  );
  @override
  ShippingMethod $make(CopyWithData data) => ShippingMethod(
    id: data.get(#id, or: $value.id),
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    price: data.get(#price, or: $value.price),
  );

  @override
  ShippingMethodCopyWith<$R2, ShippingMethod, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShippingMethodCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ShippingMethodsDataMapper extends ClassMapperBase<ShippingMethodsData> {
  ShippingMethodsDataMapper._();

  static ShippingMethodsDataMapper? _instance;
  static ShippingMethodsDataMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShippingMethodsDataMapper._());
      ShippingMethodMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ShippingMethodsData';

  static List<ShippingMethod>? _$shippingMethods(ShippingMethodsData v) =>
      v.shippingMethods;
  static const Field<ShippingMethodsData, List<ShippingMethod>>
  _f$shippingMethods = Field(
    'shippingMethods',
    _$shippingMethods,
    key: r'shipping_methods',
    opt: true,
  );
  static List<dynamic>? _$groupDeliveryPoints(ShippingMethodsData v) =>
      v.groupDeliveryPoints;
  static const Field<ShippingMethodsData, List<dynamic>>
  _f$groupDeliveryPoints = Field(
    'groupDeliveryPoints',
    _$groupDeliveryPoints,
    key: r'group_delivery_points',
    opt: true,
  );

  @override
  final MappableFields<ShippingMethodsData> fields = const {
    #shippingMethods: _f$shippingMethods,
    #groupDeliveryPoints: _f$groupDeliveryPoints,
  };

  static ShippingMethodsData _instantiate(DecodingData data) {
    return ShippingMethodsData(
      shippingMethods: data.dec(_f$shippingMethods),
      groupDeliveryPoints: data.dec(_f$groupDeliveryPoints),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShippingMethodsData fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShippingMethodsData>(map);
  }

  static ShippingMethodsData fromJson(String json) {
    return ensureInitialized().decodeJson<ShippingMethodsData>(json);
  }
}

mixin ShippingMethodsDataMappable {
  String toJson() {
    return ShippingMethodsDataMapper.ensureInitialized()
        .encodeJson<ShippingMethodsData>(this as ShippingMethodsData);
  }

  Map<String, dynamic> toMap() {
    return ShippingMethodsDataMapper.ensureInitialized()
        .encodeMap<ShippingMethodsData>(this as ShippingMethodsData);
  }

  ShippingMethodsDataCopyWith<
    ShippingMethodsData,
    ShippingMethodsData,
    ShippingMethodsData
  >
  get copyWith =>
      _ShippingMethodsDataCopyWithImpl<
        ShippingMethodsData,
        ShippingMethodsData
      >(this as ShippingMethodsData, $identity, $identity);
  @override
  String toString() {
    return ShippingMethodsDataMapper.ensureInitialized().stringifyValue(
      this as ShippingMethodsData,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShippingMethodsDataMapper.ensureInitialized().equalsValue(
      this as ShippingMethodsData,
      other,
    );
  }

  @override
  int get hashCode {
    return ShippingMethodsDataMapper.ensureInitialized().hashValue(
      this as ShippingMethodsData,
    );
  }
}

extension ShippingMethodsDataValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShippingMethodsData, $Out> {
  ShippingMethodsDataCopyWith<$R, ShippingMethodsData, $Out>
  get $asShippingMethodsData => $base.as(
    (v, t, t2) => _ShippingMethodsDataCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class ShippingMethodsDataCopyWith<
  $R,
  $In extends ShippingMethodsData,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ShippingMethod,
    ShippingMethodCopyWith<$R, ShippingMethod, ShippingMethod>
  >?
  get shippingMethods;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get groupDeliveryPoints;
  $R call({
    List<ShippingMethod>? shippingMethods,
    List<dynamic>? groupDeliveryPoints,
  });
  ShippingMethodsDataCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ShippingMethodsDataCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShippingMethodsData, $Out>
    implements ShippingMethodsDataCopyWith<$R, ShippingMethodsData, $Out> {
  _ShippingMethodsDataCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShippingMethodsData> $mapper =
      ShippingMethodsDataMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    ShippingMethod,
    ShippingMethodCopyWith<$R, ShippingMethod, ShippingMethod>
  >?
  get shippingMethods => $value.shippingMethods != null
      ? ListCopyWith(
          $value.shippingMethods!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(shippingMethods: v),
        )
      : null;
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get groupDeliveryPoints => $value.groupDeliveryPoints != null
      ? ListCopyWith(
          $value.groupDeliveryPoints!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(groupDeliveryPoints: v),
        )
      : null;
  @override
  $R call({
    Object? shippingMethods = $none,
    Object? groupDeliveryPoints = $none,
  }) => $apply(
    FieldCopyWithData({
      if (shippingMethods != $none) #shippingMethods: shippingMethods,
      if (groupDeliveryPoints != $none)
        #groupDeliveryPoints: groupDeliveryPoints,
    }),
  );
  @override
  ShippingMethodsData $make(CopyWithData data) => ShippingMethodsData(
    shippingMethods: data.get(#shippingMethods, or: $value.shippingMethods),
    groupDeliveryPoints: data.get(
      #groupDeliveryPoints,
      or: $value.groupDeliveryPoints,
    ),
  );

  @override
  ShippingMethodsDataCopyWith<$R2, ShippingMethodsData, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ShippingMethodsDataCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

