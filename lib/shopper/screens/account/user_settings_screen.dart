import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/common/utils/phone.dart';
import 'package:wakover/providers/app_provider.dart';
import 'package:wakover/router/app_routes.dart';
import 'package:wakover/shopper/models/shopper_user_model.dart';
import 'package:wakover/shopper/providers/user_session_provider.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/theme/app_theme.dart';

final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  final _profileFormKey = GlobalKey<FormState>();
  final _passwordFormKey = GlobalKey<FormState>();
  final _nameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _oldPasswordCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _bvnCtrl = TextEditingController();
  final _ninCtrl = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _isSavingProfile = false;
  bool _isSavingPassword = false;
  bool _isSavingCampaigns = false;
  bool _isSubmittingKyc = false;

  // Server-side validation errors, keyed by field name.
  final Map<String, String?> _fieldErrors = {};

  PlatformFile? _licenseFile;

  // The user the form fields were last filled from.
  ShopperUser? _filledFrom;

  @override
  void initState() {
    super.initState();
    for (final ctrl in [_nameCtrl, _emailCtrl, _phoneCtrl]) {
      // Rebuild so "Save Changes" enables as soon as something differs.
      ctrl.addListener(() => setState(() {}));
    }
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<UserSessionProvider>().refreshProfile(),
    );
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _oldPasswordCtrl.dispose();
    _newPasswordCtrl.dispose();
    _bvnCtrl.dispose();
    _ninCtrl.dispose();
    super.dispose();
  }

  /// Fills the form from the profile the first time it loads, and again after
  /// it changes on the server (e.g. a refresh), without clobbering typing.
  void _fillFrom(ShopperUser user) {
    if (identical(user, _filledFrom)) return;
    final previous = _filledFrom;
    _filledFrom = user;

    void sync(TextEditingController ctrl, String? oldValue, String? value) {
      if (previous == null || ctrl.text == (oldValue ?? '')) {
        ctrl.text = value ?? '';
      }
    }

    sync(_nameCtrl, previous?.name, user.name);
    sync(_emailCtrl, previous?.email, user.email);
    sync(_phoneCtrl, previous?.phone, user.phone);
    sync(_bvnCtrl, _kycText(previous, 'bvn'), _kycText(user, 'bvn'));
    sync(_ninCtrl, _kycText(previous, 'nin'), _kycText(user, 'nin'));
  }

  static Map? _kycDoc(ShopperUser? user, String type) {
    for (final doc in user?.kyc?.docs ?? const []) {
      if (doc is Map && doc['doc_type'] == type) return doc;
    }
    return null;
  }

  static String? _kycText(ShopperUser? user, String type) {
    final doc = _kycDoc(user, type);
    return doc == null || doc['content_type'] == 'file'
        ? null
        : doc['content']?.toString();
  }

  bool _profileChanged(ShopperUser user) =>
      _nameCtrl.text.trim() != (user.name ?? '') ||
      _emailCtrl.text.trim() != (user.email ?? '') ||
      _normalizedPhone() != (user.phone ?? '');

  /// Nigerian numbers are stored as +234…; other formats are kept as typed.
  String _normalizedPhone() {
    final text = _phoneCtrl.text.trim();
    return toNigerianE164(text) ?? text;
  }

  void _toast(String message) => context.read<AppProvider>().showToast(message);

  void _applyServerError(AuthResult result, {String? fallbackField}) {
    const fields = {'name', 'email', 'phone', 'old_password', 'new_password'};
    setState(() {
      if (fields.contains(result.field)) {
        _fieldErrors[result.field!] = result.message;
      } else if (fallbackField != null) {
        _fieldErrors[fallbackField] = result.message;
      }
    });
    if (!fields.contains(result.field) && fallbackField == null) {
      _toast(result.message ?? 'Something went wrong.');
    }
  }

  Future<void> _saveProfile() async {
    setState(_fieldErrors.clear);
    if (!_profileFormKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    setState(() => _isSavingProfile = true);
    final result = await context.read<UserSessionProvider>().updateProfile(
      name: _nameCtrl.text.trim(),
      email: _emailCtrl.text.trim(),
      phone: _normalizedPhone(),
    );
    if (!mounted) return;
    setState(() => _isSavingProfile = false);

    if (result.success) {
      _toast('Profile details updated.');
    } else {
      _applyServerError(result);
    }
  }

  Future<void> _savePassword(ShopperUser user) async {
    setState(_fieldErrors.clear);
    if (!_passwordFormKey.currentState!.validate()) return;
    FocusScope.of(context).unfocus();

    setState(() => _isSavingPassword = true);
    // The API changes the password through the profile endpoint, which also
    // expects the current details.
    final result = await context.read<UserSessionProvider>().updateProfile(
      name: user.name ?? '',
      email: user.email ?? '',
      phone: user.phone ?? '',
      oldPassword: _oldPasswordCtrl.text,
      newPassword: _newPasswordCtrl.text,
    );
    if (!mounted) return;
    setState(() => _isSavingPassword = false);

    if (result.success) {
      _oldPasswordCtrl.clear();
      _newPasswordCtrl.clear();
      TextInput.finishAutofillContext();
      _toast('Password updated successfully.');
    } else {
      // Password errors are usually about the old password.
      _applyServerError(result, fallbackField: 'old_password');
    }
  }

  Future<void> _setShowCampaigns(bool show) async {
    setState(() => _isSavingCampaigns = true);
    final error = await context.read<UserSessionProvider>().setShowCampaigns(
      show,
    );
    if (!mounted) return;
    setState(() => _isSavingCampaigns = false);
    _toast(
      error ??
          (show ? 'Campaigns are now visible.' : 'Campaigns are now hidden.'),
    );
  }

  Future<void> _pickLicense() async {
    // Null when the user cancels.
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['jpg', 'jpeg', 'png', 'pdf'],
    );
    final file = result?.files.singleOrNull;
    if (file?.path == null) return;
    setState(() => _licenseFile = file);
  }

  Future<void> _submitKyc(ShopperUser user) async {
    final bvn = _bvnCtrl.text.trim();
    final nin = _ninCtrl.text.trim();
    final existingLicense = _kycDoc(user, 'driving_license');
    final hasLicense = _licenseFile != null || existingLicense != null;

    if (bvn.isEmpty && nin.isEmpty && !hasLicense) {
      _toast('Please fill at least one field.');
      return;
    }
    for (final (label, value) in [('BVN', bvn), ('NIN', nin)]) {
      if (value.isNotEmpty && !RegExp(r'^\d{11}$').hasMatch(value)) {
        _toast('Your $label should be 11 digits.');
        return;
      }
    }

    FocusScope.of(context).unfocus();
    setState(() => _isSubmittingKyc = true);
    final error = await context.read<UserSessionProvider>().submitKyc(
      bvn: bvn.isEmpty ? null : bvn,
      nin: nin.isEmpty ? null : nin,
      licenseFilePath: _licenseFile?.path,
      // Re-send the file already on record so it isn't cleared.
      existingLicense: _licenseFile == null && existingLicense != null
          ? {'url': existingLicense['content']}
          : null,
    );
    if (!mounted) return;
    setState(() => _isSubmittingKyc = false);

    if (error == null) {
      setState(() => _licenseFile = null);
      _toast('Verification details submitted for review.');
    } else {
      _toast(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final session = context.watch<UserSessionProvider>();
    final user = session.user;
    if (user != null) _fillFrom(user);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => context.pop(),
        ),
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: session.refreshProfile,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user != null) ...[
                  ..._buildProfileSection(user),
                  ..._buildPasswordSection(user),
                  ..._buildAccountSection(session),
                ] else if (session.isSignedIn && session.isRestoring)
                  const Padding(
                    padding: EdgeInsets.all(40),
                    child: Center(child: CircularProgressIndicator()),
                  )
                else
                  ..._buildSignedOutSection(),
                ..._buildStoreSection(),
                if (user != null) ..._buildKycSection(user),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildSignedOutSection() {
    return [
      _sectionCard([
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: hubTint(context),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.lock_outline_rounded,
                color: AppTheme.primaryBlue,
              ),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                'Sign in to edit your profile, password and verification '
                'details.',
                style: TextStyle(fontSize: 12, height: 1.4),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildPrimaryButton('Sign in', () => context.push(AppRoutes.auth)),
      ]),
      const SizedBox(height: 22),
    ];
  }

  List<Widget> _buildProfileSection(ShopperUser user) {
    return [
      _sectionLabel('Profile Information'),
      const SizedBox(height: 8),
      _sectionCard([
        Form(
          key: _profileFormKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildField(
                label: 'Name',
                controller: _nameCtrl,
                errorText: _fieldErrors['name'],
                textCapitalization: TextCapitalization.words,
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (text.length < 3) return 'Please enter your full name';
                  if (text.length > 50) {
                    return 'Try a name shorter than 50 characters';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),
              _buildField(
                label: 'Email',
                controller: _emailCtrl,
                keyboardType: TextInputType.emailAddress,
                errorText: _fieldErrors['email'],
                validator: (value) =>
                    _emailPattern.hasMatch(value?.trim() ?? '')
                    ? null
                    : 'Please enter a valid email',
              ),
              const SizedBox(height: 14),
              _buildField(
                label: 'Phone',
                controller: _phoneCtrl,
                keyboardType: TextInputType.phone,
                errorText: _fieldErrors['phone'],
                validator: (value) {
                  final text = value?.trim() ?? '';
                  if (toNigerianE164(text) != null) return null;
                  // Allow international numbers entered with a country code.
                  return RegExp(r'^\+\d{10,15}$').hasMatch(text)
                      ? null
                      : 'Please enter a valid phone number';
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 18),
        _buildPrimaryButton(
          'Save Changes',
          _profileChanged(user) ? _saveProfile : null,
          isBusy: _isSavingProfile,
        ),
      ]),
      const SizedBox(height: 22),
    ];
  }

  List<Widget> _buildPasswordSection(ShopperUser user) {
    return [
      _sectionLabel('Update Password'),
      const SizedBox(height: 8),
      _sectionCard([
        AutofillGroup(
          child: Form(
            key: _passwordFormKey,
            child: Column(
              children: [
                _buildPasswordField(
                  label: 'Old Password',
                  controller: _oldPasswordCtrl,
                  obscure: _obscureOld,
                  errorText: _fieldErrors['old_password'],
                  autofillHints: const [AutofillHints.password],
                  onToggle: () => setState(() => _obscureOld = !_obscureOld),
                  validator: (value) => (value ?? '').isEmpty
                      ? 'Please enter your old password'
                      : null,
                ),
                const SizedBox(height: 14),
                _buildPasswordField(
                  label: 'New Password',
                  controller: _newPasswordCtrl,
                  obscure: _obscureNew,
                  errorText: _fieldErrors['new_password'],
                  autofillHints: const [AutofillHints.newPassword],
                  onToggle: () => setState(() => _obscureNew = !_obscureNew),
                  validator: (value) {
                    final text = value ?? '';
                    if (text.length < 8) {
                      return 'Password must be at least 8 characters';
                    }
                    if (text == _oldPasswordCtrl.text) {
                      return 'Choose a password different from the old one';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 18),
        _buildPrimaryButton(
          'Update Password',
          () => _savePassword(user),
          isBusy: _isSavingPassword,
        ),
      ]),
      const SizedBox(height: 22),
    ];
  }

  List<Widget> _buildAccountSection(UserSessionProvider session) {
    return [
      _sectionLabel('Account Settings'),
      const SizedBox(height: 8),
      _sectionCard([
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Show Campaigns',
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Display active merchant discounts and promo banners.',
                    style: TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            if (_isSavingCampaigns)
              const Padding(
                padding: EdgeInsets.only(right: 8),
                child: SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ),
            Switch(
              value: session.showsCampaigns,
              activeThumbColor: AppTheme.primaryBlue,
              onChanged: _isSavingCampaigns ? null : _setShowCampaigns,
            ),
          ],
        ),
      ]),
      const SizedBox(height: 22),
    ];
  }

  List<Widget> _buildStoreSection() {
    final origin = context.read<NetworkProvider>().storeOrigin;
    final host = origin == null ? null : Uri.tryParse(origin)?.host ?? origin;

    return [
      _sectionLabel('Marketplace'),
      const SizedBox(height: 8),
      _sectionCard([
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppTheme.navyDark,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  host != null && host.isNotEmpty ? host[0].toUpperCase() : 'W',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    host ?? 'No store connected',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    host != null
                        ? 'Currently connected store'
                        : 'Connect to a store',
                    style: TextStyle(
                      fontSize: 11,
                      color: hubMutedText(context),
                    ),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: () => context.push(AppRoutes.marketplace),
              child: const Text(
                'Change',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ]),
      const SizedBox(height: 22),
    ];
  }

  List<Widget> _buildKycSection(ShopperUser user) {
    final completion = (user.kyc?.completion ?? 0).clamp(0, 1).toDouble();
    final existingLicense = _kycDoc(user, 'driving_license');
    final licenseLabel =
        _licenseFile?.name ??
        (existingLicense != null ? 'License on file' : null);

    return [
      _sectionLabel('Identity Verification (KYC)'),
      const SizedBox(height: 8),
      _sectionCard([
        Row(
          children: [
            Expanded(
              child: Text(
                'Verify your identity to withdraw from your wallet.',
                style: TextStyle(fontSize: 11, color: hubMutedText(context)),
              ),
            ),
            Text(
              '${(completion * 100).round()}%',
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppTheme.primaryBlue,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: completion,
            minHeight: 6,
            backgroundColor: hubTint(context),
            color: completion >= 0.8
                ? const Color(0xFF2F855A)
                : AppTheme.primaryBlue,
          ),
        ),
        const SizedBox(height: 14),
        _buildField(
          label: 'BVN',
          controller: _bvnCtrl,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
        ),
        const SizedBox(height: 14),
        _buildField(
          label: 'NIN',
          controller: _ninCtrl,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(11),
          ],
        ),
        const SizedBox(height: 14),
        const Text(
          'Driving License',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        DottedUploadBox(onTap: _pickLicense, fileName: licenseLabel),
        const SizedBox(height: 6),
        Text(
          'JPG, JPEG, PNG, PDF',
          style: TextStyle(fontSize: 10, color: hubMutedText(context)),
        ),
        const SizedBox(height: 18),
        _buildPrimaryButton(
          'Submit',
          () => _submitKyc(user),
          isBusy: _isSubmittingKyc,
        ),
      ]),
      const SizedBox(height: 22),
    ];
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.6,
          color: Colors.grey.shade500,
        ),
      ),
    );
  }

  Widget _sectionCard(List<Widget> children) {
    return Builder(
      builder: (context) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: hubBorder(context)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  InputDecoration _fieldDecoration({String? errorText, Widget? suffixIcon}) {
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color),
    );
    return InputDecoration(
      isDense: true,
      filled: true,
      fillColor: Theme.of(context).scaffoldBackgroundColor,
      errorText: errorText,
      errorMaxLines: 2,
      suffixIcon: suffixIcon,
      contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
      border: border(hubBorder(context)),
      enabledBorder: border(hubBorder(context)),
      focusedBorder: border(Theme.of(context).primaryColor),
      errorBorder: border(Colors.redAccent),
      focusedErrorBorder: border(Colors.redAccent),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
    String? errorText,
    FormFieldValidator<String>? validator,
    List<TextInputFormatter>? inputFormatters,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          validator: validator,
          inputFormatters: inputFormatters,
          textCapitalization: textCapitalization,
          onChanged: (_) {
            if (errorText != null) setState(_fieldErrors.clear);
          },
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          decoration: _fieldDecoration(errorText: errorText),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
    String? errorText,
    FormFieldValidator<String>? validator,
    Iterable<String>? autofillHints,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          obscureText: obscure,
          validator: validator,
          autofillHints: autofillHints,
          onChanged: (_) {
            if (errorText != null) setState(_fieldErrors.clear);
          },
          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          decoration: _fieldDecoration(
            errorText: errorText,
            suffixIcon: IconButton(
              icon: Icon(
                obscure
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 18,
                color: Colors.grey,
              ),
              onPressed: onToggle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton(
    String label,
    VoidCallback? onPressed, {
    bool isBusy = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: isBusy ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.navyDark,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppTheme.navyDark.withValues(alpha: 0.4),
          disabledForegroundColor: Colors.white70,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: isBusy
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Colors.white,
                ),
              )
            : Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class DottedUploadBox extends StatelessWidget {
  final VoidCallback onTap;

  /// The picked (or already uploaded) file, shown instead of the prompt.
  final String? fileName;

  const DottedUploadBox({super.key, required this.onTap, this.fileName});

  @override
  Widget build(BuildContext context) {
    final fileName = this.fileName;
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          color: hubTint(context),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppTheme.primaryBlue.withValues(alpha: 0.3),
            width: 1.4,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                fileName == null
                    ? Icons.upload_rounded
                    : Icons.insert_drive_file_outlined,
                color: AppTheme.primaryBlue,
                size: 24,
              ),
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  fileName ?? 'Tap to upload a file',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              if (fileName != null)
                const Text(
                  'Tap to replace',
                  style: TextStyle(fontSize: 10, color: AppTheme.primaryBlue),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
