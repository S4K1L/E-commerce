import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/app_text_field.dart';
import '../../widgets/primary_button.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: Text('Your profile', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 92,
              height: 92,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.surface,
                border: Border.all(color: AppColors.border),
              ),
              alignment: Alignment.center,
              child: const Icon(Icons.person,
                  color: AppColors.textSecondary, size: 40),
            ),
          ),
          const SizedBox(height: 24),
          AppTextField(
              label: 'Name',
              hint: 'Esther Howard',
              controller: TextEditingController(text: 'Esther Howard')),
          const SizedBox(height: 16),
          AppTextField(
              label: 'Email',
              hint: 'esther@gmail.com',
              controller: TextEditingController(text: 'esther@gmail.com'),
              keyboardType: TextInputType.emailAddress),
          const SizedBox(height: 16),
          AppTextField(
              label: 'Phone',
              hint: '+1 555 123 4567',
              controller: TextEditingController(text: '+1 555 123 4567'),
              keyboardType: TextInputType.phone),
          const SizedBox(height: 32),
          PrimaryButton(
              label: 'Save Changes', onPressed: () => Get.back<void>()),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
