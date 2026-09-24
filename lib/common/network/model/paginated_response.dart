import 'package:dart_mappable/dart_mappable.dart';

part 'paginated_response.mapper.dart';

@MappableClass()
class PaginationMeta with PaginationMetaMappable {
  const PaginationMeta({
    this.totalRecords,
    this.totalPages,
    this.currentPage,
    this.pageSize,
  });

  final int? totalRecords;
  final int? totalPages;
  final int? currentPage;
  final int? pageSize;

  static final fromMap = PaginationMetaMapper.fromMap;
  static final fromJson = PaginationMetaMapper.fromJson;
}

@MappableClass()
class PaginatedResponse<T> with PaginatedResponseMappable<T> {
  const PaginatedResponse({
    this.success,
    this.message,
    this.metaData,
    this.data,
    this.errors,
  });

  @MappableField(key: 'status')
  final bool? success;
  final String? message;
  final PaginationMeta? metaData;
  final List<T>? data;
  final dynamic errors;

  static PaginatedResponse<T> fromMap<T>(Map<String, dynamic> map) =>
      PaginatedResponseMapper.fromMap<T>(map);

  static PaginatedResponse<T> fromJson<T>(String json) =>
      PaginatedResponseMapper.fromJson<T>(json);
}
