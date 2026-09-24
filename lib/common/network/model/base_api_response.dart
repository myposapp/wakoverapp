import 'package:dart_mappable/dart_mappable.dart';

part 'base_api_response.mapper.dart';

@MappableClass()
class BaseResponse<T> with BaseResponseMappable<T> {
  const BaseResponse({this.success, this.message, this.data, this.errors});

  @MappableField(key: 'status')
  final bool? success;
  final String? message;
  final T? data;
  final dynamic errors;

  static BaseResponse<T> fromMap<T>(Map<String, dynamic> map) =>
      BaseResponseMapper.fromMap<T>(map);

  static BaseResponse<T> fromJson<T>(String json) =>
      BaseResponseMapper.fromJson<T>(json);
}
