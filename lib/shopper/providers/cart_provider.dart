import 'package:flutter/foundation.dart';
import 'package:wakover/common/network/model/base_api_response.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/models/cart_model.dart';

/// The store cart. Guests get one too: the server issues a cart token cookie
/// on first use, which [NetworkProvider] captures and sends back as x-cart.
class CartProvider extends ChangeNotifier {
  CartProvider(this._network);

  final NetworkProvider _network;

  Cart? _cart;
  bool _isLoading = false;
  // Product id currently being added/updated, for per-button spinners.
  String? _busyProductId;

  Cart? get cart => _cart;
  List<CartItem> get items => _cart?.items ?? const [];
  int get itemCount => _cart?.itemCount ?? 0;
  num get subtotal => _cart?.subtotal ?? 0;
  bool get isLoading => _isLoading;
  String? get busyProductId => _busyProductId;

  int quantityOf(String productId, {String? variantId}) {
    return items
        .where(
          (i) =>
              i.id == productId &&
              (variantId == null || i.variantId == variantId),
        )
        .fold<int>(0, (sum, i) => sum + (i.qty ?? 0).toInt());
  }

  Future<void> load() async {
    if (_network.storeOrigin == null) return;
    _isLoading = true;
    notifyListeners();
    try {
      final response = await _network.shopperNetworkRepo.getCart();
      if (response.success == true) _cart = response.data;
    } catch (_) {
      // Keep whatever cart we had; the sheet offers a retry.
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Adds one unit. Returns an error message, or null on success.
  Future<String?> add(String productId, {String? variantId}) {
    return _mutate(
      productId,
      () => _network.shopperNetworkRepo.addToCart(
        productId: productId,
        variantId: variantId,
      ),
    );
  }

  /// Removes one unit, or the whole line when [removeAll] is set.
  Future<String?> remove(
    String productId, {
    String? variantId,
    bool removeAll = false,
  }) {
    return _mutate(
      productId,
      () => _network.shopperNetworkRepo.removeFromCart(
        productId: productId,
        variantId: variantId,
        removeAll: removeAll,
      ),
    );
  }

  Future<String?> _mutate(
    String productId,
    Future<BaseResponse<Cart>> Function() request,
  ) async {
    if (_network.storeOrigin == null) return 'Connect to a store first.';
    _busyProductId = productId;
    notifyListeners();
    try {
      final response = await request();
      if (response.success == true) {
        _cart = response.data ?? _cart;
        return null;
      }
      return response.message ?? 'Could not update your bag.';
    } catch (e) {
      return e.toString();
    } finally {
      _busyProductId = null;
      notifyListeners();
    }
  }
}
