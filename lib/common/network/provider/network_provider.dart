import 'package:dio/dio.dart';
import 'package:wakover/common/constants/config.dart';
import 'package:wakover/common/providers/preferences_provider.dart';
import 'package:wakover/shopper/network/network_repo.dart';
import 'package:wakover/shopper/network/network_service.dart';

// This class can be used to provide the NetworkClient instance to the rest of the app.
class NetworkProvider {
  NetworkProvider(PreferenceProvider prefs) {
    _initialize(prefs);
  }

  late final Dio _dio;

  ShopperNetworkRepo? _shopperNetworkRepo;
  String? _accessToken;
  String? _storeOrigin;

  ShopperNetworkRepo get shopperNetworkRepo =>
      _shopperNetworkRepo ??= ShopperNetworkRepo(ShopperNetworkClient(_dio));

  void _initialize(PreferenceProvider prefs) async {
    _dio = Dio(BaseOptions(validateStatus: (_) => true));

    _accessToken = prefs.getString(AppConfig.accessTokenKey);
    _storeOrigin = prefs.getString(AppConfig.storeOriginKey);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_accessToken != null) {
            options.headers['x-access-token'] = _accessToken;
          }
          if (_storeOrigin != null) {
            options.headers['Origin'] = _storeOrigin;
          }
          handler.next(options);
        },
      ),
    );
  }

  void updateAccessToken(String? token) {
    _accessToken = token;
  }

  void updateStoreOrigin(String? storeOrigin) {
    _storeOrigin = storeOrigin;
  }
}
