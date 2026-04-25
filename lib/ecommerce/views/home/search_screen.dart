import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_routes.dart';
import '../../config/app_text_styles.dart';
import '../../data/sample_data.dart';
import '../../models/product.dart';
import '../../widgets/app_back_button.dart';
import '../../widgets/app_search_bar.dart';
import '../../widgets/category_chip.dart';
import '../../widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctrl = TextEditingController();
  String _query = '';

  final recent = const [
    'Light Brown Coat',
    'Sneakers',
    'Sofa',
    'iPhone',
    'Headphones'
  ];
  final categories = const ['All', 'Shoes', 'Clothes', 'Electronics', 'Furniture'];
  String _selectedCat = 'All';

  List<ProductModel> get _filtered {
    final q = _query.trim().toLowerCase();
    return SampleData.products.where((p) {
      final byCat = _selectedCat == 'All' ||
          p.category.toLowerCase() == _selectedCat.toLowerCase();
      final byQ = q.isEmpty || p.name.toLowerCase().contains(q);
      return byCat && byQ;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 8),
              child: Row(
                children: [
                  const AppBackButton(),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppSearchBar(
                      controller: _ctrl,
                      autoFocus: true,
                      onChanged: (v) => setState(() => _query = v),
                      hint: 'Search products',
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (_, __) => const SizedBox(width: 8),
                  itemBuilder: (_, i) => CategoryChip(
                    label: categories[i],
                    selected: _selectedCat == categories[i],
                    onTap: () =>
                        setState(() => _selectedCat = categories[i]),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: _query.isEmpty
                  ? _recentList()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: GridView.builder(
                        itemCount: _filtered.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          childAspectRatio: 0.72,
                        ),
                        itemBuilder: (_, i) =>
                            ProductCard(product: _filtered[i]),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _recentList() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: ListView(
        children: [
          Text('Recent Searches',
              style:
                  AppTextStyles.title.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          ...recent.map((r) => ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  width: 36,
                  height: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.history,
                      color: AppColors.textSecondary, size: 18),
                ),
                title: Text(r, style: AppTextStyles.body),
                trailing: const Icon(Icons.north_west,
                    color: AppColors.textSecondary, size: 18),
                onTap: () {
                  _ctrl.text = r;
                  setState(() => _query = r);
                },
              )),
          const SizedBox(height: 16),
          Text('Popular Now',
              style:
                  AppTextStyles.title.copyWith(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.72,
            ),
            itemBuilder: (_, i) {
              return ProductCard(
                  product: SampleData.products[i + 1]);
            },
          ),
          const SizedBox(height: 24),
          Center(
            child: TextButton(
              onPressed: () => Get.toNamed<void>(Routes.category,
                  arguments: 'All Categories'),
              child: const Text('Browse all categories'),
            ),
          ),
        ],
      ),
    );
  }
}
