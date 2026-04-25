import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../data/sample_data.dart';
import '../../utils/currency.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/primary_button.dart';

class ChooseShippingScreen extends StatefulWidget {
  const ChooseShippingScreen({super.key});

  @override
  State<ChooseShippingScreen> createState() =>
      _ChooseShippingScreenState();
}

class _ChooseShippingScreenState extends State<ChooseShippingScreen> {
  String selected = 'economy';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: Text('Choose Shipping', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: SampleData.shippingOptions.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final s = SampleData.shippingOptions[i];
                  final isSelected = s.id == selected;
                  return GestureDetector(
                    onTap: () => setState(() => selected = s.id),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                          color: AppColors.surface,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.border,
                            width: isSelected ? 1.4 : 1,
                          )),
                      child: Row(
                        children: [
                          Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(10)),
                            alignment: Alignment.center,
                            child: const Icon(
                                Icons.local_shipping_outlined,
                                color: AppColors.primary,
                                size: 20),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                                  CrossAxisAlignment.start,
                              children: [
                                Text(s.name,
                                    style: AppTextStyles.subtitle
                                        .copyWith(
                                            fontWeight: FontWeight.w600)),
                                Text(s.estimatedArrival,
                                    style: AppTextStyles.caption.copyWith(
                                        color:
                                            AppColors.textSecondary)),
                              ],
                            ),
                          ),
                          Text(Currency.format(s.price),
                              style: AppTextStyles.subtitle.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary)),
                          const SizedBox(width: 8),
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
                },
              ),
            ),
            const SizedBox(height: 12),
            PrimaryButton(
              label: 'Apply',
              onPressed: () => Get.toNamed<void>(Routes.checkout),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
