import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:visualyou/features/auth/email_auth.dart';
import 'package:visualyou/l10n/app_strings.dart';

Future<void> showEmailSignupSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => const _EmailSignupSheet(),
  );
}

Future<void> showEmailLoginSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => const _EmailLoginSheet(),
  );
}

Future<void> showEmailPasswordResetSheet(
  BuildContext context, {
  String initialEmail = '',
}) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    builder: (_) => _PasswordResetSheet(initialEmail: initialEmail),
  );
}

class _EmailSignupSheet extends StatefulWidget {
  const _EmailSignupSheet();

  @override
  State<_EmailSignupSheet> createState() => _EmailSignupSheetState();
}

class _EmailSignupSheetState extends State<_EmailSignupSheet> {
  final _api = EmailAuthApi();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  int _step = 0;
  String? _challengeId;
  String? _setupToken;
  String? _error;
  bool _busy = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _api.close();
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_busy) return;
    final email = _emailController.text.trim();
    if (_step == 0 && (!email.contains('@') || !email.contains('.'))) {
      setState(() => _error = context.tr('Enter a valid email address'));
      return;
    }
    if (_step == 1 && _codeController.text.trim().length != 6) {
      setState(() => _error = context.tr('Enter the six-digit code'));
      return;
    }
    if (_step == 2 &&
        _passwordController.text != _confirmPasswordController.text) {
      setState(() => _error = context.tr('Passwords do not match'));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (_step == 0) {
        final challenge = await _api.startSignup(email);
        _challengeId = challenge.id;
        if (mounted) setState(() => _step = 1);
      } else if (_step == 1) {
        _setupToken = await _api.verifyCode(
          challengeId: _challengeId!,
          code: _codeController.text.trim(),
        );
        if (mounted) setState(() => _step = 2);
      } else {
        await _api.completeSignup(
          challengeId: _challengeId!,
          setupToken: _setupToken!,
          password: _passwordController.text,
        );
        if (!mounted) return;
        final messenger = ScaffoldMessenger.of(context);
        final message = context.tr('Your account is ready');
        Navigator.pop(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      }
    } on AuthApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      context.tr('Create account'),
      context.tr('Verify your email'),
      context.tr('Create a password'),
    ];
    final descriptions = [
      context.tr('We will email you a six-digit verification code.'),
      context.tr(
        'Enter the code sent to your email. It expires in 10 minutes.',
      ),
      context.tr('Your email is verified. Create a secure password to finish.'),
    ];
    return _AuthSheetFrame(
      title: titles[_step],
      description: descriptions[_step],
      error: _error,
      busy: _busy,
      actionLabel: _step == 2
          ? context.tr('Create account')
          : context.tr('Continue'),
      onSubmit: _submit,
      child: switch (_step) {
        0 => TextField(
          key: const Key('signupEmailField'),
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            labelText: context.tr('Email address'),
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),
        1 => TextField(
          key: const Key('signupCodeField'),
          controller: _codeController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(6),
          ],
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            letterSpacing: 10,
            fontWeight: FontWeight.w800,
          ),
          decoration: InputDecoration(
            labelText: context.tr('Verification code'),
          ),
        ),
        _ => Column(
          children: [
            TextField(
              key: const Key('signupPasswordField'),
              controller: _passwordController,
              obscureText: _obscurePassword,
              autofillHints: const [AutofillHints.newPassword],
              decoration: InputDecoration(
                labelText: context.tr('Password'),
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('signupConfirmPasswordField'),
              controller: _confirmPasswordController,
              obscureText: _obscurePassword,
              autofillHints: const [AutofillHints.newPassword],
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: context.tr('Confirm password'),
                prefixIcon: const Icon(Icons.lock_outline_rounded),
              ),
            ),
          ],
        ),
      },
    );
  }
}

class _EmailLoginSheet extends StatefulWidget {
  const _EmailLoginSheet();

  @override
  State<_EmailLoginSheet> createState() => _EmailLoginSheetState();
}

class _EmailLoginSheetState extends State<_EmailLoginSheet> {
  final _api = EmailAuthApi();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _error;
  bool _busy = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _api.close();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      await _api.login(
        email: _emailController.text.trim(),
        password: _passwordController.text,
      );
      if (!mounted) return;
      final messenger = ScaffoldMessenger.of(context);
      final message = context.tr('Signed in');
      Navigator.pop(context);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    } on AuthApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _AuthSheetFrame(
      title: context.tr('Log in'),
      description: context.tr('Enter your email and password.'),
      error: _error,
      busy: _busy,
      actionLabel: context.tr('Log in'),
      onSubmit: _login,
      child: Column(
        children: [
          TextField(
            key: const Key('loginEmailField'),
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            autofillHints: const [AutofillHints.email],
            decoration: InputDecoration(
              labelText: context.tr('Email address'),
              prefixIcon: const Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            key: const Key('loginPasswordField'),
            controller: _passwordController,
            obscureText: _obscurePassword,
            autofillHints: const [AutofillHints.password],
            onSubmitted: (_) => _login(),
            decoration: InputDecoration(
              labelText: context.tr('Password'),
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              suffixIcon: IconButton(
                onPressed: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                icon: Icon(
                  _obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              key: const Key('forgotPasswordButton'),
              onPressed: _busy
                  ? null
                  : () => showEmailPasswordResetSheet(
                      context,
                      initialEmail: _emailController.text.trim(),
                    ),
              child: Text(context.tr('Forgot password?')),
            ),
          ),
        ],
      ),
    );
  }
}

class _PasswordResetSheet extends StatefulWidget {
  const _PasswordResetSheet({required this.initialEmail});

  final String initialEmail;

  @override
  State<_PasswordResetSheet> createState() => _PasswordResetSheetState();
}

class _PasswordResetSheetState extends State<_PasswordResetSheet> {
  final _api = EmailAuthApi();
  late final TextEditingController _emailController;
  final _codeController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  int _step = 0;
  String? _challengeId;
  String? _setupToken;
  String? _error;
  bool _busy = false;
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _api.close();
    _emailController.dispose();
    _codeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_busy) return;
    if (_step == 0) {
      await _sendCode();
      return;
    }
    if (_step == 1 && _codeController.text.trim().length != 6) {
      setState(() => _error = context.tr('Enter the six-digit code'));
      return;
    }
    if (_step == 2 &&
        _passwordController.text != _confirmPasswordController.text) {
      setState(() => _error = context.tr('Passwords do not match'));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (_step == 1) {
        _setupToken = await _api.verifyPasswordResetCode(
          challengeId: _challengeId!,
          code: _codeController.text.trim(),
        );
        if (mounted) setState(() => _step = 2);
      } else {
        await _api.completePasswordReset(
          challengeId: _challengeId!,
          setupToken: _setupToken!,
          password: _passwordController.text,
        );
        if (!mounted) return;
        final messenger = ScaffoldMessenger.of(context);
        final message = context.tr(
          'Your password was changed. Log in with your new password.',
        );
        Navigator.pop(context);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(message)));
      }
    } on AuthApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _sendCode({bool announce = false}) async {
    final email = _emailController.text.trim();
    if (!email.contains('@') || !email.contains('.')) {
      setState(() => _error = context.tr('Enter a valid email address'));
      return;
    }
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      final challenge = await _api.startPasswordReset(email);
      _challengeId = challenge.id;
      _setupToken = null;
      _codeController.clear();
      if (!mounted) return;
      setState(() => _step = 1);
      if (announce) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(content: Text(context.tr('A new code was sent.'))),
          );
      }
    } on AuthApiException catch (error) {
      if (mounted) setState(() => _error = error.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final titles = [
      context.tr('Forgot password?'),
      context.tr('Verify reset code'),
      context.tr('Create a new password'),
    ];
    final descriptions = [
      context.tr(
        'Enter your account email and we will send a six-digit reset code.',
      ),
      context.tr(
        'Enter the reset code sent to your email. It expires in 10 minutes.',
      ),
      context.tr('Choose a secure new password for your account.'),
    ];
    return _AuthSheetFrame(
      title: titles[_step],
      description: descriptions[_step],
      error: _error,
      busy: _busy,
      actionLabel: switch (_step) {
        0 => context.tr('Send code'),
        1 => context.tr('Continue'),
        _ => context.tr('Change password'),
      },
      onSubmit: _submit,
      child: switch (_step) {
        0 => TextField(
          key: const Key('resetEmailField'),
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          autofillHints: const [AutofillHints.email],
          textInputAction: TextInputAction.done,
          onSubmitted: (_) => _submit(),
          decoration: InputDecoration(
            labelText: context.tr('Email address'),
            prefixIcon: const Icon(Icons.email_outlined),
          ),
        ),
        1 => Column(
          children: [
            TextField(
              key: const Key('resetCodeField'),
              controller: _codeController,
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                letterSpacing: 10,
                fontWeight: FontWeight.w800,
              ),
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: context.tr('Verification code'),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                key: const Key('resendResetCodeButton'),
                onPressed: _busy ? null : () => _sendCode(announce: true),
                child: Text(context.tr('Send a new code')),
              ),
            ),
          ],
        ),
        _ => Column(
          children: [
            TextField(
              key: const Key('resetPasswordField'),
              controller: _passwordController,
              obscureText: _obscurePassword,
              autofillHints: const [AutofillHints.newPassword],
              decoration: InputDecoration(
                labelText: context.tr('New password'),
                prefixIcon: const Icon(Icons.lock_outline_rounded),
                suffixIcon: IconButton(
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  icon: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              key: const Key('resetConfirmPasswordField'),
              controller: _confirmPasswordController,
              obscureText: _obscurePassword,
              autofillHints: const [AutofillHints.newPassword],
              onSubmitted: (_) => _submit(),
              decoration: InputDecoration(
                labelText: context.tr('Confirm password'),
                prefixIcon: const Icon(Icons.lock_outline_rounded),
              ),
            ),
          ],
        ),
      },
    );
  }
}

class _AuthSheetFrame extends StatelessWidget {
  const _AuthSheetFrame({
    required this.title,
    required this.description,
    required this.child,
    required this.error,
    required this.busy,
    required this.actionLabel,
    required this.onSubmit,
  });

  final String title;
  final String description;
  final Widget child;
  final String? error;
  final bool busy;
  final String actionLabel;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return AnimatedPadding(
      duration: const Duration(milliseconds: 180),
      padding: EdgeInsets.only(bottom: MediaQuery.viewInsetsOf(context).bottom),
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(22, 12, 22, 24),
        child: AutofillGroup(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                description,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 22),
              child,
              if (error != null) ...[
                const SizedBox(height: 12),
                Text(
                  error!,
                  key: const Key('authErrorText'),
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.error,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
              const SizedBox(height: 22),
              FilledButton(
                key: const Key('authSubmitButton'),
                onPressed: busy ? null : onSubmit,
                child: busy
                    ? const SizedBox.square(
                        dimension: 22,
                        child: CircularProgressIndicator(strokeWidth: 2.5),
                      )
                    : Text(actionLabel),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
