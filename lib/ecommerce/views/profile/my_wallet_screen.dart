import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../../config/app_text_styles.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/primary_button.dart';

class MyWalletScreen extends StatelessWidget {
  const MyWalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final txns = const [
      {'title': 'Order #FX1001', 'amount': '- ৳ 13,200'},
      {'title': 'Refund', 'amount': '+ ৳ 350'},
      {'title': 'Wallet Top-up', 'amount': '+ ৳ 5,000'},
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: const Padding(
          padding: EdgeInsets.only(left: 12),
          child: AppBackButton(),
        ),
        title: Text('My Wallet', style: AppTextStyles.title),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          const SizedBox(height: 12),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFFFF6B7A), Color(0xFFFF4D5E)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Available Balance',
                    style: AppTextStyles.bodySmall
                        .copyWith(color: Colors.white)),
                const SizedBox(height: 6),
                Text('৳ 42,000',
                    style: AppTextStyles.h1.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          PrimaryButton(label: 'Top Up Wallet', onPressed: () {}),
          const SizedBox(height: 24),
          Text('Recent Transactions',
              style: AppTextStyles.subtitle
                  .copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          ...txns.map((t) => Container(
                margin: const EdgeInsets.only(bottom: 10),
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Row(
                  children: [
                    Expanded(
                        child: Text(t['title']!,
                            style: AppTextStyles.subtitle)),
                    Text(t['amount']!,
                        style: AppTextStyles.subtitle.copyWith(
                            color: t['amount']!.startsWith('+ ')
                                ? AppColors.success
                                : AppColors.primary,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}
