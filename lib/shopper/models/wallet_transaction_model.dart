import 'package:dart_mappable/dart_mappable.dart';

part 'wallet_transaction_model.mapper.dart';

@MappableClass()
class WalletTransaction with WalletTransactionMappable {
  const WalletTransaction({
    this.id,
    this.amount,
    this.type,
    this.product,
    this.description,
    this.remark,
    this.paymentStatus,
    this.charges,
    this.createdAt,
  });

  final String? id;
  final num? amount;
  // 'credit' or 'debit'.
  final String? type;
  // Human readable source, e.g. "REVERSAL | PLATFORM ORDER".
  final String? product;
  final String? description;
  final String? remark;
  @MappableField(key: 'payment_status')
  final String? paymentStatus;
  final dynamic charges;
  final String? createdAt;

  bool get isCredit => type == 'credit';

  static final fromMap = WalletTransactionMapper.fromMap;
  static final fromJson = WalletTransactionMapper.fromJson;
}
