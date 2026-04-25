import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../data/sample_data.dart';
import '../../widgets/app_back_button.dart';

class PaymentMethodsProfileScreen extends StatelessWidget {
  const PaymentMethodsProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: Text('Payment Methods', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        itemCount: SampleData.paymentMethods.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) {
          final m = SampleData.paymentMethods[i];
          return Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: m.iconColor.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(10)),
                  child: Icon(m.icon, color: m.iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                    child: Text(m.name,
                        style: AppTextStyles.subtitle.copyWith(
                            fontWeight: FontWeight.w500))),
                const Icon(Icons.arrow_forward_ios,
                    size: 14, color: AppColors.textSecondary),
              ],
            ),
          );
        },
      ),
    );
  }
}
