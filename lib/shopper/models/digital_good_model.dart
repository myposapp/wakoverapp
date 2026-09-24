import 'package:dart_mappable/dart_mappable.dart';
import 'product_category_model.dart';

part 'digital_good_model.mapper.dart';

@MappableClass()
class DigitalGood with DigitalGoodMappable {
  const DigitalGood({
    this.id,
    this.name,
    this.image,
    this.price,
    this.unit,
    this.category,
  });

  final String? id;
  final String? name;
  final String? image;
  final num? price;
  final String? unit;
  final ProductCategory? category;

  static final fromMap = DigitalGoodMapper.fromMap;
  static final fromJson = DigitalGoodMapper.fromJson;
}
