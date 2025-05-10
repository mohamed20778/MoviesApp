import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configNotifications() async {
    try {
      final notificationSetting =
          await FirebaseMessaging.instance.requestPermission();

      final token = await FirebaseMessaging.instance.getToken();
      if (kDebugMode) {
        print("FCM Token: $token");
      }

      if (notificationSetting.authorizationStatus ==
          AuthorizationStatus.authorized) {
        await _initLocalNotifications();

        FirebaseMessaging.onMessage.listen((message) {
          if (message.notification != null) {
            _showNotification(
              message.notification?.title ?? '',
              message.notification?.body ?? '',
            );
          }
        });

        FirebaseMessaging.onMessageOpenedApp.listen((message) {
          if (message.notification != null) {}
        });
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error configuring notifications: $e');
      }
    }
  }

  Future<void> _initLocalNotifications() async {
    try {
      const AndroidInitializationSettings androidSettings =
          AndroidInitializationSettings('@mipmap/ic_launcher');

      const DarwinInitializationSettings iosSettings =
          DarwinInitializationSettings();

      const InitializationSettings settings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      await flutterLocalNotificationsPlugin.initialize(
        settings,
        onDidReceiveNotificationResponse: (response) {
          if (response.payload != null) {
            debugPrint('Notification payload: ${response.payload}');
          }
        },
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error initializing local notifications: $e');
      }
    }
  }

  Future<void> _showNotification(String title, String body) async {
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'high_importance_channel',
            'Ez Notifications',
            channelDescription: 'Channel Description',
            importance: Importance.max,
            priority: Priority.high,
          );

      const NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        0,
        title,
        body,
        platformDetails,
        payload: 'notification_payload',
      );
    } catch (e) {
      if (kDebugMode) {
        print('Error showing notification: $e');
      }
    }
  }
}
