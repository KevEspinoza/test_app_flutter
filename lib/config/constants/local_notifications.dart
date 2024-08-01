import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications{
  static Future<void> requestPermissonLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }

  static Future<void> initializeLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid = AndroidInitializationSettings('app_icon');

    const initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings
    );
  }

  static void showLocalNotification({required int id, String? title, String? body}){
    const androidDetails = AndroidNotificationDetails(
      'channelId', 
      'channelName',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails
    );

    final flutterLocalNotificationPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationPlugin.show(id, title, body, notificationDetails);
  }

}

