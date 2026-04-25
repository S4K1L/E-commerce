import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              const AppBackButton(),
              const SizedBox(height: 24),
              Center(
                child: Text('Forgot Password',
                    style: AppTextStyles.h2
                        .copyWith(fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Enter your email to receive an OTP code to reset your password.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 24),
              AppTextField(
                  label: 'Email',
                  hint: 'example@gmail.com',
                  controller: email,
                  keyboardType: TextInputType.emailAddress),
              const Spacer(),
              PrimaryButton(
                label: 'Continue',
                onPressed: () => Get.toNamed<void>(Routes.verify),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
