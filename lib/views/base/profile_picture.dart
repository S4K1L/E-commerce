import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:bdm/utils/custom_image_picker.dart';
import 'package:bdm/utils/custom_svg.dart';
import 'package:shimmer/shimmer.dart';

class ProfilePicture extends StatelessWidget {
  final double size;
  final String? image;
  final File? imageFile;
  final bool showLoading;
  final bool isEditable;
  final Function(File)? imagePickerCallback;

  const ProfilePicture({
    super.key,
    this.image,
    this.size = 140,
    this.showLoading = true,
    this.isEditable = false,
    this.imagePickerCallback,
    this.imageFile,
  });

  static const Color greenColor = Color(0xFF30D143);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () async {
        if (!isEditable) {
          return;
        }

        File? image = await customImagePicker();

        if (image != null && imagePickerCallback != null) {
          imagePickerCallback!(image);
        }
      },
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(100),
            child:
                imageFile != null
                    ? Image.file(
                      imageFile!,
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                    )
                    : image != null
                    ? CachedNetworkImage(
                      imageUrl: image!,
                      placeholder: (context, url) {
                        return Shimmer.fromColors(
                          baseColor: Theme.of(context).dividerColor,
                          highlightColor: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.5),
                          period: Duration(milliseconds: 800),
                          child: Container(
                            height: size,
                            width: size,
                            color: Colors.white,
                          ),
                        );
                      },
                      errorWidget: (context, url, error) {
                        return Container(
                          width: size,
                          height: size,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          child: Icon(
                            Icons.error,
                            color: Theme.of(context).primaryColor,
                          ),
                        );
                      },
                      width: size,
                      height: size,
                      fit: BoxFit.cover,
                    )
                    : Container(
                      width: size,
                      height: size,
                      // padding: EdgeInsets.all(size * 0.17),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(
                            context,
                          ).primaryColor.withOpacity(0.6),
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Icons.error,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
          ),
          if (isEditable)
            Positioned(
              right: -7,
              bottom: -12,
              child: Center(child: CustomSvg(asset: "assets/icons/camera.svg")),
            ),
        ],
      ),
    );
  }
}
