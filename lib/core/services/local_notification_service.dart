import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import '../navigation/app_router.dart';
import '../models/push_notification_model.dart';

class LocalNotificationService {
  static final LocalNotificationService _instance =
      LocalNotificationService._internal();
  factory LocalNotificationService() => _instance;
  LocalNotificationService._internal();

  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosInitializationSettings =
        DarwinInitializationSettings(
          requestSoundPermission: true,
          requestBadgePermission: true,
          requestAlertPermission: true,
        );

    const InitializationSettings initializationSettings =
        InitializationSettings(
          android: androidInitializationSettings,
          iOS: iosInitializationSettings,
        );

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        debugPrint('Local notification tapped: ${response.payload}');
        if (response.payload != null) {
          // Parse payload and navigate
          _handleNotificationTap(response.payload!);
        }
      },
    );

    // Create notification channel for Android
    await _createNotificationChannel();
  }

  Future<void> _createNotificationChannel() async {
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
      enableLights: true, // Turn on LED light
      enableVibration: true, // Enable vibration
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  Future<void> showNotificationFromModel(
    PushNotificationModel notification,
  ) async {
    final androidNotificationDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: notification.shouldShowHeadsUp
          ? Importance.high
          : Importance.defaultImportance,
      priority: notification.shouldShowHeadsUp
          ? Priority.high
          : Priority.defaultPriority,
      showWhen: false,
      enableLights: notification.shouldWakeScreen,
      enableVibration: notification.shouldWakeScreen,
      fullScreenIntent: notification.shouldWakeScreen,
    );

    const DarwinNotificationDetails iosNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    final NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: iosNotificationDetails,
    );

    // Create payload from notification model
    final payload = _createPayloadFromModel(notification);

    await _flutterLocalNotificationsPlugin.show(
      notification.id.hashCode, // Use notification ID hash as unique identifier
      notification.title,
      notification.body,
      notificationDetails,
      payload: payload,
    );
  }

  // Keep the old method for backward compatibility
  Future<void> showNotificationFromFCM(RemoteMessage message) async {
    final notification = PushNotificationModel.fromRemoteMessage(message);
    await showNotificationFromModel(notification);
  }

  String _createPayloadFromModel(PushNotificationModel notification) {
    // Convert notification model to a simple string format for payload
    return 'id=${notification.id}&type=${notification.type.value}&${notification.data.entries.map((e) => '${e.key}=${e.value}').join('&')}';
  }

  void _handleNotificationTap(String payload) {
    // Parse payload back to data map
    final data = <String, dynamic>{};
    for (final pair in payload.split('&')) {
      final parts = pair.split('=');
      if (parts.length == 2) {
        data[parts[0]] = parts[1];
      }
    }

    // Navigate using the same router logic
    NotificationRouter.navigateFromData(data);
  }
}
