import 'package:flutter/material.dart';
import 'package:mobile/core/theme/app_colors.dart';
import 'package:mobile/features/auth/presentation/widgets/signup_form.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.backgroundColor,
        title: const Text(
          'PASSME 🌐 TRANSLATOR',
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ),
      body: const Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 24),
          child: SignUpForm(),
        ),
      ),
    );
  }
}
