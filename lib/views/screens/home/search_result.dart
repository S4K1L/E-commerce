import 'package:bdm/models/product_model.dart';
import 'package:bdm/views/base/custom_app_bar.dart';
import 'package:bdm/views/base/show_product_cards.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchResult extends StatelessWidget {
  final List<ProductModel> results;
  const SearchResult({super.key, required this.results});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Search Result".tr, hasActions: true),
      body: SafeArea(
        top: false,
        child: Padding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(top: 24, bottom: 8),
                child: Text(
                  "${results.length} Items",
                  style: TextStyle(fontSize: 16),
                ),
              ),
              Expanded(child: ShowProductCards(products: results)),
            ],
          ),
        ),
      ),
    );
  }
}
