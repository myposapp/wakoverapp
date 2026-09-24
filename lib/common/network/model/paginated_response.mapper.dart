// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'paginated_response.dart';

class PaginationMetaMapper extends ClassMapperBase<PaginationMeta> {
  PaginationMetaMapper._();

  static PaginationMetaMapper? _instance;
  static PaginationMetaMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PaginationMetaMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PaginationMeta';

  static int? _$totalRecords(PaginationMeta v) => v.totalRecords;
  static const Field<PaginationMeta, int> _f$totalRecords = Field(
    'totalRecords',
    _$totalRecords,
    opt: true,
  );
  static int? _$totalPages(PaginationMeta v) => v.totalPages;
  static const Field<PaginationMeta, int> _f$totalPages = Field(
    'totalPages',
    _$totalPages,
    opt: true,
  );
  static int? _$currentPage(PaginationMeta v) => v.currentPage;
  static const Field<PaginationMeta, int> _f$currentPage = Field(
    'currentPage',
    _$currentPage,
    opt: true,
  );
  static int? _$pageSize(PaginationMeta v) => v.pageSize;
  static const Field<PaginationMeta, int> _f$pageSize = Field(
    'pageSize',
    _$pageSize,
    opt: true,
  );

  @override
  final MappableFields<PaginationMeta> fields = const {
    #totalRecords: _f$totalRecords,
    #totalPages: _f$totalPages,
    #currentPage: _f$currentPage,
    #pageSize: _f$pageSize,
  };

  static PaginationMeta _instantiate(DecodingData data) {
    return PaginationMeta(
      totalRecords: data.dec(_f$totalRecords),
      totalPages: data.dec(_f$totalPages),
      currentPage: data.dec(_f$currentPage),
      pageSize: data.dec(_f$pageSize),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PaginationMeta fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PaginationMeta>(map);
  }

  static PaginationMeta fromJson(String json) {
    return ensureInitialized().decodeJson<PaginationMeta>(json);
  }
}

mixin PaginationMetaMappable {
  String toJson() {
    return PaginationMetaMapper.ensureInitialized().encodeJson<PaginationMeta>(
      this as PaginationMeta,
    );
  }

  Map<String, dynamic> toMap() {
    return PaginationMetaMapper.ensureInitialized().encodeMap<PaginationMeta>(
      this as PaginationMeta,
    );
  }

  PaginationMetaCopyWith<PaginationMeta, PaginationMeta, PaginationMeta>
  get copyWith => _PaginationMetaCopyWithImpl<PaginationMeta, PaginationMeta>(
    this as PaginationMeta,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PaginationMetaMapper.ensureInitialized().stringifyValue(
      this as PaginationMeta,
    );
  }

  @override
  bool operator ==(Object other) {
    return PaginationMetaMapper.ensureInitialized().equalsValue(
      this as PaginationMeta,
      other,
    );
  }

  @override
  int get hashCode {
    return PaginationMetaMapper.ensureInitialized().hashValue(
      this as PaginationMeta,
    );
  }
}

extension PaginationMetaValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PaginationMeta, $Out> {
  PaginationMetaCopyWith<$R, PaginationMeta, $Out> get $asPaginationMeta =>
      $base.as((v, t, t2) => _PaginationMetaCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PaginationMetaCopyWith<$R, $In extends PaginationMeta, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    int? totalRecords,
    int? totalPages,
    int? currentPage,
    int? pageSize,
  });
  PaginationMetaCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PaginationMetaCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PaginationMeta, $Out>
    implements PaginationMetaCopyWith<$R, PaginationMeta, $Out> {
  _PaginationMetaCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PaginationMeta> $mapper =
      PaginationMetaMapper.ensureInitialized();
  @override
  $R call({
    Object? totalRecords = $none,
    Object? totalPages = $none,
    Object? currentPage = $none,
    Object? pageSize = $none,
  }) => $apply(
    FieldCopyWithData({
      if (totalRecords != $none) #totalRecords: totalRecords,
      if (totalPages != $none) #totalPages: totalPages,
      if (currentPage != $none) #currentPage: currentPage,
      if (pageSize != $none) #pageSize: pageSize,
    }),
  );
  @override
  PaginationMeta $make(CopyWithData data) => PaginationMeta(
    totalRecords: data.get(#totalRecords, or: $value.totalRecords),
    totalPages: data.get(#totalPages, or: $value.totalPages),
    currentPage: data.get(#currentPage, or: $value.currentPage),
    pageSize: data.get(#pageSize, or: $value.pageSize),
  );

  @override
  PaginationMetaCopyWith<$R2, PaginationMeta, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PaginationMetaCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PaginatedResponseMapper extends ClassMapperBase<PaginatedResponse> {
  PaginatedResponseMapper._();

  static PaginatedResponseMapper? _instance;
  static PaginatedResponseMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PaginatedResponseMapper._());
      PaginationMetaMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'PaginatedResponse';
  @override
  Function get typeFactory =>
      <T>(f) => f<PaginatedResponse<T>>();

  static bool? _$success(PaginatedResponse v) => v.success;
  static const Field<PaginatedResponse, bool> _f$success = Field(
    'success',
    _$success,
    key: r'status',
    opt: true,
  );
  static String? _$message(PaginatedResponse v) => v.message;
  static const Field<PaginatedResponse, String> _f$message = Field(
    'message',
    _$message,
    opt: true,
  );
  static PaginationMeta? _$metaData(PaginatedResponse v) => v.metaData;
  static const Field<PaginatedResponse, PaginationMeta> _f$metaData = Field(
    'metaData',
    _$metaData,
    opt: true,
  );
  static List<dynamic>? _$data(PaginatedResponse v) => v.data;
  static dynamic _arg$data<T>(f) => f<List<T>>();
  static const Field<PaginatedResponse, List<dynamic>> _f$data = Field(
    'data',
    _$data,
    opt: true,
    arg: _arg$data,
  );
  static dynamic _$errors(PaginatedResponse v) => v.errors;
  static const Field<PaginatedResponse, dynamic> _f$errors = Field(
    'errors',
    _$errors,
    opt: true,
  );

  @override
  final MappableFields<PaginatedResponse> fields = const {
    #success: _f$success,
    #message: _f$message,
    #metaData: _f$metaData,
    #data: _f$data,
    #errors: _f$errors,
  };

  static PaginatedResponse<T> _instantiate<T>(DecodingData data) {
    return PaginatedResponse(
      success: data.dec(_f$success),
      message: data.dec(_f$message),
      metaData: data.dec(_f$metaData),
      data: data.dec(_f$data),
      errors: data.dec(_f$errors),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PaginatedResponse<T> fromMap<T>(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PaginatedResponse<T>>(map);
  }

  static PaginatedResponse<T> fromJson<T>(String json) {
    return ensureInitialized().decodeJson<PaginatedResponse<T>>(json);
  }
}

mixin PaginatedResponseMappable<T> {
  String toJson() {
    return PaginatedResponseMapper.ensureInitialized()
        .encodeJson<PaginatedResponse<T>>(this as PaginatedResponse<T>);
  }

  Map<String, dynamic> toMap() {
    return PaginatedResponseMapper.ensureInitialized()
        .encodeMap<PaginatedResponse<T>>(this as PaginatedResponse<T>);
  }

  PaginatedResponseCopyWith<
    PaginatedResponse<T>,
    PaginatedResponse<T>,
    PaginatedResponse<T>,
    T
  >
  get copyWith =>
      _PaginatedResponseCopyWithImpl<
        PaginatedResponse<T>,
        PaginatedResponse<T>,
        T
      >(this as PaginatedResponse<T>, $identity, $identity);
  @override
  String toString() {
    return PaginatedResponseMapper.ensureInitialized().stringifyValue(
      this as PaginatedResponse<T>,
    );
  }

  @override
  bool operator ==(Object other) {
    return PaginatedResponseMapper.ensureInitialized().equalsValue(
      this as PaginatedResponse<T>,
      other,
    );
  }

  @override
  int get hashCode {
    return PaginatedResponseMapper.ensureInitialized().hashValue(
      this as PaginatedResponse<T>,
    );
  }
}

extension PaginatedResponseValueCopy<$R, $Out, T>
    on ObjectCopyWith<$R, PaginatedResponse<T>, $Out> {
  PaginatedResponseCopyWith<$R, PaginatedResponse<T>, $Out, T>
  get $asPaginatedResponse => $base.as(
    (v, t, t2) => _PaginatedResponseCopyWithImpl<$R, $Out, T>(v, t, t2),
  );
}

abstract class PaginatedResponseCopyWith<
  $R,
  $In extends PaginatedResponse<T>,
  $Out,
  T
>
    implements ClassCopyWith<$R, $In, $Out> {
  PaginationMetaCopyWith<$R, PaginationMeta, PaginationMeta>? get metaData;
  ListCopyWith<$R, T, ObjectCopyWith<$R, T, T>?>? get data;
  $R call({
    bool? success,
    String? message,
    PaginationMeta? metaData,
    List<T>? data,
    dynamic errors,
  });
  PaginatedResponseCopyWith<$R2, $In, $Out2, T> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _PaginatedResponseCopyWithImpl<$R, $Out, T>
    extends ClassCopyWithBase<$R, PaginatedResponse<T>, $Out>
    implements PaginatedResponseCopyWith<$R, PaginatedResponse<T>, $Out, T> {
  _PaginatedResponseCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PaginatedResponse> $mapper =
      PaginatedResponseMapper.ensureInitialized();
  @override
  PaginationMetaCopyWith<$R, PaginationMeta, PaginationMeta>? get metaData =>
      $value.metaData?.copyWith.$chain((v) => call(metaData: v));
  @override
  ListCopyWith<$R, T, ObjectCopyWith<$R, T, T>?>? get data =>
      $value.data != null
      ? ListCopyWith(
          $value.data!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(data: v),
        )
      : null;
  @override
  $R call({
    Object? success = $none,
    Object? message = $none,
    Object? metaData = $none,
    Object? data = $none,
    Object? errors = $none,
  }) => $apply(
    FieldCopyWithData({
      if (success != $none) #success: success,
      if (message != $none) #message: message,
      if (metaData != $none) #metaData: metaData,
      if (data != $none) #data: data,
      if (errors != $none) #errors: errors,
    }),
  );
  @override
  PaginatedResponse<T> $make(CopyWithData data) => PaginatedResponse(
    success: data.get(#success, or: $value.success),
    message: data.get(#message, or: $value.message),
    metaData: data.get(#metaData, or: $value.metaData),
    data: data.get(#data, or: $value.data),
    errors: data.get(#errors, or: $value.errors),
  );

  @override
  PaginatedResponseCopyWith<$R2, PaginatedResponse<T>, $Out2, T>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _PaginatedResponseCopyWithImpl<$R2, $Out2, T>($value, $cast, t);
}

