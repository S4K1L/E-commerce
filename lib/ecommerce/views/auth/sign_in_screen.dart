import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/social_buttons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _email = TextEditingController(text: 'example@gmail.com');
  final _password = TextEditingController(text: '12345678');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              const SizedBox(height: 24),
              Center(
                child: Text(
                  'Sign In',
                  style: AppTextStyles.h2.copyWith(fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 4),
              Center(
                child: Text(
                  "Hi! Welcome back, you've been missed",
                  style:
                      AppTextStyles.body.copyWith(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 28),
              AppTextField(
                label: 'Email',
                hint: 'example@gmail.com',
                controller: _email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AppTextField(
                label: 'Password',
                hint: 'Enter your password',
                controller: _password,
                obscure: true,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () => Get.toNamed<void>(Routes.forgot),
                  child: Text(
                    'Forgot Password?',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: AppColors.primary, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                label: 'Sign In',
                onPressed: () => Get.offAllNamed<void>(Routes.locationAccess),
              ),
              const SizedBox(height: 24),
              const OrDivider(),
              const SizedBox(height: 16),
              const SocialButtons(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? ",
                      style: AppTextStyles.body
                          .copyWith(color: AppColors.textSecondary)),
                  GestureDetector(
                    onTap: () => Get.toNamed<void>(Routes.signUp),
                    child: Text(
                      'Sign Up',
                      style: AppTextStyles.body.copyWith(
                          color: AppColors.primary, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
