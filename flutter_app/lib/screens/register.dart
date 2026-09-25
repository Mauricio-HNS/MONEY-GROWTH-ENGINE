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
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  @override
  void dispose() {
    name.dispose();
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ScreenShell(
        title: 'Create account',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Start building your financial operating system.', style: TextStyle(color: AppColors.textMuted, fontSize: 14)),
            const SizedBox(height: 26),
            _input('Your name', name, Icons.person_outline),
            const SizedBox(height: 14),
            _input('Email', email, Icons.email_outlined),
            const SizedBox(height: 14),
            _input('Password', password, Icons.lock_outline, obscure: true),
            const SizedBox(height: 24),
            SizedBox(width: double.infinity, height: 52, child: FilledButton(onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.financialSetup), child: const Text('Create account'))),
          ],
        ),
      );

  Widget _input(String label, TextEditingController controller, IconData icon, {bool obscure = false}) => TextField(controller: controller, obscureText: obscure, style: const TextStyle(color: AppColors.white), decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)));
}
