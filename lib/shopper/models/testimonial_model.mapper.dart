// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'testimonial_model.dart';

class TestimonialMapper extends ClassMapperBase<Testimonial> {
  TestimonialMapper._();

  static TestimonialMapper? _instance;
  static TestimonialMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = TestimonialMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Testimonial';

  static String? _$id(Testimonial v) => v.id;
  static const Field<Testimonial, String> _f$id = Field('id', _$id, opt: true);
  static String? _$name(Testimonial v) => v.name;
  static const Field<Testimonial, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$role(Testimonial v) => v.role;
  static const Field<Testimonial, String> _f$role = Field(
    'role',
    _$role,
    opt: true,
  );
  static String? _$comment(Testimonial v) => v.comment;
  static const Field<Testimonial, String> _f$comment = Field(
    'comment',
    _$comment,
    opt: true,
  );

  @override
  final MappableFields<Testimonial> fields = const {
    #id: _f$id,
    #name: _f$name,
    #role: _f$role,
    #comment: _f$comment,
  };

  static Testimonial _instantiate(DecodingData data) {
    return Testimonial(
      id: data.dec(_f$id),
      name: data.dec(_f$name),
      role: data.dec(_f$role),
      comment: data.dec(_f$comment),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Testimonial fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Testimonial>(map);
  }

  static Testimonial fromJson(String json) {
    return ensureInitialized().decodeJson<Testimonial>(json);
  }
}

mixin TestimonialMappable {
  String toJson() {
    return TestimonialMapper.ensureInitialized().encodeJson<Testimonial>(
      this as Testimonial,
    );
  }

  Map<String, dynamic> toMap() {
    return TestimonialMapper.ensureInitialized().encodeMap<Testimonial>(
      this as Testimonial,
    );
  }

  TestimonialCopyWith<Testimonial, Testimonial, Testimonial> get copyWith =>
      _TestimonialCopyWithImpl<Testimonial, Testimonial>(
        this as Testimonial,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return TestimonialMapper.ensureInitialized().stringifyValue(
      this as Testimonial,
    );
  }

  @override
  bool operator ==(Object other) {
    return TestimonialMapper.ensureInitialized().equalsValue(
      this as Testimonial,
      other,
    );
  }

  @override
  int get hashCode {
    return TestimonialMapper.ensureInitialized().hashValue(this as Testimonial);
  }
}

extension TestimonialValueCopy<$R, $Out>
    on ObjectCopyWith<$R, Testimonial, $Out> {
  TestimonialCopyWith<$R, Testimonial, $Out> get $asTestimonial =>
      $base.as((v, t, t2) => _TestimonialCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class TestimonialCopyWith<$R, $In extends Testimonial, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? id, String? name, String? role, String? comment});
  TestimonialCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _TestimonialCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Testimonial, $Out>
    implements TestimonialCopyWith<$R, Testimonial, $Out> {
  _TestimonialCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Testimonial> $mapper =
      TestimonialMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? name = $none,
    Object? role = $none,
    Object? comment = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (name != $none) #name: name,
      if (role != $none) #role: role,
      if (comment != $none) #comment: comment,
    }),
  );
  @override
  Testimonial $make(CopyWithData data) => Testimonial(
    id: data.get(#id, or: $value.id),
    name: data.get(#name, or: $value.name),
    role: data.get(#role, or: $value.role),
    comment: data.get(#comment, or: $value.comment),
  );

  @override
  TestimonialCopyWith<$R2, Testimonial, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _TestimonialCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

