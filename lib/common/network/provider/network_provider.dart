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
  late final PreferenceProvider _prefs;

  ShopperNetworkRepo? _shopperNetworkRepo;
  String? _accessToken;
  String? _cartToken;
  String? _storeOrigin;

  ShopperNetworkRepo get shopperNetworkRepo =>
      _shopperNetworkRepo ??= ShopperNetworkRepo(ShopperNetworkClient(_dio));

  String? get accessToken => _accessToken;
  bool get isSignedIn => _accessToken != null;

  /// The connected store's web origin (e.g. https://store.example.com). The
  /// API resolves which store a request belongs to from this.
  String? get storeOrigin => _storeOrigin;

  void _initialize(PreferenceProvider prefs) async {
    _prefs = prefs;
    _dio = Dio(BaseOptions(validateStatus: (_) => true));

    _accessToken = prefs.getString(AppConfig.accessTokenKey);
    _cartToken = prefs.getString(AppConfig.cartTokenKey);
    _storeOrigin = prefs.getString(AppConfig.storeOriginKey);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (_accessToken != null) {
            options.headers['x-access-token'] = _accessToken;
          }
          if (_cartToken != null) {
            options.headers['x-cart'] = _cartToken;
          }
          if (_storeOrigin != null) {
            options.headers['Origin'] = _storeOrigin;
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          _captureCookies(response);
          handler.next(response);
        },
      ),
    );
  }

  // The API hands back the access/cart tokens as Set-Cookie headers rather
  // than in the response body, so every response is inspected for them.
  void _captureCookies(Response response) {
    final cookies = response.headers['set-cookie'];
    if (cookies == null) return;

    for (final cookie in cookies) {
      final accessToken = _extractCookieValue(cookie, 'access_token');
      if (accessToken != null) {
        updateAccessToken(accessToken);
      }

      final cartToken = _extractCookieValue(cookie, 'cart');
      if (cartToken != null) {
        updateCartToken(cartToken);
      }
    }
  }

  String? _extractCookieValue(String cookie, String name) {
    if (!cookie.startsWith('$name=')) return null;
    return cookie.substring(name.length + 1).split(';').first;
  }

  void updateAccessToken(String? token) {
    _accessToken = token;
    if (token != null) {
      _prefs.setString(AppConfig.accessTokenKey, token);
    } else {
      _prefs.remove(AppConfig.accessTokenKey);
    }
  }

  void updateCartToken(String? token) {
    _cartToken = token;
    if (token != null) {
      _prefs.setString(AppConfig.cartTokenKey, token);
    } else {
      _prefs.remove(AppConfig.cartTokenKey);
    }
  }

  void updateStoreOrigin(String? storeOrigin) {
    _storeOrigin = storeOrigin;
    if (storeOrigin != null) {
      _prefs.setString(AppConfig.storeOriginKey, storeOrigin);
    } else {
      _prefs.remove(AppConfig.storeOriginKey);
    }
  }
}
