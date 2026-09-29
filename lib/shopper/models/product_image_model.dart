import 'package:dart_mappable/dart_mappable.dart';

part 'product_image_model.mapper.dart';

@MappableClass()
class ProductImage with ProductImageMappable {
  const ProductImage({this.url, this.mime, this.size, this.name});

  final String? url;
  final String? mime;
  final num? size;
  final String? name;

  static final fromMap = ProductImageMapper.fromMap;
  static final fromJson = ProductImageMapper.fromJson;
}
