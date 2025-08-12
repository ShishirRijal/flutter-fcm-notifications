import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_notifications/firebase_options.dart';
import 'app_prefs.dart';
import 'local_notification_service.dart';
import '../navigation/app_router.dart';

class FcmService {
  FcmService();

  /// Request notification permissions (iOS/Android 13+).
  // [Fetch] FCM token from Firebase
  Future<String?> fetchFcmToken() async {
    final status = await FirebaseMessaging.instance.getNotificationSettings();

    if (status.authorizationStatus == AuthorizationStatus.authorized) {
      try {
        String? token = await FirebaseMessaging.instance.getToken();
        return token;
      } catch (e) {
        return null;
      }
    }

    return null;
  }

  // Request notification permissions
  Future<AuthorizationStatus> requestPermissions() async {
    NotificationSettings settings = await FirebaseMessaging.instance
        .requestPermission(
          alert: true,
          announcement: false,
          badge: true,
          carPlay: false,
          criticalAlert: false,
          provisional: false,
          sound: true,
        );
    return settings.authorizationStatus;
  }

  /// Initialize listeners for all app lifecycle states:
  /// - Foreground: FirebaseMessaging.onMessage
  /// - Background (app in background and user taps): FirebaseMessaging.onMessageOpenedApp
  /// - Terminated (app killed and opened via tap): getInitialMessage
  /// Also persists token and listens for token refresh.
  Future<void> initializeListeners() async {
    // Ensure permissions
    final status = await requestPermissions();
    debugPrint('FCM permission status: $status');

    // Check existing token first, only fetch new one if needed
    try {
      String? existingToken = AppPrefs.instance.getFcmToken();

      if (existingToken != null && existingToken.isNotEmpty) {
        debugPrint('FCM token (existing): $existingToken');
      } else {
        // No existing token, fetch fresh one
        final token = await FirebaseMessaging.instance.getToken();
        if (token != null) {
          await AppPrefs.instance.setFcmToken(token);
          debugPrint('FCM token (fetched): $token');
        }
      }
    } catch (e) {
      debugPrint('FCM token operation error: $e');
    }

    // Token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await AppPrefs.instance.setFcmToken(newToken);
      debugPrint('FCM token refreshed: $newToken');
    });

    // Listen in foreground
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('FCM onMessage (foreground): ${message.toMap()}');
      // Show local notification when app is in foreground
      LocalNotificationService().showNotificationFromFCM(message);
    });

    // App opened from background via notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint(
        'FCM onMessageOpenedApp (background->foreground): ${message.toMap()}',
      );
      // Navigate based on notification data
      NotificationRouter.handleMessage(message);
    });

    // App opened from terminated via notification tap
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) {
      debugPrint(
        'FCM getInitialMessage (terminated->opened): ${initial.messageId}',
      );
      // Navigate based on notification data
      NotificationRouter.handleMessage(initial);
    }
  }
}

// Top-level background handler (required by Firebase Messaging).
// Ensure this symbol is preserved by the compiler/tree-shaker.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Initialize Firebase in the background isolate.
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint('FCM onBackgroundMessage: ${message.messageId}');
}
