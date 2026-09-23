import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:wakover/common/constants/config.dart';

part 'network_service.g.dart';

@RestApi(baseUrl: AppConfig.baseUrl)
abstract class ShopperNetworkClient {
  factory ShopperNetworkClient(Dio dio) = _ShopperNetworkClient;

  @GET("/store/auth/profile")
  Future<dynamic> getProfile();
}
