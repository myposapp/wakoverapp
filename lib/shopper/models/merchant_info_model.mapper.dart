// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'merchant_info_model.dart';

class MerchantBranchMapper extends ClassMapperBase<MerchantBranch> {
  MerchantBranchMapper._();

  static MerchantBranchMapper? _instance;
  static MerchantBranchMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MerchantBranchMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'MerchantBranch';

  static String? _$id(MerchantBranch v) => v.id;
  static const Field<MerchantBranch, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static String? _$name(MerchantBranch v) => v.name;
  static const Field<MerchantBranch, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$phone(MerchantBranch v) => v.phone;
  static const Field<MerchantBranch, String> _f$phone = Field(
    'phone',
    _$phone,
    opt: true,
  );
  static String? _$checkin(MerchantBranch v) => v.checkin;
  static const Field<MerchantBranch, String> _f$checkin = Field(
    'checkin',
    _$checkin,
    opt: true,
  );
  static String? _$checkout(MerchantBranch v) => v.checkout;
  static const Field<MerchantBranch, String> _f$checkout = Field(
    'checkout',
    _$checkout,
    opt: true,
  );

  @override
  final MappableFields<MerchantBranch> fields = const {
    #id: _f$id,
    #name: _f$name,
    #phone: _f$phone,
    #checkin: _f$checkin,
    #checkout: _f$checkout,
  };

  static MerchantBranch _instantiate(DecodingData data) {
    return MerchantBranch(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      phone: data.dec(_f$phone),
      checkin: data.dec(_f$checkin),
      checkout: data.dec(_f$checkout),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MerchantBranch fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MerchantBranch>(map);
  }

  static MerchantBranch fromJson(String json) {
    return ensureInitialized().decodeJson<MerchantBranch>(json);
  }
}

mixin MerchantBranchMappable {
  String toJson() {
    return MerchantBranchMapper.ensureInitialized().encodeJson<MerchantBranch>(
      this as MerchantBranch,
    );
  }

  Map<String, dynamic> toMap() {
    return MerchantBranchMapper.ensureInitialized().encodeMap<MerchantBranch>(
      this as MerchantBranch,
    );
  }

  MerchantBranchCopyWith<MerchantBranch, MerchantBranch, MerchantBranch>
  get copyWith => _MerchantBranchCopyWithImpl<MerchantBranch, MerchantBranch>(
    this as MerchantBranch,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return MerchantBranchMapper.ensureInitialized().stringifyValue(
      this as MerchantBranch,
    );
  }

  @override
  bool operator ==(Object other) {
    return MerchantBranchMapper.ensureInitialized().equalsValue(
      this as MerchantBranch,
      other,
    );
  }

  @override
  int get hashCode {
    return MerchantBranchMapper.ensureInitialized().hashValue(
      this as MerchantBranch,
    );
  }
}

extension MerchantBranchValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MerchantBranch, $Out> {
  MerchantBranchCopyWith<$R, MerchantBranch, $Out> get $asMerchantBranch =>
      $base.as((v, t, t2) => _MerchantBranchCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MerchantBranchCopyWith<$R, $In extends MerchantBranch, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    String? name,
    String? phone,
    String? checkin,
    String? checkout,
  });
  MerchantBranchCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _MerchantBranchCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MerchantBranch, $Out>
    implements MerchantBranchCopyWith<$R, MerchantBranch, $Out> {
  _MerchantBranchCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MerchantBranch> $mapper =
      MerchantBranchMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? name = $none,
    Object? phone = $none,
    Object? checkin = $none,
    Object? checkout = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != $none) #name: name,
      if (phone != $none) #phone: phone,
      if (checkin != $none) #checkin: checkin,
      if (checkout != $none) #checkout: checkout,
    }),
  );
  @override
  MerchantBranch $make(CopyWithData data) => MerchantBranch(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    phone: data.get(#phone, or: $value.phone),
    checkin: data.get(#checkin, or: $value.checkin),
    checkout: data.get(#checkout, or: $value.checkout),
  );

  @override
  MerchantBranchCopyWith<$R2, MerchantBranch, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MerchantBranchCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class MerchantInfoMapper extends ClassMapperBase<MerchantInfo> {
  MerchantInfoMapper._();

  static MerchantInfoMapper? _instance;
  static MerchantInfoMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = MerchantInfoMapper._());
      MerchantBranchMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'MerchantInfo';

  static String? _$id(MerchantInfo v) => v.id;
  static const Field<MerchantInfo, String> _f$id = Field('id', _$id, opt: true);
  static String? _$name(MerchantInfo v) => v.name;
  static const Field<MerchantInfo, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static MerchantBranch? _$branch(MerchantInfo v) => v.branch;
  static const Field<MerchantInfo, MerchantBranch> _f$branch = Field(
    'branch',
    _$branch,
    opt: true,
  );

  @override
  final MappableFields<MerchantInfo> fields = const {
    #id: _f$id,
    #name: _f$name,
    #branch: _f$branch,
  };

  static MerchantInfo _instantiate(DecodingData data) {
    return MerchantInfo(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      branch: data.dec(_f$branch),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static MerchantInfo fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<MerchantInfo>(map);
  }

  static MerchantInfo fromJson(String json) {
    return ensureInitialized().decodeJson<MerchantInfo>(json);
  }
}

mixin MerchantInfoMappable {
  String toJson() {
    return MerchantInfoMapper.ensureInitialized().encodeJson<MerchantInfo>(
      this as MerchantInfo,
    );
  }

  Map<String, dynamic> toMap() {
    return MerchantInfoMapper.ensureInitialized().encodeMap<MerchantInfo>(
      this as MerchantInfo,
    );
  }

  MerchantInfoCopyWith<MerchantInfo, MerchantInfo, MerchantInfo> get copyWith =>
      _MerchantInfoCopyWithImpl<MerchantInfo, MerchantInfo>(
        this as MerchantInfo,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return MerchantInfoMapper.ensureInitialized().stringifyValue(
      this as MerchantInfo,
    );
  }

  @override
  bool operator ==(Object other) {
    return MerchantInfoMapper.ensureInitialized().equalsValue(
      this as MerchantInfo,
      other,
    );
  }

  @override
  int get hashCode {
    return MerchantInfoMapper.ensureInitialized().hashValue(
      this as MerchantInfo,
    );
  }
}

extension MerchantInfoValueCopy<$R, $Out>
    on ObjectCopyWith<$R, MerchantInfo, $Out> {
  MerchantInfoCopyWith<$R, MerchantInfo, $Out> get $asMerchantInfo =>
      $base.as((v, t, t2) => _MerchantInfoCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class MerchantInfoCopyWith<$R, $In extends MerchantInfo, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  MerchantBranchCopyWith<$R, MerchantBranch, MerchantBranch>? get branch;
  $R call({String? id, String? name, MerchantBranch? branch});
  MerchantInfoCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _MerchantInfoCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, MerchantInfo, $Out>
    implements MerchantInfoCopyWith<$R, MerchantInfo, $Out> {
  _MerchantInfoCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<MerchantInfo> $mapper =
      MerchantInfoMapper.ensureInitialized();
  @override
  MerchantBranchCopyWith<$R, MerchantBranch, MerchantBranch>? get branch =>
      $value.branch?.copyWith.$chain((v) => call(branch: v));
  @override
  $R call({Object? id = $none, Object? name = $none, Object? branch = $none}) =>
      $apply(
        FieldCopyWithData({
          if (id != $none) #id: id,
          if (name != $none) #name: name,
          if (branch != $none) #branch: branch,
        }),
      );
  @override
  MerchantInfo $make(CopyWithData data) => MerchantInfo(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    branch: data.get(#branch, or: $value.branch),
  );

  @override
  MerchantInfoCopyWith<$R2, MerchantInfo, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _MerchantInfoCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

