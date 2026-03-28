import 'dart:convert';

import 'package:bdm/controllers/user_controller.dart';
import 'package:bdm/models/category_model.dart';
import 'package:bdm/models/company_model.dart';
import 'package:bdm/models/generic_model.dart';
import 'package:bdm/models/order_model.dart';
import 'package:bdm/models/product_model.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/services/shared_prefs_service.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  RxList<CategoryModel> categories = RxList.empty();
  RxList<ProductModel> items = RxList.empty();
  RxList<ProductModel> searchResult = RxList.empty();
  RxList<OrderModel> history = RxList.empty();
  RxList<CompanyModel> companies = RxList.empty();
  RxList<CompanyModel> selectedCompanies = RxList.empty();
  RxList<GenericModel> generics = RxList.empty();
  RxList<GenericModel> selectedGenerics = RxList.empty();
  RxList<String> orderingAgain = RxList.empty();
  RxList<String> cartCondition = <String>[].obs;
  RxMap<ProductModel, int> cart = RxMap();

  RxBool isLoading = RxBool(false);
  RxBool isSearching = RxBool(false);
  RxBool isPlacingOrder = RxBool(false);
  RxBool companyLoading = RxBool(false);

  final api = ApiService();
  final prefs = SharedPrefsService();

  @override
  void onInit() {
    super.onInit();
    loadCartFromCache();
  }

  Future<String> getCondition() async {
    try {
      isLoading(true);
      final response = await api.get(
        "/settings/privacy-policy/",
        authReq: true,
      );

      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final content = body['data'][0]['content'] ?? "";

        final List<String> parsedList =
            content
                .toString()
                .split("\n")
                .map((String e) => e.replaceAll("#", "").trim())
                .where((String e) => e.isNotEmpty)
                .toList();

        cartCondition.assignAll(parsedList);
        return "success";
      } else {
        return body['message'] ?? response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> fetchProductsByCategory(String id) async {
    try {
      isLoading(true);
      final response = await api.get(
        "/products/products/category/$id",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        items.clear();
        for (var i in data) {
          items.add(ProductModel.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> fetchCategories() async {
    try {
      isLoading(true);
      final response = await api.get(
        "/products/products/category/",
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        categories.clear();
        for (var i in data) {
          categories.add(CategoryModel.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> fetchCompanies() async {
    try {
      companyLoading(true);
      final response = await api.get("/products/companies/", authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        companies.clear();
        for (var i in data) {
          companies.add(CompanyModel.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    } finally {
      companyLoading(false);
    }
  }

  Future<String> fetchGenerics() async {
    try {
      companyLoading(true);
      final response = await api.get("/products/generic_name/", authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        generics.clear();
        for (var i in data) {
          generics.add(GenericModel.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    } finally {
      companyLoading(false);
    }
  }

  Future<String> fetchHistory() async {
    try {
      isLoading(true);
      final response = await api.get("/orders/orders/", authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body["results"]['data'];

        List<OrderModel> temp = [];
        for (var i in data) {
          temp.add(OrderModel.fromJson(i));
        }

        history.value = temp;

        return "success";
      } else {
        return body['message'] ?? response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> search(String text) async {
    try {
      isSearching(true);
      final response = await api.get(
        "/products/products/search/",
        queryParams: {"q": text.trim()},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        searchResult.clear();
        for (var i in data) {
          searchResult.add(ProductModel.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    } finally {
      isSearching(false);
    }
  }

  Future<String> searchByCompany() async {
    try {
      isLoading(true);
      String searchText = "";

      for (var i in selectedCompanies) {
        searchText += i.companyName;

        if (selectedCompanies.last != i) {
          searchText += ",";
        }
      }

      final response = await api.get(
        "/products/search/by_companies/",
        queryParams: {"company_names": searchText},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        searchResult.clear();
        for (var i in data) {
          searchResult.add(ProductModel.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> searchByGeneric() async {
    try {
      isLoading(true);
      String searchText = "";

      for (var i in selectedGenerics) {
        searchText += i.name;

        if (selectedGenerics.last != i) {
          searchText += ",";
        }
      }

      final response = await api.get(
        "/products/search/by_generic_name/",
        queryParams: {"generic_names": searchText},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        searchResult.clear();
        for (var i in data) {
          searchResult.add(ProductModel.fromJson(i));
        }

        return "success";
      } else {
        return body['message'] ?? response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    } finally {
      isLoading(false);
    }
  }

  Future<String> placeOrder() async {
    try {
      isPlacingOrder(true);
      Map<String, dynamic> payload = {
        "user_id": Get.find<UserController>().userInfo.value?.userId,
        "items": [
          for (var i in cart.keys)
            {"product": i.productId, "quantity": cart[i]},
        ],
      };

      final response = await api.post(
        "/orders/orders/",
        payload,
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = body['data'];

        clearCart();

        return "success ${data['order_id']}";
      } else {
        return body['message'] ?? response.statusCode.toString();
      }
    } catch (e) {
      return e.toString();
    } finally {
      isPlacingOrder(false);
    }
  }

  Future<String> orderAgain(OrderModel order) async {
    try {
      orderingAgain.add(order.orderId.toString());
      int success = 0;
      int failed = 0;
      for (int i = 0; i < order.items.length; i++) {
        final item = order.items[i];

        getSingleProduct(item.product.toString()).then((val) {
          if (val != null) {
            success += 1;
            addToCart(val, count: item.quantity);
          } else {
            failed += 1;
          }

          if (i == order.items.length - 1) {
            Get.snackbar(
              "Products added to the Cart",
              "$success Products successfully added.\n${failed == 0 ? "" : "$failed Products failed to add."}",
            );
          }
        });
      }

      return "success";
    } catch (e) {
      return e.toString();
    } finally {
      orderingAgain.remove(order.orderId.toString());
    }
  }

  Future<ProductModel?> getSingleProduct(String id) async {
    try {
      final response = await api.get("/products/products/$id/", authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return ProductModel.fromJson(body["data"]);
      }
    } catch (e) {
      debugPrint("Error fetching product with ID: $id\n$e");
    }
    return null;
  }

  num getSubTotal() {
    num total = 0;
    cart.forEach((product, quantity) {
      total += (product.sellingPrice) * quantity;
    });
    return total;
  }

  num getTotal() {
    num total = 0;
    cart.forEach((product, quantity) {
      total += (product.sellingPrice) * quantity;
    });
    return total;
  }

  num getTotalDiscount() {
    num discount = 0;
    cart.forEach((product, quantity) {
      discount += (product.mrp - product.sellingPrice) * quantity;
    });
    return discount;
  }

  int cartContains(ProductModel product) {
    return cart[product] ?? 0;
  }

  void addToCart(ProductModel product, {int count = 1, int? newCount}) {
    if (newCount != null) {
      cart[product] = newCount;
      if (newCount == 0) {
        removeFromCart(product);
      }
    } else if (cart.containsKey(product)) {
      cart[product] = cart[product]! + count;
    } else {
      cart[product] = count;
    }

    saveCartToCache();
  }

  void removeFromCart(ProductModel product) {
    cart.remove(product);
    saveCartToCache();
  }

  void decreaseQuantity(ProductModel product) {
    if (cart.containsKey(product)) {
      final currentQty = cart[product]!;
      if (currentQty > 0) {
        cart[product] = currentQty - 1;
      }
    }

    cart.removeWhere((key, qty) => qty == 0);
    saveCartToCache();
  }

  void clearCart() {
    cart.clear();
    saveCartToCache();
  }

  Future<void> saveCartToCache() async {
    final cartList =
        cart.entries.map((entry) {
          return {'product': entry.key.toJson(), 'quantity': entry.value};
        }).toList();

    await SharedPrefsService.set('cart_cache', jsonEncode(cartList));
  }

  Future<void> loadCartFromCache() async {
    final cached = await SharedPrefsService.get('cart_cache');
    if (cached != null) {
      try {
        final List<dynamic> decoded = jsonDecode(cached);
        cart.clear();
        for (var item in decoded) {
          final product = ProductModel.fromJson(item['product']);
          final quantity = item['quantity'];
          cart[product] = quantity;
        }
      } catch (e) {
        cart.clear();
        await SharedPrefsService.remove('cart_cache');
      }
    }
  }
}
