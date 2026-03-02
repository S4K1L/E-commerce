import 'package:bdm/controllers/product_controller.dart';
import 'package:bdm/utils/custom_svg.dart';
import 'package:bdm/views/base/custom_app_bar.dart';
import 'package:bdm/views/base/custom_button.dart';
import 'package:bdm/views/base/custom_loading.dart';
import 'package:bdm/views/screens/home/item_details.dart';
import 'package:bdm/views/screens/home/search_result.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Search extends StatefulWidget {
  final bool isFilter;
  const Search({super.key, this.isFilter = false});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final prod = Get.find<ProductController>();
  final searchCtrl = TextEditingController();
  final _focusNode = FocusNode();

  bool filter = false;
  bool isLoading = false;
  bool isCompany = true;

  @override
  void initState() {
    super.initState();
    filter = widget.isFilter;
  }

  void serach() async {
    setState(() {
      isLoading = true;
    });
    late String message;

    if (filter) {
      if (isCompany) {
        message = await prod.searchByCompany();
      } else {
        message = await prod.searchByGeneric();
      }
    } else {
      message = await prod.search(searchCtrl.text.trim());
    }

    setState(() {
      isLoading = false;
    });

    if (message == "success") {
      Get.to(() => SearchResult(results: prod.searchResult));
    } else {
      Get.snackbar("error_occurred".tr, message);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Search".tr),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 52,
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(99),
                  boxShadow: [
                    BoxShadow(
                      color: Theme.of(context).shadowColor,
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  spacing: 8,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomSvg(asset: "assets/icons/search.svg"),
                    Expanded(
                      child: TextField(
                        controller: searchCtrl,
                        focusNode: _focusNode,
                        cursorColor: Theme.of(context).primaryColor,
                        onTapOutside: (event) {
                          _focusNode.unfocus();
                        },
                        onChanged: (value) {
                          if (filter) {
                            setState(() {});
                          } else {
                            prod.search(value);
                          }
                        },
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                          isCollapsed: true,
                          hintText:
                              "${"Search".tr} ${!filter
                                  ? "products".tr
                                  : isCompany
                                  ? "company".tr
                                  : "generic".tr}",
                          hintStyle: TextStyle(
                            color: Theme.of(context).textTheme.bodySmall?.color,
                          ),
                        ),
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        setState(() {
                          searchCtrl.text = "";
                          filter = !filter;
                        });
                      },
                      child: CustomSvg(
                        asset: "assets/icons/filter.svg",
                        color: filter ? Theme.of(context).primaryColor : null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              if (!filter)
                Flexible(
                  child: Obx(
                    () => SingleChildScrollView(
                      child: Column(
                        spacing: 2,
                        children: [
                          if (prod.isSearching.value && !isLoading)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CustomLoading(),
                            ),
                          if ((!prod.isSearching.value || isLoading) &&
                              searchCtrl.text != "")
                            for (var i in prod.searchResult)
                              GestureDetector(
                                onTap: () {
                                  Get.to(() => ItemDetails(product: i));
                                },
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).cardColor,
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(12),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Theme.of(context).shadowColor,
                                        blurRadius: 4,
                                        offset: Offset(0, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(children: [Text(i.productName)]),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ),
              if (filter)
                Flexible(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                      boxShadow: [
                        BoxShadow(
                          color: Theme.of(context).shadowColor,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      child: Obx(() {
                        final prod = Get.find<ProductController>();

                        if (isCompany && prod.companies.isEmpty) {
                          prod.fetchCompanies();
                        }
                        if (!isCompany && prod.generics.isEmpty) {
                          prod.fetchGenerics();
                        }
                        return Column(
                          spacing: 8,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 12.0,
                              ),
                              child: Row(
                                spacing: 12,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isCompany = true;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            isCompany
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(
                                                  context,
                                                ).dividerColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text("company".tr),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isCompany = false;
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 8,
                                        vertical: 4,
                                      ),
                                      decoration: BoxDecoration(
                                        color:
                                            !isCompany
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(
                                                  context,
                                                ).dividerColor,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text("generic".tr),
                                    ),
                                  ),
                                  Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        filter = false;
                                      });
                                    },
                                    child: Container(
                                      // padding: EdgeInsets.symmetric(
                                      //   horizontal: 4,
                                      //   vertical: 4,
                                      // ),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).dividerColor,
                                        borderRadius: BorderRadius.circular(4),
                                      ),
                                      child: Icon(Icons.close_rounded),
                                    ),
                                  ),
                                  Container(),
                                ],
                              ),
                            ),
                            if (prod.companyLoading.value)
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CustomLoading(),
                              ),
                            if (isCompany)
                              for (var i in prod.companies)
                                if (i.companyName.toLowerCase().contains(
                                  searchCtrl.text.toLowerCase(),
                                ))
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      if (prod.selectedCompanies.contains(i)) {
                                        prod.selectedCompanies.remove(i);
                                      } else {
                                        prod.selectedCompanies.add(i);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).dividerColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Expanded(child: Text(i.companyName)),
                                          Checkbox(
                                            value: prod.selectedCompanies
                                                .contains(i),
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            onChanged: (val) {
                                              if (val == true) {
                                                prod.selectedCompanies.add(i);
                                              } else {
                                                prod.selectedCompanies.remove(
                                                  i,
                                                );
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                            if (!isCompany)
                              for (var i in prod.generics)
                                if (i.name.toLowerCase().contains(
                                  searchCtrl.text.toLowerCase(),
                                ))
                                  GestureDetector(
                                    behavior: HitTestBehavior.translucent,
                                    onTap: () {
                                      if (prod.selectedGenerics.contains(i)) {
                                        prod.selectedGenerics.remove(i);
                                      } else {
                                        prod.selectedGenerics.add(i);
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(
                                          context,
                                        ).dividerColor.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Row(
                                        children: [
                                          const SizedBox(width: 16),
                                          Expanded(child: Text(i.name)),
                                          Checkbox(
                                            value: prod.selectedGenerics
                                                .contains(i),
                                            activeColor:
                                                Theme.of(context).primaryColor,
                                            onChanged: (val) {
                                              if (val == true) {
                                                prod.selectedGenerics.add(i);
                                              } else {
                                                prod.selectedGenerics.remove(i);
                                              }
                                            },
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
              const SizedBox(height: 16),
              if (!filter)
                CustomButton(
                  text: "Search Now".tr,
                  isLoading: isLoading,
                  onTap: () {
                    serach();
                  },
                ),
              if (filter)
                Row(
                  children: [
                    Expanded(
                      child: CustomButton(
                        text: "clear".tr,
                        onTap: () {
                          prod.selectedCompanies.clear();
                          prod.selectedGenerics.clear();
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: CustomButton(
                        text: "apply".tr,
                        isLoading: isLoading,
                        onTap: () {
                          serach();
                        },
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
