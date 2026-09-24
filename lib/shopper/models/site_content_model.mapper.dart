// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: invalid_use_of_protected_member
// ignore_for_file: unused_element, unnecessary_cast, override_on_non_overriding_member
// ignore_for_file: strict_raw_type, inference_failure_on_untyped_parameter

part of 'site_content_model.dart';

class SiteContentMapper extends ClassMapperBase<SiteContent> {
  SiteContentMapper._();

  static SiteContentMapper? _instance;
  static SiteContentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SiteContentMapper._());
      SiteContentConfigMapper.ensureInitialized();
      HeroContentMapper.ensureInitialized();
      ContactSectionMapper.ensureInitialized();
      ArticleMapper.ensureInitialized();
    }
    return _instance!;
  }

  @override
  final String id = 'SiteContent';

  static SiteContentConfig? _$config(SiteContent v) => v.config;
  static const Field<SiteContent, SiteContentConfig> _f$config = Field(
    'config',
    _$config,
    opt: true,
  );
  static HeroContent? _$proximHeroContent(SiteContent v) => v.proximHeroContent;
  static const Field<SiteContent, HeroContent> _f$proximHeroContent = Field(
    'proximHeroContent',
    _$proximHeroContent,
    key: r'proxim_hero_content',
    opt: true,
  );
  static dynamic _$featureSection(SiteContent v) => v.featureSection;
  static const Field<SiteContent, dynamic> _f$featureSection = Field(
    'featureSection',
    _$featureSection,
    key: r'feature_section',
    opt: true,
  );
  static List<dynamic>? _$features(SiteContent v) => v.features;
  static const Field<SiteContent, List<dynamic>> _f$features = Field(
    'features',
    _$features,
    opt: true,
  );
  static dynamic _$spiderFeatureSection(SiteContent v) =>
      v.spiderFeatureSection;
  static const Field<SiteContent, dynamic> _f$spiderFeatureSection = Field(
    'spiderFeatureSection',
    _$spiderFeatureSection,
    key: r'spider_feature_section',
    opt: true,
  );
  static List<dynamic>? _$spiderFeatures(SiteContent v) => v.spiderFeatures;
  static const Field<SiteContent, List<dynamic>> _f$spiderFeatures = Field(
    'spiderFeatures',
    _$spiderFeatures,
    key: r'spider_features',
    opt: true,
  );
  static ContactSection? _$contactSection(SiteContent v) => v.contactSection;
  static const Field<SiteContent, ContactSection> _f$contactSection = Field(
    'contactSection',
    _$contactSection,
    key: r'contact_section',
    opt: true,
  );
  static dynamic _$linkShowcase(SiteContent v) => v.linkShowcase;
  static const Field<SiteContent, dynamic> _f$linkShowcase = Field(
    'linkShowcase',
    _$linkShowcase,
    key: r'link_showcase',
    opt: true,
  );
  static List<dynamic>? _$links(SiteContent v) => v.links;
  static const Field<SiteContent, List<dynamic>> _f$links = Field(
    'links',
    _$links,
    opt: true,
  );
  static List<Article>? _$articles(SiteContent v) => v.articles;
  static const Field<SiteContent, List<Article>> _f$articles = Field(
    'articles',
    _$articles,
    opt: true,
  );
  static String? _$subFormImage(SiteContent v) => v.subFormImage;
  static const Field<SiteContent, String> _f$subFormImage = Field(
    'subFormImage',
    _$subFormImage,
    key: r'sub_form_image',
    opt: true,
  );

  @override
  final MappableFields<SiteContent> fields = const {
    #config: _f$config,
    #proximHeroContent: _f$proximHeroContent,
    #featureSection: _f$featureSection,
    #features: _f$features,
    #spiderFeatureSection: _f$spiderFeatureSection,
    #spiderFeatures: _f$spiderFeatures,
    #contactSection: _f$contactSection,
    #linkShowcase: _f$linkShowcase,
    #links: _f$links,
    #articles: _f$articles,
    #subFormImage: _f$subFormImage,
  };

  static SiteContent _instantiate(DecodingData data) {
    return SiteContent(
      config: data.dec(_f$config),
      proximHeroContent: data.dec(_f$proximHeroContent),
      featureSection: data.dec(_f$featureSection),
      features: data.dec(_f$features),
      spiderFeatureSection: data.dec(_f$spiderFeatureSection),
      spiderFeatures: data.dec(_f$spiderFeatures),
      contactSection: data.dec(_f$contactSection),
      linkShowcase: data.dec(_f$linkShowcase),
      links: data.dec(_f$links),
      articles: data.dec(_f$articles),
      subFormImage: data.dec(_f$subFormImage),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SiteContent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SiteContent>(map);
  }

  static SiteContent fromJson(String json) {
    return ensureInitialized().decodeJson<SiteContent>(json);
  }
}

mixin SiteContentMappable {
  String toJson() {
    return SiteContentMapper.ensureInitialized().encodeJson<SiteContent>(
      this as SiteContent,
    );
  }

  Map<String, dynamic> toMap() {
    return SiteContentMapper.ensureInitialized().encodeMap<SiteContent>(
      this as SiteContent,
    );
  }

  SiteContentCopyWith<SiteContent, SiteContent, SiteContent> get copyWith =>
      _SiteContentCopyWithImpl<SiteContent, SiteContent>(
        this as SiteContent,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SiteContentMapper.ensureInitialized().stringifyValue(
      this as SiteContent,
    );
  }

  @override
  bool operator ==(Object other) {
    return SiteContentMapper.ensureInitialized().equalsValue(
      this as SiteContent,
      other,
    );
  }

  @override
  int get hashCode {
    return SiteContentMapper.ensureInitialized().hashValue(this as SiteContent);
  }
}

extension SiteContentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SiteContent, $Out> {
  SiteContentCopyWith<$R, SiteContent, $Out> get $asSiteContent =>
      $base.as((v, t, t2) => _SiteContentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class SiteContentCopyWith<$R, $In extends SiteContent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  SiteContentConfigCopyWith<$R, SiteContentConfig, SiteContentConfig>?
  get config;
  HeroContentCopyWith<$R, HeroContent, HeroContent>? get proximHeroContent;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get features;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get spiderFeatures;
  ContactSectionCopyWith<$R, ContactSection, ContactSection>?
  get contactSection;
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get links;
  ListCopyWith<$R, Article, ArticleCopyWith<$R, Article, Article>>?
  get articles;
  $R call({
    SiteContentConfig? config,
    HeroContent? proximHeroContent,
    dynamic featureSection,
    List<dynamic>? features,
    dynamic spiderFeatureSection,
    List<dynamic>? spiderFeatures,
    ContactSection? contactSection,
    dynamic linkShowcase,
    List<dynamic>? links,
    List<Article>? articles,
    String? subFormImage,
  });
  SiteContentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _SiteContentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SiteContent, $Out>
    implements SiteContentCopyWith<$R, SiteContent, $Out> {
  _SiteContentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SiteContent> $mapper =
      SiteContentMapper.ensureInitialized();
  @override
  SiteContentConfigCopyWith<$R, SiteContentConfig, SiteContentConfig>?
  get config => $value.config?.copyWith.$chain((v) => call(config: v));
  @override
  HeroContentCopyWith<$R, HeroContent, HeroContent>? get proximHeroContent =>
      $value.proximHeroContent?.copyWith.$chain(
        (v) => call(proximHeroContent: v),
      );
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get features => $value.features != null
      ? ListCopyWith(
          $value.features!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(features: v),
        )
      : null;
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>?
  get spiderFeatures => $value.spiderFeatures != null
      ? ListCopyWith(
          $value.spiderFeatures!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(spiderFeatures: v),
        )
      : null;
  @override
  ContactSectionCopyWith<$R, ContactSection, ContactSection>?
  get contactSection =>
      $value.contactSection?.copyWith.$chain((v) => call(contactSection: v));
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get links =>
      $value.links != null
      ? ListCopyWith(
          $value.links!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(links: v),
        )
      : null;
  @override
  ListCopyWith<$R, Article, ArticleCopyWith<$R, Article, Article>>?
  get articles => $value.articles != null
      ? ListCopyWith(
          $value.articles!,
          (v, t) => v.copyWith.$chain(t),
          (v) => call(articles: v),
        )
      : null;
  @override
  $R call({
    Object? config = $none,
    Object? proximHeroContent = $none,
    Object? featureSection = $none,
    Object? features = $none,
    Object? spiderFeatureSection = $none,
    Object? spiderFeatures = $none,
    Object? contactSection = $none,
    Object? linkShowcase = $none,
    Object? links = $none,
    Object? articles = $none,
    Object? subFormImage = $none,
  }) => $apply(
    FieldCopyWithData({
      if (config != $none) #config: config,
      if (proximHeroContent != $none) #proximHeroContent: proximHeroContent,
      if (featureSection != $none) #featureSection: featureSection,
      if (features != $none) #features: features,
      if (spiderFeatureSection != $none)
        #spiderFeatureSection: spiderFeatureSection,
      if (spiderFeatures != $none) #spiderFeatures: spiderFeatures,
      if (contactSection != $none) #contactSection: contactSection,
      if (linkShowcase != $none) #linkShowcase: linkShowcase,
      if (links != $none) #links: links,
      if (articles != $none) #articles: articles,
      if (subFormImage != $none) #subFormImage: subFormImage,
    }),
  );
  @override
  SiteContent $make(CopyWithData data) => SiteContent(
    config: data.get(#config, or: $value.config),
    proximHeroContent: data.get(
      #proximHeroContent,
      or: $value.proximHeroContent,
    ),
    featureSection: data.get(#featureSection, or: $value.featureSection),
    features: data.get(#features, or: $value.features),
    spiderFeatureSection: data.get(
      #spiderFeatureSection,
      or: $value.spiderFeatureSection,
    ),
    spiderFeatures: data.get(#spiderFeatures, or: $value.spiderFeatures),
    contactSection: data.get(#contactSection, or: $value.contactSection),
    linkShowcase: data.get(#linkShowcase, or: $value.linkShowcase),
    links: data.get(#links, or: $value.links),
    articles: data.get(#articles, or: $value.articles),
    subFormImage: data.get(#subFormImage, or: $value.subFormImage),
  );

  @override
  SiteContentCopyWith<$R2, SiteContent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SiteContentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class SiteContentConfigMapper extends ClassMapperBase<SiteContentConfig> {
  SiteContentConfigMapper._();

  static SiteContentConfigMapper? _instance;
  static SiteContentConfigMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = SiteContentConfigMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'SiteContentConfig';

  static String? _$template(SiteContentConfig v) => v.template;
  static const Field<SiteContentConfig, String> _f$template = Field(
    'template',
    _$template,
    opt: true,
  );
  static String? _$companyId(SiteContentConfig v) => v.companyId;
  static const Field<SiteContentConfig, String> _f$companyId = Field(
    'companyId',
    _$companyId,
    key: r'company_id',
    opt: true,
  );
  static String? _$merchantId(SiteContentConfig v) => v.merchantId;
  static const Field<SiteContentConfig, String> _f$merchantId = Field(
    'merchantId',
    _$merchantId,
    key: r'merchant_id',
    opt: true,
  );
  static String? _$storeName(SiteContentConfig v) => v.storeName;
  static const Field<SiteContentConfig, String> _f$storeName = Field(
    'storeName',
    _$storeName,
    key: r'store_name',
    opt: true,
  );

  @override
  final MappableFields<SiteContentConfig> fields = const {
    #template: _f$template,
    #companyId: _f$companyId,
    #merchantId: _f$merchantId,
    #storeName: _f$storeName,
  };

  static SiteContentConfig _instantiate(DecodingData data) {
    return SiteContentConfig(
      template: data.dec(_f$template),
      companyId: data.dec(_f$companyId),
      merchantId: data.dec(_f$merchantId),
      storeName: data.dec(_f$storeName),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static SiteContentConfig fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<SiteContentConfig>(map);
  }

  static SiteContentConfig fromJson(String json) {
    return ensureInitialized().decodeJson<SiteContentConfig>(json);
  }
}

mixin SiteContentConfigMappable {
  String toJson() {
    return SiteContentConfigMapper.ensureInitialized()
        .encodeJson<SiteContentConfig>(this as SiteContentConfig);
  }

  Map<String, dynamic> toMap() {
    return SiteContentConfigMapper.ensureInitialized()
        .encodeMap<SiteContentConfig>(this as SiteContentConfig);
  }

  SiteContentConfigCopyWith<
    SiteContentConfig,
    SiteContentConfig,
    SiteContentConfig
  >
  get copyWith =>
      _SiteContentConfigCopyWithImpl<SiteContentConfig, SiteContentConfig>(
        this as SiteContentConfig,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return SiteContentConfigMapper.ensureInitialized().stringifyValue(
      this as SiteContentConfig,
    );
  }

  @override
  bool operator ==(Object other) {
    return SiteContentConfigMapper.ensureInitialized().equalsValue(
      this as SiteContentConfig,
      other,
    );
  }

  @override
  int get hashCode {
    return SiteContentConfigMapper.ensureInitialized().hashValue(
      this as SiteContentConfig,
    );
  }
}

extension SiteContentConfigValueCopy<$R, $Out>
    on ObjectCopyWith<$R, SiteContentConfig, $Out> {
  SiteContentConfigCopyWith<$R, SiteContentConfig, $Out>
  get $asSiteContentConfig => $base.as(
    (v, t, t2) => _SiteContentConfigCopyWithImpl<$R, $Out>(v, t, t2),
  );
}

abstract class SiteContentConfigCopyWith<
  $R,
  $In extends SiteContentConfig,
  $Out
>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({
    String? template,
    String? companyId,
    String? merchantId,
    String? storeName,
  });
  SiteContentConfigCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _SiteContentConfigCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, SiteContentConfig, $Out>
    implements SiteContentConfigCopyWith<$R, SiteContentConfig, $Out> {
  _SiteContentConfigCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<SiteContentConfig> $mapper =
      SiteContentConfigMapper.ensureInitialized();
  @override
  $R call({
    Object? template = $none,
    Object? companyId = $none,
    Object? merchantId = $none,
    Object? storeName = $none,
  }) => $apply(
    FieldCopyWithData({
      if (template != $none) #template: template,
      if (companyId != $none) #companyId: companyId,
      if (merchantId != $none) #merchantId: merchantId,
      if (storeName != $none) #storeName: storeName,
    }),
  );
  @override
  SiteContentConfig $make(CopyWithData data) => SiteContentConfig(
    template: data.get(#template, or: $value.template),
    companyId: data.get(#companyId, or: $value.companyId),
    merchantId: data.get(#merchantId, or: $value.merchantId),
    storeName: data.get(#storeName, or: $value.storeName),
  );

  @override
  SiteContentConfigCopyWith<$R2, SiteContentConfig, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _SiteContentConfigCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class HeroContentMapper extends ClassMapperBase<HeroContent> {
  HeroContentMapper._();

  static HeroContentMapper? _instance;
  static HeroContentMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = HeroContentMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'HeroContent';

  static String? _$title(HeroContent v) => v.title;
  static const Field<HeroContent, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
  );
  static String? _$description(HeroContent v) => v.description;
  static const Field<HeroContent, String> _f$description = Field(
    'description',
    _$description,
    opt: true,
  );
  static String? _$image(HeroContent v) => v.image;
  static const Field<HeroContent, String> _f$image = Field(
    'image',
    _$image,
    opt: true,
  );
  static List<dynamic>? _$ctas(HeroContent v) => v.ctas;
  static const Field<HeroContent, List<dynamic>> _f$ctas = Field(
    'ctas',
    _$ctas,
    opt: true,
  );
  static String? _$background(HeroContent v) => v.background;
  static const Field<HeroContent, String> _f$background = Field(
    'background',
    _$background,
    opt: true,
  );

  @override
  final MappableFields<HeroContent> fields = const {
    #title: _f$title,
    #description: _f$description,
    #image: _f$image,
    #ctas: _f$ctas,
    #background: _f$background,
  };

  static HeroContent _instantiate(DecodingData data) {
    return HeroContent(
      title: data.dec(_f$title),
      description: data.dec(_f$description),
      image: data.dec(_f$image),
      ctas: data.dec(_f$ctas),
      background: data.dec(_f$background),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static HeroContent fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<HeroContent>(map);
  }

  static HeroContent fromJson(String json) {
    return ensureInitialized().decodeJson<HeroContent>(json);
  }
}

mixin HeroContentMappable {
  String toJson() {
    return HeroContentMapper.ensureInitialized().encodeJson<HeroContent>(
      this as HeroContent,
    );
  }

  Map<String, dynamic> toMap() {
    return HeroContentMapper.ensureInitialized().encodeMap<HeroContent>(
      this as HeroContent,
    );
  }

  HeroContentCopyWith<HeroContent, HeroContent, HeroContent> get copyWith =>
      _HeroContentCopyWithImpl<HeroContent, HeroContent>(
        this as HeroContent,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return HeroContentMapper.ensureInitialized().stringifyValue(
      this as HeroContent,
    );
  }

  @override
  bool operator ==(Object other) {
    return HeroContentMapper.ensureInitialized().equalsValue(
      this as HeroContent,
      other,
    );
  }

  @override
  int get hashCode {
    return HeroContentMapper.ensureInitialized().hashValue(this as HeroContent);
  }
}

extension HeroContentValueCopy<$R, $Out>
    on ObjectCopyWith<$R, HeroContent, $Out> {
  HeroContentCopyWith<$R, HeroContent, $Out> get $asHeroContent =>
      $base.as((v, t, t2) => _HeroContentCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class HeroContentCopyWith<$R, $In extends HeroContent, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get ctas;
  $R call({
    String? title,
    String? description,
    String? image,
    List<dynamic>? ctas,
    String? background,
  });
  HeroContentCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _HeroContentCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, HeroContent, $Out>
    implements HeroContentCopyWith<$R, HeroContent, $Out> {
  _HeroContentCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<HeroContent> $mapper =
      HeroContentMapper.ensureInitialized();
  @override
  ListCopyWith<$R, dynamic, ObjectCopyWith<$R, dynamic, dynamic>?>? get ctas =>
      $value.ctas != null
      ? ListCopyWith(
          $value.ctas!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(ctas: v),
        )
      : null;
  @override
  $R call({
    Object? title = $none,
    Object? description = $none,
    Object? image = $none,
    Object? ctas = $none,
    Object? background = $none,
  }) => $apply(
    FieldCopyWithData({
      if (title != $none) #title: title,
      if (description != $none) #description: description,
      if (image != $none) #image: image,
      if (ctas != $none) #ctas: ctas,
      if (background != $none) #background: background,
    }),
  );
  @override
  HeroContent $make(CopyWithData data) => HeroContent(
    title: data.get(#title, or: $value.title),
    description: data.get(#description, or: $value.description),
    image: data.get(#image, or: $value.image),
    ctas: data.get(#ctas, or: $value.ctas),
    background: data.get(#background, or: $value.background),
  );

  @override
  HeroContentCopyWith<$R2, HeroContent, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _HeroContentCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ContactSectionMapper extends ClassMapperBase<ContactSection> {
  ContactSectionMapper._();

  static ContactSectionMapper? _instance;
  static ContactSectionMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ContactSectionMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'ContactSection';

  static String? _$title(ContactSection v) => v.title;
  static const Field<ContactSection, String> _f$title = Field(
    'title',
    _$title,
    opt: true,
  );
  static String? _$subtitle(ContactSection v) => v.subtitle;
  static const Field<ContactSection, String> _f$subtitle = Field(
    'subtitle',
    _$subtitle,
    opt: true,
  );
  static String? _$icon(ContactSection v) => v.icon;
  static const Field<ContactSection, String> _f$icon = Field(
    'icon',
    _$icon,
    opt: true,
  );

  @override
  final MappableFields<ContactSection> fields = const {
    #title: _f$title,
    #subtitle: _f$subtitle,
    #icon: _f$icon,
  };

  static ContactSection _instantiate(DecodingData data) {
    return ContactSection(
      title: data.dec(_f$title),
      subtitle: data.dec(_f$subtitle),
      icon: data.dec(_f$icon),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static ContactSection fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<ContactSection>(map);
  }

  static ContactSection fromJson(String json) {
    return ensureInitialized().decodeJson<ContactSection>(json);
  }
}

mixin ContactSectionMappable {
  String toJson() {
    return ContactSectionMapper.ensureInitialized().encodeJson<ContactSection>(
      this as ContactSection,
    );
  }

  Map<String, dynamic> toMap() {
    return ContactSectionMapper.ensureInitialized().encodeMap<ContactSection>(
      this as ContactSection,
    );
  }

  ContactSectionCopyWith<ContactSection, ContactSection, ContactSection>
  get copyWith => _ContactSectionCopyWithImpl<ContactSection, ContactSection>(
    this as ContactSection,
    $identity,
    $identity,
  );
  @override
  String toString() {
    return ContactSectionMapper.ensureInitialized().stringifyValue(
      this as ContactSection,
    );
  }

  @override
  bool operator ==(Object other) {
    return ContactSectionMapper.ensureInitialized().equalsValue(
      this as ContactSection,
      other,
    );
  }

  @override
  int get hashCode {
    return ContactSectionMapper.ensureInitialized().hashValue(
      this as ContactSection,
    );
  }
}

extension ContactSectionValueCopy<$R, $Out>
    on ObjectCopyWith<$R, ContactSection, $Out> {
  ContactSectionCopyWith<$R, ContactSection, $Out> get $asContactSection =>
      $base.as((v, t, t2) => _ContactSectionCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ContactSectionCopyWith<$R, $In extends ContactSection, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  $R call({String? title, String? subtitle, String? icon});
  ContactSectionCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  );
}

class _ContactSectionCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, ContactSection, $Out>
    implements ContactSectionCopyWith<$R, ContactSection, $Out> {
  _ContactSectionCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<ContactSection> $mapper =
      ContactSectionMapper.ensureInitialized();
  @override
  $R call({
    Object? title = $none,
    Object? subtitle = $none,
    Object? icon = $none,
  }) => $apply(
    FieldCopyWithData({
      if (title != $none) #title: title,
      if (subtitle != $none) #subtitle: subtitle,
      if (icon != $none) #icon: icon,
    }),
  );
  @override
  ContactSection $make(CopyWithData data) => ContactSection(
    title: data.get(#title, or: $value.title),
    subtitle: data.get(#subtitle, or: $value.subtitle),
    icon: data.get(#icon, or: $value.icon),
  );

  @override
  ContactSectionCopyWith<$R2, ContactSection, $Out2> $chain<$R2, $Out2>(
    Then<$Out2, $R2> t,
  ) => _ContactSectionCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

class ArticleMapper extends ClassMapperBase<Article> {
  ArticleMapper._();

  static ArticleMapper? _instance;
  static ArticleMapper ensureInitialized() {
    if (_instance == null) {
      MapperContainer.globals.use(_instance = ArticleMapper._());
    }
    return _instance!;
  }

  @override
  final String id = 'Article';

  static String? _$id(Article v) => v.id;
  static const Field<Article, String> _f$id = Field('id', _$id, opt: true);
  static String? _$location(Article v) => v.location;
  static const Field<Article, String> _f$location = Field(
    'location',
    _$location,
    opt: true,
  );
  static String? _$content(Article v) => v.content;
  static const Field<Article, String> _f$content = Field(
    'content',
    _$content,
    opt: true,
  );
  static List<String>? _$images(Article v) => v.images;
  static const Field<Article, List<String>> _f$images = Field(
    'images',
    _$images,
    opt: true,
  );

  @override
  final MappableFields<Article> fields = const {
    #id: _f$id,
    #location: _f$location,
    #content: _f$content,
    #images: _f$images,
  };

  static Article _instantiate(DecodingData data) {
    return Article(
      id: data.dec(_f$id),
      location: data.dec(_f$location),
      content: data.dec(_f$content),
      images: data.dec(_f$images),
    );
  }

  @override
  final Function instantiate = _instantiate;

  static Article fromMap(Map<String, dynamic> map) {
    return ensureInitialized().decodeMap<Article>(map);
  }

  static Article fromJson(String json) {
    return ensureInitialized().decodeJson<Article>(json);
  }
}

mixin ArticleMappable {
  String toJson() {
    return ArticleMapper.ensureInitialized().encodeJson<Article>(
      this as Article,
    );
  }

  Map<String, dynamic> toMap() {
    return ArticleMapper.ensureInitialized().encodeMap<Article>(
      this as Article,
    );
  }

  ArticleCopyWith<Article, Article, Article> get copyWith =>
      _ArticleCopyWithImpl<Article, Article>(
        this as Article,
        $identity,
        $identity,
      );
  @override
  String toString() {
    return ArticleMapper.ensureInitialized().stringifyValue(this as Article);
  }

  @override
  bool operator ==(Object other) {
    return ArticleMapper.ensureInitialized().equalsValue(
      this as Article,
      other,
    );
  }

  @override
  int get hashCode {
    return ArticleMapper.ensureInitialized().hashValue(this as Article);
  }
}

extension ArticleValueCopy<$R, $Out> on ObjectCopyWith<$R, Article, $Out> {
  ArticleCopyWith<$R, Article, $Out> get $asArticle =>
      $base.as((v, t, t2) => _ArticleCopyWithImpl<$R, $Out>(v, t, t2));
}

abstract class ArticleCopyWith<$R, $In extends Article, $Out>
    implements ClassCopyWith<$R, $In, $Out> {
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get images;
  $R call({
    String? id,
    String? location,
    String? content,
    List<String>? images,
  });
  ArticleCopyWith<$R2, $In, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t);
}

class _ArticleCopyWithImpl<$R, $Out>
    extends ClassCopyWithBase<$R, Article, $Out>
    implements ArticleCopyWith<$R, Article, $Out> {
  _ArticleCopyWithImpl(super.value, super.then, super.then2);

  @override
  late final ClassMapperBase<Article> $mapper =
      ArticleMapper.ensureInitialized();
  @override
  ListCopyWith<$R, String, ObjectCopyWith<$R, String, String>>? get images =>
      $value.images != null
      ? ListCopyWith(
          $value.images!,
          (v, t) => ObjectCopyWith(v, $identity, t),
          (v) => call(images: v),
        )
      : null;
  @override
  $R call({
    Object? id = $none,
    Object? location = $none,
    Object? content = $none,
    Object? images = $none,
  }) => $apply(
    FieldCopyWithData({
      if (id != $none) #id: id,
      if (location != $none) #location: location,
      if (content != $none) #content: content,
      if (images != $none) #images: images,
    }),
  );
  @override
  Article $make(CopyWithData data) => Article(
    id: data.get(#id, or: $value.id),
    location: data.get(#location, or: $value.location),
    content: data.get(#content, or: $value.content),
    images: data.get(#images, or: $value.images),
  );

  @override
  ArticleCopyWith<$R2, Article, $Out2> $chain<$R2, $Out2>(Then<$Out2, $R2> t) =>
      _ArticleCopyWithImpl<$R2, $Out2>($value, $cast, t);
}

