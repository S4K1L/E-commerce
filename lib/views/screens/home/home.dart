import 'package:bdm/controllers/product_controller.dart';
import 'package:bdm/controllers/service_controller.dart';
import 'package:bdm/models/product_model.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/views/base/custom_loading.dart';
import 'package:bdm/views/base/custom_networked_image.dart';
import 'package:bdm/views/base/product_card.dart';
import 'package:bdm/views/screens/home/all_items.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final product = Get.find<ProductController>();
  final service = Get.find<ServiceController>();
  final List<String> ads = [
    "assets/images/ad.png",
    "assets/images/ad.png",
    "assets/images/ad.png",
    "assets/images/ad.png",
  ];

  int _current = 0;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    getProducts();
    product.getCondition();
    Get.find<ServiceController>().checkServiceAvailability();
  }

  void getProducts() async {
    if (product.categories.isEmpty) {
      setState(() {
        isLoading = true;
      });
    }

    final message = await product.fetchCategories();

    if (message == "success") {
    } else {
      Get.showSnackbar(
        GetSnackBar(title: "error_occurred".tr, message: message),
      );
    }

    if (isLoading == true) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // getProducts();
    return SingleChildScrollView(
      child: Column(
        children: [
          if (service.banners.isNotEmpty) const SizedBox(height: 16),
          Obx(
            () =>
                service.banners.isEmpty
                    ? Container()
                    : CarouselSlider(
                      items: [
                        ...service.banners.map(
                          (banner) => Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: CustomNetworkedImage(
                              url: ApiService.getImage(banner.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                      options: CarouselOptions(
                        height: 188,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: true,
                        enlargeCenterPage: false,
                        autoPlay: service.banners.length > 1,
                        pauseAutoPlayOnTouch: true,
                        autoPlayAnimationDuration: Duration(seconds: 1),
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                    ),
          ),
          if (service.banners.isNotEmpty) const SizedBox(height: 16),
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 6,
              children: List.generate(service.banners.length, (index) {
                return Container(
                  width: 7,
                  height: 7,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _current == index
                            ? Theme.of(context).primaryColor
                            : Colors.transparent,
                    border: Border.all(
                      color:
                          Theme.of(context).textTheme.bodySmall?.color ??
                          Colors.grey,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 16),
          if (isLoading)
            Padding(padding: const EdgeInsets.all(8.0), child: CustomLoading()),
          for (var i in product.categories)
            Padding(
              padding: const EdgeInsets.only(bottom: 28),
              child: category(i.categoryName, i.products ?? [], i.categoryId),
            ),
        ],
      ),
    );
  }

  Widget category(String title, List<ProductModel> products, int id) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            Get.to(() => AllItems(title: title, id: id.toString()));
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
                Spacer(),
                Text(
                  "view_all".tr,
                  style: TextStyle(
                    color: Theme.of(context).textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 240,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            clipBehavior: Clip.none,
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: EdgeInsets.only(
                  left: 16,
                  right: index == products.length - 1 ? 16 : 0,
                ),
                child: ProductCard(product: product),
              );
            },
          ),
        ),
      ],
    );
  }
}
