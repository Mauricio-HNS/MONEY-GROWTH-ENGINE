import 'package:flutter/material.dart';
import '../routes.dart';
import '../style/app_style.dart';
import '../style/brand.dart';
import 'screen_shell.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  @override State<RegisterScreen> createState() => _RegisterScreenState();
}
class _RegisterScreenState extends State<RegisterScreen> {
  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();
  @override void dispose() { name.dispose(); email.dispose(); password.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'Create account',
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const BrandMark(size: 68, borderRadius: 20),
      const SizedBox(height: 22),
      const Text('BUILD YOUR', style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2.8)),
      const Text('MONEY TEAM.', style: TextStyle(color: AppColors.white, fontSize: 39, fontWeight: FontWeight.w900, height: .92, letterSpacing: -2)),
      const SizedBox(height: 14),
      const Text('Create your account and give the engine a starting point.', style: TextStyle(color: AppColors.textMuted, fontSize: 14, height: 1.5)),
      const SizedBox(height: 28),
      _input('Your name', name, Icons.person_outline),
      const SizedBox(height: 12),
      _input('Email', email, Icons.email_outlined),
      const SizedBox(height: 12),
      _input('Password', password, Icons.lock_outline, obscure: true),
      const SizedBox(height: 22),
      SizedBox(width: double.infinity, child: FilledButton(onPressed: () => Navigator.pushReplacementNamed(context, AppRoutes.financialSetup), child: const Text('CREATE ACCOUNT'))),
      const SizedBox(height: 12),
      Center(child: TextButton(onPressed: () => Navigator.pop(context), child: const Text('Already have an account? Sign in'))),
    ]),
  );

  Widget _input(String label, TextEditingController controller, IconData icon, {bool obscure = false}) => TextField(controller: controller, obscureText: obscure, style: const TextStyle(color: AppColors.white), decoration: InputDecoration(labelText: label, prefixIcon: Icon(icon)));
}
