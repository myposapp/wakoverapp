// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'wallet_transaction_model.dart';

class WalletTransactionMapper extends ClassMapperBase<WalletTransaction> {
  WalletTransactionMapper._();

  static WalletTransactionMapper? _instance;
  static WalletTransactionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = WalletTransactionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'WalletTransaction';

  static String? _$id(WalletTransaction v) => v.id;
  static const Field<WalletTransaction, String> _f$id = Field(
    'id',
    _$id,
    opt: true,
  );
  static num? _$amount(WalletTransaction v) => v.amount;
  static const Field<WalletTransaction, num> _f$amount = Field(
    'amount',
    _$amount,
    opt: true,
  );
  static String? _$type(WalletTransaction v) => v.type;
  static const Field<WalletTransaction, String> _f$type = Field(
    'type',
    _$type,
    opt: true,
  );
  static String? _$product(WalletTransaction v) => v.product;
  static const Field<WalletTransaction, String> _f$product = Field(
    'product',
    _$product,
    opt: true,
  );
  static String? _$description(WalletTransaction v) => v.description;
  static const Field<WalletTransaction, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static String? _$remark(WalletTransaction v) => v.remark;
  static const Field<WalletTransaction, String> _f$remark = Field(
    'remark',
    _$remark,
    opt: true,
  );
  static String? _$paymentStatus(WalletTransaction v) => v.paymentStatus;
  static const Field<WalletTransaction, String> _f$paymentStatus = Field(
    'paymentStatus',
    _$paymentStatus,
    key: r'payment_status',
    opt: true,
  );
  static dynamic _$charges(WalletTransaction v) => v.charges;
  static const Field<WalletTransaction, dynamic> _f$charges = Field(
    'charges',
    _$charges,
    opt: true,
  );
  static String? _$createdAt(WalletTransaction v) => v.createdAt;
  static const Field<WalletTransaction, String> _f$createdAt = Field(
    'createdAt',
    _$createdAt,
    opt: true,
  );

  @override
  final MappableFields<WalletTransaction> fields = const {
    #id: _f$id,
    #amount: _f$amount,
    #type: _f$type,
    #product: _f$product,
    #description: _f$description,
    #remark: _f$remark,
    #paymentStatus: _f$paymentStatus,
    #charges: _f$charges,
    #createdAt: _f$createdAt,
  };

  static WalletTransaction _instantiate(DecodingData data) {
    return WalletTransaction(
      id: data.dec(_f$id),
      amount: data.dec(_f$amount),
      type: data.dec(_f$type),
      product: data.dec(_f$product),
      description: data.dec(_f$description),
      remark: data.dec(_f$remark),
      paymentStatus: data.dec(_f$paymentStatus),
      charges: data.dec(_f$charges),
      createdAt: data.dec(_f$createdAt),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static WalletTransaction fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<WalletTransaction>(map);
  }

  static WalletTransaction fromJson(String json) {
    return ensureInitialized().decodeJson<WalletTransaction>(json);
  }
}

mixin WalletTransactionMappable {
  String toJson() {
    return WalletTransactionMapper.ensureInitialized()
        .encodeJson<WalletTransaction>(this as WalletTransaction);
  }

  Map<String, dynamic> toMap() {
    return WalletTransactionMapper.ensureInitialized()
        .encodeMap<WalletTransaction>(this as WalletTransaction);
  }

  WalletTransactionCopyWith<
    WalletTransaction,
    WalletTransaction,
    WalletTransaction
  >
  get copyWith =>
      _WalletTransactionCopyWithImpl<WalletTransaction, WalletTransaction>(
        this as WalletTransaction,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return WalletTransactionMapper.ensureInitialized().stringifyValue(
      this as WalletTransaction,
    );
  }

  @override
  bool operator ==(Object other) {
    return WalletTransactionMapper.ensureInitialized().equalsValue(
      this as WalletTransaction,
      other,
    );
  }

  @override
  int get hashCode {
    return WalletTransactionMapper.ensureInitialized().hashValue(
      this as WalletTransaction,
    );
  }
}

extension WalletTransactionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, WalletTransaction, $Out> {
  WalletTransactionCopyWith<$R, WalletTransaction, $Out>
  get $asWalletTransaction => $base.as(
    (v, t, t2) => _WalletTransactionCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class WalletTransactionCopyWith<
  $R,
  $In extends WalletTransaction,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? id,
    num? amount,
    String? type,
    String? product,
    String? description,
    String? remark,
    String? paymentStatus,
    dynamic charges,
    String? createdAt,
  });
  WalletTransactionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _WalletTransactionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, WalletTransaction, $Out>
    implements WalletTransactionCopyWith<$R, WalletTransaction, $Out> {
  _WalletTransactionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<WalletTransaction> $mapper =
      WalletTransactionMapper.ensureInitialized();
  @override
  $R call({
    Object? id = $none,
    Object? amount = $none,
    Object? type = $none,
    Object? product = $none,
    Object? description = $none,
    Object? remark = $none,
    Object? paymentStatus = $none,
    Object? charges = $none,
    Object? createdAt = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (amount != $none) #amount: amount,
      if (type != $none) #type: type,
      if (product != $none) #product: product,
      if (description != $none) #description: description,
      if (remark != $none) #remark: remark,
      if (paymentStatus != $none) #paymentStatus: paymentStatus,
      if (charges != $none) #charges: charges,
      if (createdAt != $none) #createdAt: createdAt,
    }),
  );
  @override
  WalletTransaction $make(CopyWithData data) => WalletTransaction(
    id: data.get(#id, or: $value.id),
    amount: data.get(#amount, or: $value.amount),
    type: data.get(#type, or: $value.type),
    product: data.get(#product, or: $value.product),
    description: data.get(#description, or: $value.description),
    remark: data.get(#remark, or: $value.remark),
    paymentStatus: data.get(#paymentStatus, or: $value.paymentStatus),
    charges: data.get(#charges, or: $value.charges),
    createdAt: data.get(#createdAt, or: $value.createdAt),
  );

  @override
  WalletTransactionCopyWith<$R2, WalletTransaction, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _WalletTransactionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

