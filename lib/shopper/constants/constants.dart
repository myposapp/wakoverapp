import 'package:wakover/common/constants/pair.dart';

class ShopperConstants {
  static const buyAirtime = Pair(first: "Buy Airtime", second: 'Airtime');
  static const buyDataBundle = Pair(
    first: "Buy Data Bundle",
    second: 'Data Subscription',
  );
  static const payElectricityBill = Pair(
    first: "Pay Electricity Bill",
    second: 'Utility Bills',
  );
  static const payTVSubscription = Pair(
    first: "Pair TV Bill",
    second: 'Pay TV',
  );

  // /store/payment-gateways doesn't return name or payment_options yet, so
  // these mirror what the web storefront shows for each gateway.
  static const paymentGatewayNames = {
    'monnify': 'Monnify',
    'budpay': 'Budpay',
    'interswitch': 'Interswitch',
    'airvend': 'Airvend',
    'wallet': 'Wallet',
  };

  static const paymentGatewayOptions = {
    'monnify': ['transfer', 'card'],
    'budpay': ['transfer', 'card', 'ussd'],
    'interswitch': ['interswitch'],
    'airvend': ['airvend'],
    'wallet': ['wallet'],
  };

  /// Label, description and minimum amount for each payment method.
  static const paymentMethods = {
    'interswitch': (
      label: 'Card, Bank Transfer...',
      description: 'Make payment with card, bank transfer and more...',
      minAmount: 100,
    ),
    'airvend': (
      label: 'Card, Bank Transfer...',
      description: 'Make payment with card or bank transfer',
      minAmount: 100,
    ),
    'transfer': (
      label: 'Bank Transfer',
      description: 'Directly transfer to our bank account...',
      minAmount: 100,
    ),
    'card': (
      label: 'Card',
      description: 'Pay with Visa, Mastercard and more...',
      minAmount: 1,
    ),
    'ussd': (
      label: 'USSD',
      description: 'Simplest way to pay, even offline...',
      minAmount: 100,
    ),
    'wallet': (
      label: 'Wallet',
      description: 'Pay with your wallet.',
      minAmount: 1,
    ),
  };
}
