import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

Future<File?> customImagePicker({isCircular = true, isSquared = true}) async {
  final picker = ImagePicker();
  final cropper = ImageCropper();

  final XFile? pickedImage = await picker.pickImage(
    source: ImageSource.gallery,
  );

  if (pickedImage != null) {
    final CroppedFile? croppedImage = await cropper.cropImage(
      sourcePath: pickedImage.path,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: "crop_your_image".tr,
          toolbarColor: Colors.black,
          toolbarWidgetColor: Colors.blue[50],
          backgroundColor: Colors.black,
          statusBarColor: Colors.blue,
          cropStyle: isCircular ? CropStyle.circle : CropStyle.rectangle,
          hideBottomControls: isSquared,
          initAspectRatio: CropAspectRatioPreset.square,
        ),
        IOSUiSettings(
          cropStyle: isCircular ? CropStyle.circle : CropStyle.rectangle,
          showCancelConfirmationDialog: true,
        ),
      ],
    );

    if (croppedImage != null) {
      return File(croppedImage.path);
    }
  }

  return null;
}
