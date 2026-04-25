import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../data/sample_data.dart';
import '../../models/product.dart';
import '../../models/review.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/primary_button.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key});

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  String _selected = 'Verified';
  final _filters = const ['Filter', 'Verified', 'Latest', 'Detailed Reviews'];

  @override
  Widget build(BuildContext context) {
    final ProductModel? product = Get.arguments as ProductModel?;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: Text('Review', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('4.5',
                        style:
                            AppTextStyles.h1.copyWith(fontSize: 48)),
                    Row(
                      children: List.generate(5, (i) {
                        return Icon(
                          i < 4 ? Icons.star : Icons.star_half,
                          color: AppColors.star,
                          size: 16,
                        );
                      }),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '(${product?.reviewCount ?? 107} Reviews)',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: AppColors.textSecondary),
                    ),
                  ],
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: Column(
                    children: List.generate(5, (i) {
                      final star = 5 - i;
                      final percent = [0.7, 0.45, 0.2, 0.1, 0.05][i];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Text('$star',
                                style: AppTextStyles.bodySmall),
                            const SizedBox(width: 6),
                            Expanded(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: LinearProgressIndicator(
                                  value: percent,
                                  minHeight: 6,
                                  backgroundColor: AppColors.surface,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          AppColors.primary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: AppSearchBar(hint: 'Search in reviews'),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (_, __) => const SizedBox(width: 8),
                itemBuilder: (_, i) => CategoryChip(
                  label: _filters[i],
                  selected: _selected == _filters[i],
                  onTap: () => setState(() => _selected = _filters[i]),
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: SampleData.reviews.length,
              separatorBuilder: (_, __) =>
                  const Divider(height: 28, color: AppColors.divider),
              itemBuilder: (_, i) {
                final ReviewModel r = SampleData.reviews[i];
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 22,
                      backgroundImage:
                          CachedNetworkImageProvider(r.userAvatar),
                      backgroundColor: AppColors.surface,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(r.userName,
                                    style: AppTextStyles.subtitle
                                        .copyWith(
                                            fontWeight:
                                                FontWeight.w600)),
                              ),
                              Text(r.date,
                                  style: AppTextStyles.caption.copyWith(
                                      color:
                                          AppColors.textSecondary)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: List.generate(5, (s) {
                              return Icon(
                                  s < r.rating.round()
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: AppColors.star,
                                  size: 14);
                            }),
                          ),
                          const SizedBox(height: 6),
                          Text(r.comment,
                              style: AppTextStyles.body.copyWith(
                                  color: AppColors.textSecondary)),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
            child: PrimaryButton(
              icon: Icons.edit_outlined,
              label: 'Write Review',
              onPressed: () =>
                  Get.toNamed<void>(Routes.leaveReview, arguments: product),
            ),
          ),
        ],
      ),
    );
  }
}
