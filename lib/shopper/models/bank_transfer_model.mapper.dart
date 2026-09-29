// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'bank_transfer_model.dart';

class BankTransferRequestMapper extends ClassMapperBase<BankTransferRequest> {
  BankTransferRequestMapper._();

  static BankTransferRequestMapper? _instance;
  static BankTransferRequestMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = BankTransferRequestMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'BankTransferRequest';

  static String? _$requestId(BankTransferRequest v) => v.requestId;
  static const Field<BankTransferRequest, String> _f$requestId = Field(
    'requestId',
    _$requestId,
    key: r'request_id',
    opt: true,
  );
  static num? _$amount(BankTransferRequest v) => v.amount;
  static const Field<BankTransferRequest, num> _f$amount = Field(
    'amount',
    _$amount,
    opt: true,
  );
  static String? _$bankName(BankTransferRequest v) => v.bankName;
  static const Field<BankTransferRequest, String> _f$bankName = Field(
    'bankName',
    _$bankName,
    key: r'bank_name',
    opt: true,
  );
  static String? _$accountNumber(BankTransferRequest v) => v.accountNumber;
  static const Field<BankTransferRequest, String> _f$accountNumber = Field(
    'accountNumber',
    _$accountNumber,
    key: r'account_number',
    opt: true,
  );
  static String? _$accountName(BankTransferRequest v) => v.accountName;
  static const Field<BankTransferRequest, String> _f$accountName = Field(
    'accountName',
    _$accountName,
    key: r'account_name',
    opt: true,
  );
  static String? _$remark(BankTransferRequest v) => v.remark;
  static const Field<BankTransferRequest, String> _f$remark = Field(
    'remark',
    _$remark,
    opt: true,
  );
  static String? _$otpValidTill(BankTransferRequest v) => v.otpValidTill;
  static const Field<BankTransferRequest, String> _f$otpValidTill = Field(
    'otpValidTill',
    _$otpValidTill,
    key: r'otp_valid_till',
    opt: true,
  );
  static String? _$verificationMethod(BankTransferRequest v) =>
      v.verificationMethod;
  static const Field<BankTransferRequest, String> _f$verificationMethod = Field(
    'verificationMethod',
    _$verificationMethod,
    key: r'verification_method',
    opt: true,
  );

  @override
  final MappableFields<BankTransferRequest> fields = const {
    #requestId: _f$requestId,
    #amount: _f$amount,
    #bankName: _f$bankName,
    #accountNumber: _f$accountNumber,
    #accountName: _f$accountName,
    #remark: _f$remark,
    #otpValidTill: _f$otpValidTill,
    #verificationMethod: _f$verificationMethod,
  };

  static BankTransferRequest _instantiate(DecodingData data) {
    return BankTransferRequest(
      requestId: data.dec(_f$requestId),
      amount: data.dec(_f$amount),
      bankName: data.dec(_f$bankName),
      accountNumber: data.dec(_f$accountNumber),
      accountName: data.dec(_f$accountName),
      remark: data.dec(_f$remark),
      otpValidTill: data.dec(_f$otpValidTill),
      verificationMethod: data.dec(_f$verificationMethod),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static BankTransferRequest fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<BankTransferRequest>(map);
  }

  static BankTransferRequest fromJson(String json) {
    return ensureInitialized().decodeJson<BankTransferRequest>(json);
  }
}

mixin BankTransferRequestMappable {
  String toJson() {
    return BankTransferRequestMapper.ensureInitialized()
        .encodeJson<BankTransferRequest>(this as BankTransferRequest);
  }

  Map<String, dynamic> toMap() {
    return BankTransferRequestMapper.ensureInitialized()
        .encodeMap<BankTransferRequest>(this as BankTransferRequest);
  }

  BankTransferRequestCopyWith<
    BankTransferRequest,
    BankTransferRequest,
    BankTransferRequest
  >
  get copyWith =>
      _BankTransferRequestCopyWithImpl<
        BankTransferRequest,
        BankTransferRequest
      >(this as BankTransferRequest, $identity, $identity);
  @override
  String toString() {
    return BankTransferRequestMapper.ensureInitialized().stringifyValue(
      this as BankTransferRequest,
    );
  }

  @override
  bool operator ==(Object other) {
    return BankTransferRequestMapper.ensureInitialized().equalsValue(
      this as BankTransferRequest,
      other,
    );
  }

  @override
  int get hashCode {
    return BankTransferRequestMapper.ensureInitialized().hashValue(
      this as BankTransferRequest,
    );
  }
}

extension BankTransferRequestValueCopy<$R, $Out>
    on ObjectCopyWith<$R, BankTransferRequest, $Out> {
  BankTransferRequestCopyWith<$R, BankTransferRequest, $Out>
  get $asBankTransferRequest => $base.as(
    (v, t, t2) => _BankTransferRequestCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class BankTransferRequestCopyWith<
  $R,
  $In extends BankTransferRequest,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? requestId,
    num? amount,
    String? bankName,
    String? accountNumber,
    String? accountName,
    String? remark,
    String? otpValidTill,
    String? verificationMethod,
  });
  BankTransferRequestCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _BankTransferRequestCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, BankTransferRequest, $Out>
    implements BankTransferRequestCopyWith<$R, BankTransferRequest, $Out> {
  _BankTransferRequestCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<BankTransferRequest> $mapper =
      BankTransferRequestMapper.ensureInitialized();
  @override
  $R call({
    Object? requestId = $none,
    Object? amount = $none,
    Object? bankName = $none,
    Object? accountNumber = $none,
    Object? accountName = $none,
    Object? remark = $none,
    Object? otpValidTill = $none,
    Object? verificationMethod = $none,
  }) => $apply(
    FieldCopyWithData({
      if (requestId != $none) #requestId: requestId,
      if (amount != $none) #amount: amount,
      if (bankName != $none) #bankName: bankName,
      if (accountNumber != $none) #accountNumber: accountNumber,
      if (accountName != $none) #accountName: accountName,
      if (remark != $none) #remark: remark,
      if (otpValidTill != $none) #otpValidTill: otpValidTill,
      if (verificationMethod != $none) #verificationMethod: verificationMethod,
    }),
  );
  @override
  BankTransferRequest $make(CopyWithData data) => BankTransferRequest(
    requestId: data.get(#requestId, or: $value.requestId),
    amount: data.get(#amount, or: $value.amount),
    bankName: data.get(#bankName, or: $value.bankName),
    accountNumber: data.get(#accountNumber, or: $value.accountNumber),
    accountName: data.get(#accountName, or: $value.accountName),
    remark: data.get(#remark, or: $value.remark),
    otpValidTill: data.get(#otpValidTill, or: $value.otpValidTill),
    verificationMethod: data.get(
      #verificationMethod,
      or: $value.verificationMethod,
    ),
  );

  @override
  BankTransferRequestCopyWith<$R2, BankTransferRequest, $Out2>
  $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _BankTransferRequestCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

