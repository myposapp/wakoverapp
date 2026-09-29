import 'package:dart_mappable/dart_mappable.dart';

part 'bank_transfer_model.mapper.dart';

/// A pending wallet withdrawal awaiting OTP confirmation.
@MappableClass()
class BankTransferRequest with BankTransferRequestMappable {
  const BankTransferRequest({
    this.requestId,
    this.amount,
    this.bankName,
    this.accountNumber,
    this.accountName,
    this.remark,
    this.otpValidTill,
    this.verificationMethod,
  });

  @MappableField(key: 'request_id')
  final String? requestId;
  final num? amount;
  @MappableField(key: 'bank_name')
  final String? bankName;
  @MappableField(key: 'account_number')
  final String? accountNumber;
  @MappableField(key: 'account_name')
  final String? accountName;
  final String? remark;
  @MappableField(key: 'otp_valid_till')
  final String? otpValidTill;
  // Where the OTP was sent, e.g. 'email'.
  @MappableField(key: 'verification_method')
  final String? verificationMethod;

  static final fromMap = BankTransferRequestMapper.fromMap;
  static final fromJson = BankTransferRequestMapper.fromJson;
}
