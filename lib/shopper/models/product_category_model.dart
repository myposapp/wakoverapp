import 'package:dart_mappable/dart_mappable.dart';

part 'product_category_model.mapper.dart';

@MappableClass()
class ProductCategory with ProductCategoryMappable {
  const ProductCategory({this.id, this.name, this.image, this.displayOrder});

  final String? id;
  final String? name;
  final String? image;
  @MappableField(key: 'display_order')
  final int? displayOrder;

  static final fromMap = ProductCategoryMapper.fromMap;
  static final fromJson = ProductCategoryMapper.fromJson;
}
