// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
// ignore_for_file: type=lint
// ignore_for_file: unused_element

import 'common/network/model/base_api_response.dart' as p0;
import 'common/network/model/paginated_response.dart' as p1;
import 'shopper/models/affiliate_code_model.dart' as p2;
import 'shopper/models/auth_config_model.dart' as p3;
import 'shopper/models/bank_model.dart' as p4;
import 'shopper/models/bank_transfer_model.dart' as p5;
import 'shopper/models/booking_model.dart' as p6;
import 'shopper/models/cart_model.dart' as p7;
import 'shopper/models/digital_good_model.dart' as p8;
import 'shopper/models/merchant_info_model.dart' as p9;
import 'shopper/models/payment_gateway_model.dart' as p10;
import 'shopper/models/payment_model.dart' as p11;
import 'shopper/models/platform_order_model.dart' as p12;
import 'shopper/models/product_category_model.dart' as p13;
import 'shopper/models/product_image_model.dart' as p14;
import 'shopper/models/product_review_model.dart' as p15;
import 'shopper/models/service_fee_model.dart' as p16;
import 'shopper/models/shipping_method_model.dart' as p17;
import 'shopper/models/shopper_user_model.dart' as p18;
import 'shopper/models/site_config_model.dart' as p19;
import 'shopper/models/site_content_model.dart' as p20;
import 'shopper/models/store_order_model.dart' as p21;
import 'shopper/models/store_product_model.dart' as p22;
import 'shopper/models/testimonial_model.dart' as p23;
import 'shopper/models/utility_customer_account_model.dart' as p24;
import 'shopper/models/wallet_transaction_model.dart' as p25;

void initializeMappers() {
  p0.BaseResponseMapper.ensureInitialized();
  p1.PaginationMetaMapper.ensureInitialized();
  p1.PaginatedResponseMapper.ensureInitialized();
  p2.AffiliateProductMapper.ensureInitialized();
  p2.AffiliateCodeMapper.ensureInitialized();
  p3.AuthConfigDataMapper.ensureInitialized();
  p4.BankMapper.ensureInitialized();
  p5.BankTransferRequestMapper.ensureInitialized();
  p6.BookingPlaceMapper.ensureInitialized();
  p6.BookingVisitorMapper.ensureInitialized();
  p6.BookingMapper.ensureInitialized();
  p7.CartItemMapper.ensureInitialized();
  p7.CartMapper.ensureInitialized();
  p8.DigitalGoodMapper.ensureInitialized();
  p9.MerchantBranchMapper.ensureInitialized();
  p9.MerchantInfoMapper.ensureInitialized();
  p10.PaymentGatewayFeeMapper.ensureInitialized();
  p10.PaymentGatewayMapper.ensureInitialized();
  p11.PaymentProductSummaryMapper.ensureInitialized();
  p11.StorePaymentMapper.ensureInitialized();
  p12.PlatformOrderProductMapper.ensureInitialized();
  p12.PlatformOrderMapper.ensureInitialized();
  p13.ProductCategoryMapper.ensureInitialized();
  p14.ProductImageMapper.ensureInitialized();
  p15.ProductReviewMapper.ensureInitialized();
  p16.ServiceFeeResultMapper.ensureInitialized();
  p17.ShippingMethodMapper.ensureInitialized();
  p17.ShippingMethodsDataMapper.ensureInitialized();
  p18.KycMapper.ensureInitialized();
  p18.ShopperUserMapper.ensureInitialized();
  p19.SiteConfigMapper.ensureInitialized();
  p19.CurrencyMapper.ensureInitialized();
  p19.PointGiveawayMapper.ensureInitialized();
  p19.SocialMapper.ensureInitialized();
  p20.SiteContentMapper.ensureInitialized();
  p20.SiteContentConfigMapper.ensureInitialized();
  p20.HeroContentMapper.ensureInitialized();
  p20.ContactSectionMapper.ensureInitialized();
  p20.ArticleMapper.ensureInitialized();
  p20.HeroSlideMapper.ensureInitialized();
  p20.PromoBannerMapper.ensureInitialized();
  p20.SpecialPickMapper.ensureInitialized();
  p21.StoreOrderItemMapper.ensureInitialized();
  p21.ShippingAddressMapper.ensureInitialized();
  p21.ShippingDetailMapper.ensureInitialized();
  p21.DeliveryStatusMapper.ensureInitialized();
  p21.StoreOrderMapper.ensureInitialized();
  p22.ProductVariantMapper.ensureInitialized();
  p22.ProductDiscountMapper.ensureInitialized();
  p22.ProductReviewSummaryMapper.ensureInitialized();
  p22.ProductBoxItemMapper.ensureInitialized();
  p22.StoreProductMapper.ensureInitialized();
  p23.TestimonialMapper.ensureInitialized();
  p24.UtilityCustomerAccountMapper.ensureInitialized();
  p25.WalletTransactionMapper.ensureInitialized();
}

