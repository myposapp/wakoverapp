import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wakover/common/network/provider/network_provider.dart';
import 'package:wakover/common/utils/phone.dart';
import 'package:wakover/providers/app_provider.dart';
import 'package:wakover/router/app_routes.dart';
import 'package:wakover/shopper/providers/user_session_provider.dart';
import 'package:wakover/shopper/widgets/hub/hub_image.dart';
import 'package:wakover/shopper/widgets/hub/hub_sheet.dart';
import 'package:wakover/shopper/widgets/hub/hub_states.dart';
import 'package:wakover/theme/app_theme.dart';

enum AuthMode { signIn, signUp }

/// Sign in and sign up in one screen, so switching between them doesn't
/// replace the route. Pops with `true` once the shopper is signed in.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, this.initialMode = AuthMode.signIn});

  final AuthMode initialMode;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthMode _mode = widget.initialMode;

  bool get _isSignIn => _mode == AuthMode.signIn;

  void _onAuthenticated() {
    final name = context.read<UserSessionProvider>().user?.name;
    context.read<AppProvider>().showToast(
      name == null
          ? 'You\'re signed in.'
          : 'Welcome, ${name.split(' ').first}!',
    );
    if (context.canPop()) {
      context.pop(true);
    } else {
      context.go(AppRoutes.buyerAccount);
    }
  }

  @override
  Widget build(BuildContext context) {
    final origin = context.read<NetworkProvider>().storeOrigin;
    final storeHost = origin == null ? null : Uri.tryParse(origin)?.host;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: _AuthHeader(
              title: _isSignIn ? 'Welcome back' : 'Create your account',
              subtitle: _isSignIn
                  ? 'Sign in to track orders, bookings and your wallet.'
                  : 'One account works across every Wakover store.',
              storeHost: storeHost,
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
              child: SafeArea(
                top: false,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _ModeSwitch(
                      mode: _mode,
                      onChanged: (mode) => setState(() => _mode = mode),
                    ),
                    const SizedBox(height: 22),
                    if (origin == null)
                      const _NoStoreNotice()
                    else
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 250),
                        layoutBuilder: (current, previous) => Stack(
                          alignment: Alignment.topCenter,
                          children: [...previous, ?current],
                        ),
                        child: _isSignIn
                            ? _SignInForm(
                                key: const ValueKey('sign-in'),
                                origin: origin,
                                onSuccess: _onAuthenticated,
                              )
                            : _SignUpForm(
                                key: const ValueKey('sign-up'),
                                onSuccess: _onAuthenticated,
                              ),
                      ),
                    const SizedBox(height: 28),
                    Wrap(
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          _isSignIn
                              ? 'New to Wakover?'
                              : 'Already have an account?',
                          style: TextStyle(
                            fontSize: 12,
                            color: hubMutedText(context),
                          ),
                        ),
                        TextButton(
                          onPressed: () => setState(
                            () => _mode = _isSignIn
                                ? AuthMode.signUp
                                : AuthMode.signIn,
                          ),
                          child: Text(
                            _isSignIn ? 'Create an account' : 'Sign in',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AuthHeader extends StatelessWidget {
  const _AuthHeader({
    required this.title,
    required this.subtitle,
    required this.storeHost,
  });

  final String title;
  final String subtitle;
  final String? storeHost;

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppTheme.navyDark, Color(0xFF102468), AppTheme.primaryBlue],
        ),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28)),
      ),
      child: Stack(
        children: [
          // Oversized watermark, matching the storefront banner.
          Positioned(
            right: -20,
            top: 10,
            child: Icon(
              Icons.shopping_bag_rounded,
              size: 180,
              color: Colors.white.withValues(alpha: 0.05),
            ),
          ),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 4, 20, 28),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back_rounded),
                    onPressed: () => context.canPop()
                        ? context.pop()
                        : context.go(AppRoutes.buyerAccount),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, top: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (storeHost != null)
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white12,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.storefront_rounded,
                                  size: 12,
                                  color: AppTheme.accentCyan,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  storeHost!.toUpperCase(),
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 14),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 200),
                          child: Text(
                            title,
                            key: ValueKey(title),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 12,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeSwitch extends StatelessWidget {
  const _ModeSwitch({required this.mode, required this.onChanged});

  final AuthMode mode;
  final ValueChanged<AuthMode> onChanged;

  @override
  Widget build(BuildContext context) {
    Widget segment(AuthMode value, String label) {
      final isActive = mode == value;
      return Expanded(
        child: GestureDetector(
          onTap: () => onChanged(value),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(vertical: 11),
            decoration: BoxDecoration(
              color: isActive
                  ? Theme.of(context).cardColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ]
                  : null,
            ),
            alignment: Alignment.center,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: isActive
                    ? Theme.of(context).colorScheme.onSurface
                    : hubMutedText(context),
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: hubTint(context),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          segment(AuthMode.signIn, 'Sign in'),
          segment(AuthMode.signUp, 'Create account'),
        ],
      ),
    );
  }
}

class _NoStoreNotice extends StatelessWidget {
  const _NoStoreNotice();

  @override
  Widget build(BuildContext context) {
    return HubMessage(
      icon: Icons.storefront_outlined,
      title: 'Connect to a store first',
      message:
          'Your account works across stores, but you need to open one before '
          'signing in.',
      actionLabel: 'Find a store',
      onAction: () => context.go(AppRoutes.marketplace),
    );
  }
}

/// Shared styling for the auth text fields.
class _AuthField extends StatelessWidget {
  const _AuthField({
    required this.controller,
    required this.label,
    required this.icon,
    this.hint,
    this.errorText,
    this.validator,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.autofillHints,
    this.obscureText = false,
    this.suffix,
    this.prefixText,
    this.inputFormatters,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final IconData icon;
  final String? hint;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final Iterable<String>? autofillHints;
  final bool obscureText;
  final Widget? suffix;
  final String? prefixText;
  final List<TextInputFormatter>? inputFormatters;
  final TextCapitalization textCapitalization;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  Widget build(BuildContext context) {
    OutlineInputBorder border(Color color, [double width = 1.2]) =>
        OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: color, width: width),
        );

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: TextFormField(
        controller: controller,
        validator: validator,
        keyboardType: keyboardType,
        textInputAction: textInputAction,
        autofillHints: autofillHints,
        obscureText: obscureText,
        inputFormatters: inputFormatters,
        textCapitalization: textCapitalization,
        onChanged: onChanged,
        onFieldSubmitted: onSubmitted,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          errorText: errorText,
          errorMaxLines: 2,
          prefixText: prefixText,
          prefixIcon: Icon(icon, size: 20),
          suffixIcon: suffix,
          filled: true,
          fillColor: Theme.of(context).cardColor,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 16,
          ),
          border: border(hubBorder(context)),
          enabledBorder: border(hubBorder(context)),
          focusedBorder: border(Theme.of(context).primaryColor, 1.6),
          errorBorder: border(Colors.redAccent),
          focusedErrorBorder: border(Colors.redAccent, 1.6),
        ),
      ),
    );
  }
}

class _PasswordField extends StatefulWidget {
  const _PasswordField({
    required this.controller,
    required this.label,
    this.errorText,
    this.validator,
    this.autofillHints,
    this.onChanged,
    this.onSubmitted,
  });

  final TextEditingController controller;
  final String label;
  final String? errorText;
  final FormFieldValidator<String>? validator;
  final Iterable<String>? autofillHints;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;

  @override
  State<_PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<_PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return _AuthField(
      controller: widget.controller,
      label: widget.label,
      icon: Icons.lock_outline_rounded,
      errorText: widget.errorText,
      validator: widget.validator,
      obscureText: _obscure,
      autofillHints: widget.autofillHints,
      textInputAction: TextInputAction.done,
      onChanged: widget.onChanged,
      onSubmitted: widget.onSubmitted,
      suffix: IconButton(
        tooltip: _obscure ? 'Show password' : 'Hide password',
        icon: Icon(
          _obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined,
          size: 20,
        ),
        onPressed: () => setState(() => _obscure = !_obscure),
      ),
    );
  }
}

class _ErrorBanner extends StatelessWidget {
  const _ErrorBanner({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.redAccent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.redAccent.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.error_outline_rounded,
            color: Colors.redAccent,
            size: 18,
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(message, style: const TextStyle(fontSize: 12))),
        ],
      ),
    );
  }
}

final _emailPattern = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');

class _SignInForm extends StatefulWidget {
  const _SignInForm({super.key, required this.origin, required this.onSuccess});

  final String origin;
  final VoidCallback onSuccess;

  @override
  State<_SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<_SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _identifierController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;
  String? _error;
  String? _identifierError;
  String? _passwordError;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  /// Email as typed, or the phone number in E.164; null if neither.
  String? _identifier() {
    final value = _identifierController.text.trim();
    if (value.contains('@'))
      return _emailPattern.hasMatch(value) ? value : null;
    return toNigerianE164(value);
  }

  Future<void> _submit() async {
    setState(() {
      _error = null;
      _identifierError = null;
      _passwordError = null;
    });
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isSubmitting = true);
    final result = await context.read<UserSessionProvider>().signIn(
      identifier: _identifier()!,
      password: _passwordController.text,
    );
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (result.success) {
      TextInput.finishAutofillContext();
      widget.onSuccess();
      return;
    }
    setState(() {
      switch (result.field) {
        case 'email' || 'phone':
          _identifierError = result.message;
        case 'password':
          _passwordError = result.message;
        default:
          _error = result.message;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_error != null) _ErrorBanner(message: _error!),
            _AuthField(
              controller: _identifierController,
              label: 'Email or phone number',
              hint: 'you@example.com or 0803 123 4567',
              icon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [
                AutofillHints.email,
                AutofillHints.telephoneNumber,
              ],
              errorText: _identifierError,
              onChanged: (_) {
                if (_identifierError != null) {
                  setState(() => _identifierError = null);
                }
              },
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return 'Enter your email or phone number';
                if (_identifier() == null) {
                  return text.contains('@')
                      ? 'Please enter a valid email'
                      : 'Please enter a valid phone number';
                }
                return null;
              },
            ),
            _PasswordField(
              controller: _passwordController,
              label: 'Password',
              autofillHints: const [AutofillHints.password],
              errorText: _passwordError,
              onChanged: (_) {
                if (_passwordError != null) {
                  setState(() => _passwordError = null);
                }
              },
              onSubmitted: (_) => _submit(),
              validator: (value) =>
                  (value ?? '').isEmpty ? 'Please enter your password' : null,
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                // The API's password reset isn't live yet; the store
                // website handles it.
                onPressed: () => openExternalUrl(
                  context,
                  '${widget.origin}/customer/forgot-password',
                ),
                child: const Text(
                  'Forgot password?',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
            const SizedBox(height: 6),
            HubPrimaryButton(
              label: 'Sign in',
              icon: Icons.login_rounded,
              expand: true,
              isBusy: _isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

class _SignUpForm extends StatefulWidget {
  const _SignUpForm({super.key, required this.onSuccess});

  final VoidCallback onSuccess;

  @override
  State<_SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<_SignUpForm> {
  static const _minPasswordLength = 8;

  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSubmitting = false;
  String? _error;
  final Map<String, String?> _fieldErrors = {};

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _clearFieldError(String field) {
    if (_fieldErrors[field] != null) setState(() => _fieldErrors[field] = null);
  }

  Future<void> _submit() async {
    setState(() {
      _error = null;
      _fieldErrors.clear();
    });
    if (!_formKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    setState(() => _isSubmitting = true);
    final result = await context.read<UserSessionProvider>().signUp(
      name: _nameController.text.trim(),
      phone: toNigerianE164(_phoneController.text)!,
      email: _emailController.text.trim(),
      password: _passwordController.text,
    );
    if (!mounted) return;
    setState(() => _isSubmitting = false);

    if (result.success) {
      TextInput.finishAutofillContext();
      widget.onSuccess();
      return;
    }
    setState(() {
      const knownFields = {'name', 'phone', 'email', 'password'};
      if (knownFields.contains(result.field)) {
        _fieldErrors[result.field!] = result.message;
      } else {
        _error = result.message;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AutofillGroup(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (_error != null) _ErrorBanner(message: _error!),
            _AuthField(
              controller: _nameController,
              label: 'Full name',
              icon: Icons.person_outline_rounded,
              textCapitalization: TextCapitalization.words,
              autofillHints: const [AutofillHints.name],
              errorText: _fieldErrors['name'],
              onChanged: (_) => _clearFieldError('name'),
              validator: (value) {
                final text = value?.trim() ?? '';
                if (text.isEmpty) return 'Please enter your name';
                if (text.length < 3 || !text.contains(' ')) {
                  return 'Please enter your full name';
                }
                if (text.length > 50)
                  return 'Try a name shorter than 50 characters';
                return null;
              },
            ),
            _AuthField(
              controller: _phoneController,
              label: 'Phone number',
              hint: '803 123 4567',
              prefixText: '+234 ',
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              autofillHints: const [AutofillHints.telephoneNumberNational],
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(11),
              ],
              errorText: _fieldErrors['phone'],
              onChanged: (_) => _clearFieldError('phone'),
              validator: (value) => toNigerianE164(value ?? '') == null
                  ? 'Please enter a valid phone number'
                  : null,
            ),
            _AuthField(
              controller: _emailController,
              label: 'Email address',
              icon: Icons.alternate_email_rounded,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              errorText: _fieldErrors['email'],
              onChanged: (_) => _clearFieldError('email'),
              validator: (value) => _emailPattern.hasMatch(value?.trim() ?? '')
                  ? null
                  : 'Please enter a valid email',
            ),
            _PasswordField(
              controller: _passwordController,
              label: 'Password',
              autofillHints: const [AutofillHints.newPassword],
              errorText: _fieldErrors['password'],
              onChanged: (_) => _clearFieldError('password'),
              onSubmitted: (_) => _submit(),
              validator: (value) => (value ?? '').length < _minPasswordLength
                  ? 'Password must be at least $_minPasswordLength characters'
                  : null,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16, left: 4),
              child: Text(
                'Use at least $_minPasswordLength characters.',
                style: TextStyle(fontSize: 11, color: hubMutedText(context)),
              ),
            ),
            HubPrimaryButton(
              label: 'Create account',
              icon: Icons.person_add_alt_1_rounded,
              expand: true,
              isBusy: _isSubmitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
