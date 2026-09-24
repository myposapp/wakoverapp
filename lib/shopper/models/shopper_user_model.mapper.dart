// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'shopper_user_model.dart';

class KycMapper extends ClassMapperBase<Kyc> {
  KycMapper._();

  static KycMapper? _instance;
  static KycMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = KycMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Kyc';

  static String? _$id(Kyc v) => v.id;
  static const Field<Kyc, String> _f$id = Field('id', _$id, opt: true);
  static num? _$completion(Kyc v) => v.completion;
  static const Field<Kyc, num> _f$completion = Field(
    'completion',
    _$completion,
    opt: true,
  );
  static String? _$status(Kyc v) => v.status;
  static const Field<Kyc, String> _f$status = Field(
    'status',
    _$status,
    opt: true,
  );
  static String? _$userId(Kyc v) => v.userId;
  static const Field<Kyc, String> _f$userId = Field(
    'userId',
    _$userId,
    key: r'user_id',
    opt: true,
  );
  static String? _$createdAt(Kyc v) => v.createdAt;
  static const Field<Kyc, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );
  static String? _$updatedAt(Kyc v) => v.updatedAt;
  static const Field<Kyc, String> _f$updatedAt = Field(
    'updatedAt',
    _$updatedAt,
    opt: true,
  );
  static List<dynamic>? _$docs(Kyc v) => v.docs;
  static const Field<Kyc, List<dynamic>> _f$docs = Field(
    'docs',
    _$docs,
    opt: true,
  );

  @override
  final MappableFields<Kyc> fields = const {
    #id: _f$id,
    #completion: _f$completion,
    #status: _f$status,
    #userId: _f$userId,
    #createdAt: _f$createdAt,
    #updatedAt: _f$updatedAt,
    #docs: _f$docs,
  };

  static Kyc _instantiate(DecodingData data) {
    return Kyc(
      id: data.dec(_f$id),
      completion: data.dec(_f$completion),
      status: data.dec(_f$status),
      userId: data.dec(_f$userId),
      createdAt: data.dec(_f$createdAt),
      updatedAt: data.dec(_f$updatedAt),
      docs: data.dec(_f$docs),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Kyc fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Kyc>(map);
  }

  static Kyc fromJson(String json) {
    return ensureInitialized().decodeJson<Kyc>(json);
  }
}

mixin KycMappable {
  String toJson() {
    return KycMapper.ensureInitialized().encodeJson<Kyc>(this as Kyc);
  }

  Map<String, dynamic> toMap() {
    return KycMapper.ensureInitialized().encodeMap<Kyc>(this as Kyc);
  }

  KycCopyWith<Kyc, Kyc, Kyc> get copyWith =>
      _KycCopyWithImpl<Kyc, Kyc>(this as Kyc, $identity, $identity);
  @override
  String toString() {
    return KycMapper.ensureInitialized().stringifyValue(this as Kyc);
  }

  @override
  bool operator ==(Object other) {
    return KycMapper.ensureInitialized().equalsValue(this as Kyc, other);
  }

  @override
  int get hashCode {
    return KycMapper.ensureInitialized().hashValue(this as Kyc);
  }
}

extension KycValueCopy<$R, $Out> on ObjectCopyWith<$R, Kyc, $Out> {
  KycCopyWith<$R, Kyc, $Out> get $asKyc =>
      $base.as((v, t, t2) => _KycCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class KycCopyWith<$R, $In extends Kyc, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get docs;
  $R call({
    String? id,
    num? completion,
    String? status,
    String? userId,
    String? createdAt,
    String? updatedAt,
    List<dynamic>? docs,
  });
  KycCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _KycCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Kyc, $Out>
    implements KycCopyWith<$R, Kyc, $Out> {
  _KycCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Kyc> $mapper = KycMapper.ensureInitialized();
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get docs =>
      $value.docs != null
      ? ListCopyWith(
          $value.docs!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(docs: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    Object? completion = $none,
    Object? status = $none,
    Object? userId = $none,
    Object? createdAt = $none,
    Object? updatedAt = $none,
    Object? docs = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (completion != $none) #completion: completion,
      if (status != $none) #status: status,
      if (userId != $none) #userId: userId,
      if (createdAt != $none) #createdAt: createdAt,
      if (updatedAt != $none) #updatedAt: updatedAt,
      if (docs != $none) #docs: docs,
    }),
  );
  @override
  Kyc $make(CopyWithData data) => Kyc(
    id: data.get(#id, or: $value.id),
    completion: data.get(#completion, or: $value.completion),
    status: data.get(#status, or: $value.status),
    userId: data.get(#userId, or: $value.userId),
    createdAt: data.get(#createdAt, or: $value.createdAt),
    updatedAt: data.get(#updatedAt, or: $value.updatedAt),
    docs: data.get(#docs, or: $value.docs),
  );

  @override
  KycCopyWith<$R2, Kyc, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _KycCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ShopperUserMapper extends ClassMapperBase<ShopperUser> {
  ShopperUserMapper._();

  static ShopperUserMapper? _instance;
  static ShopperUserMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ShopperUserMapper._());
      KycMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'ShopperUser';

  static String? _$id(ShopperUser v) => v.id;
  static const Field<ShopperUser, String> _f$id = Field('id', _$id, opt: true);
  static String? _$name(ShopperUser v) => v.name;
  static const Field<ShopperUser, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$phone(ShopperUser v) => v.phone;
  static const Field<ShopperUser, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static String? _$email(ShopperUser v) => v.email;
  static const Field<ShopperUser, String> _f$email = Field(
    'email',
    _$email,
    opt: true,
  );
  static String? _$photo(ShopperUser v) => v.photo;
  static const Field<ShopperUser, String> _f$photo = Field(
    'photo',
    _$photo,
    opt: true,
  );
  static String? _$userType(ShopperUser v) => v.userType;
  static const Field<ShopperUser, String> _f$userType = Field(
    'userType',
    _$userType,
    key: r'user_type',
    opt: true,
  );
  static dynamic _$userLevel(ShopperUser v) => v.userLevel;
  static const Field<ShopperUser, dynamic> _f$userLevel = Field(
    'userLevel',
    _$userLevel,
    key: r'user_level',
    opt: true,
  );
  static String? _$sessionId(ShopperUser v) => v.sessionId;
  static const Field<ShopperUser, String> _f$sessionId = Field(
    'sessionId',
    _$sessionId,
    key: r'session_id',
    opt: true,
  );
  static String? _$walletId(ShopperUser v) => v.walletId;
  static const Field<ShopperUser, String> _f$walletId = Field(
    'walletId',
    _$walletId,
    key: r'wallet_id',
    opt: true,
  );
  static num? _$walletBalance(ShopperUser v) => v.walletBalance;
  static const Field<ShopperUser, num> _f$walletBalance = Field(
    'walletBalance',
    _$walletBalance,
    key: r'wallet_balance',
    opt: true,
  );
  static num? _$points(ShopperUser v) => v.points;
  static const Field<ShopperUser, num> _f$points = Field(
    'points',
    _$points,
    opt: true,
  );
  static Kyc? _$kyc(ShopperUser v) => v.kyc;
  static const Field<ShopperUser, Kyc> _f$kyc = Field('kyc', _$kyc, opt: true);
  static dynamic _$config(ShopperUser v) => v.config;
  static const Field<ShopperUser, dynamic> _f$config = Field(
    'config',
    _$config,
    opt: true,
  );

  @override
  final MappableFields<ShopperUser> fields = const {
    #id: _f$id,
    #name: _f$name,
    #phone: _f$phone,
    #email: _f$email,
    #photo: _f$photo,
    #userType: _f$userType,
    #userLevel: _f$userLevel,
    #sessionId: _f$sessionId,
    #walletId: _f$walletId,
    #walletBalance: _f$walletBalance,
    #points: _f$points,
    #kyc: _f$kyc,
    #config: _f$config,
  };

  static ShopperUser _instantiate(DecodingData data) {
    return ShopperUser(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      phone: data.dec(_f$phone),
      email: data.dec(_f$email),
      photo: data.dec(_f$photo),
      userType: data.dec(_f$userType),
      userLevel: data.dec(_f$userLevel),
      sessionId: data.dec(_f$sessionId),
      walletId: data.dec(_f$walletId),
      walletBalance: data.dec(_f$walletBalance),
      points: data.dec(_f$points),
      kyc: data.dec(_f$kyc),
      config: data.dec(_f$config),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ShopperUser fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ShopperUser>(map);
  }

  static ShopperUser fromJson(String json) {
    return ensureInitialized().decodeJson<ShopperUser>(json);
  }
}

mixin ShopperUserMappable {
  String toJson() {
    return ShopperUserMapper.ensureInitialized().encodeJson<ShopperUser>(
      this as ShopperUser,
    );
  }

  Map<String, dynamic> toMap() {
    return ShopperUserMapper.ensureInitialized().encodeMap<ShopperUser>(
      this as ShopperUser,
    );
  }

  ShopperUserCopyWith<ShopperUser, ShopperUser, ShopperUser> get copyWith =>
      _ShopperUserCopyWithImpl<ShopperUser, ShopperUser>(
        this as ShopperUser,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ShopperUserMapper.ensureInitialized().stringifyValue(
      this as ShopperUser,
    );
  }

  @override
  bool operator ==(Object other) {
    return ShopperUserMapper.ensureInitialized().equalsValue(
      this as ShopperUser,
      other,
    );
  }

  @override
  int get hashCode {
    return ShopperUserMapper.ensureInitialized().hashValue(this as ShopperUser);
  }
}

extension ShopperUserValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ShopperUser, $Out> {
  ShopperUserCopyWith<$R, ShopperUser, $Out> get $asShopperUser =>
      $base.as((v, t, t2) => _ShopperUserCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ShopperUserCopyWith<$R, $In extends ShopperUser, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  KycCopyWith<$R, Kyc, Kyc>? get kyc;
  $R call({
    String? id,
    String? name,
    String? phone,
    String? email,
    String? photo,
    String? userType,
    dynamic userLevel,
    String? sessionId,
    String? walletId,
    num? walletBalance,
    num? points,
    Kyc? kyc,
    dynamic config,
  });
  ShopperUserCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ShopperUserCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ShopperUser, $Out>
    implements ShopperUserCopyWith<$R, ShopperUser, $Out> {
  _ShopperUserCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ShopperUser> $mapper =
      ShopperUserMapper.ensureInitialized();
  @override
  KycCopyWith<$R, Kyc, Kyc>? get kyc =>
      $value.kyc?.copyWith.$chain((v) => call(kyc: v));
  @override
  $R call({
    Object? id = $none,
    Object? name = $none,
    Object? phone = $none,
    Object? email = $none,
    Object? photo = $none,
    Object? userType = $none,
    Object? userLevel = $none,
    Object? sessionId = $none,
    Object? walletId = $none,
    Object? walletBalance = $none,
    Object? points = $none,
    Object? kyc = $none,
    Object? config = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != $none) #name: name,
      if (phone != $none) #phone: phone,
      if (email != $none) #email: email,
      if (photo != $none) #photo: photo,
      if (userType != $none) #userType: userType,
      if (userLevel != $none) #userLevel: userLevel,
      if (sessionId != $none) #sessionId: sessionId,
      if (walletId != $none) #walletId: walletId,
      if (walletBalance != $none) #walletBalance: walletBalance,
      if (points != $none) #points: points,
      if (kyc != $none) #kyc: kyc,
      if (config != $none) #config: config,
    }),
  );
  @override
  ShopperUser $make(CopyWithData data) => ShopperUser(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    phone: data.get(#phone, or: $value.phone),
    email: data.get(#email, or: $value.email),
    photo: data.get(#photo, or: $value.photo),
    userType: data.get(#userType, or: $value.userType),
    userLevel: data.get(#userLevel, or: $value.userLevel),
    sessionId: data.get(#sessionId, or: $value.sessionId),
    walletId: data.get(#walletId, or: $value.walletId),
    walletBalance: data.get(#walletBalance, or: $value.walletBalance),
    points: data.get(#points, or: $value.points),
    kyc: data.get(#kyc, or: $value.kyc),
    config: data.get(#config, or: $value.config),
  );

  @override
  ShopperUserCopyWith<$R2, ShopperUser, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ShopperUserCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

