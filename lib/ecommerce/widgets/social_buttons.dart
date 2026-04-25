import 'package:flutter/material.dart';

import '../config/app_colors.dart';

class SocialButtons extends StatelessWidget {
  final VoidCallback? onApple;
  final VoidCallback? onGoogle;
  final VoidCallback? onFacebook;

  const SocialButtons({
    super.key,
    this.onApple,
    this.onGoogle,
    this.onFacebook,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _btn(Icons.apple, Colors.black, onApple),
        const SizedBox(width: 16),
        _btn(Icons.g_mobiledata, const Color(0xFF4285F4), onGoogle, big: true),
        const SizedBox(width: 16),
        _btn(Icons.facebook, const Color(0xFF1877F2), onFacebook),
      ],
    );
  }

  Widget _btn(IconData icon, Color color, VoidCallback? onTap,
      {bool big = false}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.border),
          color: Colors.white,
        ),
        alignment: Alignment.center,
        child: Icon(icon, color: color, size: big ? 32 : 24),
      ),
    );
  }
}

class OrDivider extends StatelessWidget {
  final String text;
  const OrDivider({super.key, this.text = 'Or sign in with'});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider(color: AppColors.border)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            text,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
          ),
        ),
        const Expanded(child: Divider(color: AppColors.border)),
      ],
    );
  }
}
