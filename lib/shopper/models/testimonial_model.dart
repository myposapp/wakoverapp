import 'package:dart_mappable/dart_mappable.dart';

part 'testimonial_model.mapper.dart';

@MappableClass()
class Testimonial with TestimonialMappable {
  const Testimonial({this.id, this.name, this.role, this.comment});

  final String? id;
  final String? name;
  final String? role;
  final String? comment;

  static final fromMap = TestimonialMapper.fromMap;
  static final fromJson = TestimonialMapper.fromJson;
}
