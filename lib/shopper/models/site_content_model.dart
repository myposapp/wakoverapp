import 'package:dart_mappable/dart_mappable.dart';

part 'site_content_model.mapper.dart';

@MappableClass()
class SiteContent with SiteContentMappable {
  const SiteContent({
    this.config,
    this.proximHeroContent,
    this.featureSection,
    this.features,
    this.spiderFeatureSection,
    this.spiderFeatures,
    this.contactSection,
    this.linkShowcase,
    this.links,
    this.articles,
    this.subFormImage,
  });

  final SiteContentConfig? config;
  @MappableField(key: 'proxim_hero_content')
  final HeroContent? proximHeroContent;
  @MappableField(key: 'feature_section')
  final dynamic featureSection;
  final List<dynamic>? features;
  @MappableField(key: 'spider_feature_section')
  final dynamic spiderFeatureSection;
  @MappableField(key: 'spider_features')
  final List<dynamic>? spiderFeatures;
  @MappableField(key: 'contact_section')
  final ContactSection? contactSection;
  @MappableField(key: 'link_showcase')
  final dynamic linkShowcase;
  final List<dynamic>? links;
  final List<Article>? articles;
  @MappableField(key: 'sub_form_image')
  final String? subFormImage;

  static final fromMap = SiteContentMapper.fromMap;
  static final fromJson = SiteContentMapper.fromJson;
}

@MappableClass()
class SiteContentConfig with SiteContentConfigMappable {
  const SiteContentConfig({
    this.template,
    this.companyId,
    this.merchantId,
    this.storeName,
  });

  final String? template;
  @MappableField(key: 'company_id')
  final String? companyId;
  @MappableField(key: 'merchant_id')
  final String? merchantId;
  @MappableField(key: 'store_name')
  final String? storeName;

  static final fromMap = SiteContentConfigMapper.fromMap;
  static final fromJson = SiteContentConfigMapper.fromJson;
}

@MappableClass()
class HeroContent with HeroContentMappable {
  const HeroContent({
    this.title,
    this.description,
    this.image,
    this.ctas,
    this.background,
  });

  final String? title;
  final String? description;
  final String? image;
  final List<dynamic>? ctas;
  final String? background;

  static final fromMap = HeroContentMapper.fromMap;
  static final fromJson = HeroContentMapper.fromJson;
}

@MappableClass()
class ContactSection with ContactSectionMappable {
  const ContactSection({this.title, this.subtitle, this.icon});

  final String? title;
  final String? subtitle;
  final String? icon;

  static final fromMap = ContactSectionMapper.fromMap;
  static final fromJson = ContactSectionMapper.fromJson;
}

@MappableClass()
class Article with ArticleMappable {
  const Article({this.id, this.location, this.content, this.images});

  final String? id;
  final String? location;
  final String? content;
  final List<String>? images;

  static final fromMap = ArticleMapper.fromMap;
  static final fromJson = ArticleMapper.fromJson;
}
