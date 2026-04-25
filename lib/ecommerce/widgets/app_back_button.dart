import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../config/app_colors.dart';

class AppBackButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Color? color;
  final Color? bgColor;
  const AppBackButton({super.key, this.onTap, this.color, this.bgColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () => Get.back<void>(),
      child: Container(
        width: 40,
        height: 40,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.surface,
          shape: BoxShape.circle,
        ),
        child: Icon(Icons.arrow_back_ios_new_rounded,
            size: 18, color: color ?? AppColors.textPrimary),
      ),
    );
  }
}
