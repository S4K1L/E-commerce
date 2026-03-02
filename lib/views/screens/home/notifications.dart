import 'package:bdm/controllers/user_controller.dart';
import 'package:bdm/utils/custom_svg.dart';
import 'package:bdm/utils/formatter.dart';
import 'package:bdm/views/base/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Notifications extends StatelessWidget {
  const Notifications({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<UserController>().readNotifications();
    });
    return Scaffold(
      appBar: CustomAppBar(title: "Notification".tr, hasActions: true),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: SafeArea(
            child: Obx(() {
              final user = Get.find<UserController>();
              return Column(
                children: [
                  const SizedBox(height: 12),
                  for (var i in user.notifications)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 16,
                        ),
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
                        child: Row(
                          children: [
                            Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                color: Theme.of(context).dividerColor,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: CustomSvg(
                                  asset: "assets/icons/anouncement.svg",
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        i.title,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Text(
                                        Formatter.durationFormatter(
                                          DateTime.now().difference(
                                            i.createdAt,
                                          ),
                                        ),
                                        style: TextStyle(
                                          fontSize: 10,
                                          color:
                                              Theme.of(
                                                context,
                                              ).textTheme.bodySmall?.color,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    i.message,
                                    style: TextStyle(
                                      fontSize: 10,
                                      color:
                                          Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 12),
                            if (!i.isRead)
                              Container(
                                height: 10,
                                width: 10,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xffF4686E),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
