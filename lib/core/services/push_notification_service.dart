import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> configNotifications() async {
    try {
      final notificationSetting =
          await FirebaseMessaging.instance.requestPermission();

      if (notificationSetting.authorizationStatus ==
          AuthorizationStatus.authorized) {
        await _initLocalNotifications();

        FirebaseMessaging.onMessage.listen((message) {
          if (message.notification != null) {
            _showNotification(
              message.notification?.title ?? 'New Notification',
              message.notification?.body ?? '',
            );
          }
        });

        // Get and print FCM token
        final token = await FirebaseMessaging.instance.getToken();
        print("FCM Token: $token");
      }
    } catch (e) {
      print('Error configuring notifications: $e');
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
      print('Error initializing local notifications: $e');
    }
  }

  Future<void> _showNotification(String title, String body) async {
    try {
      const AndroidNotificationDetails androidDetails =
          AndroidNotificationDetails(
            'high_importance_channel', // Change to your channel ID
            'Ez Notifications', // Change to your channel name
            channelDescription: 'Channel Description',
            importance: Importance.max,
            priority: Priority.high,
          );

      const NotificationDetails platformDetails = NotificationDetails(
        android: androidDetails,
      );

      await flutterLocalNotificationsPlugin.show(
        0, // Notification ID
        title,
        body,
        platformDetails,
        payload: 'notification_payload',
      );
    } catch (e) {
      print('Error showing notification: $e');
    }
  }
}
