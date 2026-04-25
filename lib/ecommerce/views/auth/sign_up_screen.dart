import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';
import '../../widgets/social_buttons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _agreed = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: ListView(
            children: [
              const SizedBox(height: 12),
              Center(
                child: Text('Create Account',
                    style:
                        AppTextStyles.h2.copyWith(fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 6),
              Center(
                child: Text(
                  'Fill your information below or register with your social account.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 24),
              AppTextField(
                  label: 'Name',
                  hint: 'Ex. John Doe',
                  controller: _name),
              const SizedBox(height: 16),
              AppTextField(
                  label: 'Email',
                  hint: 'example@gmail.com',
                  controller: _email,
                  keyboardType: TextInputType.emailAddress),
              const SizedBox(height: 16),
              AppTextField(
                  label: 'Password',
                  hint: 'Enter your password',
                  controller: _password,
                  obscure: true),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    activeColor: AppColors.primary,
                    value: _agreed,
                    onChanged: (v) => setState(() => _agreed = v ?? false),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4)),
                  ),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.bodySmall,
                        children: const [
                          TextSpan(text: 'Agree with '),
                          TextSpan(
                              text: 'Terms & Condition',
                              style: TextStyle(
                                  color: AppColors.primary,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              PrimaryButton(
                label: 'Sign Up',
                onPressed: () => Get.toNamed<void>(Routes.verify),
              ),
              const SizedBox(height: 20),
              const OrDivider(text: 'Or sign up with'),
              const SizedBox(height: 16),
              const SocialButtons(),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account? ',
                      style: AppTextStyles.body
                          .copyWith(color: AppColors.textSecondary)),
                  GestureDetector(
                    onTap: () => Get.back<void>(),
                    child: Text('Sign In',
                        style: AppTextStyles.body.copyWith(
                            color: AppColors.primary,
                            fontWeight: FontWeight.w600)),
                  )
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
