import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wakover/common/constants/config.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/constants/constants.dart';
import 'package:wakover/shopper/models/digital_good_model.dart';
import 'package:wakover/shopper/models/payment_gateway_model.dart';
import 'package:wakover/theme/app_theme.dart';

/// Lets the shopper pick a payment gateway/method and places the digital good
/// order. Pops with `true` once the order has been handed off for payment.
class BuyerDigitalGoodCheckoutScreen extends StatefulWidget {
  const BuyerDigitalGoodCheckoutScreen({
    super.key,
    required this.good,
    required this.purchaseDetail,
    required this.totalPrice,
    this.subtitle,
    this.packageLabel,
  });

  final DigitalGood good;

  /// Product specific fields for the buy request (phone, amount, package...).
  final Map<String, dynamic> purchaseDetail;
  final num totalPrice;

  /// Primary line shown under the product name (phone or meter number).
  final String? subtitle;
  final String? packageLabel;

  @override
  State<BuyerDigitalGoodCheckoutScreen> createState() =>
      _BuyerDigitalGoodCheckoutScreenState();
}

class _BuyerDigitalGoodCheckoutScreenState
    extends State<BuyerDigitalGoodCheckoutScreen> {
  List<PaymentGateway>? _gateways;
  String? _errorMessage;
  String? _selectedGateway;
  String? _selectedMethod;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadGateways());
  }

  Future<void> _loadGateways() async {
    setState(() {
      _gateways = null;
      _errorMessage = null;
    });

    try {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final (gatewaysResponse, siteConfigResponse) = await (
        repo.getPaymentGateways(),
        repo.getSiteConfig(),
      ).wait;
      final siteConfig = siteConfigResponse.data;
      if (!mounted) return;

      if (gatewaysResponse.success != true) {
        setState(() {
          _errorMessage =
              gatewaysResponse.message ?? "Failed to load payment methods";
        });
        return;
      }

      final gateways = [
        if (siteConfig?.purchaseWithWallet == true)
          const PaymentGateway(id: 'wallet'),
        ...?gatewaysResponse.data,
      ];

      setState(() {
        _gateways = gateways;
        _selectGateway(gateways.firstOrNull?.id);
      });
    } catch (e) {
      if (!mounted) return;
      setState(() => _errorMessage = e.toString());
    }
  }

  List<String> _optionsFor(PaymentGateway gateway) {
    final options =
        gateway.paymentOptions ??
        ShopperConstants.paymentGatewayOptions[gateway.id] ??
        const [];
    return options.where(ShopperConstants.paymentMethods.containsKey).toList();
  }

  bool _isMethodAvailable(String method) {
    final minAmount = ShopperConstants.paymentMethods[method]?.minAmount ?? 0;
    return widget.totalPrice >= minAmount;
  }

  /// Mirrors the web: prefer bank transfer from ₦100, otherwise card, falling
  /// back to the first method the amount qualifies for.
  void _selectGateway(String? gatewayId) {
    _selectedGateway = gatewayId;
    final gateway = _gateways?.firstWhereOrNull((g) => g.id == gatewayId);
    if (gateway == null) {
      _selectedMethod = null;
      return;
    }

    final options = _optionsFor(gateway).where(_isMethodAvailable).toList();
    if (options.contains(_selectedMethod)) return;

    final preferred = widget.totalPrice >= 100 ? 'transfer' : 'card';
    _selectedMethod = options.contains(preferred)
        ? preferred
        : options.firstOrNull;
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _onPayNow() async {
    if (_selectedGateway == null || _selectedMethod == null) {
      _showMessage("Please choose a payment method");
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final response = await repo.buyDigitalGood(widget.good.id ?? '', {
        ...widget.purchaseDetail,
        "payment_gateway": _selectedGateway,
        "payment_method": _selectedMethod,
      });
      if (!mounted) return;

      if (response.success != true) {
        _showMessage(response.message ?? "Purchase failed");
        return;
      }
      await _handlePurchaseResult(response.data);
    } catch (e) {
      if (mounted) _showMessage(e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _handlePurchaseResult(dynamic data) async {
    final result = data is Map ? data : const {};
    final checkoutUrl = result['checkout_url']?.toString();

    if (checkoutUrl != null && checkoutUrl.isNotEmpty) {
      var launched = false;
      try {
        launched = await launchUrl(
          Uri.parse(checkoutUrl),
          mode: LaunchMode.externalApplication,
        );
      } catch (e) {
        debugPrint('Could not open $checkoutUrl: $e');
      }
      if (!mounted) return;
      if (!launched) {
        // The order already exists, so keep the payment link reachable.
        await _showResultDialog(
          title: "Complete your payment",
          message:
              "We couldn't open your browser. Open this link to pay for "
              "your order:",
          details: {'Payment link': checkoutUrl},
        );
        if (mounted) Navigator.of(context).pop(true);
        return;
      }
      await _showResultDialog(
        title: "Complete your payment",
        message:
            "The payment page has been opened in your browser. "
            "Your order will be processed once payment is confirmed.",
      );
    } else if (result['bank_name'] != null &&
        result['account_number'] != null) {
      await _showResultDialog(
        title: "Pay by bank transfer",
        message: "Transfer the amount below to complete your order.",
        details: {
          'Bank': result['bank_name'],
          'Account Number': result['account_number'],
          'Account Name': result['account_name'],
          'Amount': result['amount'] != null ? '₦${result['amount']}' : null,
          'Reference': result['reference'],
        },
      );
    } else {
      await _showResultDialog(
        title: "Order successful",
        message: "Your purchase was successful.",
        details: {'Order ID': result['order_id']},
      );
    }

    if (mounted) Navigator.of(context).pop(true);
  }

  Future<void> _showResultDialog({
    required String title,
    required String message,
    Map<String, dynamic> details = const {},
  }) {
    final rows = details.entries.where((e) => e.value != null).toList();

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(message),
            if (rows.isNotEmpty) const SizedBox(height: 12),
            ...rows.map(
              (row) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: SelectableText.rich(
                  TextSpan(
                    text: '${row.key}: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: '${row.value}',
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Checkout")),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildSummary(),
              const SizedBox(height: 24),
              const Text(
                "Choose a payment method",
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const SizedBox(height: 8),
              _buildGateways(),
              const SizedBox(height: 24),
              _buildPayButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummary() {
    final good = widget.good;
    final meterType = widget.purchaseDetail['meter_type']?.toString();
    final heading = [
      good.name,
      good.category?.name,
      if (meterType != null)
        '${meterType[0].toUpperCase()}${meterType.substring(1)}',
    ].whereType<String>().join(' | ');

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFE9D5FF),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          CachedNetworkImage(
            imageUrl: '${AppConfig.cdnBaseUrl}${good.image ?? ''}',
            height: 56,
            width: 56,
            fit: BoxFit.contain,
            errorWidget: (context, url, error) =>
                const Icon(Icons.receipt_long, size: 40),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  heading,
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                if (widget.subtitle != null)
                  Text(
                    widget.subtitle!,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                if (widget.purchaseDetail['number_of_pins'] != null)
                  Text(
                    '₦${widget.purchaseDetail['amount']} × '
                    '${widget.purchaseDetail['number_of_pins']}',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                const SizedBox(height: 8),
                Text(
                  widget.packageLabel ?? "Total Price:",
                  style: const TextStyle(fontSize: 13, color: Colors.black54),
                ),
                Text(
                  '₦${widget.totalPrice}',
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGateways() {
    if (_errorMessage != null) {
      return Column(
        children: [
          Text(
            _errorMessage!,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.redAccent),
          ),
          TextButton(onPressed: _loadGateways, child: const Text("Retry")),
        ],
      );
    }

    final gateways = _gateways;
    if (gateways == null) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (gateways.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(24.0),
        child: Text(
          "No payment methods available for this store",
          textAlign: TextAlign.center,
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black26),
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: RadioGroup<String>(
        groupValue: _selectedGateway,
        onChanged: (id) => setState(() => _selectGateway(id)),
        child: Column(
          children: [
            for (final (index, gateway) in gateways.indexed) ...[
              if (index > 0) const Divider(height: 1, color: Colors.black26),
              _buildGatewayTile(gateway),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildGatewayTile(PaymentGateway gateway) {
    final isSelected = gateway.id == _selectedGateway;
    final name =
        gateway.name ??
        ShopperConstants.paymentGatewayNames[gateway.id] ??
        gateway.id ??
        '';

    return Column(
      children: [
        RadioListTile<String>(
          value: gateway.id ?? '',
          title: Text(name),
          tileColor: isSelected ? const Color(0xFFE0F2FE) : null,
        ),
        AnimatedSize(
          duration: const Duration(milliseconds: 250),
          child: isSelected
              ? Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                  child: Column(
                    children: _optionsFor(
                      gateway,
                    ).map(_buildMethodTile).toList(),
                  ),
                )
              : const SizedBox(width: double.infinity),
        ),
      ],
    );
  }

  Widget _buildMethodTile(String method) {
    final info = ShopperConstants.paymentMethods[method]!;
    final isAvailable = _isMethodAvailable(method);
    final isSelected = _selectedMethod == method;

    return Opacity(
      opacity: isAvailable ? (isSelected ? 1 : 0.6) : 0.35,
      child: Card(
        margin: const EdgeInsets.only(top: 8),
        color: isSelected ? const Color(0xFFFFF2DE) : const Color(0xFFF4F4F4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
          side: BorderSide(
            color: isSelected ? const Color(0xFFF5D9A8) : Colors.transparent,
          ),
        ),
        child: InkWell(
          onTap: isAvailable
              ? () => setState(() => _selectedMethod = method)
              : null,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Icon(_methodIcon(method), color: AppTheme.navyDark),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        info.label,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        info.description,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.black54,
                        ),
                      ),
                      if (!isAvailable)
                        Text(
                          'Minimum ₦${info.minAmount}',
                          style: const TextStyle(fontSize: 13),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconData _methodIcon(String method) {
    switch (method) {
      case 'transfer':
        return Icons.account_balance;
      case 'card':
        return Icons.credit_card;
      case 'ussd':
        return Icons.dialpad;
      case 'wallet':
        return Icons.account_balance_wallet;
      default:
        return Icons.payments;
    }
  }

  Widget _buildPayButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 48,
        width: 140,
        child: ElevatedButton(
          onPressed: _isSubmitting || _gateways == null ? null : _onPayNow,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.navyDark,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
          ),
          child: _isSubmitting
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text(
                  "Pay Now",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }
}
