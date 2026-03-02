import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkedImage extends StatelessWidget {
  final String? url;
  final File? file;
  final String? randomSeed;
  final double? height;
  final double? width;
  final double radius;
  final bool shimmer;
  final BoxFit? fit;
  final Widget? errorWidget;
  final Color? baseColor;
  const CustomNetworkedImage({
    super.key,
    this.url,
    this.randomSeed,
    this.height,
    this.width,
    this.baseColor,
    this.radius = 10,
    this.fit = BoxFit.cover,
    this.shimmer = true,
    this.errorWidget,
    this.file,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(radius),
      child:
          file != null
              ? Image.file(file!, height: height, width: width, fit: fit)
              : CachedNetworkImage(
                imageUrl:
                    url ??
                    "https://picsum.photos/${randomSeed == null ? "" : "seed/$randomSeed/"}${(width ?? 400).toInt()}/${(height ?? 400).toInt()}",
                height: height,
                width: width,
                fit: fit,
                errorWidget: (context, url, error) {
                  return errorWidget ??
                      Container(
                        height: height,
                        width: width,
                        color: Theme.of(context).dividerColor,
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.error, color: Colors.red),
                              Text(error.toString()),
                            ],
                          ),
                        ),
                      );
                },
                placeholder: (context, url) {
                  return Shimmer.fromColors(
                    baseColor: baseColor ?? Theme.of(context).dividerColor,
                    highlightColor: Theme.of(
                      context,
                    ).primaryColor.withOpacity(0.5),
                    period: Duration(milliseconds: 800),
                    child: Container(
                      height: height ?? width,
                      width: width ?? height,
                      color: Colors.white,
                    ),
                  );
                },
              ),
    );
  }
}
