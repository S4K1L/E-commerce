import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';

class CompleteProfileScreen extends StatefulWidget {
  const CompleteProfileScreen({super.key});

  @override
  State<CompleteProfileScreen> createState() => _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends State<CompleteProfileScreen> {
  final _name = TextEditingController();
  final _phone = TextEditingController();
  String? _gender;

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
              const AppBackButton(),
              const SizedBox(height: 16),
              Text('Complete Your Profile',
                  style:
                      AppTextStyles.h2.copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 6),
              Text(
                "Don't worry, only you can see your personal data. No one else will be able to see it.",
                style: AppTextStyles.body
                    .copyWith(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: AppColors.border, width: 1.4),
                      ),
                      alignment: Alignment.center,
                      child: const Icon(Icons.person_outline,
                          size: 48, color: AppColors.textHint),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit,
                            color: Colors.white, size: 16),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 24),
              AppTextField(
                  label: 'Name',
                  hint: 'Ex. John Doe',
                  controller: _name),
              const SizedBox(height: 16),
              AppTextField(
                  label: 'Phone Number',
                  hint: 'Enter Phone Number',
                  controller: _phone,
                  keyboardType: TextInputType.phone),
              const SizedBox(height: 16),
              Text('Gender',
                  style: AppTextStyles.body
                      .copyWith(fontWeight: FontWeight.w500)),
              const SizedBox(height: 8),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.border)),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text('Select',
                        style: AppTextStyles.body
                            .copyWith(color: AppColors.textHint)),
                    value: _gender,
                    items: const [
                      DropdownMenuItem(value: 'Male', child: Text('Male')),
                      DropdownMenuItem(
                          value: 'Female', child: Text('Female')),
                      DropdownMenuItem(value: 'Other', child: Text('Other')),
                    ],
                    onChanged: (v) => setState(() => _gender = v),
                  ),
                ),
              ),
              const SizedBox(height: 32),
              PrimaryButton(
                label: 'Complete Profile',
                onPressed: () =>
                    Get.offAllNamed<void>(Routes.locationAccess),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
