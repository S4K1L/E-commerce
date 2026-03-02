import 'package:bdm/models/banner_model.dart';
import 'package:bdm/models/service_info.dart';
import 'package:bdm/services/api_service.dart';
import 'package:bdm/services/shared_prefs_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'dart:convert';

class ServiceController extends GetxController {
  var serviceInfo = Rxn<ServiceInfo>();
  RxList<BannerModel> banners = RxList.empty();
  final api = ApiService();

  var isLoading = false.obs;

  Future<void> fetchServiceInfo() async {
    try {
      isLoading.value = true;

      final response = await api.get("/settings/site_info/");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        final info = ServiceInfo.fromJson(data['data'][0]);
        serviceInfo.value = info;

        if (data['data'][0] != null) {
          await SharedPrefsService.set('service_info', data['data'][0]);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBanners() async {
    try {
      isLoading.value = true;

      final response = await api.get("/products/banners/");
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];

        List<BannerModel> temp = [];
        for (var i in data) {
          temp.add(BannerModel.fromJson(i));
        }

        if (temp.isNotEmpty) {
          banners = RxList.from(temp);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void checkServiceAvailability() {
    if (serviceInfo.value == null) {
      fetchServiceInfo();
    }
    if (banners.isEmpty) {
      fetchBanners();
    }
  }
}
