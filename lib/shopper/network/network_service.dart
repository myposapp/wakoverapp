import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wakover/common/constants/config.dart';

part 'network_service.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ShopperNetworkClient {
  factory ShopperNetworkClient(Dio dio) = _ShopperNetworkClient;

  // Common

  @GET("/store/site-content")
  Future<dynamic> getSiteContent();

  @GET("/store/site-config")
  Future<dynamic> getSiteConfig();

  @GET("/store/products")
  Future<dynamic> getProducts(@Queries() Map<String, dynamic> query);

  @GET("/store/products/{productId}")
  Future<dynamic> getProduct(@Path("productId") String productId);

  @GET("/store/products/{productId}/places")
  Future<dynamic> getProductPlaces(
    @Path("productId") String productId,
    @Queries() Map<String, dynamic> query,
  );

  @GET("/store/products/{productId}/timeslots")
  Future<dynamic> getProductTimeslots(
    @Path("productId") String productId,
    @Queries() Map<String, dynamic> query,
  );

  @GET("/store/products/{productId}/reviews")
  Future<dynamic> getProductReviews(
    @Path("productId") String productId,
    @Queries() Map<String, dynamic> query,
  );

  @POST("/store/products/{productId}/reviews")
  Future<dynamic> postProductReview(
    @Path("productId") String productId,
    @Body() Map<String, dynamic> body,
  );

  @GET("/store/payment-products")
  Future<dynamic> getPaymentProducts(@Queries() Map<String, dynamic> query);

  @GET("/store/payment-products/{paymentProductId}")
  Future<dynamic> getPaymentProduct(
    @Path("paymentProductId") String paymentProductId,
  );

  @POST("/store/newsletter/subscribe")
  Future<dynamic> subscribeNewsletter(@Body() Map<String, dynamic> body);

  @GET("/store/shipping-methods")
  Future<dynamic> getShippingMethods(@Queries() Map<String, dynamic> query);

  @GET("/store/payment-gateways")
  Future<dynamic> getPaymentGateways();

  @GET("/store/validate-affiliate-code")
  Future<dynamic> validateAffiliateCode(@Query("code") String code);

  @POST("/store/calculate-service-fee")
  Future<dynamic> calculateServiceFee(@Body() Map<String, dynamic> body);

  @GET("/store/campaigns")
  Future<dynamic> getCampaigns();

  @POST("/store/campaigns/{campaignId}/click")
  Future<dynamic> logCampaignClick(@Path("campaignId") String campaignId);

  @POST("/store/campaigns/{campaignId}/view")
  Future<dynamic> logCampaignView(@Path("campaignId") String campaignId);

  @GET("/store/banks")
  Future<dynamic> getBanks();

  @GET("/store/faqs")
  Future<dynamic> getFaqs();

  @POST("/store/testimonials")
  Future<dynamic> postTestimonial(@Body() Map<String, dynamic> body);

  @POST("/store/rsvp")
  Future<dynamic> postRsvp(@Body() Map<String, dynamic> body);

  // Authentication

  @POST("/store/auth/signup")
  Future<dynamic> signUp(@Body() Map<String, dynamic> body);

  @POST("/store/auth/signin")
  Future<dynamic> signIn(@Body() Map<String, dynamic> body);

  @GET("/store/auth/profile")
  Future<dynamic> getProfile();

  @PUT("/store/auth/profile")
  Future<dynamic> updateProfile(@Body() Map<String, dynamic> body);

  @PUT("/store/auth/config")
  Future<dynamic> updateAuthConfig(@Body() Map<String, dynamic> body);

  @POST("/store/auth/signout")
  Future<dynamic> signOut();

  @POST("/store/auth/forgot-password")
  Future<dynamic> forgotPassword(@Body() Map<String, dynamic> body);

  @POST("/store/auth/validate-password-reset-token")
  Future<dynamic> validatePasswordResetToken(@Body() Map<String, dynamic> body);

  @POST("/store/auth/reset-password")
  Future<dynamic> resetPassword(@Body() Map<String, dynamic> body);

  // Multipart, because the driving license is uploaded as a file.
  @POST("/store/auth/kyc")
  Future<dynamic> submitKyc(@Body() FormData body);

  // Cart and Checkout

  @GET("/store/cart")
  Future<dynamic> getCart();

  @POST("/store/cart")
  Future<dynamic> addToCart(@Body() Map<String, dynamic> body);

  @DELETE("/store/cart")
  Future<dynamic> removeFromCart(@Body() Map<String, dynamic> body);

  @POST("/store/orders/calculate-shipping")
  Future<dynamic> calculateShipping(@Body() Map<String, dynamic> body);

  @POST("/store/validate-coupon")
  Future<dynamic> validateCoupon(@Body() Map<String, dynamic> body);

  @POST("/store/place-order")
  Future<dynamic> placeOrder(@Body() Map<String, dynamic> body);

  @GET("/store/phantom-cart/{phantomCartReference}")
  Future<dynamic> getPhantomCart(
    @Path("phantomCartReference") String phantomCartReference,
    @Queries() Map<String, dynamic> query,
  );

  @PUT("/store/phantom-cart/{phantomCartReference}/cancel")
  Future<dynamic> cancelPhantomCart(
    @Path("phantomCartReference") String phantomCartReference,
  );

  // Orders

  @GET("/store/orders")
  Future<dynamic> getOrders(@Queries() Map<String, dynamic> query);

  @GET("/store/orders/{orderId}")
  Future<dynamic> getOrder(
    @Path("orderId") String orderId,
    @Queries() Map<String, dynamic> query,
  );

  @GET("/store/platform-orders")
  Future<dynamic> getPlatformOrders(@Queries() Map<String, dynamic> query);

  @GET("/store/platform-orders/{platformOrderId}")
  Future<dynamic> getPlatformOrder(
    @Path("platformOrderId") String platformOrderId,
    @Queries() Map<String, dynamic> query,
  );

  // Bookings

  @POST("/store/book-now")
  Future<dynamic> bookNow(@Body() Map<String, dynamic> body);

  @GET("/store/bookings")
  Future<dynamic> getBookings(@Queries() Map<String, dynamic> query);

  @GET("/store/bookings/{bookingId}")
  Future<dynamic> getBooking(
    @Path("bookingId") String bookingId,
    @Queries() Map<String, dynamic> query,
  );

  @POST("/store/bookings/{bookingId}/visitors")
  Future<dynamic> addBookingVisitor(
    @Path("bookingId") String bookingId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE("/store/bookings/{bookingId}/visitors/{visitorId}")
  Future<dynamic> removeBookingVisitor(
    @Path("bookingId") String bookingId,
    @Path("visitorId") String visitorId,
  );

  // Payments

  @POST("/store/payments")
  Future<dynamic> makePayment(@Body() Map<String, dynamic> body);

  @GET("/store/payments")
  Future<dynamic> getPayments(@Queries() Map<String, dynamic> query);

  @GET("/store/payments/{paymentId}")
  Future<dynamic> getPayment(@Path("paymentId") String paymentId);

  // Digital Goods

  @GET("/store/digital-goods/categories")
  Future<dynamic> getDigitalGoodCategories(
    @Queries() Map<String, dynamic> query,
  );

  @GET("/store/digital-goods/categories/{digitalCategoryId}")
  Future<dynamic> getDigitalGoodCategory(
    @Path("digitalCategoryId") String digitalCategoryId,
  );

  @GET("/store/digital-goods")
  Future<dynamic> getDigitalGoods(@Queries() Map<String, dynamic> query);

  @GET("/store/digital-goods/{digitalGoodId}")
  Future<dynamic> getDigitalGood(@Path("digitalGoodId") String digitalGoodId);

  @GET("/store/digital-goods/{digitalGoodId}/data-packages")
  Future<dynamic> getDigitalGoodDataPackages(
    @Path("digitalGoodId") String digitalGoodId,
    @Queries() Map<String, dynamic> query,
  );

  @POST("/store/digital-goods/{digitalGoodId}/customer-account")
  Future<dynamic> validateUtilityCustomerAccount(
    @Path("digitalGoodId") String digitalGoodId,
    @Body() Map<String, dynamic> body,
  );

  @POST("/store/digital-goods/{digitalGoodId}/buy")
  Future<dynamic> buyDigitalGood(
    @Path("digitalGoodId") String digitalGoodId,
    @Body() Map<String, dynamic> body,
  );

  // Affiliate Codes

  @GET("/store/affiliate-codes")
  Future<dynamic> getAffiliateCodes(@Queries() Map<String, dynamic> query);

  @GET("/store/affiliate-codes/{affiliateCodeId}/affiliates")
  Future<dynamic> getAffiliateCodeAffiliates(
    @Path("affiliateCodeId") String affiliateCodeId,
    @Queries() Map<String, dynamic> query,
  );

  @POST("/store/affiliate-codes/request")
  Future<dynamic> requestAffiliateCode();

  // Wallet and Bank Transfers

  @GET("/store/wallet/transactions")
  Future<dynamic> getWalletTransactions(@Queries() Map<String, dynamic> query);

  @POST("/store/bank-transfers/initiate")
  Future<dynamic> initiateBankTransfer(@Body() Map<String, dynamic> body);

  @POST("/store/bank-transfers/resend-otp")
  Future<dynamic> resendBankTransferOtp(@Body() Map<String, dynamic> body);

  @POST("/store/bank-transfers/validate")
  Future<dynamic> validateBankTransfer(@Body() Map<String, dynamic> body);
}
