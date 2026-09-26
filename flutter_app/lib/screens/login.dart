import 'package:flutter/material.dart';

import '../routes.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  final email = TextEditingController();
  final password = TextEditingController();
  final emailFocus = FocusNode();
  final passwordFocus = FocusNode();

  bool obscure = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    emailFocus.dispose();
    passwordFocus.dispose();
    super.dispose();
  }

  void focus(FocusNode node) {
    if (!node.hasFocus) node.requestFocus();
  }

  void submit() {
    FocusManager.instance.primaryFocus?.unfocus();
    if (!formKey.currentState!.validate()) return;
    Navigator.pushReplacementNamed(context, AppRoutes.financialSetup);
  }

  @override
  Widget build(BuildContext context) => ScreenShell(
        title: 'Welcome back',
        child: AutofillGroup(
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),
                const Text(
                  'CONTROL YOUR MONEY.',
                  style: TextStyle(
                    color: AppColors.white,
                    fontSize: 31,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -1.4,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Sign in to continue to your financial command center.',
                  style: TextStyle(
                    color: AppColors.textMuted,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 26),
                TextFormField(
                  controller: email,
                  focusNode: emailFocus,
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  autofillHints: const [AutofillHints.email],
                  autocorrect: false,
                  enableSuggestions: false,
                  enableInteractiveSelection: true,
                  onTap: () => focus(emailFocus),
                  onFieldSubmitted: (_) => focus(passwordFocus),
                  validator: (value) {
                    final text = value?.trim() ?? '';
                    return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text)
                        ? null
                        : 'Enter a valid email';
                  },
                  style: const TextStyle(color: AppColors.white),
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: AppIconBadge(icon: Icons.email_outlined),
                  ),
                ),
                const SizedBox(height: 14),
                TextFormField(
                  controller: password,
                  focusNode: passwordFocus,
                  obscureText: obscure,
                  keyboardType: TextInputType.visiblePassword,
                  textInputAction: TextInputAction.done,
                  autofillHints: const [AutofillHints.password],
                  autocorrect: false,
                  enableSuggestions: false,
                  enableInteractiveSelection: true,
                  onTap: () => focus(passwordFocus),
                  onFieldSubmitted: (_) => submit(),
                  validator: (value) =>
                      (value ?? '').isEmpty ? 'Enter your password' : null,
                  style: const TextStyle(color: AppColors.white),
                  decoration: InputDecoration(
                    labelText: 'Password',
                    prefixIcon:
                        const AppIconBadge(icon: Icons.lock_outline),
                    suffixIcon: IconButton(
                      tooltip: obscure ? 'Show password' : 'Hide password',
                      onPressed: () => setState(() => obscure = !obscure),
                      icon: Icon(
                        obscure
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                      ),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.forgotPassword),
                    child: const Text('Forgot password?'),
                  ),
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: FilledButton.icon(
                    onPressed: submit,
                    icon: const Icon(Icons.login_rounded),
                    label: const Text('SIGN IN'),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Expanded(child: Divider()),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text(
                        'NEW HERE?',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
                    const Expanded(child: Divider()),
                  ],
                ),
                const SizedBox(height: 10),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () =>
                        Navigator.pushNamed(context, AppRoutes.register),
                    child: const Text('CREATE A NEW ACCOUNT'),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
