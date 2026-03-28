import 'package:bdm/controllers/service_controller.dart';
import 'package:bdm/controllers/user_controller.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/utils/custom_svg.dart';
import 'package:bdm/views/base/custom_networked_image.dart';
import 'package:bdm/views/screens/home/notice.dart';
import 'package:bdm/views/screens/home/search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool isHome;
  final bool hasActions;
  final bool hasLeading;
  final String? title;
  const CustomAppBar({
    super.key,
    this.isHome = false,
    this.hasActions = false,
    this.hasLeading = true,
    this.title,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

class _CustomAppBarState extends State<CustomAppBar> {
  final user = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 0,
      surfaceTintColor: Colors.transparent,
      backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      automaticallyImplyLeading: false,
      title: Padding(
        padding: const EdgeInsets.only(
          top: 12,
          left: 16,
          bottom: 16,
          right: 16,
        ),
        child: Row(
          children: [
            if (widget.hasLeading && !widget.isHome)
              GestureDetector(
                onTap: () {
                  Get.back();
                },
                behavior: HitTestBehavior.translucent,
                child: SizedBox(
                  height: 40,
                  width: 40,
                  child: Center(
                    child: CustomSvg(
                      asset: "assets/icons/arrow_back.svg",
                      color: Theme.of(context).appBarTheme.iconTheme?.color,
                    ),
                  ),
                ),
              ),
            if (widget.isHome)
              Row(
                children: [
                  // Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       "hei".tr,
                  //       style: TextStyle(
                  //         fontSize: 12,
                  //         color: Color(0xffE8F6ED),
                  //       ),
                  //     ),
                  //     Text(
                  //       "${user.userInfo.value?.fullName}!",
                  //       style: TextStyle(
                  //         fontSize: 18,
                  //         fontWeight: FontWeight.w600,
                  //         color: Color(0xffE8F6ED),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // ,
                  Obx(() {
                    final service = Get.find<ServiceController>();
                    if (service.serviceInfo.value != null) {
                      return CustomNetworkedImage(
                        url: ApiService.getImage(
                          service.serviceInfo.value!.logo,
                        ),
                        height: 18,
                        width: 18,
                        baseColor: Colors.transparent,
                        errorWidget: Container(),
                      );
                    }
                    return Container();
                  }),
                  const SizedBox(width: 2),
                  Obx(
                    () => Text(
                      Get.find<ServiceController>().serviceInfo.value?.name ??
                          "",
                      style: Theme.of(context).appBarTheme.titleTextStyle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => Notice());
                    },
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Theme.of(context).dividerColor,
                      ),
                      child: Center(
                        child: CustomSvg(
                          asset: "assets/icons/anouncement.svg",
                          size: 16,
                          color: Theme.of(context).appBarTheme.iconTheme?.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            if (widget.title != null)
              Text(
                widget.title!,
                style: Theme.of(context).appBarTheme.titleTextStyle,
              ),

            Spacer(),
            if (widget.hasActions)
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(() => Search());
                    },
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Center(
                        child: CustomSvg(
                          asset: "assets/icons/search.svg",
                          color: Theme.of(context).appBarTheme.iconTheme?.color,
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => Search(isFilter: true));
                    },
                    child: SizedBox(
                      height: 40,
                      width: 40,
                      child: Center(
                        child: CustomSvg(
                          asset: "assets/icons/filter.svg",
                          color: Theme.of(context).appBarTheme.iconTheme?.color,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
