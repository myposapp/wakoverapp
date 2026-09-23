import '../../common/network/model/base_api_response.dart';
import 'network_service.dart';

class ShopperNetworkRepo {
  ShopperNetworkRepo(this._client);

  final ShopperNetworkClient _client;

  Future<BaseResponse<dynamic>> getProfile() async {
    final response = await _client.getProfile() as Map<String, dynamic>;
    return BaseResponse.fromMap<dynamic>(response);
  }
}
