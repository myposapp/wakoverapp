// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'store_order_model.dart';

class StoreOrderItemMapper extends ClassMapperBase<StoreOrderItem> {
  StoreOrderItemMapper._();

  static StoreOrderItemMapper? _instance;
  static StoreOrderItemMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StoreOrderItemMapper._());
      ProductImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StoreOrderItem';

  static String? _$id(StoreOrderItem v) => v.id;
  static const Field<StoreOrderItem, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$productId(StoreOrderItem v) => v.productId;
  static const Field<StoreOrderItem, String> _f$productId = Field(
    'productId',
    _$productId,
    key: r'product_id',
    opt: true,
  );
  static String? _$name(StoreOrderItem v) => v.name;
  static const Field<StoreOrderItem, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static ProductImage? _$image(StoreOrderItem v) => v.image;
  static const Field<StoreOrderItem, ProductImage> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static String? _$productType(StoreOrderItem v) => v.productType;
  static const Field<StoreOrderItem, String> _f$productType = Field(
    'productType',
    _$productType,
    key: r'product_type',
    opt: true,
  );
  static num? _$qty(StoreOrderItem v) => v.qty;
  static const Field<StoreOrderItem, num> _f$qty = Field(
    'qty',
    _$qty,
    opt: true,
  );
  static String? _$unit(StoreOrderItem v) => v.unit;
  static const Field<StoreOrderItem, String> _f$unit = Field(
    'unit',
    _$unit,
    opt: true,
  );
  static num? _$price(StoreOrderItem v) => v.price;
  static const Field<StoreOrderItem, num> _f$price = Field(
    'price',
    _$price,
    opt: true,
  );
  static dynamic _$variant(StoreOrderItem v) => v.variant;
  static const Field<StoreOrderItem, dynamic> _f$variant = Field(
    'variant',
    _$variant,
    opt: true,
  );
  static List<dynamic>? _$files(StoreOrderItem v) => v.files;
  static const Field<StoreOrderItem, List<dynamic>> _f$files = Field(
    'files',
    _$files,
    opt: true,
  );
  static dynamic _$review(StoreOrderItem v) => v.review;
  static const Field<StoreOrderItem, dynamic> _f$review = Field(
    'review',
    _$review,
    opt: true,
  );

  @override
  final MappableFields<StoreOrderItem> fields = const {
    #id: _f$id,
    #productId: _f$productId,
    #name: _f$name,
    #image: _f$image,
    #productType: _f$productType,
    #qty: _f$qty,
    #unit: _f$unit,
    #price: _f$price,
    #variant: _f$variant,
    #files: _f$files,
    #review: _f$review,
  };

  static StoreOrderItem _instantiate(DecodingData data) {
    return StoreOrderItem(
      id: data.dec(_f$id),
      productId: data.dec(_f$productId),
      name: data.dec(_f$name),
      image: data.dec(_f$image),
      productType: data.dec(_f$productType),
      qty: data.dec(_f$qty),
      unit: data.dec(_f$unit),
      price: data.dec(_f$price),
      variant: data.dec(_f$variant),
      files: data.dec(_f$files),
      review: data.dec(_f$review),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StoreOrderItem fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StoreOrderItem>(map);
  }

  static StoreOrderItem fromJson(String json) {
    return ensureInitialized().decodeJson<StoreOrderItem>(json);
  }
}

mixin StoreOrderItemMappable {
  String toJson() {
    return StoreOrderItemMapper.ensureInitialized().encodeJson<StoreOrderItem>(
      this as StoreOrderItem,
    );
  }

  Map<String, dynamic> toMap() {
    return StoreOrderItemMapper.ensureInitialized().encodeMap<StoreOrderItem>(
      this as StoreOrderItem,
    );
  }

  StoreOrderItemCopyWith<StoreOrderItem, StoreOrderItem, StoreOrderItem>
  get copyWith => _StoreOrderItemCopyWithImpl<StoreOrderItem, StoreOrderItem>(
    this as StoreOrderItem,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return StoreOrderItemMapper.ensureInitialized().stringifyValue(
      this as StoreOrderItem,
    );
  }

  @override
  bool operator ==(Object other) {
    return StoreOrderItemMapper.ensureInitialized().equalsValue(
      this as StoreOrderItem,
      other,
    );
  }

  @override
  int get hashCode {
    return StoreOrderItemMapper.ensureInitialized().hashValue(
      this as StoreOrderItem,
    );
  }
}

extension StoreOrderItemValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StoreOrderItem, $Out> {
  StoreOrderItemCopyWith<$R, StoreOrderItem, $Out> get $asStoreOrderItem =>
      $base.as((v, t, t2) => _StoreOrderItemCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StoreOrderItemCopyWith<$R, $In extends StoreOrderItem, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ProductImageCopyWith<$R, ProductImage, ProductImage>? get image;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get files;
  $R call({
    String? id,
    String? productId,
    String? name,
    ProductImage? image,
    String? productType,
    num? qty,
    String? unit,
    num? price,
    dynamic variant,
    List<dynamic>? files,
    dynamic review,
  });
  StoreOrderItemCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _StoreOrderItemCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StoreOrderItem, $Out>
    implements StoreOrderItemCopyWith<$R, StoreOrderItem, $Out> {
  _StoreOrderItemCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StoreOrderItem> $mapper =
      StoreOrderItemMapper.ensureInitialized();
  @override
  ProductImageCopyWith<$R, ProductImage, ProductImage>? get image =>
      $value.image?.copyWith.$chain((v) => call(image: v));
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get files =>
      $value.files != null
      ? ListCopyWith(
          $value.files!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(files: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    Object? productId = $none,
    Object? name = $none,
    Object? image = $none,
    Object? productType = $none,
    Object? qty = $none,
    Object? unit = $none,
    Object? price = $none,
    Object? variant = $none,
    Object? files = $none,
    Object? review = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (productId != $none) #productId: productId,
      if (name != $none) #name: name,
      if (image != $none) #image: image,
      if (productType != $none) #productType: productType,
      if (qty != $none) #qty: qty,
      if (unit != $none) #unit: unit,
      if (price != $none) #price: price,
      if (variant != $none) #variant: variant,
      if (files != $none) #files: files,
      if (review != $none) #review: review,
    }),
  );
  @override
  StoreOrderItem $make(CopyWithData data) => StoreOrderItem(
    id: data.get(#id, or: $value.id),
    productId: data.get(#productId, or: $value.productId),
    name: data.get(#name, or: $value.name),
    image: data.get(#image, or: $value.image),
    productType: data.get(#productType, or: $value.productType),
    qty: data.get(#qty, or: $value.qty),
    unit: data.get(#unit, or: $value.unit),
    price: data.get(#price, or: $value.price),
    variant: data.get(#variant, or: $value.variant),
    files: data.get(#files, or: $value.files),
    review: data.get(#review, or: $value.review),
  );

  @override
  StoreOrderItemCopyWith<$R2, StoreOrderItem, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StoreOrderItemCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ShippingAddressMapper extends ClassMapperBase<ShippingAddress> {
  ShippingAddressMapper._();

  static ShippingAddressMapper? _instance;
  static ShippingAddressMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShippingAddressMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ShippingAddress';

  static String? _$name(ShippingAddress v) => v.name;
  static const Field<ShippingAddress, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$phone(ShippingAddress v) => v.phone;
  static const Field<ShippingAddress, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static String? _$email(ShippingAddress v) => v.email;
  static const Field<ShippingAddress, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
  );
  static String? _$address(ShippingAddress v) => v.address;
  static const Field<ShippingAddress, String> _f$address = Field(
    'address',
    _$address,
    opt: true,
  );
  static String? _$address2(ShippingAddress v) => v.address2;
  static const Field<ShippingAddress, String> _f$address2 = Field(
    'address2',
    _$address2,
    opt: true,
  );
  static String? _$city(ShippingAddress v) => v.city;
  static const Field<ShippingAddress, String> _f$city = Field(
    'city',
    _$city,
    opt: true,
  );
  static String? _$county(ShippingAddress v) => v.county;
  static const Field<ShippingAddress, String> _f$county = Field(
    'county',
    _$county,
    opt: true,
  );
  static String? _$state(ShippingAddress v) => v.state;
  static const Field<ShippingAddress, String> _f$state = Field(
    'state',
    _$state,
    opt: true,
  );
  static String? _$country(ShippingAddress v) => v.country;
  static const Field<ShippingAddress, String> _f$country = Field(
    'country',
    _$country,
    opt: true,
  );

  @override
  final MappableFields<ShippingAddress> fields = const {
    #name: _f$name,
    #phone: _f$phone,
    #email: _f$email,
    #address: _f$address,
    #address2: _f$address2,
    #city: _f$city,
    #county: _f$county,
    #state: _f$state,
    #country: _f$country,
  };

  static ShippingAddress _instantiate(DecodingData data) {
    return ShippingAddress(
      name: data.dec(_f$name),
      phone: data.dec(_f$phone),
      email: data.dec(_f$email),
      address: data.dec(_f$address),
      address2: data.dec(_f$address2),
      city: data.dec(_f$city),
      county: data.dec(_f$county),
      state: data.dec(_f$state),
      country: data.dec(_f$country),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShippingAddress fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShippingAddress>(map);
  }

  static ShippingAddress fromJson(String json) {
    return ensureInitialized().decodeJson<ShippingAddress>(json);
  }
}

mixin ShippingAddressMappable {
  String toJson() {
    return ShippingAddressMapper.ensureInitialized()
        .encodeJson<ShippingAddress>(this as ShippingAddress);
  }

  Map<String, dynamic> toMap() {
    return ShippingAddressMapper.ensureInitialized().encodeMap<ShippingAddress>(
      this as ShippingAddress,
    );
  }

  ShippingAddressCopyWith<ShippingAddress, ShippingAddress, ShippingAddress>
  get copyWith =>
      _ShippingAddressCopyWithImpl<ShippingAddress, ShippingAddress>(
        this as ShippingAddress,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ShippingAddressMapper.ensureInitialized().stringifyValue(
      this as ShippingAddress,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShippingAddressMapper.ensureInitialized().equalsValue(
      this as ShippingAddress,
      other,
    );
  }

  @override
  int get hashCode {
    return ShippingAddressMapper.ensureInitialized().hashValue(
      this as ShippingAddress,
    );
  }
}

extension ShippingAddressValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShippingAddress, $Out> {
  ShippingAddressCopyWith<$R, ShippingAddress, $Out> get $asShippingAddress =>
      $base.as((v, t, t2) => _ShippingAddressCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ShippingAddressCopyWith<$R, $In extends ShippingAddress, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? name,
    String? phone,
    String? email,
    String? address,
    String? address2,
    String? city,
    String? county,
    String? state,
    String? country,
  });
  ShippingAddressCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ShippingAddressCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShippingAddress, $Out>
    implements ShippingAddressCopyWith<$R, ShippingAddress, $Out> {
  _ShippingAddressCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShippingAddress> $mapper =
      ShippingAddressMapper.ensureInitialized();
  @override
  $R call({
    Object? name = $none,
    Object? phone = $none,
    Object? email = $none,
    Object? address = $none,
    Object? address2 = $none,
    Object? city = $none,
    Object? county = $none,
    Object? state = $none,
    Object? country = $none,
  }) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (phone != $none) #phone: phone,
      if (email != $none) #email: email,
      if (address != $none) #address: address,
      if (address2 != $none) #address2: address2,
      if (city != $none) #city: city,
      if (county != $none) #county: county,
      if (state != $none) #state: state,
      if (country != $none) #country: country,
    }),
  );
  @override
  ShippingAddress $make(CopyWithData data) => ShippingAddress(
    name: data.get(#name, or: $value.name),
    phone: data.get(#phone, or: $value.phone),
    email: data.get(#email, or: $value.email),
    address: data.get(#address, or: $value.address),
    address2: data.get(#address2, or: $value.address2),
    city: data.get(#city, or: $value.city),
    county: data.get(#county, or: $value.county),
    state: data.get(#state, or: $value.state),
    country: data.get(#country, or: $value.country),
  );

  @override
  ShippingAddressCopyWith<$R2, ShippingAddress, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShippingAddressCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ShippingDetailMapper extends ClassMapperBase<ShippingDetail> {
  ShippingDetailMapper._();

  static ShippingDetailMapper? _instance;
  static ShippingDetailMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShippingDetailMapper._());
      ShippingAddressMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ShippingDetail';

  static ShippingAddress? _$contact(ShippingDetail v) => v.contact;
  static const Field<ShippingDetail, ShippingAddress> _f$contact = Field(
    'contact',
    _$contact,
    opt: true,
  );
  static ShippingAddress? _$address(ShippingDetail v) => v.address;
  static const Field<ShippingDetail, ShippingAddress> _f$address = Field(
    'address',
    _$address,
    opt: true,
  );

  @override
  final MappableFields<ShippingDetail> fields = const {
    #contact: _f$contact,
    #address: _f$address,
  };

  static ShippingDetail _instantiate(DecodingData data) {
    return ShippingDetail(
      contact: data.dec(_f$contact),
      address: data.dec(_f$address),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShippingDetail fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShippingDetail>(map);
  }

  static ShippingDetail fromJson(String json) {
    return ensureInitialized().decodeJson<ShippingDetail>(json);
  }
}

mixin ShippingDetailMappable {
  String toJson() {
    return ShippingDetailMapper.ensureInitialized().encodeJson<ShippingDetail>(
      this as ShippingDetail,
    );
  }

  Map<String, dynamic> toMap() {
    return ShippingDetailMapper.ensureInitialized().encodeMap<ShippingDetail>(
      this as ShippingDetail,
    );
  }

  ShippingDetailCopyWith<ShippingDetail, ShippingDetail, ShippingDetail>
  get copyWith => _ShippingDetailCopyWithImpl<ShippingDetail, ShippingDetail>(
    this as ShippingDetail,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ShippingDetailMapper.ensureInitialized().stringifyValue(
      this as ShippingDetail,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShippingDetailMapper.ensureInitialized().equalsValue(
      this as ShippingDetail,
      other,
    );
  }

  @override
  int get hashCode {
    return ShippingDetailMapper.ensureInitialized().hashValue(
      this as ShippingDetail,
    );
  }
}

extension ShippingDetailValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShippingDetail, $Out> {
  ShippingDetailCopyWith<$R, ShippingDetail, $Out> get $asShippingDetail =>
      $base.as((v, t, t2) => _ShippingDetailCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ShippingDetailCopyWith<$R, $In extends ShippingDetail, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ShippingAddressCopyWith<$R, ShippingAddress, ShippingAddress>? get contact;
  ShippingAddressCopyWith<$R, ShippingAddress, ShippingAddress>? get address;
  $R call({ShippingAddress? contact, ShippingAddress? address});
  ShippingDetailCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ShippingDetailCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShippingDetail, $Out>
    implements ShippingDetailCopyWith<$R, ShippingDetail, $Out> {
  _ShippingDetailCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShippingDetail> $mapper =
      ShippingDetailMapper.ensureInitialized();
  @override
  ShippingAddressCopyWith<$R, ShippingAddress, ShippingAddress>? get contact =>
      $value.contact?.copyWith.$chain((v) => call(contact: v));
  @override
  ShippingAddressCopyWith<$R, ShippingAddress, ShippingAddress>? get address =>
      $value.address?.copyWith.$chain((v) => call(address: v));
  @override
  $R call({Object? contact = $none, Object? address = $none}) => $apply(
    FieldCopyWithData({
      if (contact != $none) #contact: contact,
      if (address != $none) #address: address,
    }),
  );
  @override
  ShippingDetail $make(CopyWithData data) => ShippingDetail(
    contact: data.get(#contact, or: $value.contact),
    address: data.get(#address, or: $value.address),
  );

  @override
  ShippingDetailCopyWith<$R2, ShippingDetail, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShippingDetailCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class DeliveryStatusMapper extends ClassMapperBase<DeliveryStatus> {
  DeliveryStatusMapper._();

  static DeliveryStatusMapper? _instance;
  static DeliveryStatusMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = DeliveryStatusMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'DeliveryStatus';

  static String? _$id(DeliveryStatus v) => v.id;
  static const Field<DeliveryStatus, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$status(DeliveryStatus v) => v.status;
  static const Field<DeliveryStatus, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static String? _$note(DeliveryStatus v) => v.note;
  static const Field<DeliveryStatus, String> _f$note = Field(
    'note',
    _$note,
    opt: true,
  );
  static String? _$dateTime(DeliveryStatus v) => v.dateTime;
  static const Field<DeliveryStatus, String> _f$dateTime = Field(
    'dateTime',
    _$dateTime,
    key: r'date_time',
    opt: true,
  );

  @override
  final MappableFields<DeliveryStatus> fields = const {
    #id: _f$id,
    #status: _f$status,
    #note: _f$note,
    #dateTime: _f$dateTime,
  };

  static DeliveryStatus _instantiate(DecodingData data) {
    return DeliveryStatus(
      id: data.dec(_f$id),
      status: data.dec(_f$status),
      note: data.dec(_f$note),
      dateTime: data.dec(_f$dateTime),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static DeliveryStatus fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<DeliveryStatus>(map);
  }

  static DeliveryStatus fromJson(String json) {
    return ensureInitialized().decodeJson<DeliveryStatus>(json);
  }
}

mixin DeliveryStatusMappable {
  String toJson() {
    return DeliveryStatusMapper.ensureInitialized().encodeJson<DeliveryStatus>(
      this as DeliveryStatus,
    );
  }

  Map<String, dynamic> toMap() {
    return DeliveryStatusMapper.ensureInitialized().encodeMap<DeliveryStatus>(
      this as DeliveryStatus,
    );
  }

  DeliveryStatusCopyWith<DeliveryStatus, DeliveryStatus, DeliveryStatus>
  get copyWith => _DeliveryStatusCopyWithImpl<DeliveryStatus, DeliveryStatus>(
    this as DeliveryStatus,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return DeliveryStatusMapper.ensureInitialized().stringifyValue(
      this as DeliveryStatus,
    );
  }

  @override
  bool operator ==(Object other) {
    return DeliveryStatusMapper.ensureInitialized().equalsValue(
      this as DeliveryStatus,
      other,
    );
  }

  @override
  int get hashCode {
    return DeliveryStatusMapper.ensureInitialized().hashValue(
      this as DeliveryStatus,
    );
  }
}

extension DeliveryStatusValueCopy<$R, $Out>
    on ObjectCopyWith<$R, DeliveryStatus, $Out> {
  DeliveryStatusCopyWith<$R, DeliveryStatus, $Out> get $asDeliveryStatus =>
      $base.as((v, t, t2) => _DeliveryStatusCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class DeliveryStatusCopyWith<$R, $In extends DeliveryStatus, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? status, String? note, String? dateTime});
  DeliveryStatusCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _DeliveryStatusCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, DeliveryStatus, $Out>
    implements DeliveryStatusCopyWith<$R, DeliveryStatus, $Out> {
  _DeliveryStatusCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<DeliveryStatus> $mapper =
      DeliveryStatusMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? status = $none,
    Object? note = $none,
    Object? dateTime = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (status != $none) #status: status,
      if (note != $none) #note: note,
      if (dateTime != $none) #dateTime: dateTime,
    }),
  );
  @override
  DeliveryStatus $make(CopyWithData data) => DeliveryStatus(
    id: data.get(#id, or: $value.id),
    status: data.get(#status, or: $value.status),
    note: data.get(#note, or: $value.note),
    dateTime: data.get(#dateTime, or: $value.dateTime),
  );

  @override
  DeliveryStatusCopyWith<$R2, DeliveryStatus, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _DeliveryStatusCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class StoreOrderMapper extends ClassMapperBase<StoreOrder> {
  StoreOrderMapper._();

  static StoreOrderMapper? _instance;
  static StoreOrderMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = StoreOrderMapper._());
      StoreOrderItemMapper.ensureInitialized();
      ShippingDetailMapper.ensureInitialized();
      DeliveryStatusMapper.ensureInitialized();
      MerchantInfoMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'StoreOrder';

  static String? _$id(StoreOrder v) => v.id;
  static const Field<StoreOrder, String> _f$id = Field('id', _$id, opt: true);
  static String? _$status(StoreOrder v) => v.status;
  static const Field<StoreOrder, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static List<StoreOrderItem>? _$items(StoreOrder v) => v.items;
  static const Field<StoreOrder, List<StoreOrderItem>> _f$items = Field(
    'items',
    _$items,
    opt: true,
  );
  static dynamic _$fees(StoreOrder v) => v.fees;
  static const Field<StoreOrder, dynamic> _f$fees = Field(
    'fees',
    _$fees,
    opt: true,
  );
  static ShippingDetail? _$shippingDetail(StoreOrder v) => v.shippingDetail;
  static const Field<StoreOrder, ShippingDetail> _f$shippingDetail = Field(
    'shippingDetail',
    _$shippingDetail,
    key: r'shipping_detail',
    opt: true,
  );
  static List<DeliveryStatus>? _$deliveryStatus(StoreOrder v) =>
      v.deliveryStatus;
  static const Field<StoreOrder, List<DeliveryStatus>> _f$deliveryStatus =
      Field(
        'deliveryStatus',
        _$deliveryStatus,
        key: r'delivery_status',
        opt: true,
      );
  static MerchantInfo? _$merchant(StoreOrder v) => v.merchant;
  static const Field<StoreOrder, MerchantInfo> _f$merchant = Field(
    'merchant',
    _$merchant,
    opt: true,
  );
  static String? _$paymentReference(StoreOrder v) => v.paymentReference;
  static const Field<StoreOrder, String> _f$paymentReference = Field(
    'paymentReference',
    _$paymentReference,
    key: r'payment_reference',
    opt: true,
  );
  static String? _$createdAt(StoreOrder v) => v.createdAt;
  static const Field<StoreOrder, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static String? _$updatedAt(StoreOrder v) => v.updatedAt;
  static const Field<StoreOrder, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );

  @override
  final MappableFields<StoreOrder> fields = const {
    #id: _f$id,
    #status: _f$status,
    #items: _f$items,
    #fees: _f$fees,
    #shippingDetail: _f$shippingDetail,
    #deliveryStatus: _f$deliveryStatus,
    #merchant: _f$merchant,
    #paymentReference: _f$paymentReference,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
  };

  static StoreOrder _instantiate(DecodingData data) {
    return StoreOrder(
      id: data.dec(_f$id),
      status: data.dec(_f$status),
      items: data.dec(_f$items),
      fees: data.dec(_f$fees),
      shippingDetail: data.dec(_f$shippingDetail),
      deliveryStatus: data.dec(_f$deliveryStatus),
      merchant: data.dec(_f$merchant),
      paymentReference: data.dec(_f$paymentReference),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static StoreOrder fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<StoreOrder>(map);
  }

  static StoreOrder fromJson(String json) {
    return ensureInitialized().decodeJson<StoreOrder>(json);
  }
}

mixin StoreOrderMappable {
  String toJson() {
    return StoreOrderMapper.ensureInitialized().encodeJson<StoreOrder>(
      this as StoreOrder,
    );
  }

  Map<String, dynamic> toMap() {
    return StoreOrderMapper.ensureInitialized().encodeMap<StoreOrder>(
      this as StoreOrder,
    );
  }

  StoreOrderCopyWith<StoreOrder, StoreOrder, StoreOrder> get copyWith =>
      _StoreOrderCopyWithImpl<StoreOrder, StoreOrder>(
        this as StoreOrder,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return StoreOrderMapper.ensureInitialized().stringifyValue(
      this as StoreOrder,
    );
  }

  @override
  bool operator ==(Object other) {
    return StoreOrderMapper.ensureInitialized().equalsValue(
      this as StoreOrder,
      other,
    );
  }

  @override
  int get hashCode {
    return StoreOrderMapper.ensureInitialized().hashValue(this as StoreOrder);
  }
}

extension StoreOrderValueCopy<$R, $Out>
    on ObjectCopyWith<$R, StoreOrder, $Out> {
  StoreOrderCopyWith<$R, StoreOrder, $Out> get $asStoreOrder =>
      $base.as((v, t, t2) => _StoreOrderCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class StoreOrderCopyWith<$R, $In extends StoreOrder, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    StoreOrderItem,
    StoreOrderItemCopyWith<$R, StoreOrderItem, StoreOrderItem>
  >?
  get items;
  ShippingDetailCopyWith<$R, ShippingDetail, ShippingDetail>?
  get shippingDetail;
  ListCopyWith<
    $R,
    DeliveryStatus,
    DeliveryStatusCopyWith<$R, DeliveryStatus, DeliveryStatus>
  >?
  get deliveryStatus;
  MerchantInfoCopyWith<$R, MerchantInfo, MerchantInfo>? get merchant;
  $R call({
    String? id,
    String? status,
    List<StoreOrderItem>? items,
    dynamic fees,
    ShippingDetail? shippingDetail,
    List<DeliveryStatus>? deliveryStatus,
    MerchantInfo? merchant,
    String? paymentReference,
    String? createdAt,
    String? updatedAt,
  });
  StoreOrderCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _StoreOrderCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, StoreOrder, $Out>
    implements StoreOrderCopyWith<$R, StoreOrder, $Out> {
  _StoreOrderCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<StoreOrder> $mapper =
      StoreOrderMapper.ensureInitialized();
  @override
  ListCopyWith<
    $R,
    StoreOrderItem,
    StoreOrderItemCopyWith<$R, StoreOrderItem, StoreOrderItem>
  >?
  get items => $value.items != null
      ? ListCopyWith(
          $value.items!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(items: v),
        )
      : null;
  @override
  ShippingDetailCopyWith<$R, ShippingDetail, ShippingDetail>?
  get shippingDetail =>
      $value.shippingDetail?.copyWith.$chain((v) => call(shippingDetail: v));
  @override
  ListCopyWith<
    $R,
    DeliveryStatus,
    DeliveryStatusCopyWith<$R, DeliveryStatus, DeliveryStatus>
  >?
  get deliveryStatus => $value.deliveryStatus != null
      ? ListCopyWith(
          $value.deliveryStatus!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(deliveryStatus: v),
        )
      : null;
  @override
  MerchantInfoCopyWith<$R, MerchantInfo, MerchantInfo>? get merchant =>
      $value.merchant?.copyWith.$chain((v) => call(merchant: v));
  @override
  $R call({
    Object? id = $none,
    Object? status = $none,
    Object? items = $none,
    Object? fees = $none,
    Object? shippingDetail = $none,
    Object? deliveryStatus = $none,
    Object? merchant = $none,
    Object? paymentReference = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (status != $none) #status: status,
      if (items != $none) #items: items,
      if (fees != $none) #fees: fees,
      if (shippingDetail != $none) #shippingDetail: shippingDetail,
      if (deliveryStatus != $none) #deliveryStatus: deliveryStatus,
      if (merchant != $none) #merchant: merchant,
      if (paymentReference != $none) #paymentReference: paymentReference,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
    }),
  );
  @override
  StoreOrder $make(CopyWithData data) => StoreOrder(
    id: data.get(#id, or: $value.id),
    status: data.get(#status, or: $value.status),
    items: data.get(#items, or: $value.items),
    fees: data.get(#fees, or: $value.fees),
    shippingDetail: data.get(#shippingDetail, or: $value.shippingDetail),
    deliveryStatus: data.get(#deliveryStatus, or: $value.deliveryStatus),
    merchant: data.get(#merchant, or: $value.merchant),
    paymentReference: data.get(#paymentReference, or: $value.paymentReference),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
  );

  @override
  StoreOrderCopyWith<$R2, StoreOrder, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _StoreOrderCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

