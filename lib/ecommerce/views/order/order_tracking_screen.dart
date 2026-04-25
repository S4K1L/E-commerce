import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../data/sample_data.dart';
import '../../models/order.dart';
import '../../widgets/app_back_button.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: Text('Track Order', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(14)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundImage: const CachedNetworkImageProvider(
                      'https://images.unsplash.com/photo-1633332755192-727a05c4013d?w=200&q=80'),
                  backgroundColor: AppColors.surface,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Arm Chair',
                          style: AppTextStyles.subtitle
                              .copyWith(fontWeight: FontWeight.w600)),
                      const Text('Item Qty : Three Item'),
                      const Text('৳ 19,800',
                          style: TextStyle(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w700)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Text('Order Details',
              style: AppTextStyles.subtitle
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          _detailRow('Expected Delivery Date', '03 Sep 2026'),
          _detailRow('Tracking ID', 'TRK425C18542'),
          const SizedBox(height: 24),
          Text('Order Status',
              style: AppTextStyles.subtitle
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 16),
          ...List.generate(SampleData.sampleTimeline.length, (i) {
            final OrderTimelineEntry e = SampleData.sampleTimeline[i];
            final bool last = i == SampleData.sampleTimeline.length - 1;
            return _timelineRow(e, isLast: last);
          }),
          const SizedBox(height: 24),
          OutlinedButton.icon(
            onPressed: () => Get.toNamed<void>(Routes.chat),
            icon: const Icon(Icons.chat_bubble_outline),
            label: const Text('Chat with Seller'),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _detailRow(String l, String r) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Text(l,
                style: AppTextStyles.body
                    .copyWith(color: AppColors.textSecondary)),
          ),
          Text(r,
              style: AppTextStyles.subtitle
                  .copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _timelineRow(OrderTimelineEntry e, {bool isLast = false}) {
    final color = e.isActive ? AppColors.primary : AppColors.border;
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                    color: color, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: color,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(e.label,
                      style: AppTextStyles.subtitle
                          .copyWith(fontWeight: FontWeight.w600)),
                  Text(e.date,
                      style: AppTextStyles.caption
                          .copyWith(color: AppColors.textSecondary)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
