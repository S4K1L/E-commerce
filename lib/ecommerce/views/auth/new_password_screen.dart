import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';

class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final pwd = TextEditingController();
    final confirm = TextEditingController();

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
                child: Text('New Password',
                    style: AppTextStyles.h2
                        .copyWith(fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Your new password must be different from previously used passwords.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.textSecondary),
                ),
              ),
              const SizedBox(height: 32),
              AppTextField(
                  label: 'Password',
                  hint: '••••••••',
                  controller: pwd,
                  obscure: true),
              const SizedBox(height: 16),
              AppTextField(
                  label: 'Confirm Password',
                  hint: '••••••••',
                  controller: confirm,
                  obscure: true),
              const Spacer(),
              PrimaryButton(
                label: 'Create New Password',
                onPressed: () =>
                    Get.offAllNamed<void>(Routes.completeProfile),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
