// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'site_config_model.dart';

class SiteConfigMapper extends ClassMapperBase<SiteConfig> {
  SiteConfigMapper._();

  static SiteConfigMapper? _instance;
  static SiteConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SiteConfigMapper._());
      CurrencyMapper.ensureInitialized();
      PointGiveawayMapper.ensureInitialized();
      SocialMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SiteConfig';

  static String? _$template(SiteConfig v) => v.template;
  static const Field<SiteConfig, String> _f$template = Field(
    'template',
    _$template,
    opt: true,
  );
  static num? _$pointExchangeRate(SiteConfig v) => v.pointExchangeRate;
  static const Field<SiteConfig, num> _f$pointExchangeRate = Field(
    'pointExchangeRate',
    _$pointExchangeRate,
    key: r'point_exchange_rate',
    opt: true,
  );
  static List<Currency>? _$currencies(SiteConfig v) => v.currencies;
  static const Field<SiteConfig, List<Currency>> _f$currencies = Field(
    'currencies',
    _$currencies,
    opt: true,
  );
  static String? _$storeName(SiteConfig v) => v.storeName;
  static const Field<SiteConfig, String> _f$storeName = Field(
    'storeName',
    _$storeName,
    key: r'store_name',
    opt: true,
  );
  static bool? _$digitalGoods(SiteConfig v) => v.digitalGoods;
  static const Field<SiteConfig, bool> _f$digitalGoods = Field(
    'digitalGoods',
    _$digitalGoods,
    key: r'digital_goods',
    opt: true,
  );
  static bool? _$showNavBar(SiteConfig v) => v.showNavBar;
  static const Field<SiteConfig, bool> _f$showNavBar = Field(
    'showNavBar',
    _$showNavBar,
    key: r'show_nav_bar',
    opt: true,
  );
  static bool? _$payments(SiteConfig v) => v.payments;
  static const Field<SiteConfig, bool> _f$payments = Field(
    'payments',
    _$payments,
    opt: true,
  );
  static bool? _$cod(SiteConfig v) => v.cod;
  static const Field<SiteConfig, bool> _f$cod = Field('cod', _$cod, opt: true);
  static PointGiveaway? _$pointGiveway(SiteConfig v) => v.pointGiveway;
  static const Field<SiteConfig, PointGiveaway> _f$pointGiveway = Field(
    'pointGiveway',
    _$pointGiveway,
    key: r'point_giveway',
    opt: true,
  );
  static bool? _$purchaseWithWallet(SiteConfig v) => v.purchaseWithWallet;
  static const Field<SiteConfig, bool> _f$purchaseWithWallet = Field(
    'purchaseWithWallet',
    _$purchaseWithWallet,
    key: r'purchase_with_wallet',
    opt: true,
  );
  static bool? _$groupDelivery(SiteConfig v) => v.groupDelivery;
  static const Field<SiteConfig, bool> _f$groupDelivery = Field(
    'groupDelivery',
    _$groupDelivery,
    key: r'group_delivery',
    opt: true,
  );
  static List<Social>? _$socials(SiteConfig v) => v.socials;
  static const Field<SiteConfig, List<Social>> _f$socials = Field(
    'socials',
    _$socials,
    opt: true,
  );
  static String? _$gTagId(SiteConfig v) => v.gTagId;
  static const Field<SiteConfig, String> _f$gTagId = Field(
    'gTagId',
    _$gTagId,
    key: r'g_tag_id',
    opt: true,
  );
  static String? _$metaPixelId(SiteConfig v) => v.metaPixelId;
  static const Field<SiteConfig, String> _f$metaPixelId = Field(
    'metaPixelId',
    _$metaPixelId,
    key: r'meta_pixel_id',
    opt: true,
  );
  static int? _$totalProducts(SiteConfig v) => v.totalProducts;
  static const Field<SiteConfig, int> _f$totalProducts = Field(
    'totalProducts',
    _$totalProducts,
    key: r'total_products',
    opt: true,
  );
  static List<dynamic>? _$branches(SiteConfig v) => v.branches;
  static const Field<SiteConfig, List<dynamic>> _f$branches = Field(
    'branches',
    _$branches,
    opt: true,
  );

  @override
  final MappableFields<SiteConfig> fields = const {
    #template: _f$template,
    #pointExchangeRate: _f$pointExchangeRate,
    #currencies: _f$currencies,
    #storeName: _f$storeName,
    #digitalGoods: _f$digitalGoods,
    #showNavBar: _f$showNavBar,
    #payments: _f$payments,
    #cod: _f$cod,
    #pointGiveway: _f$pointGiveway,
    #purchaseWithWallet: _f$purchaseWithWallet,
    #groupDelivery: _f$groupDelivery,
    #socials: _f$socials,
    #gTagId: _f$gTagId,
    #metaPixelId: _f$metaPixelId,
    #totalProducts: _f$totalProducts,
    #branches: _f$branches,
  };

  static SiteConfig _instantiate(DecodingData data) {
    return SiteConfig(
      template: data.dec(_f$template),
      pointExchangeRate: data.dec(_f$pointExchangeRate),
      currencies: data.dec(_f$currencies),
      storeName: data.dec(_f$storeName),
      digitalGoods: data.dec(_f$digitalGoods),
      showNavBar: data.dec(_f$showNavBar),
      payments: data.dec(_f$payments),
      cod: data.dec(_f$cod),
      pointGiveway: data.dec(_f$pointGiveway),
      purchaseWithWallet: data.dec(_f$purchaseWithWallet),
      groupDelivery: data.dec(_f$groupDelivery),
      socials: data.dec(_f$socials),
      gTagId: data.dec(_f$gTagId),
      metaPixelId: data.dec(_f$metaPixelId),
      totalProducts: data.dec(_f$totalProducts),
      branches: data.dec(_f$branches),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SiteConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SiteConfig>(map);
  }

  static SiteConfig fromJson(String json) {
    return ensureInitialized().decodeJson<SiteConfig>(json);
  }
}

mixin SiteConfigMappable {
  String toJson() {
    return SiteConfigMapper.ensureInitialized().encodeJson<SiteConfig>(
      this as SiteConfig,
    );
  }

  Map<String, dynamic> toMap() {
    return SiteConfigMapper.ensureInitialized().encodeMap<SiteConfig>(
      this as SiteConfig,
    );
  }

  SiteConfigCopyWith<SiteConfig, SiteConfig, SiteConfig> get copyWith =>
      _SiteConfigCopyWithImpl<SiteConfig, SiteConfig>(
        this as SiteConfig,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SiteConfigMapper.ensureInitialized().stringifyValue(
      this as SiteConfig,
    );
  }

  @override
  bool operator ==(Object other) {
    return SiteConfigMapper.ensureInitialized().equalsValue(
      this as SiteConfig,
      other,
    );
  }

  @override
  int get hashCode {
    return SiteConfigMapper.ensureInitialized().hashValue(this as SiteConfig);
  }
}

extension SiteConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SiteConfig, $Out> {
  SiteConfigCopyWith<$R, SiteConfig, $Out> get $asSiteConfig =>
      $base.as((v, t, t2) => _SiteConfigCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SiteConfigCopyWith<$R, $In extends SiteConfig, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, Currency, CurrencyCopyWith<$R, Currency, Currency>>?
  get currencies;
  PointGiveawayCopyWith<$R, PointGiveaway, PointGiveaway>? get pointGiveway;
  ListCopyWith<$R, Social, SocialCopyWith<$R, Social, Social>>? get socials;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get branches;
  $R call({
    String? template,
    num? pointExchangeRate,
    List<Currency>? currencies,
    String? storeName,
    bool? digitalGoods,
    bool? showNavBar,
    bool? payments,
    bool? cod,
    PointGiveaway? pointGiveway,
    bool? purchaseWithWallet,
    bool? groupDelivery,
    List<Social>? socials,
    String? gTagId,
    String? metaPixelId,
    int? totalProducts,
    List<dynamic>? branches,
  });
  SiteConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SiteConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SiteConfig, $Out>
    implements SiteConfigCopyWith<$R, SiteConfig, $Out> {
  _SiteConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SiteConfig> $mapper =
      SiteConfigMapper.ensureInitialized();
  @override
  ListCopyWith<$R, Currency, CurrencyCopyWith<$R, Currency, Currency>>?
  get currencies => $value.currencies != null
      ? ListCopyWith(
          $value.currencies!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(currencies: v),
        )
      : null;
  @override
  PointGiveawayCopyWith<$R, PointGiveaway, PointGiveaway>? get pointGiveway =>
      $value.pointGiveway?.copyWith.$chain((v) => call(pointGiveway: v));
  @override
  ListCopyWith<$R, Social, SocialCopyWith<$R, Social, Social>>? get socials =>
      $value.socials != null
      ? ListCopyWith(
          $value.socials!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(socials: v),
        )
      : null;
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get branches => $value.branches != null
      ? ListCopyWith(
          $value.branches!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(branches: v),
        )
      : null;
  @override
  $R call({
    Object? template = $none,
    Object? pointExchangeRate = $none,
    Object? currencies = $none,
    Object? storeName = $none,
    Object? digitalGoods = $none,
    Object? showNavBar = $none,
    Object? payments = $none,
    Object? cod = $none,
    Object? pointGiveway = $none,
    Object? purchaseWithWallet = $none,
    Object? groupDelivery = $none,
    Object? socials = $none,
    Object? gTagId = $none,
    Object? metaPixelId = $none,
    Object? totalProducts = $none,
    Object? branches = $none,
  }) => $apply(
    FieldCopyWithData({
      if (template != $none) #template: template,
      if (pointExchangeRate != $none) #pointExchangeRate: pointExchangeRate,
      if (currencies != $none) #currencies: currencies,
      if (storeName != $none) #storeName: storeName,
      if (digitalGoods != $none) #digitalGoods: digitalGoods,
      if (showNavBar != $none) #showNavBar: showNavBar,
      if (payments != $none) #payments: payments,
      if (cod != $none) #cod: cod,
      if (pointGiveway != $none) #pointGiveway: pointGiveway,
      if (purchaseWithWallet != $none) #purchaseWithWallet: purchaseWithWallet,
      if (groupDelivery != $none) #groupDelivery: groupDelivery,
      if (socials != $none) #socials: socials,
      if (gTagId != $none) #gTagId: gTagId,
      if (metaPixelId != $none) #metaPixelId: metaPixelId,
      if (totalProducts != $none) #totalProducts: totalProducts,
      if (branches != $none) #branches: branches,
    }),
  );
  @override
  SiteConfig $make(CopyWithData data) => SiteConfig(
    template: data.get(#template, or: $value.template),
    pointExchangeRate: data.get(
      #pointExchangeRate,
      or: $value.pointExchangeRate,
    ),
    currencies: data.get(#currencies, or: $value.currencies),
    storeName: data.get(#storeName, or: $value.storeName),
    digitalGoods: data.get(#digitalGoods, or: $value.digitalGoods),
    showNavBar: data.get(#showNavBar, or: $value.showNavBar),
    payments: data.get(#payments, or: $value.payments),
    cod: data.get(#cod, or: $value.cod),
    pointGiveway: data.get(#pointGiveway, or: $value.pointGiveway),
    purchaseWithWallet: data.get(
      #purchaseWithWallet,
      or: $value.purchaseWithWallet,
    ),
    groupDelivery: data.get(#groupDelivery, or: $value.groupDelivery),
    socials: data.get(#socials, or: $value.socials),
    gTagId: data.get(#gTagId, or: $value.gTagId),
    metaPixelId: data.get(#metaPixelId, or: $value.metaPixelId),
    totalProducts: data.get(#totalProducts, or: $value.totalProducts),
    branches: data.get(#branches, or: $value.branches),
  );

  @override
  SiteConfigCopyWith<$R2, SiteConfig, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SiteConfigCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class CurrencyMapper extends ClassMapperBase<Currency> {
  CurrencyMapper._();

  static CurrencyMapper? _instance;
  static CurrencyMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = CurrencyMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Currency';

  static String? _$name(Currency v) => v.name;
  static const Field<Currency, String> _f$name = Field(
    'name',
    _$name,
    opt: true,
  );
  static String? _$short(Currency v) => v.short;
  static const Field<Currency, String> _f$short = Field(
    'short',
    _$short,
    opt: true,
  );
  static String? _$symbol(Currency v) => v.symbol;
  static const Field<Currency, String> _f$symbol = Field(
    'symbol',
    _$symbol,
    opt: true,
  );
  static num? _$exRate(Currency v) => v.exRate;
  static const Field<Currency, num> _f$exRate = Field(
    'exRate',
    _$exRate,
    opt: true,
  );

  @override
  final MappableFields<Currency> fields = const {
    #name: _f$name,
    #short: _f$short,
    #symbol: _f$symbol,
    #exRate: _f$exRate,
  };

  static Currency _instantiate(DecodingData data) {
    return Currency(
      name: data.dec(_f$name),
      short: data.dec(_f$short),
      symbol: data.dec(_f$symbol),
      exRate: data.dec(_f$exRate),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Currency fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Currency>(map);
  }

  static Currency fromJson(String json) {
    return ensureInitialized().decodeJson<Currency>(json);
  }
}

mixin CurrencyMappable {
  String toJson() {
    return CurrencyMapper.ensureInitialized().encodeJson<Currency>(
      this as Currency,
    );
  }

  Map<String, dynamic> toMap() {
    return CurrencyMapper.ensureInitialized().encodeMap<Currency>(
      this as Currency,
    );
  }

  CurrencyCopyWith<Currency, Currency, Currency> get copyWith =>
      _CurrencyCopyWithImpl<Currency, Currency>(
        this as Currency,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return CurrencyMapper.ensureInitialized().stringifyValue(this as Currency);
  }

  @override
  bool operator ==(Object other) {
    return CurrencyMapper.ensureInitialized().equalsValue(
      this as Currency,
      other,
    );
  }

  @override
  int get hashCode {
    return CurrencyMapper.ensureInitialized().hashValue(this as Currency);
  }
}

extension CurrencyValueCopy<$R, $Out> on ObjectCopyWith<$R, Currency, $Out> {
  CurrencyCopyWith<$R, Currency, $Out> get $asCurrency =>
      $base.as((v, t, t2) => _CurrencyCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class CurrencyCopyWith<$R, $In extends Currency, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? name, String? short, String? symbol, num? exRate});
  CurrencyCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _CurrencyCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Currency, $Out>
    implements CurrencyCopyWith<$R, Currency, $Out> {
  _CurrencyCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Currency> $mapper =
      CurrencyMapper.ensureInitialized();
  @override
  $R call({
    Object? name = $none,
    Object? short = $none,
    Object? symbol = $none,
    Object? exRate = $none,
  }) => $apply(
    FieldCopyWithData({
      if (name != $none) #name: name,
      if (short != $none) #short: short,
      if (symbol != $none) #symbol: symbol,
      if (exRate != $none) #exRate: exRate,
    }),
  );
  @override
  Currency $make(CopyWithData data) => Currency(
    name: data.get(#name, or: $value.name),
    short: data.get(#short, or: $value.short),
    symbol: data.get(#symbol, or: $value.symbol),
    exRate: data.get(#exRate, or: $value.exRate),
  );

  @override
  CurrencyCopyWith<$R2, Currency, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _CurrencyCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class PointGiveawayMapper extends ClassMapperBase<PointGiveaway> {
  PointGiveawayMapper._();

  static PointGiveawayMapper? _instance;
  static PointGiveawayMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = PointGiveawayMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'PointGiveaway';

  static String? _$amountType(PointGiveaway v) => v.amountType;
  static const Field<PointGiveaway, String> _f$amountType = Field(
    'amountType',
    _$amountType,
    key: r'amount_type',
    opt: true,
  );
  static num? _$amount(PointGiveaway v) => v.amount;
  static const Field<PointGiveaway, num> _f$amount = Field(
    'amount',
    _$amount,
    opt: true,
  );

  @override
  final MappableFields<PointGiveaway> fields = const {
    #amountType: _f$amountType,
    #amount: _f$amount,
  };

  static PointGiveaway _instantiate(DecodingData data) {
    return PointGiveaway(
      amountType: data.dec(_f$amountType),
      amount: data.dec(_f$amount),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static PointGiveaway fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<PointGiveaway>(map);
  }

  static PointGiveaway fromJson(String json) {
    return ensureInitialized().decodeJson<PointGiveaway>(json);
  }
}

mixin PointGiveawayMappable {
  String toJson() {
    return PointGiveawayMapper.ensureInitialized().encodeJson<PointGiveaway>(
      this as PointGiveaway,
    );
  }

  Map<String, dynamic> toMap() {
    return PointGiveawayMapper.ensureInitialized().encodeMap<PointGiveaway>(
      this as PointGiveaway,
    );
  }

  PointGiveawayCopyWith<PointGiveaway, PointGiveaway, PointGiveaway>
  get copyWith => _PointGiveawayCopyWithImpl<PointGiveaway, PointGiveaway>(
    this as PointGiveaway,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return PointGiveawayMapper.ensureInitialized().stringifyValue(
      this as PointGiveaway,
    );
  }

  @override
  bool operator ==(Object other) {
    return PointGiveawayMapper.ensureInitialized().equalsValue(
      this as PointGiveaway,
      other,
    );
  }

  @override
  int get hashCode {
    return PointGiveawayMapper.ensureInitialized().hashValue(
      this as PointGiveaway,
    );
  }
}

extension PointGiveawayValueCopy<$R, $Out>
    on ObjectCopyWith<$R, PointGiveaway, $Out> {
  PointGiveawayCopyWith<$R, PointGiveaway, $Out> get $asPointGiveaway =>
      $base.as((v, t, t2) => _PointGiveawayCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class PointGiveawayCopyWith<$R, $In extends PointGiveaway, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? amountType, num? amount});
  PointGiveawayCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _PointGiveawayCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, PointGiveaway, $Out>
    implements PointGiveawayCopyWith<$R, PointGiveaway, $Out> {
  _PointGiveawayCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<PointGiveaway> $mapper =
      PointGiveawayMapper.ensureInitialized();
  @override
  $R call({Object? amountType = $none, Object? amount = $none}) => $apply(
    FieldCopyWithData({
      if (amountType != $none) #amountType: amountType,
      if (amount != $none) #amount: amount,
    }),
  );
  @override
  PointGiveaway $make(CopyWithData data) => PointGiveaway(
    amountType: data.get(#amountType, or: $value.amountType),
    amount: data.get(#amount, or: $value.amount),
  );

  @override
  PointGiveawayCopyWith<$R2, PointGiveaway, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _PointGiveawayCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SocialMapper extends ClassMapperBase<Social> {
  SocialMapper._();

  static SocialMapper? _instance;
  static SocialMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SocialMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Social';

  static String? _$platform(Social v) => v.platform;
  static const Field<Social, String> _f$platform = Field(
    'platform',
    _$platform,
    opt: true,
  );
  static String? _$username(Social v) => v.username;
  static const Field<Social, String> _f$username = Field(
    'username',
    _$username,
    opt: true,
  );
  static String? _$url(Social v) => v.url;
  static const Field<Social, String> _f$url = Field('url', _$url, opt: true);

  @override
  final MappableFields<Social> fields = const {
    #platform: _f$platform,
    #username: _f$username,
    #url: _f$url,
  };

  static Social _instantiate(DecodingData data) {
    return Social(
      platform: data.dec(_f$platform),
      username: data.dec(_f$username),
      url: data.dec(_f$url),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Social fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Social>(map);
  }

  static Social fromJson(String json) {
    return ensureInitialized().decodeJson<Social>(json);
  }
}

mixin SocialMappable {
  String toJson() {
    return SocialMapper.ensureInitialized().encodeJson<Social>(this as Social);
  }

  Map<String, dynamic> toMap() {
    return SocialMapper.ensureInitialized().encodeMap<Social>(this as Social);
  }

  SocialCopyWith<Social, Social, Social> get copyWith =>
      _SocialCopyWithImpl<Social, Social>(this as Social, $identity, $identity);
  @override
  String toString() {
    return SocialMapper.ensureInitialized().stringifyValue(this as Social);
  }

  @override
  bool operator ==(Object other) {
    return SocialMapper.ensureInitialized().equalsValue(this as Social, other);
  }

  @override
  int get hashCode {
    return SocialMapper.ensureInitialized().hashValue(this as Social);
  }
}

extension SocialValueCopy<$R, $Out> on ObjectCopyWith<$R, Social, $Out> {
  SocialCopyWith<$R, Social, $Out> get $asSocial =>
      $base.as((v, t, t2) => _SocialCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SocialCopyWith<$R, $In extends Social, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? platform, String? username, String? url});
  SocialCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SocialCopyWithImpl<$R, $Out> extends ClassCopyWithBase<$R, Social, $Out>
    implements SocialCopyWith<$R, Social, $Out> {
  _SocialCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Social> $mapper = SocialMapper.ensureInitialized();
  @override
  $R call({
    Object? platform = $none,
    Object? username = $none,
    Object? url = $none,
  }) => $apply(
    FieldCopyWithData({
      if (platform != $none) #platform: platform,
      if (username != $none) #username: username,
      if (url != $none) #url: url,
    }),
  );
  @override
  Social $make(CopyWithData data) => Social(
    platform: data.get(#platform, or: $value.platform),
    username: data.get(#username, or: $value.username),
    url: data.get(#url, or: $value.url),
  );

  @override
  SocialCopyWith<$R2, Social, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _SocialCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

