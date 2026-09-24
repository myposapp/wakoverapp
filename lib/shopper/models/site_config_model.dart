import 'package:dart_mappable/dart_mappable.dart';

part 'site_config_model.mapper.dart';

@MappableClass()
class SiteConfig with SiteConfigMappable {
  const SiteConfig({
    this.template,
    this.pointExchangeRate,
    this.currencies,
    this.storeName,
    this.digitalGoods,
    this.showNavBar,
    this.payments,
    this.cod,
    this.pointGiveway,
    this.purchaseWithWallet,
    this.groupDelivery,
    this.socials,
    this.gTagId,
    this.metaPixelId,
    this.totalProducts,
    this.branches,
  });

  final String? template;
  @MappableField(key: 'point_exchange_rate')
  final num? pointExchangeRate;
  final List<Currency>? currencies;
  @MappableField(key: 'store_name')
  final String? storeName;
  @MappableField(key: 'digital_goods')
  final bool? digitalGoods;
  @MappableField(key: 'show_nav_bar')
  final bool? showNavBar;
  final bool? payments;
  final bool? cod;
  @MappableField(key: 'point_giveway')
  final PointGiveaway? pointGiveway;
  @MappableField(key: 'purchase_with_wallet')
  final bool? purchaseWithWallet;
  @MappableField(key: 'group_delivery')
  final bool? groupDelivery;
  final List<Social>? socials;
  @MappableField(key: 'g_tag_id')
  final String? gTagId;
  @MappableField(key: 'meta_pixel_id')
  final String? metaPixelId;
  @MappableField(key: 'total_products')
  final int? totalProducts;
  final List<dynamic>? branches;

  static final fromMap = SiteConfigMapper.fromMap;
  static final fromJson = SiteConfigMapper.fromJson;
}

@MappableClass()
class Currency with CurrencyMappable {
  const Currency({this.name, this.short, this.symbol, this.exRate});

  final String? name;
  final String? short;
  final String? symbol;
  final num? exRate;

  static final fromMap = CurrencyMapper.fromMap;
  static final fromJson = CurrencyMapper.fromJson;
}

@MappableClass()
class PointGiveaway with PointGiveawayMappable {
  const PointGiveaway({this.amountType, this.amount});

  @MappableField(key: 'amount_type')
  final String? amountType;
  final num? amount;

  static final fromMap = PointGiveawayMapper.fromMap;
  static final fromJson = PointGiveawayMapper.fromJson;
}

@MappableClass()
class Social with SocialMappable {
  const Social({this.platform, this.username, this.url});

  final String? platform;
  final String? username;
  final String? url;

  static final fromMap = SocialMapper.fromMap;
  static final fromJson = SocialMapper.fromJson;
}
