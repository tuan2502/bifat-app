import 'dart:convert';

import 'package:bifat_app/const/api_const.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class ApiNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> fetchNotificationData() async {
    try {
      final response = await http.get(Uri.parse(API_NOTIFICATION));
      if (response.statusCode == 200) {
        // Xử lý phản hồi từ API
        final data = jsonDecode(response.body);
        final notificationTitle = data['title'];
        final notificationBody = data['body'];

        // Hiển thị thông báo
        showNotification(notificationTitle, notificationBody);
      } else {
        throw Exception(
            'Failed to load notification data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Xử lý lỗi tại đây
      print('Error: $e');
    }
  }

  Future<void> showNotification(String title, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'notification_payload',
    );
  }
}
