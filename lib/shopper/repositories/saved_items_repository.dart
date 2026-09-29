import 'package:drift/drift.dart';
import 'package:wakover/common/database/app_database.dart';
import 'package:wakover/common/network/provider/network_provider.dart';

typedef SavedItemsScope = ({String userKey, String storeOrigin});

/// Everything needed to show a saved item without refetching the product.
typedef SavedProductSnapshot = ({
  String productId,
  String name,
  String? image,
  String? category,
  double? price,
});

class NoStoreConnectedException implements Exception {
  const NoStoreConnectedException();

  @override
  String toString() => 'Connect to a store to save items.';
}

/// Saved catalog items live only on device, scoped to the signed-in user (or
/// a guest bucket when signed out) and the currently connected store.
class SavedItemsRepository {
  SavedItemsRepository(this._db, this._network);

  final AppDatabase _db;
  final NetworkProvider _network;

  // The profile lookup is cached per access token so a new sign-in resolves
  // to the new user.
  String? _cachedToken;
  String? _cachedUserId;

  Future<SavedItemsScope?> currentScope() async {
    final origin = _network.storeOrigin;
    if (origin == null) return null;
    return (userKey: await _resolveUserKey(), storeOrigin: origin);
  }

  Future<String> _resolveUserKey() async {
    final token = _network.accessToken;
    if (token == null) return AppDatabase.guestUserKey;
    if (token == _cachedToken && _cachedUserId != null) return _cachedUserId!;

    try {
      final response = await _network.shopperNetworkRepo.getProfile();
      final userId = response.data?.id;
      if (response.success == true && userId != null) {
        _cachedToken = token;
        _cachedUserId = userId;
        return userId;
      }
    } catch (_) {
      // Fall through to the guest bucket if the profile can't be loaded.
    }
    return AppDatabase.guestUserKey;
  }

  /// Emits the saved items for the current scope, or an empty list when no
  /// store is connected.
  Stream<List<SavedItem>> watchSavedItems() async* {
    final scope = await currentScope();
    if (scope == null) {
      yield const [];
      return;
    }
    yield* _db.watchSavedItems(scope.userKey, scope.storeOrigin);
  }

  /// Saves the product, or removes it if already saved. Returns whether the
  /// product is saved afterwards.
  Future<bool> toggle(SavedProductSnapshot product) async {
    final scope = await currentScope();
    if (scope == null) throw const NoStoreConnectedException();

    final existing = await _db.findSavedItem(
      scope.userKey,
      scope.storeOrigin,
      product.productId,
    );
    if (existing != null) {
      await _db.removeSavedItem(
        scope.userKey,
        scope.storeOrigin,
        product.productId,
      );
      return false;
    }

    await _db.saveItem(
      SavedItemsCompanion.insert(
        userKey: scope.userKey,
        storeOrigin: scope.storeOrigin,
        productId: product.productId,
        name: product.name,
        image: Value(product.image),
        category: Value(product.category),
        price: Value(product.price),
      ),
    );
    return true;
  }

  Future<void> remove(String productId) async {
    final scope = await currentScope();
    if (scope == null) return;
    await _db.removeSavedItem(scope.userKey, scope.storeOrigin, productId);
  }

  Future<void> clear() async {
    final scope = await currentScope();
    if (scope == null) return;
    await _db.clearSavedItems(scope.userKey, scope.storeOrigin);
  }
}
