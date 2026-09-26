import 'package:flutter/material.dart';
import '../style/app_style.dart';
import '../style/brand.dart';
import 'screen_shell.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final email = TextEditingController();
  @override
  Widget build(BuildContext context) => ScreenShell(
    title: 'Reset password',
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const BrandMark(size: 68, borderRadius: 20),
      const SizedBox(height: 22),
      const Text('GET BACK', style: TextStyle(color: AppColors.textMuted, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2.8)),
      const Text('IN CONTROL.', style: TextStyle(color: AppColors.white, fontSize: 39, fontWeight: FontWeight.w900, height: .92, letterSpacing: -2)),
      const SizedBox(height: 14),
      const Text('Enter your email and we will send recovery instructions.', style: TextStyle(color: AppColors.textMuted, fontSize: 14, height: 1.5)),
      const SizedBox(height: 28),
      TextField(controller: email, keyboardType: TextInputType.emailAddress, style: const TextStyle(color: AppColors.white), decoration: const InputDecoration(labelText: 'Email', prefixIcon: Icon(Icons.email_outlined))),
      const SizedBox(height: 20),
      SizedBox(width: double.infinity, child: FilledButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Recovery flow ready for API integration.'))), child: const Text('SEND RECOVERY EMAIL'))),
    ]),
  );
}
