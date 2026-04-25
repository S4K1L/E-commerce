import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../data/sample_data.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/primary_button.dart';
import '../cart/shipping_address_screen.dart' show DottedAddNewBox;

class ManageAddressesScreen extends StatelessWidget {
  const ManageAddressesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: Text('Manage Address', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Expanded(
              child: ListView.separated(
                itemCount: SampleData.addresses.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, i) {
                  final a = SampleData.addresses[i];
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: AppColors.primaryLight,
                              borderRadius: BorderRadius.circular(10)),
                          alignment: Alignment.center,
                          child: const Icon(Icons.location_on_outlined,
                              color: AppColors.primary),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              Text(a.label,
                                  style: AppTextStyles.subtitle
                                      .copyWith(
                                          fontWeight:
                                              FontWeight.w600)),
                              Text(a.fullAddress,
                                  style: AppTextStyles.bodySmall
                                      .copyWith(
                                          color:
                                              AppColors.textSecondary)),
                            ],
                          ),
                        ),
                        const Icon(Icons.edit_outlined,
                            color: AppColors.textSecondary, size: 18),
                      ],
                    ),
                  );
                },
              ),
            ),
            const DottedAddNewBox(label: '+ Add New Address'),
            const SizedBox(height: 16),
            PrimaryButton(label: 'Save', onPressed: () {}),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
