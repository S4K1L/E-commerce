import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../data/sample_data.dart';
import '../../models/payment_method.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/primary_button.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() =>
      _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  String selected = 'cash';

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<PaymentMethodModel>>{};
    for (final m in SampleData.paymentMethods) {
      groups.putIfAbsent(m.group, () => []).add(m);
    }

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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: groups.entries.expand((e) {
                  return <Widget>[
                    const SizedBox(height: 8),
                    Text(e.key,
                        style: AppTextStyles.subtitle
                            .copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),
                    ...e.value.map((m) => Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: _tile(m),
                        )),
                  ];
                }).toList(),
              ),
            ),
            PrimaryButton(
              label: 'Confirm Payment',
              onPressed: () {
                Get.offAllNamed<void>(Routes.orderTracking);
              },
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _tile(PaymentMethodModel m) {
    final isSelected = selected == m.id;
    return GestureDetector(
      onTap: () => setState(() => selected = m.id),
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
              color: isSelected
                  ? AppColors.primary
                  : AppColors.border),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: m.iconColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(m.icon, color: m.iconColor, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(m.name,
                  style: AppTextStyles.subtitle
                      .copyWith(fontWeight: FontWeight.w500)),
            ),
            Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: isSelected
                        ? AppColors.primary
                        : AppColors.border,
                    width: 2),
              ),
              alignment: Alignment.center,
              child: isSelected
                  ? Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}
