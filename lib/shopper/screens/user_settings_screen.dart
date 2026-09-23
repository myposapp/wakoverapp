import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/app_provider.dart';
import '../../theme/app_theme.dart';

class UserSettingsScreen extends StatefulWidget {
  const UserSettingsScreen({super.key});

  @override
  State<UserSettingsScreen> createState() => _UserSettingsScreenState();
}

class _UserSettingsScreenState extends State<UserSettingsScreen> {
  final _nameCtrl = TextEditingController(text: 'Jordan Blake');
  final _emailCtrl = TextEditingController(text: 'jordan.blake@wakover.com');
  final _phoneCtrl = TextEditingController(text: '+1 415 555 0198');
  final _oldPasswordCtrl = TextEditingController();
  final _newPasswordCtrl = TextEditingController();
  final _bvnCtrl = TextEditingController();
  final _ninCtrl = TextEditingController();

  bool _obscureOld = true;
  bool _obscureNew = true;
  bool _showCampaigns = true;

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

  Future<void> _onUpdatePassword(AppProvider provider) async {
    if (_oldPasswordCtrl.text.isEmpty || _newPasswordCtrl.text.isEmpty) {
      provider.showToast('Enter both your old and new password.');
      return;
    }
    final verified = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const _OtpSheet(),
    );
    if (!mounted || verified != true) return;
    _oldPasswordCtrl.clear();
    _newPasswordCtrl.clear();
    provider.showToast('Password updated successfully.');
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    final store = provider.selectedStore;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => provider.navigateTo('buyer_account'),
        ),
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _sectionLabel('Profile Information'),
              const SizedBox(height: 8),
              _sectionCard([
                _buildField(label: 'Name', controller: _nameCtrl),
                const SizedBox(height: 14),
                _buildField(
                  label: 'Email',
                  controller: _emailCtrl,
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 14),
                _buildField(
                  label: 'Phone',
                  controller: _phoneCtrl,
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 18),
                _buildPrimaryButton(
                  'Save Changes',
                  () => provider.showToast('Profile details updated.'),
                ),
              ]),
              const SizedBox(height: 22),

              _sectionLabel('Update Password'),
              const SizedBox(height: 8),
              _sectionCard([
                _buildPasswordField(
                  label: 'Old Password',
                  controller: _oldPasswordCtrl,
                  obscure: _obscureOld,
                  onToggle: () => setState(() => _obscureOld = !_obscureOld),
                ),
                const SizedBox(height: 14),
                _buildPasswordField(
                  label: 'New Password',
                  controller: _newPasswordCtrl,
                  obscure: _obscureNew,
                  onToggle: () => setState(() => _obscureNew = !_obscureNew),
                ),
                const SizedBox(height: 18),
                _buildPrimaryButton(
                  'Update Password',
                  () => _onUpdatePassword(provider),
                ),
              ]),
              const SizedBox(height: 22),

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
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Display active merchant discounts and promo banners.',
                            style: TextStyle(fontSize: 11, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                    Switch(
                      value: _showCampaigns,
                      activeThumbColor: AppTheme.primaryBlue,
                      onChanged: (val) {
                        setState(() => _showCampaigns = val);
                        provider.showToast(
                          val
                              ? 'Campaigns are now visible.'
                              : 'Campaigns are now hidden.',
                        );
                      },
                    ),
                  ],
                ),
              ]),
              const SizedBox(height: 22),

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
                          store != null && store.name.isNotEmpty
                              ? store.name[0]
                              : 'W',
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
                            store?.name ?? 'No marketplace selected',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            store != null
                                ? 'Currently connected vault'
                                : 'Connect to a merchant vault',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    TextButton(
                      onPressed: () => provider.navigateTo('buyer_marketplace'),
                      child: const Text(
                        'Change',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ]),
              const SizedBox(height: 22),

              _sectionLabel('Identity Verification (KYC)'),
              const SizedBox(height: 8),
              _sectionCard([
                Text(
                  'Verify your identity to unlock higher order limits and faster escrow release.',
                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 14),
                _buildField(
                  label: 'BVN',
                  controller: _bvnCtrl,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 14),
                _buildField(
                  label: 'NIN',
                  controller: _ninCtrl,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 14),
                const Text(
                  'Driving License',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                DottedUploadBox(
                  onTap: () => provider.showToast(
                    'Document upload is not available yet.',
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'JPG, JPEG, PNG, PDF',
                  style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                ),
                const SizedBox(height: 18),
                _buildPrimaryButton('Submit', () {
                  if (_bvnCtrl.text.isEmpty || _ninCtrl.text.isEmpty) {
                    provider.showToast('Enter your BVN and NIN to continue.');
                    return;
                  }
                  provider.showToast('KYC documents submitted for review.');
                }),
              ]),
            ],
          ),
        ),
      ),
    );
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
          border: Border.all(color: Colors.black.withOpacity(0.06)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildField({
    required String label,
    required TextEditingController controller,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Builder(
          builder: (context) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.08)),
            ),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 13,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscure,
    required VoidCallback onToggle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Builder(
          builder: (context) => Container(
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.black.withOpacity(0.08)),
            ),
            child: TextField(
              controller: controller,
              obscureText: obscure,
              style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
              decoration: InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 13,
                ),
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
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton(String label, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.navyDark,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
        child: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class DottedUploadBox extends StatelessWidget {
  final VoidCallback onTap;

  const DottedUploadBox({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 110,
        decoration: BoxDecoration(
          color: const Color(0xFFEFF4FF),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: AppTheme.primaryBlue.withOpacity(0.3),
            width: 1.4,
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.upload_rounded, color: AppTheme.primaryBlue, size: 24),
              SizedBox(height: 6),
              Text(
                'Tap to upload a file',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppTheme.navyDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _OtpSheet extends StatefulWidget {
  const _OtpSheet();

  @override
  State<_OtpSheet> createState() => _OtpSheetState();
}

class _OtpSheetState extends State<_OtpSheet> {
  final List<TextEditingController> _controllers = List.generate(
    6,
    (_) => TextEditingController(),
  );
  final List<FocusNode> _nodes = List.generate(6, (_) => FocusNode());
  String? _error;

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    for (final n in _nodes) {
      n.dispose();
    }
    super.dispose();
  }

  void _onChanged(int idx, String value) {
    if (value.isNotEmpty && idx < 5) {
      _nodes[idx + 1].requestFocus();
    } else if (value.isEmpty && idx > 0) {
      _nodes[idx - 1].requestFocus();
    }
  }

  void _verify() {
    final code = _controllers.map((c) => c.text).join();
    if (code.length != 6) {
      setState(() => _error = 'Enter the full 6-digit code.');
      return;
    }
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 28),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 18),
            Container(
              width: 56,
              height: 56,
              decoration: const BoxDecoration(
                color: Color(0xFFEFF4FF),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.sms_outlined,
                color: AppTheme.primaryBlue,
                size: 26,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              "Verify It's You",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 6),
            Text(
              'Enter the 6-digit code sent to your registered phone number to confirm this password change.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey.shade600,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (i) {
                return SizedBox(
                  width: 44,
                  height: 54,
                  child: TextField(
                    controller: _controllers[i],
                    focusNode: _nodes[i],
                    textAlign: TextAlign.center,
                    maxLength: 1,
                    keyboardType: TextInputType.number,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      counterText: '',
                      filled: true,
                      fillColor: const Color(0xFFEFF4FF),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    onChanged: (val) => _onChanged(i, val),
                  ),
                );
              }),
            ),
            if (_error != null) ...[
              const SizedBox(height: 8),
              Text(
                _error!,
                style: TextStyle(fontSize: 11, color: Colors.red.shade600),
              ),
            ],
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _verify,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.navyDark,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                child: const Text(
                  'Verify & Update Password',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextButton(
              onPressed: () => context.read<AppProvider>().showToast(
                'OTP resent to your registered number.',
              ),
              child: const Text(
                'Resend Code',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
