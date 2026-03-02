import 'dart:io';
import 'package:bdm/controllers/user_controller.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/views/base/custom_app_bar.dart';
import 'package:bdm/views/base/custom_button.dart';
import 'package:bdm/views/base/custom_text_field.dart';
import 'package:bdm/views/base/profile_picture.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final user = Get.find<UserController>();
  final nameCtrl = TextEditingController();

  File? _image;

  @override
  void initState() {
    super.initState();
    nameCtrl.text = user.userInfo.value?.fullName ?? "";
  }

  void onCallBack() async {
    Map<String, dynamic> payload = {"full_name": nameCtrl.text.trim()};

    if (_image != null) {
      payload.addAll({"image": _image});
    }

    final message = await user.updateInfo(payload);

    if (message == "success") {
      Get.back();
      Get.snackbar(
        "Profile Saved".tr,
        "Your changes have been successfully updated.".tr,
      );
    } else {
      Get.snackbar("error_occurred".tr, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Edit Profile".tr, hasActions: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context).dividerColor,
                    width: 0.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 10,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 2,
                          color: Theme.of(context).dividerColor,
                        ),
                      ),
                      child: Center(
                        child: ProfilePicture(
                          image: ApiService.getImage(
                            user.userInfo.value?.image,
                          ),
                          imageFile: _image,
                          imagePickerCallback: (image) {
                            setState(() {
                              _image = image;
                            });
                          },
                          isEditable: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    CustomTextField(
                      title: "Name".tr,
                      controller: nameCtrl,
                      hintText: "Enter your name".tr,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 60),
              Obx(
                () => CustomButton(
                  text: "Save Now".tr,
                  isLoading: user.isLoading.value,
                  onTap: onCallBack,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
