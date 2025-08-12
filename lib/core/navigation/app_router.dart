import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import '../models/push_notification_model.dart';

class AppRoutes {
  static const home = '/';
  static const friendRequests = '/friendRequests';
  static const chat = '/chat';
  static const profile = '/profile';
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class NotificationRouter {
  /// Entry point to handle navigation for a PushNotificationModel.
  static Future<void> handleNotification(
    PushNotificationModel notification,
  ) async {
    debugPrint('Handling notification: $notification');
    await navigateFromNotification(notification);
  }

  /// Entry point to handle navigation for an incoming RemoteMessage.
  static Future<void> handleMessage(RemoteMessage message) async {
    final notification = PushNotificationModel.fromRemoteMessage(message);
    await handleNotification(notification);
  }

  /// Navigate based on notification model
  static Future<void> navigateFromNotification(
    PushNotificationModel notification,
  ) async {
    // Wait for navigator to be ready, with timeout
    await _waitForNavigator();

    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint('Navigator still not available after waiting');
      return;
    }

    debugPrint(
      'Navigating to: ${notification.routePath} with data: ${notification.data}',
    );

    // Use the route path from the notification model
    nav.pushNamed(notification.routePath, arguments: notification.data);
  }

  /// Navigate to the appropriate route from a raw data map.
  static Future<void> navigateFromData(Map<String, dynamic> data) async {
    // Wait for navigator to be ready, with timeout
    await _waitForNavigator();

    final nav = navigatorKey.currentState;
    if (nav == null) {
      debugPrint('Navigator still not available after waiting');
      return;
    }

    final type = (data['type'] ?? '').toString();
    debugPrint('Navigating to type: $type with data: $data');

    switch (type) {
      case 'friend_request':
        nav.pushNamed(AppRoutes.friendRequests, arguments: data);
        break;
      case 'chat':
        // Expect chatId in data
        nav.pushNamed(AppRoutes.chat, arguments: data);
        break;
      case 'like':
        // Expect userId in data
        nav.pushNamed(AppRoutes.profile, arguments: data);
        break;
      default:
        // Unknown type -> fallback to home
        nav.pushNamed(AppRoutes.home);
    }
  }

  /// Wait for navigator to become available with exponential backoff
  static Future<void> _waitForNavigator() async {
    int attempts = 0;
    const maxAttempts = 10;

    while (navigatorKey.currentState == null && attempts < maxAttempts) {
      attempts++;
      await Future.delayed(Duration(milliseconds: 100 * attempts));
      debugPrint('Waiting for navigator... attempt $attempts');
    }
  }
}
