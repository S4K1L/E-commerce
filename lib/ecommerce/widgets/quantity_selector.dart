import 'package:flutter/material.dart';

import '../config/app_colors.dart';
import '../config/app_text_styles.dart';

class QuantitySelector extends StatelessWidget {
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final double size;

  const QuantitySelector({
    super.key,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
    this.size = 28,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _btn(icon: Icons.remove, onTap: onDecrement, filled: false),
        SizedBox(
          width: 36,
          child: Text(
            quantity.toString(),
            textAlign: TextAlign.center,
            style: AppTextStyles.subtitle.copyWith(fontWeight: FontWeight.w600),
          ),
        ),
        _btn(icon: Icons.add, onTap: onIncrement, filled: true),
      ],
    );
  }

  Widget _btn(
      {required IconData icon,
      required VoidCallback onTap,
      bool filled = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: filled ? AppColors.primary : AppColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon,
            size: 16,
            color: filled ? Colors.white : AppColors.textPrimary),
      ),
    );
  }
}
