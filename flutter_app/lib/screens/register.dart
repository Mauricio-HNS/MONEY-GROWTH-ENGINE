import 'package:flutter/material.dart';
import '../routes.dart';
import '../style/app_style.dart';
import 'screen_shell.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();
  bool obscurePassword = true;
  bool obscureConfirm = true;

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  void submit() {
    FocusScope.of(context).unfocus();
    if (!formKey.currentState!.validate()) return;
    Navigator.pushReplacementNamed(context, AppRoutes.financialSetup);
  }

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'Create account',
    child: Form(
      key: formKey,
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(height: 8),
        const Text('BUILD YOUR', style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2.8)),
        const Text('MONEY TEAM.', style: TextStyle(color: AppColors.white, fontSize: 39, fontWeight: FontWeight.w900, height: .92, letterSpacing: -2)),
        const SizedBox(height: 14),
        const Text('Create your account first. Then we will build your financial baseline together.', style: TextStyle(color: AppColors.textMuted, fontSize: 14, height: 1.5)),
        const SizedBox(height: 26),
        _field('Your name', name, Icons.person_outline, validator: (value) => value == null || value.trim().length < 2 ? 'Enter your name' : null),
        const SizedBox(height: 12),
        _field('Email', email, Icons.email_outlined, keyboardType: TextInputType.emailAddress, validator: (value) {
          final text = value?.trim() ?? '';
          return RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(text) ? null : 'Enter a valid email';
        }),
        const SizedBox(height: 12),
        _passwordField('Password', password, obscurePassword, () => setState(() => obscurePassword = !obscurePassword), validator: (value) => (value ?? '').length < 8 ? 'Use at least 8 characters' : null),
        const SizedBox(height: 12),
        _passwordField('Confirm password', confirmPassword, obscureConfirm, () => setState(() => obscureConfirm = !obscureConfirm), validator: (value) => value != password.text ? 'Passwords do not match' : null),
        const SizedBox(height: 14),
        const Text('8+ characters. Use a unique password for your account.', style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
        const SizedBox(height: 22),
        SizedBox(width: double.infinity, child: FilledButton.icon(onPressed: submit, icon: const Icon(Icons.arrow_forward_rounded), label: const Text('CREATE ACCOUNT'))),
        const SizedBox(height: 10),
        Center(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text('Already have an account? Sign in'))),
      ]),
    ),
  );

  Widget _field(
    String label,
    TextEditingController controller,
    IconData icon, {
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        validator: validator,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 16,
          height: 1.2,
        ),
        cursorColor: AppColors.red,
        textCapitalization: label == 'Email'
            ? TextCapitalization.none
            : TextCapitalization.words,
        autocorrect: label != 'Email',
        enableSuggestions: label != 'Email',
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: AppIconBadge(icon: icon),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      );

  Widget _passwordField(
    String label,
    TextEditingController controller,
    bool obscure,
    VoidCallback toggle, {
    String? Function(String?)? validator,
  }) =>
      TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validator,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 16,
          height: 1.2,
        ),
        cursorColor: AppColors.red,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: const AppIconBadge(icon: Icons.lock_outline),
          suffixIcon: IconButton(
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
