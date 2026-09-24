import 'package:dart_mappable/dart_mappable.dart';

part 'shipping_method_model.mapper.dart';

@MappableClass()
class ShippingMethod with ShippingMethodMappable {
  const ShippingMethod({this.id, this.title, this.description, this.price});

  final String? id;
  final String? title;
  final String? description;
  final num? price;

  static final fromMap = ShippingMethodMapper.fromMap;
  static final fromJson = ShippingMethodMapper.fromJson;
}

@MappableClass()
class ShippingMethodsData with ShippingMethodsDataMappable {
  const ShippingMethodsData({this.shippingMethods, this.groupDeliveryPoints});

  @MappableField(key: 'shipping_methods')
  final List<ShippingMethod>? shippingMethods;
  @MappableField(key: 'group_delivery_points')
  final List<dynamic>? groupDeliveryPoints;

  static final fromMap = ShippingMethodsDataMapper.fromMap;
  static final fromJson = ShippingMethodsDataMapper.fromJson;
}
