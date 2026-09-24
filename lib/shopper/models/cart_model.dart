import 'package:dart_mappable/dart_mappable.dart';

part 'cart_model.mapper.dart';

@MappableClass()
class Cart with CartMappable {
  const Cart({this.id, this.branchId, this.items});

  final String? id;
  @MappableField(key: 'branch_id')
  final String? branchId;
  final List<dynamic>? items;

  static final fromMap = CartMapper.fromMap;
  static final fromJson = CartMapper.fromJson;
}
