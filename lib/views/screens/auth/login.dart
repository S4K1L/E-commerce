import 'package:bdm/controllers/auth_controller.dart';
import 'package:bdm/controllers/service_controller.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/services/shared_prefs_service.dart';
import 'package:bdm/views/base/custom_button.dart';
import 'package:bdm/views/base/custom_networked_image.dart';
import 'package:bdm/views/base/custom_text_field.dart';
import 'package:bdm/views/screens/app.dart';
import 'package:bdm/views/screens/auth/approval.dart';
import 'package:bdm/views/screens/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final auth = Get.find<AuthController>();
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  bool rememberMe = true;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final savedEmail = await SharedPrefsService.get('email');
    final savedPassword = await SharedPrefsService.get('password');

    if (savedEmail != null && savedPassword != null) {
      emailCtrl.text = savedEmail;
      passCtrl.text = savedPassword;
      rememberMe = true;
    }
  }

  void callBack() async {
    await SharedPrefsService.set('email', emailCtrl.text.trim());
    await SharedPrefsService.set('password', passCtrl.text.trim());
    final message = await auth.login(
      emailCtrl.text.trim(),
      passCtrl.text.trim(),
      rememberMe: rememberMe,
    );

    if (message == "success") {
      Get.offAll(() => App(key: appKey));
    } else if (message == "Wait for admin approval.") {
      Get.to(() => Approval());
    } else {
      Get.snackbar("Error occured", message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
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
                      "login".tr,
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
                      "login2".tr,
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
                          title: "login3".tr,
                          hintText: "login4".tr,
                          controller: emailCtrl,
                          leading: "assets/icons/email.svg",
                        ),
                        CustomTextField(
                          leading: "assets/icons/lock.svg",
                          title: "login5".tr,
                          hintText: "login6".tr,
                          controller: passCtrl,
                          isPassword: true,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          height: 20,
                          width: 20,
                          child: Checkbox(
                            activeColor: Colors.green,
                            value: rememberMe,
                            onChanged: (val) {
                              setState(() {
                                rememberMe = !rememberMe;
                              });
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text("Remember me".tr),
                      ],
                    ),
                  ),
                  const SizedBox(height: 70),
                  Obx(
                    () => CustomButton(
                      text: "Log In".tr,
                      onTap: callBack,
                      isLoading: auth.isLoading.value,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    spacing: 4,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Do not have an account?".tr,
                        style: TextStyle(fontSize: 12),
                      ),
                      InkWell(
                        onTap: () {
                          Get.to(() => Signin());
                        },
                        child: Text(
                          "Sign Up".tr,
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
