import 'package:bdm/utils/custom_svg.dart';
import 'package:bdm/views/base/custom_app_bar.dart';
import 'package:bdm/views/base/custom_button.dart';
import 'package:bdm/views/screens/app.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Import Get package

class OrderConfimation extends StatelessWidget {
  final String id;
  const OrderConfimation({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "placed_order".tr, hasActions: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const SizedBox(height: 24),
              Align(
                alignment: Alignment.center,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    CustomSvg(asset: "assets/icons/order_confirmation.svg"),
                    CustomSvg(asset: "assets/icons/tick.svg"),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 31),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      "successfully_placed_order".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "thank_you_order".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              CustomButton(
                onTap: () {
                  if (Navigator.canPop(context)) {
                    Get.back();
                    appKey.currentState?.changeIndex(0);
                  }
                },
                text: "go_to_home".tr,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  // Future<void> _launchPhone(String phone) async {
  //   final Uri uri = Uri(scheme: 'tel', path: phone);
  //   if (await canLaunchUrl(uri)) {
  //     await launchUrl(uri);
  //   } else {
  //     Get.snackbar("Error", "Could not launch phone dialer");
  //   }
  // }
}
