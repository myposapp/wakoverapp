import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product.dart';
import '../models/order.dart';
import '../models/campaign.dart';
import '../models/store_hub.dart';

enum UserRole { merchant, buyer }

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  Map<String, dynamic> toJson() => {
        'product': product.toJson(),
        'quantity': quantity,
      };

  factory CartItem.fromJson(Map<String, dynamic> json) => CartItem(
        product: Product.fromJson(json['product'] as Map<String, dynamic>),
        quantity: json['quantity'] as int,
      );
}

class AppProvider extends ChangeNotifier {
  // Preferences
  bool _hasLoadedPreferences = false;
  UserRole _role = UserRole.merchant;
  bool _isDarkMode = false;
  String _activeDepot = 'Apex Depot';
  String _activePeriod = 'today';
  String _inventoryFilter = 'all';
  String _searchQuery = '';
  bool _hasCompletedIntro = false;
  String? _selectedStoreId;

  // Data Collections
  List<Product> _products = [];
  final List<CartItem> _cart = [];
  final List<String> _wishlist = [];
  List<Order> _orders = [];
  List<Campaign> _campaigns = [];
  List<StoreHub> _stores = [];

  // Active Modals & Transient selection
  Product? _selectedProduct;
  String? _toastMessage;

  // Getters
  bool get hasLoadedPreferences => _hasLoadedPreferences;
  UserRole get role => _role;
  bool get isDarkMode => _isDarkMode;
  String get activeDepot => _activeDepot;
  String get activePeriod => _activePeriod;
  String get inventoryFilter => _inventoryFilter;
  String get searchQuery => _searchQuery;
  bool get hasCompletedIntro => _hasCompletedIntro;
  String? get selectedStoreId => _selectedStoreId;
  StoreHub? get selectedStore {
    if (_selectedStoreId == null) return null;
    for (final s in _stores) {
      if (s.id == _selectedStoreId) return s;
    }
    return null;
  }

  List<Product> get products => _products;
  List<CartItem> get cart => _cart;
  List<String> get wishlist => _wishlist;
  List<Order> get orders => _orders;
  List<Campaign> get campaigns => _campaigns;
  List<StoreHub> get stores => _stores;
  Product? get selectedProduct => _selectedProduct;
  String? get toastMessage => _toastMessage;

  int get cartCount => _cart.fold(0, (sum, item) => sum + item.quantity);
  double get cartTotal =>
      _cart.fold(0.0, (sum, item) => sum + (item.product.price * item.quantity));

  AppProvider() {
    _initDefaultData();
    _loadFromPreferences();
  }

  void _initDefaultData() {
    _products = [
      Product(
        id: '1',
        name: 'Vanguard Pro Studio Headset',
        sku: 'VG-8802',
        category: 'Electronics',
        price: 189.00,
        originalPrice: 220.00,
        stock: 34,
        targetStock: 50,
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCrap1HoNurSIU10g-vUfIsexGl3HhRnB1mPeKFV9PcSz0R97xbix_WLlGnJ0ItAvU2vbbscZ2fFN0nq6gcSXg7nWZW4lRiFOdUJVED0Q2eESdfjdtG7UDM-yD1UF2PiHKbC6MhvZWdAPqeqO-NO6fx0cmiMFGQuFYspZdgd3UnwL2UbThzo5n6f-cf2UfP9DJXtFvI5Yl4SOpdFBX_wJZimaoG_wAlgGVuwch0kOouZm8bgAnCohnA1g',
        status: 'in_stock',
        badge: 'Top Seller',
        salesCount: 128,
        revenue: 3920.00,
      ),
      Product(
        id: '2',
        name: 'Apex Linear Mechanical Switchboard',
        sku: 'SW-4010',
        category: 'Workspace',
        price: 145.00,
        originalPrice: 170.00,
        stock: 18,
        targetStock: 30,
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuD_K1OPNvApVkqtgtdGwhuTHwNHFSmco13CbY9iXaBHZq_jLCtuSpglE-91zcR3dlQQyLfIq59JyskuMd4sNMqCltpk9qgOySEHKYKV0glKs02FQIWL40jACkA6tOBipiFu3Fq2zR-6mLoVP4gtDciiI0Uskyu09IMEDdpCTy_7eC11IxIBEjnfPST52U0kNs5evXafusdZU4-RYjBG18f9f6pfb6bpW4Exnw-Ngf4NwsKRie0Zcv_0Bw',
        status: 'in_stock',
        badge: 'Hot Drop',
        salesCount: 95,
        revenue: 2415.00,
      ),
      Product(
        id: '3',
        name: 'Matrix Multiport Hub 10-in-1',
        sku: 'MX-1004',
        category: 'Workspace',
        price: 65.00,
        originalPrice: 85.00,
        stock: 3,
        targetStock: 25,
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuDWchbdaETWCmv1Y79h8F4Xf9fJ15UkgYSIE8ANK0srCnV2yj22PH2ntEIUSD1j4tLC2_FRdC_iGlc-GRkPWqxKyUep_xqnMat48hVSAAAPR7jsrV5U-kLm09y5GHCXV1U0dd3ta9d7TAG3cQG915UsiuR5N6UF5RxIrf2LgkMZNQAQjTzyX57_3h11EPj4YSppvaRU_iPtYCfNR_RX_iOUKyaBoeTuX0EJycrCVEgZKg15rhOFrUE1yA',
        status: 'low_stock',
        badge: 'Low Stock',
        salesCount: 63,
        revenue: 1890.00,
      ),
      Product(
        id: '4',
        name: 'Stealth ANC Wireless Earbuds',
        sku: 'EA-3301',
        category: 'Electronics',
        price: 119.00,
        originalPrice: 139.00,
        stock: 0,
        targetStock: 40,
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuCF9VDVEfjerVDZB7CAATxuizXnKVlfNnT-1HxlVWDjTA8aGiG0888SYhd5EsJWJjIG_7PW3V__HVwpMbPFmNY8dehKhLbkQNqzybtZTVFBJ67AsW-g4nAR0PKN2QWGa5uvcDVGTG4BJc_diraHcijT0W4t1pD-oyQWk3hyz6qU5ZZ6vI8tIxVF-Sf91GGenLyYxUOZAeTGsw0wQT8wxxfNpudLoXbmvs8W_Yyra32tbtEgx-AQAZfilw',
        status: 'out_of_stock',
        salesCount: 42,
        revenue: 980.00,
      ),
      Product(
        id: '5',
        name: 'Apex Chrono Smart Watch Ultra',
        sku: 'SW-9921',
        category: 'Horology',
        price: 299.00,
        stock: 22,
        targetStock: 30,
        image:
            'https://lh3.googleusercontent.com/aida-public/AB6AXuD_K1OPNvApVkqtgtdGwhuTHwNHFSmco13CbY9iXaBHZq_jLCtuSpglE-91zcR3dlQQyLfIq59JyskuMd4sNMqCltpk9qgOySEHKYKV0glKs02FQIWL40jACkA6tOBipiFu3Fq2zR-6mLoVP4gtDciiI0Uskyu09IMEDdpCTy_7eC11IxIBEjnfPST52U0kNs5evXafusdZU4-RYjBG18f9f6pfb6bpW4Exnw-Ngf4NwsKRie0Zcv_0Bw',
        status: 'in_stock',
        badge: 'New',
        salesCount: 51,
        revenue: 1524.90,
      ),
    ];

    _orders = [
      Order(
        id: 'WAK-8821',
        customerName: 'Sarah Jenkins',
        total: 324.50,
        date: 'Today, 2:45 PM',
        status: 'processing',
        itemsCount: 2,
        escrowSecured: true,
        items: [
          OrderItemDetail(
              productId: '1', name: 'Vanguard Pro Studio Headset', quantity: 1, price: 189.00),
          OrderItemDetail(
              productId: '2', name: 'Apex Linear Mechanical Switchboard', quantity: 1, price: 135.50),
        ],
      ),
      Order(
        id: 'WAK-8820',
        customerName: 'Marcus Vance',
        total: 145.00,
        date: 'Today, 11:20 AM',
        status: 'shipped',
        itemsCount: 1,
        escrowSecured: true,
        trackingNumber: 'US-88294',
        items: [
          OrderItemDetail(
              productId: '2', name: 'Apex Linear Mechanical Switchboard', quantity: 1, price: 145.00),
        ],
      ),
      Order(
        id: 'WAK-8819',
        customerName: 'Elena Rostova',
        total: 598.00,
        date: 'Yesterday',
        status: 'delivered',
        itemsCount: 3,
        escrowSecured: true,
        trackingNumber: 'US-77192',
        items: [
          OrderItemDetail(
              productId: '5', name: 'Apex Chrono Smart Watch Ultra', quantity: 2, price: 299.00),
        ],
      ),
    ];

    _campaigns = [
      Campaign(
        id: 'c1',
        title: 'Flash Friday 20% Off',
        code: 'FLASH20',
        discount: '20% OFF',
        status: 'active',
        usedCount: 289,
        duration: '18 hours left',
      ),
      Campaign(
        id: 'c2',
        title: 'Wholesale Tier Volume',
        code: 'B2BBULK',
        discount: '12% OFF',
        status: 'active',
        usedCount: 142,
        duration: 'Ongoing Tier',
      ),
      Campaign(
        id: 'c3',
        title: 'Courier Express Dispatch',
        code: 'FREESHIP',
        discount: 'FREE SHIP',
        status: 'active',
        usedCount: 58,
        duration: 'Min. \$75 Cart',
      ),
    ];

    _stores = [
      StoreHub(
        id: 's1',
        name: 'Apex Retail Flagship',
        handle: 'store.wakover.com/apex',
        category: 'Electronics & Audio',
        rating: 4.9,
        reviewCount: 1240,
        location: 'San Francisco, CA',
        isVerified: true,
        description:
            'Direct warehouse distribution for precision hardware, studio audio monitors, and modern desk architecture.',
      ),
      StoreHub(
        id: 's2',
        name: 'Solace Apparel Studio',
        handle: 'store.wakover.com/solace',
        category: 'Premium Garments',
        rating: 4.8,
        reviewCount: 840,
        location: 'Portland, OR',
        isVerified: true,
        description: 'Sustainable organic cotton essentials and weatherproof commuter overshirts.',
      ),
      StoreHub(
        id: 's3',
        name: 'Nordic Living Co.',
        handle: 'store.wakover.com/nordic',
        category: 'Home & Ceramics',
        rating: 5.0,
        reviewCount: 620,
        location: 'Seattle, WA',
        isVerified: true,
        description: 'Handcrafted stoneware ceramics and minimalist scandinavian task lighting.',
      ),
    ];
  }

  // State Mutators
  void setRole(UserRole role) {
    _role = role;
    _hasCompletedIntro = true;
    _saveToPreferences();
    notifyListeners();
  }

  void selectStore(StoreHub store) {
    _selectedStoreId = store.id;
    _saveToPreferences();
    notifyListeners();
  }

  void logout() {
    _hasCompletedIntro = false;
    _selectedStoreId = null;
    _saveToPreferences();
    notifyListeners();
  }

  void deleteAccount() {
    _cart.clear();
    _wishlist.clear();
    _hasCompletedIntro = false;
    _selectedStoreId = null;
    _saveToPreferences();
    notifyListeners();
  }

  void toggleDarkMode() {
    _isDarkMode = !_isDarkMode;
    _saveToPreferences();
    notifyListeners();
  }

  void setActiveDepot(String depot) {
    _activeDepot = depot;
    notifyListeners();
  }

  void setActivePeriod(String period) {
    _activePeriod = period;
    notifyListeners();
  }

  void setInventoryFilter(String filter) {
    _inventoryFilter = filter;
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setSelectedProduct(Product? product) {
    _selectedProduct = product;
    notifyListeners();
  }

  void updateProductStock(String productId, int newStock) {
    final idx = _products.indexWhere((p) => p.id == productId);
    if (idx != -1) {
      final old = _products[idx];
      String newStatus = 'in_stock';
      if (newStock <= 0) {
        newStatus = 'out_of_stock';
      } else if (newStock <= 5) {
        newStatus = 'low_stock';
      }
      _products[idx] = old.copyWith(stock: newStock, status: newStatus);
      _saveToPreferences();
      showToast('Inventory for ${old.name} updated to $newStock units.');
      notifyListeners();
    }
  }

  void addToCart(Product product) {
    final existingIdx = _cart.indexWhere((item) => item.product.id == product.id);
    if (existingIdx != -1) {
      _cart[existingIdx].quantity++;
    } else {
      _cart.add(CartItem(product: product, quantity: 1));
    }
    showToast('Added ${product.name} to your bag.');
    notifyListeners();
  }

  void updateCartQuantity(String productId, int qty) {
    if (qty <= 0) {
      _cart.removeWhere((item) => item.product.id == productId);
    } else {
      final item = _cart.firstWhere((i) => i.product.id == productId);
      item.quantity = qty;
    }
    notifyListeners();
  }

  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

  void toggleWishlist(String productId) {
    if (_wishlist.contains(productId)) {
      _wishlist.remove(productId);
    } else {
      _wishlist.add(productId);
    }
    notifyListeners();
  }

  void updateOrderStatus(String orderId, String status, [String? tracking]) {
    final idx = _orders.indexWhere((o) => o.id == orderId);
    if (idx != -1) {
      _orders[idx].status = status;
      if (tracking != null) {
        _orders[idx].trackingNumber = tracking;
      }
      notifyListeners();
    }
  }

  void toggleCampaign(String id) {
    final idx = _campaigns.indexWhere((c) => c.id == id);
    if (idx != -1) {
      _campaigns[idx].status = _campaigns[idx].status == 'active' ? 'paused' : 'active';
      notifyListeners();
    }
  }

  void showToast(String message) {
    _toastMessage = message;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () {
      if (_toastMessage == message) {
        _toastMessage = null;
        notifyListeners();
      }
    });
  }

  // Offline Persistence with SharedPreferences
  Future<void> _loadFromPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _isDarkMode = prefs.getBool('is_dark_mode') ?? false;

      final productsJson = prefs.getString('saved_products');
      if (productsJson != null) {
        final List list = jsonDecode(productsJson);
        _products = list.map((j) => Product.fromJson(j)).toList();
      }

      _hasCompletedIntro = prefs.getBool('has_completed_intro') ?? false;
      final roleStr = prefs.getString('user_role');
      if (roleStr == 'buyer') {
        _role = UserRole.buyer;
      } else if (roleStr == 'merchant') {
        _role = UserRole.merchant;
      }
      _selectedStoreId = prefs.getString('selected_store_id');
    } catch (_) {
      // Fallback gracefully to default memory data
    }
    // The router waits for this before sending returning users past splash.
    _hasLoadedPreferences = true;
    notifyListeners();
  }

  Future<void> _saveToPreferences() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('is_dark_mode', _isDarkMode);
      final productsString = jsonEncode(_products.map((p) => p.toJson()).toList());
      await prefs.setString('saved_products', productsString);

      await prefs.setBool('has_completed_intro', _hasCompletedIntro);
      await prefs.setString(
          'user_role', _role == UserRole.buyer ? 'buyer' : 'merchant');
      if (_selectedStoreId != null) {
        await prefs.setString('selected_store_id', _selectedStoreId!);
      } else {
        await prefs.remove('selected_store_id');
      }
    } catch (_) {}
  }
}
