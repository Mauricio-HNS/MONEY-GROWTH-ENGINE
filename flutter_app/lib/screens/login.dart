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
  final email = TextEditingController();
  final password = TextEditingController();
  bool obscure = true;

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScreenShell(
        title: 'Welcome back',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Control your money. Grow with intention.', style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
            const SizedBox(height: 28),
            _field('Email', email, Icons.email_outlined),
            const SizedBox(height: 14),
            TextField(controller: password, obscureText: obscure, style: const TextStyle(color: AppColors.white), decoration: InputDecoration(labelText: 'Password', prefixIcon: const Icon(Icons.lock_outline), suffixIcon: IconButton(onPressed: () => setState(() => obscure = !obscure), icon: Icon(obscure ? Icons.visibility_outlined : Icons.visibility_off_outlined)))),
            Align(alignment: Alignment.centerRight, child: TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.forgotPassword), child: const Text('Forgot password?'))),
            const SizedBox(height: 12),
            SizedBox(width: double.infinity, height: 52, child: FilledButton(onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.financialSetup), child: const Text('Sign in'))),
            const SizedBox(height: 18),
            Center(child: TextButton(onPressed: () => Navigator.pushNamed(context, AppRoutes.register), child: const Text('Create a new account'))),
          ],
        ),
      );

  Widget _field(String label, TextEditingController controller, IconData icon) => TextField(controller: controller, keyboardType: TextInputType.emailAddress, style: const TextStyle(color: AppColors.white), decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)));
}
