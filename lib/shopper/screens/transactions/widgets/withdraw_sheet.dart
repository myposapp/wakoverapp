import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/shopper/models/bank_model.dart';
import 'package:wakover/shopper/models/bank_transfer_model.dart';
import 'package:wakover/shopper/models/shopper_user_model.dart';
import 'package:wakover/shopper/widgets/hub/formatters.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/theme/app_theme.dart';

/// Withdrawals need at least 80% KYC completion, matching the web dashboard.
const _minKycCompletion = 0.8;

/// Resolves to true once the withdrawal has been confirmed with the OTP.
Future<bool?> showWithdrawSheet(
  BuildContext context, {
  required ShopperUser user,
}) {
  final kycComplete = (user.kyc?.completion ?? 0) >= _minKycCompletion;
  return showHubSheet<bool>(
    context,
    title: kycComplete ? 'Withdraw' : 'Verify your identity',
    child: kycComplete
        ? _WithdrawFlow(balance: user.walletBalance ?? 0)
        : const _KycRequired(),
  );
}

class _KycRequired extends StatelessWidget {
  const _KycRequired();

  @override
  Widget build(BuildContext context) {
    final origin = context.read<NetworkProvider>().storeOrigin;
    return HubMessage(
      icon: Icons.verified_user_outlined,
      title: 'Complete your KYC',
      message:
          'For your security, withdrawals are available once your identity '
          'verification is complete. You can finish it on the store website.',
      actionLabel: origin == null ? null : 'Continue on web',
      onAction: origin == null
          ? null
          : () => openExternalUrl(context, '$origin/dashboard/transactions'),
    );
  }
}

class _WithdrawFlow extends StatefulWidget {
  const _WithdrawFlow({required this.balance});

  final num balance;

  @override
  State<_WithdrawFlow> createState() => _WithdrawFlowState();
}

class _WithdrawFlowState extends State<_WithdrawFlow> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _accountController = TextEditingController();
  final _remarkController = TextEditingController();
  final _otpController = TextEditingController();

  List<Bank>? _banks;
  String? _banksError;
  Bank? _bank;
  BankTransferRequest? _request;
  bool _isSubmitting = false;
  bool _isResending = false;
  String? _otpError;
  Timer? _cooldownTimer;
  int _cooldownSeconds = 0;

  @override
  void initState() {
    super.initState();
    _loadBanks();
  }

  @override
  void dispose() {
    _cooldownTimer?.cancel();
    _amountController.dispose();
    _accountController.dispose();
    _remarkController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  NetworkProvider get _network => context.read<NetworkProvider>();

  Future<void> _loadBanks() async {
    setState(() {
      _banks = null;
      _banksError = null;
    });
    try {
      final response = await _network.shopperNetworkRepo.getBanks();
      if (!mounted) return;
      setState(() {
        if (response.success == true) {
          _banks = response.data ?? [];
        } else {
          _banksError = response.message ?? 'Could not load banks.';
        }
      });
    } catch (e) {
      if (mounted) setState(() => _banksError = e.toString());
    }
  }

  void _startCooldown(String? validTill) {
    _cooldownTimer?.cancel();
    final until = DateTime.tryParse(validTill ?? '');
    final seconds = until == null
        ? 0
        : until.difference(DateTime.now()).inSeconds;
    setState(() => _cooldownSeconds = seconds > 0 ? seconds : 0);
    if (_cooldownSeconds == 0) return;

    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted || _cooldownSeconds <= 1) {
        timer.cancel();
        if (mounted) setState(() => _cooldownSeconds = 0);
        return;
      }
      setState(() => _cooldownSeconds--);
    });
  }

  Future<void> _initiate() async {
    if (!_formKey.currentState!.validate()) return;
    final bank = _bank;
    if (bank == null) {
      showHubSnack(context, 'Please select a bank.');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final remark = _remarkController.text.trim();
      final response = await _network.shopperNetworkRepo.initiateBankTransfer(
        amount: int.parse(_amountController.text.trim()),
        bankName: bank.name ?? '',
        bankCode: bank.code ?? '',
        accountNumber: _accountController.text.trim(),
        remark: remark.isEmpty ? null : remark,
      );
      if (!mounted) return;

      if (response.success == true && response.data != null) {
        setState(() => _request = response.data);
        _startCooldown(response.data!.otpValidTill);
        if (response.message != null) showHubSnack(context, response.message!);
      } else {
        showHubSnack(context, response.message ?? 'Could not start transfer.');
      }
    } catch (e) {
      if (mounted) showHubSnack(context, e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _resendOtp() async {
    final requestId = _request?.requestId;
    if (requestId == null) return;
    setState(() => _isResending = true);
    try {
      final response = await _network.shopperNetworkRepo.resendBankTransferOtp(
        requestId,
      );
      if (!mounted) return;
      if (response.success == true) {
        _otpController.clear();
        setState(() => _otpError = null);
        _startCooldown(response.data?.otpValidTill);
        showHubSnack(
          context,
          'A new OTP has been sent. Don\'t forget to check your spam folder.',
        );
      } else {
        showHubSnack(context, response.message ?? 'Could not resend the OTP.');
      }
    } catch (e) {
      if (mounted) showHubSnack(context, e.toString());
    } finally {
      if (mounted) setState(() => _isResending = false);
    }
  }

  Future<void> _confirm() async {
    final code = _otpController.text.trim();
    if (code.length < 6 || code.length > 8) {
      setState(() => _otpError = 'Please enter the valid OTP');
      return;
    }

    setState(() {
      _isSubmitting = true;
      _otpError = null;
    });
    try {
      final response = await _network.shopperNetworkRepo.validateBankTransfer(
        requestId: _request!.requestId ?? '',
        code: code,
      );
      if (!mounted) return;

      if (response.success == true) {
        Navigator.of(context).pop(true);
      } else if (response.errors is Map &&
          response.errors['field'] == 'body.code') {
        setState(() => _otpError = response.message);
      } else {
        showHubSnack(
          context,
          response.message ?? 'Could not confirm transfer.',
        );
      }
    } catch (e) {
      if (mounted) showHubSnack(context, e.toString());
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _startOver() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Start over?'),
        content: const Text(
          'You\'ll need to enter the transfer details again.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            child: const Text('Yes'),
          ),
        ],
      ),
    );
    if (confirmed == true && mounted) {
      _cooldownTimer?.cancel();
      _otpController.clear();
      setState(() {
        _request = null;
        _otpError = null;
      });
    }
  }

  InputDecoration _decoration(String label, {String? prefix, String? hint}) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: hubBorder(context)),
    );
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixText: prefix,
      filled: true,
      fillColor: Theme.of(context).cardColor,
      border: border,
      enabledBorder: border,
    );
  }

  @override
  Widget build(BuildContext context) {
    final request = _request;
    return request == null ? _buildDetailsStep() : _buildOtpStep(request);
  }

  Widget _buildDetailsStep() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: hubTint(context),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.account_balance_wallet_outlined,
                  color: AppTheme.primaryBlue,
                ),
                const SizedBox(width: 10),
                const Text('Available', style: TextStyle(fontSize: 12)),
                const Spacer(),
                Text(
                  formatNaira(widget.balance),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: _decoration('Amount', prefix: '₦ '),
            validator: (value) {
              final amount = int.tryParse(value ?? '');
              if (amount == null) return 'Please enter an amount';
              if (amount < 10) return 'Minimum amount is ₦10';
              if (amount > widget.balance) {
                return 'Maximum amount is ${formatNaira(widget.balance)}';
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          _buildBankField(),
          const SizedBox(height: 12),
          TextFormField(
            controller: _accountController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10),
            ],
            decoration: _decoration('Account Number'),
            validator: (value) => (value ?? '').length == 10
                ? null
                : 'Enter the 10-digit account number',
          ),
          const SizedBox(height: 12),
          TextFormField(
            controller: _remarkController,
            maxLength: 250,
            decoration: _decoration('Remark (optional)'),
          ),
          const SizedBox(height: 4),
          HubPrimaryButton(
            label: 'Proceed',
            expand: true,
            isBusy: _isSubmitting,
            onPressed: _banks == null ? null : _initiate,
          ),
        ],
      ),
    );
  }

  Widget _buildBankField() {
    if (_banksError != null) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.redAccent.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            const Icon(Icons.error_outline_rounded, color: Colors.redAccent),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Couldn\'t load banks: $_banksError',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            TextButton(onPressed: _loadBanks, child: const Text('Retry')),
          ],
        ),
      );
    }

    final banks = _banks;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: banks == null
          ? null
          : () async {
              final picked = await _pickBank(context, banks);
              if (picked != null) setState(() => _bank = picked);
            },
      child: InputDecorator(
        decoration: _decoration('Bank').copyWith(
          suffixIcon: banks == null
              ? const Padding(
                  padding: EdgeInsets.all(14),
                  child: SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              : const Icon(Icons.expand_more_rounded),
        ),
        child: Text(
          _bank?.name ?? (banks == null ? 'Loading banks…' : 'Select a bank'),
          style: TextStyle(
            fontSize: 14,
            color: _bank == null ? hubMutedText(context) : null,
          ),
        ),
      ),
    );
  }

  Widget _buildOtpStep(BankTransferRequest request) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppTheme.navyDark, AppTheme.primaryBlue],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Withdraw amount',
                style: TextStyle(color: Colors.white70, fontSize: 11),
              ),
              Text(
                formatNaira(request.amount),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        HubInfoRow(label: 'Bank', value: request.bankName ?? '—'),
        HubInfoRow(
          label: 'Account Number',
          value: request.accountNumber ?? '—',
        ),
        HubInfoRow(label: 'Account Name', value: request.accountName ?? '—'),
        if (request.remark?.isNotEmpty == true)
          HubInfoRow(label: 'Remark', value: request.remark!),
        const SizedBox(height: 16),
        Text(
          'Enter the OTP sent to your ${request.verificationMethod ?? 'email'}.',
          style: TextStyle(fontSize: 12, color: hubMutedText(context)),
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _otpController,
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(8),
          ],
          style: const TextStyle(
            fontSize: 22,
            letterSpacing: 8,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (_) {
            if (_otpError != null) setState(() => _otpError = null);
          },
          decoration: _decoration('OTP').copyWith(errorText: _otpError),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Didn\'t get the code?',
              style: TextStyle(fontSize: 12, color: hubMutedText(context)),
            ),
            TextButton(
              onPressed: _isResending || _cooldownSeconds > 0
                  ? null
                  : _resendOtp,
              child: Text(
                _isResending
                    ? 'Resending…'
                    : _cooldownSeconds > 0
                    ? 'Resend in ${_cooldownSeconds ~/ 60}:'
                          '${(_cooldownSeconds % 60).toString().padLeft(2, '0')}'
                    : 'Resend',
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        HubPrimaryButton(
          label: 'Confirm Withdrawal',
          expand: true,
          isBusy: _isSubmitting,
          onPressed: _confirm,
        ),
        TextButton.icon(
          onPressed: _isSubmitting ? null : _startOver,
          icon: const Icon(Icons.restart_alt_rounded, size: 16),
          label: const Text('Start over'),
        ),
      ],
    );
  }
}

Future<Bank?> _pickBank(BuildContext context, List<Bank> banks) {
  return showHubSheet<Bank>(
    context,
    title: 'Select Bank',
    child: _BankPicker(banks: banks),
  );
}

class _BankPicker extends StatefulWidget {
  const _BankPicker({required this.banks});

  final List<Bank> banks;

  @override
  State<_BankPicker> createState() => _BankPickerState();
}

class _BankPickerState extends State<_BankPicker> {
  String _query = '';

  @override
  Widget build(BuildContext context) {
    final query = _query.toLowerCase();
    final results = widget.banks
        .where((b) => (b.name ?? '').toLowerCase().contains(query))
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextField(
          autofocus: true,
          onChanged: (value) => setState(() => _query = value),
          decoration: InputDecoration(
            hintText: 'Search banks',
            prefixIcon: const Icon(Icons.search_rounded),
            filled: true,
            fillColor: Theme.of(context).cardColor,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide.none,
            ),
          ),
        ),
        const SizedBox(height: 8),
        if (results.isEmpty)
          Padding(
            padding: const EdgeInsets.all(24),
            child: Text(
              'No banks match "$_query".',
              textAlign: TextAlign.center,
              style: TextStyle(color: hubMutedText(context)),
            ),
          ),
        for (final bank in results)
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleAvatar(
              backgroundColor: hubTint(context),
              child: const Icon(
                Icons.account_balance_rounded,
                size: 18,
                color: AppTheme.primaryBlue,
              ),
            ),
            title: Text(bank.name ?? '', style: const TextStyle(fontSize: 13)),
            onTap: () => Navigator.of(context).pop(bank),
          ),
      ],
    );
  }
}
