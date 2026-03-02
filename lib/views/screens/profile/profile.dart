import 'package:bdm/controllers/localization_controller.dart';
import 'package:bdm/controllers/service_controller.dart';
import 'package:bdm/controllers/theme_controller.dart';
import 'package:bdm/controllers/user_controller.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/utils/custom_svg.dart';
import 'package:bdm/views/base/profile_picture.dart';
import 'package:bdm/views/screens/profile/edit_profile.dart';
import 'package:bdm/views/screens/profile/log_out.dart';
import 'package:bdm/views/screens/profile/privacy_and_policy.dart';
import 'package:bdm/views/screens/profile/terms_and_condition.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final user = Get.find<UserController>();
  final serviceInfo = Get.find<ServiceController>().serviceInfo.value;
  bool pushNotifications = false;
  bool isBangla = false;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocalizationController>().locale.toString() == "bn") {
      isBangla = true;
    } else {
      isBangla = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(height: 12),
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).shadowColor,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Obx(
                    () => Row(
                      children: [
                        Container(
                          height: 80,
                          width: 80,
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).dividerColor,
                              width: 2,
                            ),
                          ),
                          child: Center(
                            child: ProfilePicture(
                              image: ApiService.getImage(
                                user.userInfo.value?.image,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            spacing: 2,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.userInfo.value?.fullName ?? "Null",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                user.userInfo.value?.email ?? "Null",
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodySmall?.color,
                                ),
                              ),
                              Text(
                                "${user.userInfo.value?.shopName} ${user.userInfo.value?.shopAddress}, ${user.userInfo.value?.areaName}",
                                style: TextStyle(
                                  fontSize: 12,
                                  color:
                                      Theme.of(
                                        context,
                                      ).textTheme.bodySmall?.color,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 0,
                  top: 22,
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Get.to(() => EditProfile());
                    },
                    child: Container(
                      height: 18,
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(8),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          "edit".tr,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Theme.of(context).shadowColor,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                spacing: 25,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      setState(() {
                        isBangla = !isBangla;
                      });

                      if (isBangla) {
                        Get.find<LocalizationController>().setLanguage(
                          Locale.fromSubtags(languageCode: "bn"),
                        );
                      } else {
                        Get.find<LocalizationController>().setLanguage(
                          Locale.fromSubtags(languageCode: "en"),
                        );
                      }
                    },
                    child: Row(
                      children: [
                        CustomSvg(
                          asset: "assets/icons/profile.svg",
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 12),
                        Text("language".tr, style: TextStyle(fontSize: 16)),
                        Spacer(),
                        Text(
                          "ban".tr,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                !isBangla
                                    ? Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color
                                    : Color(0xff30D143),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text("/", style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 4),
                        Text(
                          "eng".tr,
                          style: TextStyle(
                            fontSize: 16,
                            color:
                                isBangla
                                    ? Theme.of(
                                      context,
                                    ).textTheme.bodyLarge?.color
                                    : Color(0xff30D143),
                          ),
                        ),
                      ],
                    ),
                  ),
                  GetBuilder<ThemeController>(
                    builder: (themeController) {
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => themeController.toggleTheme(),
                        child: Row(
                          children: [
                            Icon(
                              themeController.darkTheme
                                  ? Icons.dark_mode_outlined
                                  : Icons.light_mode_outlined,
                              size: 24,
                              color: Theme.of(context).iconTheme.color,
                            ),
                            const SizedBox(width: 12),
                            Text("theme".tr, style: TextStyle(fontSize: 16)),
                            Spacer(),
                            Text(
                              "dark".tr,
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    themeController.darkTheme
                                        ? Color(0xff30D143)
                                        : Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                              ),
                            ),
                            const SizedBox(width: 4),
                            Text("/", style: TextStyle(fontSize: 16)),
                            const SizedBox(width: 4),
                            Text(
                              "light".tr,
                              style: TextStyle(
                                fontSize: 16,
                                color:
                                    !themeController.darkTheme
                                        ? Color(0xff30D143)
                                        : Theme.of(
                                          context,
                                        ).textTheme.bodyLarge?.color,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  // Row(
                  //   children: [
                  //     CustomSvg(asset: "assets/icons/profile.svg"),
                  //     const SizedBox(width: 12),
                  //     Text(
                  //       "push_notification".tr,
                  //       style: TextStyle(fontSize: 16),
                  //     ),
                  //     Spacer(),
                  //     SizedBox(
                  //       height: 24,
                  //       child: Switch(
                  //         value: pushNotifications,
                  //         onChanged: (val) {
                  //           setState(() {
                  //             pushNotifications = val;
                  //           });
                  //         },
                  //         activeTrackColor: Color(0xff30D143),
                  //         activeColor: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Row(
                    children: [
                      CustomSvg(
                        asset: "assets/icons/support.svg",
                        color: Theme.of(context).iconTheme.color,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "contact_support".tr,
                        style: TextStyle(fontSize: 16),
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          if (serviceInfo?.contactPhone != null) {
                            _launchPhone(serviceInfo!.contactPhone);
                          }
                        },
                        child: CustomSvg(
                          asset: "assets/icons/phone.svg",
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                      const SizedBox(width: 12),
                      InkWell(
                        onTap: () {
                          if (serviceInfo?.contactEmail != null) {
                            _launchEmail(serviceInfo!.contactEmail);
                          }
                        },
                        child: CustomSvg(
                          asset: "assets/icons/email.svg",
                          color: Theme.of(context).iconTheme.color,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Get.to(() => TermsAndCondition());
                    },
                    child: Row(
                      children: [
                        CustomSvg(
                          asset: "assets/icons/terms.svg",
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "terms_and_conditions".tr,
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Get.to(() => PrivacyAndPolicy());
                    },
                    child: Row(
                      children: [
                        CustomSvg(
                          asset: "assets/icons/privacy.svg",
                          color: Theme.of(context).iconTheme.color,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "privacy_and_policy".tr,
                          style: TextStyle(fontSize: 16),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      Get.to(() => LogOut());
                    },
                    child: Row(
                      children: [
                        CustomSvg(
                          asset: "assets/icons/logout.svg",
                          color: const Color(0xffFDB9B9),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          "log_out".tr,
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffFDB9B9),
                          ),
                        ),
                        Spacer(),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String? get formattedPhoneNumber {
    return "${user.userInfo.value?.phone.substring(0, 5)}-${user.userInfo.value?.phone.substring(5, 8)} ${user.userInfo.value?.phone.substring(8)}";
  }

  Future<void> _launchPhone(String phone) async {
    final Uri uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar("Error", "Could not launch phone dialer");
    }
  }

  Future<void> _launchEmail(String email) async {
    final Uri uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      Get.snackbar("Error", "Could not launch email app");
    }
  }
}
