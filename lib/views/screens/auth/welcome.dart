import 'package:bdm/controllers/service_controller.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/views/base/custom_button.dart';
import 'package:bdm/views/base/custom_networked_image.dart';
import 'package:bdm/views/screens/auth/login.dart';
import 'package:bdm/views/screens/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Welcome extends StatelessWidget {
  const Welcome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Obx(() {
            final service = Get.find<ServiceController>();
            if (service.serviceInfo.value != null) {
              return CustomNetworkedImage(
                url: ApiService.getImage(service.serviceInfo.value!.logo),
                height: 120,
                width: 120,
                baseColor: Colors.transparent,
                errorWidget: Container(),
              );
            }
            return Container();
          }),
          const SizedBox(height: 80, width: double.infinity),
          Text(
            "welcome".tr,
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 28),
          ),
          const SizedBox(height: 4),
          Text(
            "welcome2".tr,
            style: TextStyle(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 90),
          CustomButton(text: "Log In".tr, onTap: () => Get.to(() => Login())),
          const SizedBox(height: 24),
          CustomButton(
            text: "Sign Up".tr,
            isSecondary: true,
            onTap: () => Get.to(() => Signin()),
          ),
        ],
      ),
    );
  }
}
