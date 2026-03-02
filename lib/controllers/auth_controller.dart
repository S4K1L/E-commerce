import 'dart:convert';
import 'package:bdm/controllers/user_controller.dart';
import 'package:bdm/models/area_model.dart';
import 'package:bdm/views/screens/auth/welcome.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/services/shared_prefs_service.dart';

class AuthController extends GetxController {
  RxBool isLoggedIn = RxBool(false);
  RxBool isLoading = RxBool(false);
  final api = ApiService();

  RxList<AreaModel> areas = RxList.empty();

  Future<String> login(
    String email,
    String password, {
    bool rememberMe = true,
  }) async {
    isLoading(true);
    try {
      final response = await api.post("/auth/login/", {
        "phone": email.trim(),
        "password": password.trim(),
      });
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (rememberMe) {
          setToken(body['access_token']);
        }
        Get.find<UserController>().setInfo(body['data']);

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  Future<String> signup(
    String name,
    String email,
    String phone,
    String shopName,
    String shopAddress,
    String area,
    String password,
    String confirmPassword,
  ) async {
    isLoading(true);
    try {
      final response = await api.post("/auth/signup/", {
        "full_name": name.trim(),
        "email": email.trim(),
        "phone": phone.trim(),
        "shop_name": shopName.trim(),
        "shop_address": shopAddress.trim(),
        "area_id": area.trim(),
        "password": password.trim(),
        "confirm_password": confirmPassword.trim(),
      });

      if (response.statusCode == 200 || response.statusCode == 201) {
        return "success";
      } else {
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading(false);
    }
  }

  Future<bool> previouslyLoggedIn() async {
    String? token = await SharedPrefsService.get('token');
    if (token != null) {
      debugPrint('🔍 Token found. Fetching user info...');
      final message = await Get.find<UserController>().getInfo();
      if (message == "success") {
        debugPrint("🟡 Token: $token");
        isLoggedIn.value = true;
        return true;
      }
    }
    isLoggedIn.value = false;
    return false;
  }

  Future<void> logout({bool isForced = false}) async {
    await SharedPrefsService.remove('token');
    Get.offAll(() => Welcome());
    if (isForced) {
      Get.snackbar("Session expired", "You have been logged out");
    }
    isLoggedIn.value = false;
  }

  Future<void> setToken(String value) async {
    await SharedPrefsService.set('token', value);
    debugPrint('💾 Token Saved: $value');
  }

  Future<String> getAreas() async {
    try {
      final response = await api.get("/auth/area/");
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        areas.clear();
        for (var i in data) {
          areas.add(AreaModel.fromJson(i));
        }

        return "success";
      } else {
        return "Failed to get Areas";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }
}
