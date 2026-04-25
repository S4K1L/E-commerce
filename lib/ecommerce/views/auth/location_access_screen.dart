import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/primary_button.dart';

class LocationAccessScreen extends StatelessWidget {
  const LocationAccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const Spacer(),
              Container(
                width: 140,
                height: 140,
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(70),
                ),
                alignment: Alignment.center,
                child: const Icon(Icons.location_on,
                    color: AppColors.primary, size: 72),
              ),
              const SizedBox(height: 32),
              Text('What is Your Location?',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.h2
                      .copyWith(fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              Text(
                'We need to know your location in order to suggest nearby services.',
                textAlign: TextAlign.center,
                style: AppTextStyles.body
                    .copyWith(color: AppColors.textSecondary),
              ),
              const Spacer(),
              PrimaryButton(
                label: 'Allow Location Access',
                onPressed: () =>
                    Get.offAllNamed<void>(Routes.notificationAccess),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () =>
                    Get.offAllNamed<void>(Routes.notificationAccess),
                child: Text('Enter Location Manually',
                    style: AppTextStyles.body.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600)),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
