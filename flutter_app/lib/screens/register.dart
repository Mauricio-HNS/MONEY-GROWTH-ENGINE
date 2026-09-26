import 'package:flutter/material.dart';

import '../routes.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final nameFocus = FocusNode();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();
  final confirmPasswordFocus = FocusNode();

  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    nameFocus.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    confirmPasswordFocus.dispose();
    super.dispose();
  }

  void submit() {
    FocusScope.of(context).unfocus();

    if (!formKey.currentState!.validate()) {
      return;
    }

    Navigator.pushReplacementNamed(
      context,
      AppRoutes.financialSetup,
    );
  }

  void moveFocus(FocusNode node) {
    FocusScope.of(context).requestFocus(node);
  }

  void insertAt() {
    final value = email.value;
    final selection = value.selection.isValid
        ? value.selection
        : TextSelection.collapsed(offset: value.text.length);

    final start = selection.start.clamp(0, value.text.length);
    final end = selection.end.clamp(0, value.text.length);
    final nextText = value.text.replaceRange(start, end, '@');
    final nextOffset = start + 1;

    email.value = value.copyWith(
      text: nextText,
      selection: TextSelection.collapsed(offset: nextOffset),
      composing: TextRange.empty,
    );

    moveFocus(emailFocus);
  }

  String? validateEmail(String? value) {
    final text = value?.trim() ?? '';

    if (text.isEmpty) {
      return 'Enter your email';
    }

    if (text.contains(RegExp(r'\\s'))) {
      return 'Email cannot contain spaces';
    }

    if (text.contains('@')) {
      final parts = text.split('@');
      if (parts.length != 2 ||
          parts.first.isEmpty ||
          parts.last.isEmpty ||
          !parts.last.contains('.') ||
          parts.last.startsWith('.') ||
          parts.last.endsWith('.')) {
        return 'Enter a valid email';
      }
    } else {
      return 'Enter a valid email';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ScreenShell(
      title: 'Create account',
      showRadar: false,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 8),
            const Text(
              'BUILD YOUR',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
                fontWeight: FontWeight.w900,
                letterSpacing: 2.8,
              ),
            ),
            const Text(
              'MONEY TEAM.',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 39,
                fontWeight: FontWeight.w900,
                height: .92,
                letterSpacing: -2,
              ),
            ),
            const SizedBox(height: 14),
            const Text(
              'Create your account first. Then we will build your financial baseline together.',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 14,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 26),
            _textField(
              label: 'Your name',
              controller: name,
              focusNode: nameFocus,
              icon: Icons.person_outline,
              keyboardType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              autocorrect: true,
              enableSuggestions: true,
              validator: (value) {
                final text = value?.trim() ?? '';
                return text.length < 2 ? 'Enter your name' : null;
              },
              onSubmitted: (_) => moveFocus(emailFocus),
            ),
            const SizedBox(height: 12),
            _textField(
              label: 'Email',
              controller: email,
              focusNode: emailFocus,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.email],
              autocorrect: false,
              enableSuggestions: false,
              validator: validateEmail,
              onSubmitted: (_) => moveFocus(passwordFocus),
              suffix: TextButton(
                onPressed: insertAt,
                style: TextButton.styleFrom(
                  foregroundColor: AppColors.white,
                  backgroundColor: AppColors.red,
                  minimumSize: const Size(46, 38),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  '@',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            _passwordField(
              label: 'Password',
              controller: password,
              focusNode: passwordFocus,
              obscure: obscurePassword,
              autofillHints: const [AutofillHints.newPassword],
              textInputAction: TextInputAction.next,
              onSubmitted: (_) => moveFocus(confirmPasswordFocus),
              toggle: () => setState(
                () => obscurePassword = !obscurePassword,
              ),
              validator: (value) {
                return (value ?? '').length < 8
                    ? 'Use at least 8 characters'
                    : null;
              },
            ),
            const SizedBox(height: 12),
            _passwordField(
              label: 'Confirm password',
              controller: confirmPassword,
              focusNode: confirmPasswordFocus,
              obscure: obscureConfirm,
              autofillHints: const [AutofillHints.newPassword],
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => submit(),
              toggle: () => setState(
                () => obscureConfirm = !obscureConfirm,
              ),
              validator: (value) {
                if ((value ?? '').isEmpty) {
                  return 'Confirm your password';
                }
                return value != password.text
                    ? 'Passwords do not match'
                    : null;
              },
            ),
            const SizedBox(height: 14),
            const Text(
              'Your name accepts accents. Email accepts normal keyboard input and the @ shortcut.',
              style: TextStyle(
                color: AppColors.textMuted,
                fontSize: 11,
                height: 1.4,
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: submit,
                icon: const Icon(Icons.arrow_forward_rounded),
                label: const Text('CREATE ACCOUNT'),
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Already have an account? Sign in'),
              ),
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }

  Widget _textField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required IconData icon,
    required TextInputType keyboardType,
    required TextCapitalization textCapitalization,
    required TextInputAction textInputAction,
    required Iterable<String> autofillHints,
    required bool autocorrect,
    required bool enableSuggestions,
    required String? Function(String?) validator,
    required ValueChanged<String> onSubmitted,
    Widget? suffix,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      autocorrect: autocorrect,
      enableSuggestions: enableSuggestions,
      enableInteractiveSelection: true,
      validator: validator,
      onTap: () => moveFocus(focusNode),
      onFieldSubmitted: onSubmitted,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        height: 1.2,
      ),
      cursorColor: AppColors.red,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: AppIconBadge(icon: icon),
        suffixIcon: suffix,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }

  Widget _passwordField({
    required String label,
    required TextEditingController controller,
    required FocusNode focusNode,
    required bool obscure,
    required Iterable<String> autofillHints,
    required TextInputAction textInputAction,
    required ValueChanged<String> onSubmitted,
    required VoidCallback toggle,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: obscure,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: textInputAction,
      autofillHints: autofillHints,
      autocorrect: false,
      enableSuggestions: false,
      enableInteractiveSelection: true,
      validator: validator,
      onTap: () => moveFocus(focusNode),
      onFieldSubmitted: onSubmitted,
      style: const TextStyle(
        color: AppColors.white,
        fontSize: 16,
        height: 1.2,
      ),
      cursorColor: AppColors.red,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: const AppIconBadge(icon: Icons.lock_outline),
        suffixIcon: IconButton(
          tooltip: obscure ? 'Show password' : 'Hide password',
          onPressed: toggle,
          icon: Icon(
            obscure
                ? Icons.visibility_outlined
                : Icons.visibility_off_outlined,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
      ),
    );
  }
}
