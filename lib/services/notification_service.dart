import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // Запрос разрешения на уведомления
    final status = await Permission.notification.request();
    if (!status.isGranted) {
      // Разрешение не получено — можно обработать при необходимости
    }

    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );

    const initializationSettings = InitializationSettings(
      android: androidSettings,
    );

    await _notificationsPlugin.initialize(initializationSettings);
  }

  static Future<void> showNotification({
    required String title,
    required String body,
    List<String>? lines, // ← для списка товаров
  }) async {
    final inboxStyle =
        lines != null
            ? InboxStyleInformation(
              lines,
              contentTitle: title,
              summaryText: body,
            )
            : null;

    final androidDetails = AndroidNotificationDetails(
      'default_channel_v4',
      'Уведомления',
      channelDescription: 'Основной канал уведомлений',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: inboxStyle,
      // icon: '@drawable/ic_notification', // кастомная иконка (ниже)
      // sound: RawResourceAndroidNotificationSound(
      //   'notif',
      // ), // кастомный звук (ниже)
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title,
      body,
      notificationDetails,
    );
  }
}
