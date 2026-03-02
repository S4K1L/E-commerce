import 'package:bdm/controllers/service_controller.dart';
import 'package:bdm/utils/custom_svg.dart';
import 'package:bdm/views/base/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Approval extends StatelessWidget {
  const Approval({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 80),
              CustomSvg(asset: "assets/icons/admin_approval.svg"),
              const SizedBox(height: 60, width: double.infinity),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(12),
                  border: Border.all(width: 0.5, color: Color(0xff49494A)),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  spacing: 12,
                  children: [
                    Text(
                      "approval".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text("approval_details".tr, textAlign: TextAlign.center),
                  ],
                ),
              ),
              const SizedBox(height: 117),
              CustomButton(
                text: "Contact To Admin".tr,
                onTap: ()=> _launchPhone(Get.find<ServiceController>().serviceInfo.value?.contactPhone ?? ""),
              ),
            ],
          ),
        ),
      ),
    );
  }
  
    Future<void> _launchPhone(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar("Error", "Could not launch phone dialer");
    }
  }
}
