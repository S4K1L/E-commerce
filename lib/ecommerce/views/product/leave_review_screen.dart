import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../data/sample_data.dart';
import '../../models/product.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/primary_button.dart';

class LeaveReviewScreen extends StatefulWidget {
  const LeaveReviewScreen({super.key});

  @override
  State<LeaveReviewScreen> createState() => _LeaveReviewScreenState();
}

class _LeaveReviewScreenState extends State<LeaveReviewScreen> {
  int _rating = 5;
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final ProductModel product =
        (Get.arguments as ProductModel?) ?? SampleData.products.first;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: Text('Leave Review', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: 56,
                      height: 56,
                      child: CachedNetworkImage(
                        imageUrl: product.image,
                        fit: BoxFit.cover,
                        errorWidget: (_, __, ___) =>
                            Container(color: AppColors.surface),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.name,
                            style: AppTextStyles.subtitle.copyWith(
                                fontWeight: FontWeight.w600)),
                        Text(
                            '${product.category} | Qty : 02 pcs',
                            style: AppTextStyles.caption.copyWith(
                                color: AppColors.textSecondary)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                        color: AppColors.primary,
                        borderRadius: BorderRadius.circular(20)),
                    child: const Text('Re-Order',
                        style: TextStyle(
                            color: Colors.white, fontSize: 12)),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Center(
              child: Text('How is your order?',
                  style: AppTextStyles.h3
                      .copyWith(fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: 4),
            Center(
              child: Text('Your overall rating',
                  style: AppTextStyles.body
                      .copyWith(color: AppColors.textSecondary)),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (i) {
                return GestureDetector(
                  onTap: () => setState(() => _rating = i + 1),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Icon(
                      i < _rating ? Icons.star : Icons.star_border,
                      color: AppColors.star,
                      size: 32,
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            Text('Add detailed review',
                style: AppTextStyles.subtitle
                    .copyWith(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: 'Enter here',
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(Icons.add_a_photo_outlined,
                    color: AppColors.primary, size: 18),
                SizedBox(width: 6),
                Text('add photo',
                    style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600)),
              ],
            ),
            const Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlineActionButton(
                      label: 'Cancel', onPressed: () => Get.back<void>()),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: PrimaryButton(
                    label: 'Submit',
                    onPressed: () {
                      Get.back<void>();
                      Get.snackbar('Thank you',
                          'Your review has been submitted',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: AppColors.primary,
                          colorText: Colors.white,
                          margin: const EdgeInsets.all(16));
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
