import 'package:bdm/controllers/product_controller.dart';
import 'package:bdm/utils/custom_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomNavbar extends StatelessWidget {
  final int index;
  final Function(int)? onChanged;
  const CustomBottomNavbar({super.key, required this.index, this.onChanged});

  final List<String> names = const ["Home", "Cart", "History", "Profile"];
  final List<String> icons = const [
    "assets/icons/home.svg",
    "assets/icons/cart.svg",
    "assets/icons/history.svg",
    "assets/icons/profile.svg",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -2),
            blurRadius: 16,
            color: Theme.of(context).shadowColor,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Row(
          children: [
            item(context, 0),
            item(context, 1, cartCount: true),
            item(context, 2),
            item(context, 3),
          ],
        ),
      ),
    );
  }

  Widget item(BuildContext context, int pos, {bool cartCount = false}) {
    bool isSelected = pos == index;
    String name = names[pos];
    String icon = icons[pos];

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (onChanged != null) onChanged!(pos);
        },
        behavior: HitTestBehavior.translucent,
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.topRight,
                clipBehavior: Clip.none,
                children: [
                  CustomSvg(
                    asset: icon,
                    size: 24,
                    color:
                        isSelected
                            ? Theme.of(
                              context,
                            ).bottomNavigationBarTheme.selectedItemColor
                            : Theme.of(
                              context,
                            ).bottomNavigationBarTheme.unselectedItemColor,
                  ),
                  if (cartCount)
                    Positioned(
                      top: -2,
                      right: -5,
                      child: Obx(() {
                        final prod = Get.find<ProductController>();
                        if (prod.cart.isEmpty) {
                          return Container();
                        }
                        return Container(
                          height: 16,
                          width: 16,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0xffF4686E),
                          ),
                          child: FittedBox(
                            child: Text(
                              prod.cart.length.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 8,
                              ),
                            ),
                          ),
                        );
                      }),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                name.tr,
                style: TextStyle(
                  fontSize: 12,
                  color:
                      isSelected
                          ? Theme.of(
                            context,
                          ).bottomNavigationBarTheme.selectedItemColor
                          : Theme.of(
                            context,
                          ).bottomNavigationBarTheme.unselectedItemColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
