import 'package:dart_mappable/dart_mappable.dart';

part 'bank_model.mapper.dart';

@MappableClass()
class Bank with BankMappable {
  const Bank({this.name, this.code});

  final String? name;
  final String? code;

  static final fromMap = BankMapper.fromMap;
  static final fromJson = BankMapper.fromJson;
}
