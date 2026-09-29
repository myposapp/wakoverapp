/// Every location in the app's navigation graph (see app_router.dart).
abstract final class AppRoutes {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const roleSelect = '/role-select';

  // Merchant
  static const connectStore = '/merchant/connect';
  static const merchantDashboard = '/merchant/dashboard';
  static const merchantInventory = '/merchant/inventory';
  static const merchantOrders = '/merchant/orders';
  static const merchantCampaigns = '/merchant/campaigns';

  // Buyer
  static const marketplace = '/marketplace';
  static const buyerWeb = '/buyer/web';
  static const buyerCatalog = '/buyer/catalog';
  static String product(String id) => '$buyerCatalog/product/$id';
  static const buyerUtility = '/buyer/utility';
  static const buyerHub = '/buyer/hub';
  static const hubOrders = '$buyerHub/orders';
  static const hubBookings = '$buyerHub/bookings';
  static const hubPayments = '$buyerHub/payments';
  static const hubTransactions = '$buyerHub/transactions';
  static const hubSaved = '$buyerHub/saved';
  static const hubAffiliateCodes = '$buyerHub/affiliate-codes';
  static const buyerAccount = '/buyer/account';
  static const userSettings = '$buyerAccount/settings';

  // Full screen, above the tab bar. Add `?mode=sign-up` to open on sign up.
  static const auth = '/auth';
  static const signUp = '$auth?mode=sign-up';
}
