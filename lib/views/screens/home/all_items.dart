import 'package:bdm/controllers/product_controller.dart';
import 'package:bdm/views/base/custom_app_bar.dart';
import 'package:bdm/views/base/custom_loading.dart';
import 'package:bdm/views/base/show_product_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllItems extends StatefulWidget {
  final String title;
  final String id;
  const AllItems({super.key, required this.title, required this.id});

  @override
  State<AllItems> createState() => _AllItemsState();
}

class _AllItemsState extends State<AllItems> {
  final prod = Get.find<ProductController>();

  @override
  void initState() {
    super.initState();
    prod.fetchProductsByCategory(widget.id).then((message) {
      if (message != "success") {
        Get.showSnackbar(
          GetSnackBar(title: "error_occurred".tr, message: message),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.title, hasActions: true),
      // bottomNavigationBar: CustomBottomNavbar(index: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SizedBox(
          width: double.infinity,
          child: SafeArea(
            child: Obx(
              () =>
                  prod.isLoading.value
                      ? CustomLoading()
                      : ShowProductCards(products: prod.items),
            ),
          ),
        ),
      ),
    );
  }
}
