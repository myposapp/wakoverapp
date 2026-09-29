// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'booking_model.dart';

class BookingPlaceMapper extends ClassMapperBase<BookingPlace> {
  BookingPlaceMapper._();

  static BookingPlaceMapper? _instance;
  static BookingPlaceMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookingPlaceMapper._());
      ProductImageMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'BookingPlace';

  static String? _$id(BookingPlace v) => v.id;
  static const Field<BookingPlace, String> _f$id = Field('id', _$id, opt: true);
  static String? _$name(BookingPlace v) => v.name;
  static const Field<BookingPlace, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static List<ProductImage>? _$images(BookingPlace v) => v.images;
  static const Field<BookingPlace, List<ProductImage>> _f$images = Field(
    'images',
    _$images,
    opt: true,
  );

  @override
  final MappableFields<BookingPlace> fields = const {
    #id: _f$id,
    #name: _f$name,
    #images: _f$images,
  };

  static BookingPlace _instantiate(DecodingData data) {
    return BookingPlace(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      images: data.dec(_f$images),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BookingPlace fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BookingPlace>(map);
  }

  static BookingPlace fromJson(String json) {
    return ensureInitialized().decodeJson<BookingPlace>(json);
  }
}

mixin BookingPlaceMappable {
  String toJson() {
    return BookingPlaceMapper.ensureInitialized().encodeJson<BookingPlace>(
      this as BookingPlace,
    );
  }

  Map<String, dynamic> toMap() {
    return BookingPlaceMapper.ensureInitialized().encodeMap<BookingPlace>(
      this as BookingPlace,
    );
  }

  BookingPlaceCopyWith<BookingPlace, BookingPlace, BookingPlace> get copyWith =>
      _BookingPlaceCopyWithImpl<BookingPlace, BookingPlace>(
        this as BookingPlace,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BookingPlaceMapper.ensureInitialized().stringifyValue(
      this as BookingPlace,
    );
  }

  @override
  bool operator ==(Object other) {
    return BookingPlaceMapper.ensureInitialized().equalsValue(
      this as BookingPlace,
      other,
    );
  }

  @override
  int get hashCode {
    return BookingPlaceMapper.ensureInitialized().hashValue(
      this as BookingPlace,
    );
  }
}

extension BookingPlaceValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BookingPlace, $Out> {
  BookingPlaceCopyWith<$R, BookingPlace, $Out> get $asBookingPlace =>
      $base.as((v, t, t2) => _BookingPlaceCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BookingPlaceCopyWith<$R, $In extends BookingPlace, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<
    $R,
    ProductImage,
    ProductImageCopyWith<$R, ProductImage, ProductImage>
  >?
  get images;
  $R call({String? id, String? name, List<ProductImage>? images});
  BookingPlaceCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BookingPlaceCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BookingPlace, $Out>
    implements BookingPlaceCopyWith<$R, BookingPlace, $Out> {
  _BookingPlaceCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BookingPlace> $mapper =
      BookingPlaceMapper.ensureInitialized();
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
  $R call({Object? id = $none, Object? name = $none, Object? images = $none}) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (name != $none) #name: name,
          if (images != $none) #images: images,
        }),
      );
  @override
  BookingPlace $make(CopyWithData data) => BookingPlace(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    images: data.get(#images, or: $value.images),
  );

  @override
  BookingPlaceCopyWith<$R2, BookingPlace, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BookingPlaceCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BookingVisitorMapper extends ClassMapperBase<BookingVisitor> {
  BookingVisitorMapper._();

  static BookingVisitorMapper? _instance;
  static BookingVisitorMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookingVisitorMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BookingVisitor';

  static String? _$id(BookingVisitor v) => v.id;
  static const Field<BookingVisitor, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$name(BookingVisitor v) => v.name;
  static const Field<BookingVisitor, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$email(BookingVisitor v) => v.email;
  static const Field<BookingVisitor, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
  );
  static String? _$phone(BookingVisitor v) => v.phone;
  static const Field<BookingVisitor, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static String? _$dateTime(BookingVisitor v) => v.dateTime;
  static const Field<BookingVisitor, String> _f$dateTime = Field(
    'dateTime',
    _$dateTime,
    key: r'date_time',
    opt: true,
  );
  static String? _$code(BookingVisitor v) => v.code;
  static const Field<BookingVisitor, String> _f$code = Field(
    'code',
    _$code,
    opt: true,
  );
  static String? _$description(BookingVisitor v) => v.description;
  static const Field<BookingVisitor, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );

  @override
  final MappableFields<BookingVisitor> fields = const {
    #id: _f$id,
    #name: _f$name,
    #email: _f$email,
    #phone: _f$phone,
    #dateTime: _f$dateTime,
    #code: _f$code,
    #description: _f$description,
  };

  static BookingVisitor _instantiate(DecodingData data) {
    return BookingVisitor(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      email: data.dec(_f$email),
      phone: data.dec(_f$phone),
      dateTime: data.dec(_f$dateTime),
      code: data.dec(_f$code),
      description: data.dec(_f$description),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BookingVisitor fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BookingVisitor>(map);
  }

  static BookingVisitor fromJson(String json) {
    return ensureInitialized().decodeJson<BookingVisitor>(json);
  }
}

mixin BookingVisitorMappable {
  String toJson() {
    return BookingVisitorMapper.ensureInitialized().encodeJson<BookingVisitor>(
      this as BookingVisitor,
    );
  }

  Map<String, dynamic> toMap() {
    return BookingVisitorMapper.ensureInitialized().encodeMap<BookingVisitor>(
      this as BookingVisitor,
    );
  }

  BookingVisitorCopyWith<BookingVisitor, BookingVisitor, BookingVisitor>
  get copyWith => _BookingVisitorCopyWithImpl<BookingVisitor, BookingVisitor>(
    this as BookingVisitor,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return BookingVisitorMapper.ensureInitialized().stringifyValue(
      this as BookingVisitor,
    );
  }

  @override
  bool operator ==(Object other) {
    return BookingVisitorMapper.ensureInitialized().equalsValue(
      this as BookingVisitor,
      other,
    );
  }

  @override
  int get hashCode {
    return BookingVisitorMapper.ensureInitialized().hashValue(
      this as BookingVisitor,
    );
  }
}

extension BookingVisitorValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BookingVisitor, $Out> {
  BookingVisitorCopyWith<$R, BookingVisitor, $Out> get $asBookingVisitor =>
      $base.as((v, t, t2) => _BookingVisitorCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BookingVisitorCopyWith<$R, $In extends BookingVisitor, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? dateTime,
    String? code,
    String? description,
  });
  BookingVisitorCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BookingVisitorCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BookingVisitor, $Out>
    implements BookingVisitorCopyWith<$R, BookingVisitor, $Out> {
  _BookingVisitorCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BookingVisitor> $mapper =
      BookingVisitorMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? name = $none,
    Object? email = $none,
    Object? phone = $none,
    Object? dateTime = $none,
    Object? code = $none,
    Object? description = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != $none) #name: name,
      if (email != $none) #email: email,
      if (phone != $none) #phone: phone,
      if (dateTime != $none) #dateTime: dateTime,
      if (code != $none) #code: code,
      if (description != $none) #description: description,
    }),
  );
  @override
  BookingVisitor $make(CopyWithData data) => BookingVisitor(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    email: data.get(#email, or: $value.email),
    phone: data.get(#phone, or: $value.phone),
    dateTime: data.get(#dateTime, or: $value.dateTime),
    code: data.get(#code, or: $value.code),
    description: data.get(#description, or: $value.description),
  );

  @override
  BookingVisitorCopyWith<$R2, BookingVisitor, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _BookingVisitorCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class BookingMapper extends ClassMapperBase<Booking> {
  BookingMapper._();

  static BookingMapper? _instance;
  static BookingMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BookingMapper._());
      MerchantInfoMapper.ensureInitialized();
      BookingPlaceMapper.ensureInitialized();
      BookingVisitorMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'Booking';

  static String? _$id(Booking v) => v.id;
  static const Field<Booking, String> _f$id = Field('id', _$id, opt: true);
  static String? _$status(Booking v) => v.status;
  static const Field<Booking, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static String? _$bookingCode(Booking v) => v.bookingCode;
  static const Field<Booking, String> _f$bookingCode = Field(
    'bookingCode',
    _$bookingCode,
    key: r'booking_code',
    opt: true,
  );
  static String? _$dateTime(Booking v) => v.dateTime;
  static const Field<Booking, String> _f$dateTime = Field(
    'dateTime',
    _$dateTime,
    key: r'date_time',
    opt: true,
  );
  static String? _$startDate(Booking v) => v.startDate;
  static const Field<Booking, String> _f$startDate = Field(
    'startDate',
    _$startDate,
    key: r'start_date',
    opt: true,
  );
  static String? _$endDate(Booking v) => v.endDate;
  static const Field<Booking, String> _f$endDate = Field(
    'endDate',
    _$endDate,
    key: r'end_date',
    opt: true,
  );
  static MerchantInfo? _$merchant(Booking v) => v.merchant;
  static const Field<Booking, MerchantInfo> _f$merchant = Field(
    'merchant',
    _$merchant,
    opt: true,
  );
  static List<BookingPlace>? _$merchantPlaces(Booking v) => v.merchantPlaces;
  static const Field<Booking, List<BookingPlace>> _f$merchantPlaces = Field(
    'merchantPlaces',
    _$merchantPlaces,
    key: r'merchant_places',
    opt: true,
  );
  static List<BookingPlace>? _$cart(Booking v) => v.cart;
  static const Field<Booking, List<BookingPlace>> _f$cart = Field(
    'cart',
    _$cart,
    opt: true,
  );
  static List<BookingVisitor>? _$visitors(Booking v) => v.visitors;
  static const Field<Booking, List<BookingVisitor>> _f$visitors = Field(
    'visitors',
    _$visitors,
    opt: true,
  );
  static String? _$paymentReference(Booking v) => v.paymentReference;
  static const Field<Booking, String> _f$paymentReference = Field(
    'paymentReference',
    _$paymentReference,
    key: r'payment_reference',
    opt: true,
  );
  static String? _$createdAt(Booking v) => v.createdAt;
  static const Field<Booking, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );

  @override
  final MappableFields<Booking> fields = const {
    #id: _f$id,
    #status: _f$status,
    #bookingCode: _f$bookingCode,
    #dateTime: _f$dateTime,
    #startDate: _f$startDate,
    #endDate: _f$endDate,
    #merchant: _f$merchant,
    #merchantPlaces: _f$merchantPlaces,
    #cart: _f$cart,
    #visitors: _f$visitors,
    #paymentReference: _f$paymentReference,
    #createdAt: _f$createdAt,
  };

  static Booking _instantiate(DecodingData data) {
    return Booking(
      id: data.dec(_f$id),
      status: data.dec(_f$status),
      bookingCode: data.dec(_f$bookingCode),
      dateTime: data.dec(_f$dateTime),
      startDate: data.dec(_f$startDate),
      endDate: data.dec(_f$endDate),
      merchant: data.dec(_f$merchant),
      merchantPlaces: data.dec(_f$merchantPlaces),
      cart: data.dec(_f$cart),
      visitors: data.dec(_f$visitors),
      paymentReference: data.dec(_f$paymentReference),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Booking fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Booking>(map);
  }

  static Booking fromJson(String json) {
    return ensureInitialized().decodeJson<Booking>(json);
  }
}

mixin BookingMappable {
  String toJson() {
    return BookingMapper.ensureInitialized().encodeJson<Booking>(
      this as Booking,
    );
  }

  Map<String, dynamic> toMap() {
    return BookingMapper.ensureInitialized().encodeMap<Booking>(
      this as Booking,
    );
  }

  BookingCopyWith<Booking, Booking, Booking> get copyWith =>
      _BookingCopyWithImpl<Booking, Booking>(
        this as Booking,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return BookingMapper.ensureInitialized().stringifyValue(this as Booking);
  }

  @override
  bool operator ==(Object other) {
    return BookingMapper.ensureInitialized().equalsValue(
      this as Booking,
      other,
    );
  }

  @override
  int get hashCode {
    return BookingMapper.ensureInitialized().hashValue(this as Booking);
  }
}

extension BookingValueCopy<$R, $Out> on ObjectCopyWith<$R, Booking, $Out> {
  BookingCopyWith<$R, Booking, $Out> get $asBooking =>
      $base.as((v, t, t2) => _BookingCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class BookingCopyWith<$R, $In extends Booking, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MerchantInfoCopyWith<$R, MerchantInfo, MerchantInfo>? get merchant;
  ListCopyWith<
    $R,
    BookingPlace,
    BookingPlaceCopyWith<$R, BookingPlace, BookingPlace>
  >?
  get merchantPlaces;
  ListCopyWith<
    $R,
    BookingPlace,
    BookingPlaceCopyWith<$R, BookingPlace, BookingPlace>
  >?
  get cart;
  ListCopyWith<
    $R,
    BookingVisitor,
    BookingVisitorCopyWith<$R, BookingVisitor, BookingVisitor>
  >?
  get visitors;
  $R call({
    String? id,
    String? status,
    String? bookingCode,
    String? dateTime,
    String? startDate,
    String? endDate,
    MerchantInfo? merchant,
    List<BookingPlace>? merchantPlaces,
    List<BookingPlace>? cart,
    List<BookingVisitor>? visitors,
    String? paymentReference,
    String? createdAt,
  });
  BookingCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _BookingCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Booking, $Out>
    implements BookingCopyWith<$R, Booking, $Out> {
  _BookingCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Booking> $mapper =
      BookingMapper.ensureInitialized();
  @override
  MerchantInfoCopyWith<$R, MerchantInfo, MerchantInfo>? get merchant =>
      $value.merchant?.copyWith.$chain((v) => call(merchant: v));
  @override
  ListCopyWith<
    $R,
    BookingPlace,
    BookingPlaceCopyWith<$R, BookingPlace, BookingPlace>
  >?
  get merchantPlaces => $value.merchantPlaces != null
      ? ListCopyWith(
          $value.merchantPlaces!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(merchantPlaces: v),
        )
      : null;
  @override
  ListCopyWith<
    $R,
    BookingPlace,
    BookingPlaceCopyWith<$R, BookingPlace, BookingPlace>
  >?
  get cart => $value.cart != null
      ? ListCopyWith(
          $value.cart!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(cart: v),
        )
      : null;
  @override
  ListCopyWith<
    $R,
    BookingVisitor,
    BookingVisitorCopyWith<$R, BookingVisitor, BookingVisitor>
  >?
  get visitors => $value.visitors != null
      ? ListCopyWith(
          $value.visitors!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(visitors: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    Object? status = $none,
    Object? bookingCode = $none,
    Object? dateTime = $none,
    Object? startDate = $none,
    Object? endDate = $none,
    Object? merchant = $none,
    Object? merchantPlaces = $none,
    Object? cart = $none,
    Object? visitors = $none,
    Object? paymentReference = $none,
    Object? createdAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (status != $none) #status: status,
      if (bookingCode != $none) #bookingCode: bookingCode,
      if (dateTime != $none) #dateTime: dateTime,
      if (startDate != $none) #startDate: startDate,
      if (endDate != $none) #endDate: endDate,
      if (merchant != $none) #merchant: merchant,
      if (merchantPlaces != $none) #merchantPlaces: merchantPlaces,
      if (cart != $none) #cart: cart,
      if (visitors != $none) #visitors: visitors,
      if (paymentReference != $none) #paymentReference: paymentReference,
      if (createdAt != $none) #createdAt: createdAt,
    }),
  );
  @override
  Booking $make(CopyWithData data) => Booking(
    id: data.get(#id, or: $value.id),
    status: data.get(#status, or: $value.status),
    bookingCode: data.get(#bookingCode, or: $value.bookingCode),
    dateTime: data.get(#dateTime, or: $value.dateTime),
    startDate: data.get(#startDate, or: $value.startDate),
    endDate: data.get(#endDate, or: $value.endDate),
    merchant: data.get(#merchant, or: $value.merchant),
    merchantPlaces: data.get(#merchantPlaces, or: $value.merchantPlaces),
    cart: data.get(#cart, or: $value.cart),
    visitors: data.get(#visitors, or: $value.visitors),
    paymentReference: data.get(#paymentReference, or: $value.paymentReference),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  BookingCopyWith<$R2, Booking, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BookingCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

