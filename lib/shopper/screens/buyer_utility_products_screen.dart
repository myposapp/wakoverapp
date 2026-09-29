import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:collection/collection.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/constants/config.dart';
import 'package:wakover/common/constants/pair.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/common/widgets/loading_shimmer_widget.dart';
import 'package:wakover/shopper/constants/constants.dart';
import 'package:wakover/shopper/models/digital_good_model.dart';
import 'package:wakover/shopper/models/utility_customer_account_model.dart';
import 'package:wakover/shopper/screens/buyer_digital_good_checkout_screen.dart';
import 'package:wakover/theme/app_theme.dart';

class BuyerUtilityProductsScreen extends StatefulWidget {
  const BuyerUtilityProductsScreen({super.key, required this.utilityType});

  final Pair<String, String> utilityType;

  @override
  State<BuyerUtilityProductsScreen> createState() =>
      _BuyerUtilityProductsScreenState();
}

class _BuyerUtilityProductsScreenState
    extends State<BuyerUtilityProductsScreen> {
  List<DigitalGood?> _utilityProducts = [null, null, null];
  int? _selectedIndex;
  String? _errorMessage;
  bool _isSubmitting = false;

  final _phoneController = TextEditingController();
  final _amountController = TextEditingController();
  final _meterNoController = TextEditingController();

  // Data bundle state
  List<_DataPackage> _packages = [];
  bool _isLoadingPackages = false;
  String? _packagesError;
  String? _selectedPackageCode;
  int _numberOfPins = 1;
  String? _selectedPinPackageCode;

  // Electricity state. Step 1 picks the provider, step 2 collects meter details.
  int _electricityStep = 1;
  String _meterType = 'Prepaid';
  UtilityCustomerAccount? _customerAccount;

  DigitalGood? get _selectedGood =>
      _selectedIndex == null ? null : _utilityProducts[_selectedIndex!];

  bool get _isElectricity =>
      widget.utilityType == ShopperConstants.payElectricityBill;

  bool get _isSpectranet => _selectedGood?.name?.toLowerCase() == 'spectranet';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUtilityProducts(context);
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _amountController.dispose();
    _meterNoController.dispose();
    super.dispose();
  }

  Future<void> _loadUtilityProducts(BuildContext context) async {
    try {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final response = await repo.getDigitalGoods(
        categoryName: widget.utilityType.second,
      );
      if (!mounted) return;

      if (response.success == true) {
        setState(() {
          _utilityProducts = response.data ?? [];
          _errorMessage = null;
        });
      } else {
        setState(() {
          _errorMessage = response.message ?? "Failed to load utility products";
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = e.toString();
      });
    }
  }

  Future<void> _loadDataPackages(DigitalGood good) async {
    setState(() {
      _packages = [];
      _packagesError = null;
      _isLoadingPackages = true;
    });

    try {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final response = await repo.getDigitalGoodDataPackages(good.id ?? '');
      // Ignore stale responses if the user switched provider mid-request.
      if (!mounted || _selectedGood?.id != good.id) return;

      setState(() {
        if (response.success == true) {
          _packages = (response.data ?? [])
              .whereType<Map<String, dynamic>>()
              .map(_DataPackage.fromMap)
              .toList();
        } else {
          _packagesError = response.message ?? "Failed to load packages";
        }
      });
    } catch (e) {
      if (!mounted || _selectedGood?.id != good.id) return;
      setState(() => _packagesError = e.toString());
    } finally {
      if (mounted && _selectedGood?.id == good.id) {
        setState(() => _isLoadingPackages = false);
      }
    }
  }

  void _onProductTapped(int index, DigitalGood? good) {
    final isDeselecting = good == null || _selectedIndex == index;
    setState(() {
      _selectedIndex = isDeselecting ? null : index;
      _selectedPackageCode = null;
      _selectedPinPackageCode = null;
      _numberOfPins = 1;
      _packages = [];
      _packagesError = null;
      _customerAccount = null;
    });

    if (!isDeselecting &&
        widget.utilityType == ShopperConstants.buyDataBundle) {
      _loadDataPackages(good);
    }
  }

  void _resetCustomerAccount() {
    if (_customerAccount == null) return;
    setState(() {
      _customerAccount = null;
      _amountController.clear();
    });
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }

  /// Converts the local input (with or without the leading 0) to E.164.
  String? _formatPhone() {
    var digits = _phoneController.text.trim();
    if (digits.startsWith('0')) digits = digits.substring(1);
    if (digits.length != 10) return null;
    return '+234$digits';
  }

  /// Validates the form and returns what the checkout needs, or null (after
  /// showing the reason) if something is missing.
  BuyerDigitalGoodCheckoutScreen? _buildCheckout(DigitalGood good) {
    if (_isSpectranet) {
      final package = _packages.firstWhereOrNull(
        (pkg) => pkg.code == _selectedPinPackageCode,
      );
      final amount = num.tryParse(package?.price ?? '')?.round();
      if (amount == null) {
        _showMessage("Please select an amount");
        return null;
      }
      return BuyerDigitalGoodCheckoutScreen(
        good: good,
        purchaseDetail: {"number_of_pins": _numberOfPins, "amount": amount},
        totalPrice: amount * _numberOfPins,
      );
    }

    final phone = _formatPhone();
    if (phone == null) {
      _showMessage("Please enter a valid phone number");
      return null;
    }

    if (widget.utilityType == ShopperConstants.buyDataBundle) {
      final package = _packages.firstWhereOrNull(
        (pkg) => pkg.code == _selectedPackageCode,
      );
      if (package == null) {
        _showMessage("Please select a package");
        return null;
      }
      return BuyerDigitalGoodCheckoutScreen(
        good: good,
        purchaseDetail: {"phone": phone, "package": package.code},
        totalPrice: num.tryParse(package.price) ?? 0,
        subtitle: phone,
        packageLabel: package.label,
      );
    }

    final amount = int.tryParse(_amountController.text.trim());
    if (amount == null || amount <= 0) {
      _showMessage("Please enter a valid amount");
      return null;
    }

    if (_isElectricity) {
      final account = _customerAccount!;
      final min = account.minAmount;
      final max = account.maxAmount;
      if (min != null && amount < min) {
        _showMessage("Amount must be at least ₦$min");
        return null;
      }
      if (max != null && amount > max) {
        _showMessage("Amount must not exceed ₦$max");
        return null;
      }
      final meterNo = _meterNoController.text.trim();
      return BuyerDigitalGoodCheckoutScreen(
        good: good,
        purchaseDetail: {
          "phone": phone,
          "amount": amount,
          "meter_type": _meterType.toLowerCase(),
          "meter_no": meterNo,
        },
        totalPrice: amount,
        subtitle: meterNo,
      );
    }

    return BuyerDigitalGoodCheckoutScreen(
      good: good,
      purchaseDetail: {"phone": phone, "amount": amount},
      totalPrice: amount,
      subtitle: phone,
    );
  }

  Future<void> _onSubmit() async {
    final good = _selectedGood;
    if (good == null) {
      _showMessage("Please select a provider");
      return;
    }

    if (_isElectricity && _electricityStep == 1) {
      setState(() => _electricityStep = 2);
      return;
    }

    if (_isElectricity && _customerAccount == null) {
      await _validateMeter(good);
      return;
    }

    final checkout = _buildCheckout(good);
    if (checkout == null) return;

    final isCompleted = await Navigator.of(
      context,
    ).push<bool>(MaterialPageRoute(builder: (_) => checkout));
    if (isCompleted == true && mounted) Navigator.of(context).pop();
  }

  Future<void> _validateMeter(DigitalGood good) async {
    final meterNo = _meterNoController.text.trim();
    if (meterNo.isEmpty) {
      _showMessage("Please enter your meter number");
      return;
    }
    if (_formatPhone() == null) {
      _showMessage("Please enter a valid phone number");
      return;
    }

    await _runSubmitting(() async {
      final repo = context.read<NetworkProvider>().shopperNetworkRepo;
      final response = await repo.validateUtilityCustomerAccount(
        good.id ?? '',
        meterNo: meterNo,
        meterType: _meterType.toLowerCase(),
      );
      if (!mounted) return;

      if (response.success == true && response.data != null) {
        setState(() {
          _customerAccount = response.data;
          _amountController.clear();
        });
      } else {
        _showMessage(response.message ?? "Meter number is invalid.");
      }
    });
  }

  Future<void> _runSubmitting(Future<void> Function() action) async {
    setState(() => _isSubmitting = true);
    try {
      await action();
    } catch (e) {
      if (mounted) _showMessage(e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  String get _submitLabel {
    if (_isElectricity && (_electricityStep == 1 || _customerAccount == null)) {
      return "Next";
    }
    return "Buy Now";
  }

  @override
  Widget build(BuildContext context) {
    final showMeterStep = _isElectricity && _electricityStep == 2;

    return PopScope(
      canPop: !showMeterStep,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop && showMeterStep) {
          setState(() {
            _electricityStep = 1;
            _customerAccount = null;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text(widget.utilityType.first)),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (showMeterStep)
                    _buildSelectedProviderHeader(_selectedGood!)
                  else
                    ..._buildProviderPicker(context),
                  if (_selectedGood != null && _errorMessage == null) ...[
                    if (!_isElectricity || showMeterStep) ...[
                      const SizedBox(height: 20),
                      _buildDataCollectionForm(),
                    ],
                    const SizedBox(height: 24),
                    _buildSubmitButton(),
                  ],
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildProviderPicker(BuildContext context) {
    return [
      Text(
        "Please select a provider",
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.titleLarge,
      ),
      const SizedBox(height: 10),
      if (_errorMessage != null)
        _buildErrorView(_errorMessage!, () {
          setState(() {
            _errorMessage = null;
            _utilityProducts = [null, null, null];
          });
          _loadUtilityProducts(context);
        })
      else if (_utilityProducts.isEmpty)
        const Padding(
          padding: EdgeInsets.all(24.0),
          child: Text("No providers available", textAlign: TextAlign.center),
        )
      else
        Wrap(
          alignment: WrapAlignment.center,
          spacing: 7,
          runSpacing: 4,
          children: _utilityProducts
              .mapIndexed(
                (index, good) => _buildUtilityProductCard(
                  context,
                  index,
                  (_selectedIndex == index),
                  good,
                  () => _onProductTapped(index, good),
                ),
              )
              .toList(),
        ),
    ];
  }

  Widget _buildErrorView(String message, VoidCallback onRetry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.redAccent),
          ),
          TextButton(onPressed: onRetry, child: const Text("Retry")),
        ],
      ),
    );
  }

  Widget _buildSelectedProviderHeader(DigitalGood good) {
    return Column(
      children: [
        _buildProductImage(good),
        const SizedBox(height: 6),
        Text(
          good.name ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSubmitButton() {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 48,
        width: 140,
        child: ElevatedButton(
          onPressed: _isSubmitting ? null : _onSubmit,
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
              : Text(
                  _submitLabel,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
        ),
      ),
    );
  }

  Widget _buildDataCollectionForm() {
    if (widget.utilityType == ShopperConstants.buyAirtime) {
      return _buildAirtimeForm(
        phoneController: _phoneController,
        amountController: _amountController,
      );
    } else if (widget.utilityType == ShopperConstants.buyDataBundle) {
      return _buildDataBundleForm(
        packages: _packages,
        isSpectranet: _isSpectranet,
        phoneController: _phoneController,
        selectedPackage: _selectedPackageCode,
        onPackageChanged: (code) => setState(() => _selectedPackageCode = code),
        numberOfPins: _numberOfPins,
        onPinsChanged: (count) => setState(() => _numberOfPins = count),
        selectedPinPackage: _selectedPinPackageCode,
        onPinPackageChanged: (code) =>
            setState(() => _selectedPinPackageCode = code),
      );
    } /*else if (widget.utilityType == ShopperConstants.payBill) {
      return _buildBillForm();
    }*/ else if (widget.utilityType == ShopperConstants.payElectricityBill) {
      return _buildElectricityForm(
        selectedMeterType: _meterType,
        onMeterTypeChanged: (type) {
          setState(() => _meterType = type);
          _resetCustomerAccount();
        },
        meterNoController: _meterNoController,
        phoneController: _phoneController,
        onMeterNoChanged: (_) => _resetCustomerAccount(),
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _buildProductImage(DigitalGood good) {
    final image = good.image ?? '';
    final imageUrl = image.startsWith('http')
        ? image
        : '${AppConfig.cdnBaseUrl}$image';

    return CachedNetworkImage(
      imageUrl: imageUrl,
      height: 50,
      width: 120,
      fit: BoxFit.contain,
      errorWidget: (context, url, error) => Container(
        height: 50,
        width: 120,
        color: AppTheme.primaryBlue,
        child: Center(
          child: FittedBox(
            child: Text(good.name?.split(" ").first.toUpperCase() ?? ''),
          ),
        ),
      ),
      placeholder: (context, url) =>
          Container(height: 50, width: 120, color: Colors.grey[200]),
    );
  }

  Widget _buildUtilityProductCard(
    BuildContext ctx,
    int index,
    bool isSelected,
    DigitalGood? good,
    VoidCallback onTap,
  ) {
    if (good == null) {
      return ShimmerCardLoader(width: 120, imageHeight: 50);
    }

    return Card(
      elevation: 1,
      color: isSelected ? const Color(0xFFFFF2DE) : const Color(0xFFF4F4F4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? const Color(0xFFF5D9A8) : const Color(0xFFE6E6E6),
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => onTap(),
        child: Opacity(
          opacity: isSelected ? 1 : 0.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _buildProductImage(good),
                const SizedBox(height: 4),
                SizedBox(
                  width: 120,
                  child: Text(
                    good.name ?? "",
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFieldLabel(String label, {bool isRequired = true}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6.0),
      child: RichText(
        text: TextSpan(
          text: label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          children: isRequired
              ? const [
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.redAccent),
                  ),
                ]
              : [],
        ),
      ),
    );
  }

  InputDecoration _inputOutlineDecoration({
    String? hintText,
    Widget? prefix,
    Widget? prefixIcon,
    Widget? suffixIcon,
  }) {
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.black38, fontSize: 14),
      prefix: prefix,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      filled: true,
      fillColor: Colors.white,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: const BorderSide(color: Color(0xFFE0E0E0), width: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(6.0),
        borderSide: const BorderSide(color: Color(0xFF2979FF), width: 1.4),
      ),
    );
  }

  Widget _buildPhoneNumberField({
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Phone Number'),
        Row(
          children: [
            // Static Nigerian Prefix Box
            Container(
              height: 48,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: const Color(0xFFF7F7F8),
                borderRadius: BorderRadius.circular(6.0),
                border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
              ),
              alignment: Alignment.center,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('🇳🇬', style: TextStyle(fontSize: 16)),
                  SizedBox(width: 6),
                  Text(
                    '+234',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),

            // Dynamic Number Input
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextFormField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  onChanged: onChanged,
                  decoration: _inputOutlineDecoration(hintText: '8012345678'),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildAmountField({
    TextEditingController? controller,
    ValueChanged<String>? onChanged,
    String? hintText,
  }) {
    return SizedBox(
      height: 48,
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        onChanged: onChanged,
        decoration: _inputOutlineDecoration(
          hintText: hintText,
          prefix: const Padding(
            padding: EdgeInsets.only(right: 6.0),
            child: Text(
              '₦',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAirtimeForm({
    TextEditingController? phoneController,
    TextEditingController? amountController,
    ValueChanged<String>? onPhoneChanged,
    ValueChanged<String>? onAmountChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPhoneNumberField(
          controller: phoneController,
          onChanged: onPhoneChanged,
        ),
        const SizedBox(height: 16),
        _buildFieldLabel('Amount'),
        _buildAmountField(
          controller: amountController,
          onChanged: onAmountChanged,
        ),
      ],
    );
  }

  Widget _buildPackagesStatus() {
    if (_isLoadingPackages) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Center(
          child: SizedBox(
            height: 24,
            width: 24,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }
    return _buildErrorView(_packagesError!, () {
      final good = _selectedGood;
      if (good != null) _loadDataPackages(good);
    });
  }

  Widget _buildDataBundleForm({
    required List<_DataPackage> packages,
    bool isSpectranet = false,
    TextEditingController? phoneController,
    String? selectedPackage,
    ValueChanged<String?>? onPackageChanged,
    int numberOfPins = 1,
    ValueChanged<int>? onPinsChanged,
    String? selectedPinPackage,
    ValueChanged<String?>? onPinPackageChanged,
  }) {
    final isPackagesPending = _isLoadingPackages || _packagesError != null;

    if (isSpectranet) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldLabel('Number of Pins'),
          SizedBox(
            height: 48,
            child: DropdownButtonFormField<int>(
              initialValue: numberOfPins,
              decoration: _inputOutlineDecoration(),
              items: [1, 2, 3, 4, 5].map((count) {
                return DropdownMenuItem<int>(
                  value: count,
                  child: Text('$count'),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null && onPinsChanged != null) onPinsChanged(val);
              },
            ),
          ),
          const SizedBox(height: 16),
          _buildFieldLabel('Amount'),
          if (isPackagesPending)
            _buildPackagesStatus()
          else if (packages.isEmpty)
            SizedBox(
              height: 48,
              child: TextFormField(
                enabled: false,
                decoration: _inputOutlineDecoration(
                  hintText: 'No options provided',
                ),
              ),
            )
          else
            DropdownButtonFormField<String>(
              key: ValueKey('pins-${_selectedGood?.id}'),
              initialValue: selectedPinPackage,
              isExpanded: true,
              hint: const Text('Select an amount'),
              decoration: _inputOutlineDecoration(),
              items: packages.map((pkg) {
                return DropdownMenuItem<String>(
                  value: pkg.code,
                  child: Text(
                    pkg.label,
                    style: const TextStyle(fontSize: 14),
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: onPinPackageChanged,
            ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildPhoneNumberField(controller: phoneController),
        const SizedBox(height: 16),
        _buildFieldLabel('Package'),
        if (isPackagesPending)
          _buildPackagesStatus()
        else
          DropdownButtonFormField<String>(
            // Rebuild per provider so the previous selection doesn't linger.
            key: ValueKey('packages-${_selectedGood?.id}'),
            initialValue: selectedPackage,
            isExpanded: true,
            hint: Text(
              packages.isEmpty ? 'No options provided' : 'Select a package',
            ),
            decoration: _inputOutlineDecoration(),
            items: packages.map((pkg) {
              return DropdownMenuItem<String>(
                value: pkg.code,
                child: Text(
                  pkg.label,
                  style: const TextStyle(fontSize: 14),
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList(),
            onChanged: onPackageChanged,
          ),
      ],
    );
  }

  Widget _buildElectricityForm({
    String selectedMeterType = 'Prepaid', // 'Prepaid' or 'Postpaid'
    ValueChanged<String>? onMeterTypeChanged,
    TextEditingController? meterNoController,
    TextEditingController? phoneController,
    ValueChanged<String>? onMeterNoChanged,
    ValueChanged<String>? onPhoneChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildFieldLabel('Meter Type'),
        Row(
          children: ['Prepaid', 'Postpaid'].map((type) {
            final isSelected = selectedMeterType == type;
            return Expanded(
              child: GestureDetector(
                onTap: () {
                  if (onMeterTypeChanged != null) onMeterTypeChanged(type);
                },
                child: Container(
                  height: 46,
                  margin: EdgeInsets.only(right: type == 'Prepaid' ? 8.0 : 0),
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF2979FF) : Colors.white,
                    borderRadius: BorderRadius.circular(6.0),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF2979FF)
                          : const Color(0xFFE0E0E0),
                      width: 1.2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    type,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isSelected ? Colors.white : Colors.black87,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 16),
        _buildFieldLabel('Meter No'),
        SizedBox(
          height: 48,
          child: TextFormField(
            controller: meterNoController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: onMeterNoChanged,
            decoration: _inputOutlineDecoration(),
          ),
        ),
        const SizedBox(height: 16),
        _buildPhoneNumberField(
          controller: phoneController,
          onChanged: onPhoneChanged,
        ),
        if (_customerAccount != null) ...[
          const SizedBox(height: 16),
          _buildCustomerAccountSummary(_customerAccount!),
          const SizedBox(height: 16),
          _buildFieldLabel('Amount'),
          _buildAmountField(
            controller: _amountController,
            hintText: _amountRangeHint(_customerAccount!),
          ),
        ],
      ],
    );
  }

  String? _amountRangeHint(UtilityCustomerAccount account) {
    final min = account.minAmount;
    final max = account.maxAmount;
    if (min != null && max != null) return 'Between $min and $max';
    if (min != null) return 'Minimum $min';
    if (max != null) return 'Maximum $max';
    return null;
  }

  Widget _buildCustomerAccountSummary(UtilityCustomerAccount account) {
    final rows = <Pair<String, String>>[
      if (account.name?.isNotEmpty == true)
        Pair(first: 'Name', second: account.name!),
      if (account.address?.isNotEmpty == true)
        Pair(first: 'Address', second: account.address!),
      if (account.outstanding != null)
        Pair(first: 'Outstanding', second: '₦${account.outstanding}'),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F7F8),
        borderRadius: BorderRadius.circular(6.0),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: rows
            .map(
              (row) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text.rich(
                  TextSpan(
                    text: '${row.first}: ',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                    children: [
                      TextSpan(
                        text: row.second,
                        style: const TextStyle(fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                  style: const TextStyle(fontSize: 14, color: Colors.black87),
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}

// The data-packages endpoint still returns untyped maps, so only the fields
// the form needs are pulled out here.
class _DataPackage {
  const _DataPackage({
    required this.code,
    required this.price,
    required this.label,
  });

  final String code;
  final String price;
  final String label;

  factory _DataPackage.fromMap(Map<String, dynamic> map) {
    final price = map['price']?.toString() ?? '';
    return _DataPackage(
      code: map['code']?.toString() ?? '',
      price: price,
      label: map['label']?.toString() ?? '₦$price',
    );
  }
}
