import '../../common/network/model/base_api_response.dart';
import '../../common/network/model/paginated_response.dart';
import '../models/affiliate_code_model.dart';
import '../models/auth_config_model.dart';
import '../models/bank_model.dart';
import '../models/bank_transfer_model.dart';
import '../models/booking_model.dart';
import '../models/cart_model.dart';
import '../models/digital_good_model.dart';
import '../models/payment_gateway_model.dart';
import '../models/payment_model.dart';
import '../models/platform_order_model.dart';
import '../models/product_category_model.dart';
import '../models/product_review_model.dart';
import '../models/service_fee_model.dart';
import '../models/shipping_method_model.dart';
import '../models/shopper_user_model.dart';
import '../models/site_config_model.dart';
import '../models/site_content_model.dart';
import '../models/store_order_model.dart';
import '../models/store_product_model.dart';
import '../models/testimonial_model.dart';
import '../models/utility_customer_account_model.dart';
import '../models/wallet_transaction_model.dart';
import 'network_service.dart';

class ShopperNetworkRepo {
  ShopperNetworkRepo(this._client);

  final ShopperNetworkClient _client;

  // Common

  Future<BaseResponse<SiteContent>> getSiteContent() async {
    final response = await _client.getSiteContent() as Map<String, dynamic>;
    return BaseResponse.fromMap<SiteContent>(response);
  }

  Future<BaseResponse<SiteConfig>> getSiteConfig() async {
    final response = await _client.getSiteConfig() as Map<String, dynamic>;
    return BaseResponse.fromMap<SiteConfig>(response);
  }

  Future<PaginatedResponse<StoreProduct>> getProducts({
    int page = 0,
    int pageSize = 20,
    String? search,
    String? sort,
  }) async {
    final query = {
      "page": page,
      "pageSize": pageSize,
      if (search != null) "search": search,
      if (sort != null) "sort": sort,
    };

    final response = await _client.getProducts(query) as Map<String, dynamic>;
    return PaginatedResponse.fromMap<StoreProduct>(response);
  }

  Future<BaseResponse<StoreProduct>> getProduct(String productId) async {
    final response = await _client.getProduct(productId) as Map<String, dynamic>;
    return BaseResponse.fromMap<StoreProduct>(response);
  }

  Future<BaseResponse<dynamic>> getProductPlaces(
    String productId, {
    String? startDate,
    String? endDate,
  }) async {
    final query = {
      if (startDate != null) "start_date": startDate,
      if (endDate != null) "end_date": endDate,
    };

    final response =
        await _client.getProductPlaces(productId, query) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<dynamic>> getProductTimeslots(
    String productId, {
    String? date,
    int? timezoneOffset,
  }) async {
    final query = {
      if (date != null) "date": date,
      if (timezoneOffset != null) "timezone_offset": timezoneOffset,
    };

    final response =
        await _client.getProductTimeslots(productId, query)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<PaginatedResponse<ProductReview>> getProductReviews(
    String productId, {
    int page = 0,
    int pageSize = 10,
  }) async {
    final query = {"page": page, "pageSize": pageSize};

    final response =
        await _client.getProductReviews(productId, query)
            as Map<String, dynamic>;
    return PaginatedResponse.fromMap<ProductReview>(response);
  }

  Future<BaseResponse<dynamic>> postProductReview(
    String productId, {
    required int rating,
    required String comment,
  }) async {
    final body = {"rating": rating, "comment": comment};

    final response =
        await _client.postProductReview(productId, body) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<List<dynamic>>> getPaymentProducts({
    String? branchId,
  }) async {
    final query = {if (branchId != null) "branch_id": branchId};

    final response =
        await _client.getPaymentProducts(query) as Map<String, dynamic>;
    return BaseResponse.fromMap<List<dynamic>>(response);
  }

  Future<BaseResponse<dynamic>> getPaymentProduct(
    String paymentProductId,
  ) async {
    final response =
        await _client.getPaymentProduct(paymentProductId)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<void>> subscribeNewsletter({
    required String name,
    required String phone,
    required String email,
  }) async {
    final body = {"name": name, "phone": phone, "email": email};

    final response =
        await _client.subscribeNewsletter(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<void>(response);
  }

  Future<BaseResponse<ShippingMethodsData>> getShippingMethods({
    String? state,
    String? county,
  }) async {
    final query = {
      if (state != null) "state": state,
      if (county != null) "county": county,
    };

    final response =
        await _client.getShippingMethods(query) as Map<String, dynamic>;
    return BaseResponse.fromMap<ShippingMethodsData>(response);
  }

  Future<BaseResponse<List<PaymentGateway>>> getPaymentGateways() async {
    final response = await _client.getPaymentGateways() as Map<String, dynamic>;
    return BaseResponse.fromMap<List<PaymentGateway>>(response);
  }

  Future<BaseResponse<dynamic>> validateAffiliateCode(String code) async {
    final response =
        await _client.validateAffiliateCode(code) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<ServiceFeeResult>> calculateServiceFee({
    required int amount,
    required String paymentMethod,
    String? branchId,
  }) async {
    final body = {
      "amount": amount,
      "payment_method": paymentMethod,
      if (branchId != null) "branch_id": branchId,
    };

    final response =
        await _client.calculateServiceFee(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<ServiceFeeResult>(response);
  }

  Future<BaseResponse<List<dynamic>>> getCampaigns() async {
    final response = await _client.getCampaigns() as Map<String, dynamic>;
    return BaseResponse.fromMap<List<dynamic>>(response);
  }

  Future<BaseResponse<void>> logCampaignClick(String campaignId) async {
    final response =
        await _client.logCampaignClick(campaignId) as Map<String, dynamic>;
    return BaseResponse.fromMap<void>(response);
  }

  Future<BaseResponse<void>> logCampaignView(String campaignId) async {
    final response =
        await _client.logCampaignView(campaignId) as Map<String, dynamic>;
    return BaseResponse.fromMap<void>(response);
  }

  Future<BaseResponse<List<Bank>>> getBanks() async {
    final response = await _client.getBanks() as Map<String, dynamic>;
    return BaseResponse.fromMap<List<Bank>>(response);
  }

  Future<BaseResponse<List<dynamic>>> getFaqs() async {
    final response = await _client.getFaqs() as Map<String, dynamic>;
    return BaseResponse.fromMap<List<dynamic>>(response);
  }

  Future<BaseResponse<Testimonial>> postTestimonial({
    required String name,
    required String role,
    required String comment,
  }) async {
    final body = {"name": name, "role": role, "comment": comment};

    final response = await _client.postTestimonial(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<Testimonial>(response);
  }

  Future<BaseResponse<void>> postRsvp({
    required String name,
    required String phone,
    required String email,
    String? relation,
    String? address,
  }) async {
    final body = {
      "name": name,
      "phone": phone,
      "email": email,
      if (relation != null) "relation": relation,
      if (address != null) "address": address,
    };

    final response = await _client.postRsvp(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<void>(response);
  }

  // Authentication

  Future<BaseResponse<ShopperUser>> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) async {
    final body = {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
    };

    final response = await _client.signUp(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<ShopperUser>(response);
  }

  /// Signs in with either an email or a phone number (E.164).
  Future<BaseResponse<ShopperUser>> signIn({
    String? email,
    String? phone,
    required String password,
  }) async {
    final body = {
      if (email != null) "email": email,
      if (phone != null) "phone": phone,
      "password": password,
    };

    final response = await _client.signIn(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<ShopperUser>(response);
  }

  Future<BaseResponse<ShopperUser>> getProfile() async {
    final response = await _client.getProfile() as Map<String, dynamic>;
    return BaseResponse.fromMap<ShopperUser>(response);
  }

  Future<BaseResponse<ShopperUser>> updateProfile({
    String? name,
    String? phone,
    String? email,
    String? oldPassword,
    String? newPassword,
  }) async {
    final body = {
      if (name != null) "name": name,
      if (phone != null) "phone": phone,
      if (email != null) "email": email,
      if (oldPassword != null) "old_password": oldPassword,
      if (newPassword != null) "new_password": newPassword,
    };

    final response = await _client.updateProfile(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<ShopperUser>(response);
  }

  Future<BaseResponse<AuthConfigData>> updateAuthConfig({
    required bool showMerchantCampaigns,
  }) async {
    final body = {"show_merchant_campaigns": showMerchantCampaigns};

    final response =
        await _client.updateAuthConfig(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<AuthConfigData>(response);
  }

  Future<BaseResponse<void>> signOut() async {
    final response = await _client.signOut() as Map<String, dynamic>;
    return BaseResponse.fromMap<void>(response);
  }

  Future<BaseResponse<dynamic>> forgotPassword(String email) async {
    final response =
        await _client.forgotPassword({"email": email}) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<dynamic>> validatePasswordResetToken(String token) async {
    final response =
        await _client.validatePasswordResetToken({"token": token})
            as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<dynamic>> resetPassword({
    required String token,
    required String password,
  }) async {
    final body = {"token": token, "password": password};

    final response = await _client.resetPassword(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<dynamic>> submitKyc(Map<String, dynamic> body) async {
    final response = await _client.submitKyc(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  // Cart and Checkout

  Future<BaseResponse<Cart>> getCart() async {
    final response = await _client.getCart() as Map<String, dynamic>;
    return BaseResponse.fromMap<Cart>(response);
  }

  Future<BaseResponse<Cart>> addToCart({
    required String productId,
    String? variantId,
    int quantity = 1,
  }) async {
    final body = {
      "product_id": productId,
      if (variantId != null) "variant_id": variantId,
      "quantity": quantity,
    };

    final response = await _client.addToCart(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<Cart>(response);
  }

  Future<BaseResponse<Cart>> removeFromCart({
    required String productId,
    String? variantId,
    bool removeAll = false,
  }) async {
    final body = {
      "product_id": productId,
      if (variantId != null) "variant_id": variantId,
      "removeAll": removeAll,
    };

    final response = await _client.removeFromCart(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<Cart>(response);
  }

  Future<BaseResponse<num>> calculateShipping({
    required String shippingMethodId,
    required String state,
    required String county,
    double? weight,
  }) async {
    final body = {
      "shipping_method_id": shippingMethodId,
      "state": state,
      "county": county,
      if (weight != null) "weight": weight,
    };

    final response =
        await _client.calculateShipping(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<num>(response);
  }

  Future<BaseResponse<dynamic>> validateCoupon({
    required String code,
    required int cartPrice,
  }) async {
    final body = {"code": code, "cart_price": cartPrice};

    final response = await _client.validateCoupon(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<dynamic>> placeOrder(Map<String, dynamic> body) async {
    final response = await _client.placeOrder(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<dynamic>> getPhantomCart(
    String phantomCartReference, {
    bool? requery,
  }) async {
    final query = {if (requery != null) "requery": requery};

    final response =
        await _client.getPhantomCart(phantomCartReference, query)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<dynamic>> cancelPhantomCart(
    String phantomCartReference,
  ) async {
    final response =
        await _client.cancelPhantomCart(phantomCartReference)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  // Orders

  Future<PaginatedResponse<StoreOrder>> getOrders({
    int page = 0,
    int pageSize = 10,
  }) async {
    final query = {"page": page, "pageSize": pageSize};

    final response = await _client.getOrders(query) as Map<String, dynamic>;
    return PaginatedResponse.fromMap<StoreOrder>(response);
  }

  Future<BaseResponse<dynamic>> getOrder(String orderId, {bool? requery}) async {
    final query = {if (requery != null) "requery": requery};

    final response =
        await _client.getOrder(orderId, query) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<PaginatedResponse<PlatformOrder>> getPlatformOrders({
    int page = 0,
    int pageSize = 10,
  }) async {
    final query = {"page": page, "pageSize": pageSize};

    final response =
        await _client.getPlatformOrders(query) as Map<String, dynamic>;
    return PaginatedResponse.fromMap<PlatformOrder>(response);
  }

  Future<BaseResponse<PlatformOrder>> getPlatformOrder(
    String platformOrderId, {
    bool? requery,
  }) async {
    final query = {if (requery != null) "requery": requery};

    final response =
        await _client.getPlatformOrder(platformOrderId, query)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<PlatformOrder>(response);
  }

  // Bookings

  Future<BaseResponse<dynamic>> bookNow(Map<String, dynamic> body) async {
    final response = await _client.bookNow(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<PaginatedResponse<Booking>> getBookings({
    int page = 0,
    int pageSize = 10,
  }) async {
    final query = {"page": page, "pageSize": pageSize};

    final response = await _client.getBookings(query) as Map<String, dynamic>;
    return PaginatedResponse.fromMap<Booking>(response);
  }

  Future<BaseResponse<dynamic>> getBooking(
    String bookingId, {
    bool? requery,
  }) async {
    final query = {if (requery != null) "requery": requery};

    final response =
        await _client.getBooking(bookingId, query) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<BookingVisitor>> addBookingVisitor(
    String bookingId, {
    required String name,
    required String phone,
    required String dateTime,
    String? email,
    String? description,
  }) async {
    final body = {
      "name": name,
      "phone": phone,
      "date_time": dateTime,
      if (email != null) "email": email,
      if (description != null) "description": description,
    };

    final response =
        await _client.addBookingVisitor(bookingId, body) as Map<String, dynamic>;
    return BaseResponse.fromMap<BookingVisitor>(response);
  }

  Future<BaseResponse<dynamic>> removeBookingVisitor(
    String bookingId,
    String visitorId,
  ) async {
    final response =
        await _client.removeBookingVisitor(bookingId, visitorId)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  // Payments

  Future<BaseResponse<dynamic>> makePayment(Map<String, dynamic> body) async {
    final response = await _client.makePayment(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  Future<PaginatedResponse<StorePayment>> getPayments({
    int page = 0,
    int pageSize = 10,
  }) async {
    final query = {"page": page, "pageSize": pageSize};

    final response = await _client.getPayments(query) as Map<String, dynamic>;
    return PaginatedResponse.fromMap<StorePayment>(response);
  }

  Future<BaseResponse<dynamic>> getPayment(String paymentId) async {
    final response = await _client.getPayment(paymentId) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  // Digital Goods

  Future<BaseResponse<List<ProductCategory>>> getDigitalGoodCategories({
    String? name,
  }) async {
    final query = {if (name != null) "name": name};

    final response =
        await _client.getDigitalGoodCategories(query) as Map<String, dynamic>;
    return BaseResponse.fromMap<List<ProductCategory>>(response);
  }

  Future<BaseResponse<ProductCategory>> getDigitalGoodCategory(
    String digitalCategoryId,
  ) async {
    final response =
        await _client.getDigitalGoodCategory(digitalCategoryId)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<ProductCategory>(response);
  }

  Future<BaseResponse<List<DigitalGood>>> getDigitalGoods({
    String? categoryName,
  }) async {
    final query = {if (categoryName != null) "category_name": categoryName};

    final response =
        await _client.getDigitalGoods(query) as Map<String, dynamic>;
    return BaseResponse.fromMap<List<DigitalGood>>(response);
  }

  Future<BaseResponse<DigitalGood>> getDigitalGood(String digitalGoodId) async {
    final response =
        await _client.getDigitalGood(digitalGoodId) as Map<String, dynamic>;
    return BaseResponse.fromMap<DigitalGood>(response);
  }

  Future<BaseResponse<List<dynamic>>> getDigitalGoodDataPackages(
    String digitalGoodId, {
    String? phone,
  }) async {
    final query = {if (phone != null) "phone": phone};

    final response =
        await _client.getDigitalGoodDataPackages(digitalGoodId, query)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<List<dynamic>>(response);
  }

  Future<BaseResponse<UtilityCustomerAccount>> validateUtilityCustomerAccount(
    String digitalGoodId, {
    required String meterNo,
    required String meterType,
  }) async {
    final body = {"meter_no": meterNo, "meter_type": meterType};

    final response =
        await _client.validateUtilityCustomerAccount(digitalGoodId, body)
            as Map<String, dynamic>;
    return BaseResponse.fromMap<UtilityCustomerAccount>(response);
  }

  Future<BaseResponse<dynamic>> buyDigitalGood(
    String digitalGoodId,
    Map<String, dynamic> body,
  ) async {
    final response =
        await _client.buyDigitalGood(digitalGoodId, body) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  // Affiliate Codes

  Future<PaginatedResponse<AffiliateCode>> getAffiliateCodes({
    int page = 0,
    int pageSize = 10,
    String? name,
  }) async {
    final query = {
      "page": page,
      "pageSize": pageSize,
      if (name != null) "name": name,
    };

    final response =
        await _client.getAffiliateCodes(query) as Map<String, dynamic>;
    return PaginatedResponse.fromMap<AffiliateCode>(response);
  }

  Future<PaginatedResponse<dynamic>> getAffiliateCodeAffiliates(
    String affiliateCodeId, {
    int page = 0,
    int pageSize = 10,
  }) async {
    final query = {"page": page, "pageSize": pageSize};

    final response =
        await _client.getAffiliateCodeAffiliates(affiliateCodeId, query)
            as Map<String, dynamic>;
    return PaginatedResponse.fromMap<dynamic>(response);
  }

  Future<BaseResponse<dynamic>> requestAffiliateCode() async {
    final response =
        await _client.requestAffiliateCode() as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }

  // Wallet and Bank Transfers

  Future<PaginatedResponse<WalletTransaction>> getWalletTransactions({
    int page = 0,
    int pageSize = 10,
  }) async {
    final query = {"page": page, "pageSize": pageSize};

    final response =
        await _client.getWalletTransactions(query) as Map<String, dynamic>;
    return PaginatedResponse.fromMap<WalletTransaction>(response);
  }

  Future<BaseResponse<BankTransferRequest>> initiateBankTransfer({
    required int amount,
    required String bankName,
    required String bankCode,
    required String accountNumber,
    String? remark,
    double? latitude,
    double? longitude,
  }) async {
    final body = {
      "amount": amount,
      "bank_name": bankName,
      "bank_code": bankCode,
      "account_number": accountNumber,
      if (remark != null) "remark": remark,
      if (latitude != null) "latitude": latitude,
      if (longitude != null) "longitude": longitude,
    };

    final response =
        await _client.initiateBankTransfer(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<BankTransferRequest>(response);
  }

  Future<BaseResponse<BankTransferRequest>> resendBankTransferOtp(
    String requestId,
  ) async {
    final response =
        await _client.resendBankTransferOtp({"request_id": requestId})
            as Map<String, dynamic>;
    return BaseResponse.fromMap<BankTransferRequest>(response);
  }

  Future<BaseResponse<dynamic>> validateBankTransfer({
    required String requestId,
    required String code,
    double? latitude,
    double? longitude,
  }) async {
    final body = {
      "request_id": requestId,
      "code": code,
      if (latitude != null) "latitude": latitude,
      if (longitude != null) "longitude": longitude,
    };

    final response =
        await _client.validateBankTransfer(body) as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }
}
