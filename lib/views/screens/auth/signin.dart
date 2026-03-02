import 'package:bdm/controllers/auth_controller.dart';
import 'package:bdm/controllers/service_controller.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/views/base/custom_button.dart';
import 'package:bdm/views/base/custom_dropdown.dart';
import 'package:bdm/views/base/custom_networked_image.dart';
import 'package:bdm/views/base/custom_text_field.dart';
import 'package:bdm/views/screens/auth/login.dart';
import 'package:bdm/views/screens/auth/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Signin extends StatefulWidget {
  const Signin({super.key});

  @override
  State<Signin> createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  final auth = Get.find<AuthController>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final conPassCtrl = TextEditingController();
  final shopNameCtrl = TextEditingController();
  final shopAddressCtrl = TextEditingController();

  int? area;

  void callBack() async {
    final message = await auth.signup(
      nameCtrl.text,
      emailCtrl.text,
      phoneCtrl.text,
      shopNameCtrl.text,
      shopAddressCtrl.text,
      area.toString(),
      passCtrl.text,
      conPassCtrl.text,
    );

    if (message == "success") {
      Get.snackbar("User created successfully", "Please Login to your account");
      Get.off(() => Welcome());
      Get.to(() => Login());
    } else {
      Get.snackbar("error_occurred".tr, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Align(
          alignment: Alignment.center,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  Hero(
                    tag: "logo",
                    child: Obx(() {
                      final service = Get.find<ServiceController>();
                      if (service.serviceInfo.value != null) {
                        return CustomNetworkedImage(
                          url: ApiService.getImage(
                            service.serviceInfo.value!.logo,
                          ),
                          height: 120,
                          width: 120,
                          baseColor: Colors.transparent,
                          errorWidget: Container(),
                        );
                      }
                      return Container();
                    }),
                  ),
                  const SizedBox(height: 24, width: double.infinity),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "signin".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "signin2".tr,
                      style: TextStyle(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        width: 0.5,
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      spacing: 12,
                      children: [
                        CustomTextField(
                          title: "signin3".tr,
                          hintText: "signin4".tr,
                          controller: nameCtrl,
                          leading: "assets/icons/profile.svg",
                        ),
                        CustomTextField(
                          title: "signin5".tr,
                          hintText: "signin6".tr,
                          controller: emailCtrl,
                          leading: "assets/icons/email.svg",
                        ),
                        CustomTextField(
                          title: "singin7".tr,
                          hintText: "singin8".tr,
                          controller: phoneCtrl,
                          leading: "assets/icons/phone.svg",
                        ),
                        CustomTextField(
                          leading: "assets/icons/lock.svg",
                          title: "signin9".tr,
                          hintText: "signin10".tr,
                          controller: passCtrl,
                          isPassword: true,
                        ),
                        CustomTextField(
                          leading: "assets/icons/lock.svg",
                          title: "signin11".tr,
                          hintText: "signin12".tr,
                          controller: conPassCtrl,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "signin13".tr,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                        width: 0.5,
                        color: Theme.of(context).dividerColor,
                      ),
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      spacing: 12,
                      children: [
                        CustomTextField(
                          title: "shop_name".tr,
                          hintText: "shop_name_hint".tr,
                          controller: shopNameCtrl,
                          leading: "assets/icons/shop.svg",
                        ),
                        CustomTextField(
                          title: "shop_address".tr,
                          hintText: "shop_address_hint".tr,
                          controller: shopAddressCtrl,
                          leading: "assets/icons/home.svg",
                        ),
                        Obx(
                          () => CustomDropdown(
                            title: "shop_area".tr,
                            hintText: "shop_area_hint".tr,
                            values:
                                auth.areas.map((val) => val.areaName).toList(),
                            leading: "assets/icons/location.svg",
                            onChanged: (index) {
                              setState(() {
                                area = auth.areas[index].areaId;
                              });
                            },
                            fetchArea: () {
                              auth.getAreas().then((message) {
                                if (message != "success") {
                                  Get.snackbar("error_occurred".tr, message);
                                  auth.getAreas();
                                }
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(() {
                    return CustomButton(
                      text: "Register".tr,
                      onTap: callBack,
                      isLoading: auth.isLoading.value,
                    );
                  }),
                  const SizedBox(height: 12),
                  Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?".tr,
                        style: TextStyle(fontSize: 12),
                      ),
                      InkWell(
                        onTap: () {
                          Get.off(() => Login());
                        },
                        child: Text(
                          "Log In".tr,
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
