import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:bdm/models/notice_model.dart';
import 'package:bdm/models/notification_model.dart';
import 'package:bdm/models/user.dart';
import 'package:bdm/services/api_service.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  final userInfo = Rxn<User>();
  final api = ApiService();
  final RxnString privacyPolicy = RxnString();

  // Notification
  final RxList<NotificationModel> notifications = RxList();
  final RxList<NoticeModel> notices = RxList();
  final RxInt unreadNotifications = RxInt(0);
  final notificationRefreshTime = Duration(minutes: 10);
  Timer? _notificationTimer;

  RxBool isLoading = RxBool(false);

  Future<String> getInfo() async {
    isLoading.value = true;
    try {
      final response = await api.get("/auth/user_profile/", authReq: true);
      var body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        setInfo(body);

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

  void setInfo(Map<String, dynamic>? json) {
    if (json != null) {
      userInfo.value = User.fromJson(json);
    }

    if (_notificationTimer == null) {
      _startNotificationTimer();
    }
  }

  Future<String> updateInfo(Map<String, dynamic> data) async {
    isLoading.value = true;
    try {
      final response = await api.patch(
        "/auth/user_profile/",
        data,
        authReq: true,
      );

      if (response.statusCode == 200) {
        setInfo(jsonDecode(response.body)['data']);
        isLoading.value = false;
        return "success";
      } else {
        isLoading.value = false;
        return jsonDecode(response.body)['message'] ?? "Connection Error";
      }
    } catch (e) {
      isLoading.value = false;
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> _getNotifications() async {
    try {
      final response = await api.get("/user/notifications/", authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        notifications.clear();
        int count = 0;

        final data = body['data'];

        for (var i in data) {
          if (!i["is_read"]) {
            count++;
          }
          notifications.add(NotificationModel.fromJson(i));
        }

        unreadNotifications.value = count;

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> readNotifications() async {
    try {
      final response = await api.post(
        "/user/notifications/mark_all_as_read/",
        {},
        authReq: true,
      );
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        unreadNotifications.value = 0;

        for (var i in notifications) {
          i.isRead = true;
        }

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      return "Unexpected error: ${e.toString()}";
    }
  }

  Future<String> getNotices() async {
    isLoading.value = true;
    try {
      final response = await api.get("/announcement/notices/", authReq: true);
      final body = jsonDecode(response.body);

      if (response.statusCode == 200) {
        final data = body['data'];
        List<NoticeModel> tempNotices = [];

        if (data is List) {
          for (var i in data) {
            try {
              tempNotices.add(NoticeModel.fromJson(i));
            } catch (e) {
              debugPrint("❗ Notice parsing error for item $i: $e");
            }
          }
          notices.assignAll(tempNotices);
        } else {
          debugPrint("❗ Notice data is not a list: $data");
        }

        return "success";
      } else {
        return body['message'] ?? "Connection Error";
      }
    } catch (e) {
      debugPrint("❗ Unexpected error in getNotices: $e");
      return "Unexpected error: ${e.toString()}";
    } finally {
      isLoading.value = false;
    }
  }

  void _startNotificationTimer() {
    _notificationTimer?.cancel();

    _getNotifications();
    getNotices();

    _notificationTimer = Timer.periodic(notificationRefreshTime, (timer) {
      _getNotifications();
      getNotices();
    });
  }

  void _stopNotificationTimer() {
    _notificationTimer?.cancel();
    _notificationTimer = null;
  }

  Future<String> refreshNotifications() async {
    _stopNotificationTimer();
    final result = await _getNotifications();
    _startNotificationTimer();
    return result;
  }

  @override
  void onClose() {
    _stopNotificationTimer();
    super.onClose();
  }
}
