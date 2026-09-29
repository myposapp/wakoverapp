import 'package:flutter/foundation.dart';
import 'package:wakover/common/network/model/base_api_response.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/models/shopper_user_model.dart';

/// The outcome of a sign in or sign up. [field] names the form field the
/// server rejected (e.g. 'email'), so the error can be shown inline.
typedef AuthResult = ({bool success, String? message, String? field});

/// Holds the signed-in shopper. The access token itself arrives as a
/// Set-Cookie header, which [NetworkProvider] captures and persists; this
/// provider tracks the profile that goes with it.
class UserSessionProvider extends ChangeNotifier {
  UserSessionProvider(this._network) {
    restore();
  }

  final NetworkProvider _network;

  ShopperUser? _user;
  bool _isRestoring = false;

  ShopperUser? get user => _user;
  bool get isSignedIn => _network.isSignedIn;

  /// True while a saved session's profile is being loaded at startup.
  bool get isRestoring => _isRestoring;

  /// Loads the profile for a token saved from a previous launch, dropping the
  /// token if the server no longer accepts it.
  Future<void> restore() async {
    if (!_network.isSignedIn || _network.storeOrigin == null) return;
    _isRestoring = true;
    notifyListeners();
    try {
      await refreshProfile();
    } finally {
      _isRestoring = false;
      notifyListeners();
    }
  }

  Future<void> refreshProfile() async {
    if (!_network.isSignedIn) return;
    try {
      final response = await _network.shopperNetworkRepo.getProfile();
      if (response.success == true && response.data != null) {
        _user = response.data;
      } else if (_isAuthError(response.message)) {
        _clearSession();
      }
    } catch (_) {
      // Offline or server error: keep the token and try again later.
    }
    notifyListeners();
  }

  /// [identifier] is an email address or a phone number.
  Future<AuthResult> signIn({
    required String identifier,
    required String password,
  }) {
    final isEmail = identifier.contains('@');
    return _authenticate(
      () => _network.shopperNetworkRepo.signIn(
        email: isEmail ? identifier : null,
        phone: isEmail ? null : identifier,
        password: password,
      ),
    );
  }

  Future<AuthResult> signUp({
    required String name,
    required String phone,
    required String email,
    required String password,
  }) {
    return _authenticate(
      () => _network.shopperNetworkRepo.signUp(
        name: name,
        phone: phone,
        email: email,
        password: password,
      ),
    );
  }

  Future<AuthResult> _authenticate(
    Future<BaseResponse<ShopperUser>> Function() request,
  ) async {
    if (_network.storeOrigin == null) {
      return (
        success: false,
        message: 'Connect to a store before signing in.',
        field: null,
      );
    }

    try {
      final response = await request();
      if (response.success != true || response.data == null) {
        return (
          success: false,
          message: response.message ?? 'Something went wrong.',
          field: _errorField(response.errors),
        );
      }
      if (!_network.isSignedIn) {
        // The server accepted the credentials but sent no session cookie.
        return (
          success: false,
          message: 'Could not start a session. Please try again.',
          field: null,
        );
      }
      _user = response.data;
      notifyListeners();
      return (success: true, message: null, field: null);
    } catch (e) {
      return (success: false, message: e.toString(), field: null);
    }
  }

  Future<void> signOut() async {
    try {
      await _network.shopperNetworkRepo.signOut();
    } catch (_) {
      // Signing out locally is what matters; the server session expires.
    }
    _clearSession();
    notifyListeners();
  }

  void _clearSession() {
    _user = null;
    _network.updateAccessToken(null);
  }

  /// Validation errors look like {"field": "body.email"}.
  static String? _errorField(dynamic errors) {
    if (errors is! Map) return null;
    final field = errors['field']?.toString();
    if (field == null) return null;
    return field.startsWith('body.') ? field.substring(5) : field;
  }

  static bool _isAuthError(String? message) {
    final text = message?.toLowerCase() ?? '';
    return text.contains('no token') ||
        text.contains('unauthori') ||
        text.contains('invalid token') ||
        text.contains('expired');
  }
}
