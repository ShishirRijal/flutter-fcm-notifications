import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:app_notifications/firebase_options.dart';
import 'app_prefs.dart';

class FcmService {
  FcmService();

  /// Request notification permissions (iOS/Android 13+).
  // [Fetch] FCM token from Firebase
  Future<String?> fetchFcmToken() async {
    final status = await FirebaseMessaging.instance.getNotificationSettings();
    print(
      "Firebase Notification Settings Status: ${status.authorizationStatus}",
    );
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
  Future<void> initializeListeners({
    void Function(RemoteMessage message)? onForeground,
    void Function(RemoteMessage message)? onOpenedApp,
  }) async {
    // Ensure permissions
    final status = await requestPermissions();
    debugPrint('FCM permission status: $status');

    // Get and persist token
    try {
      final token = await FirebaseMessaging.instance.getToken();
      if (token != null) {
        await AppPrefs.instance.setFcmToken(token);
        debugPrint('FCM token (init): $token');
      }
    } catch (e) {
      debugPrint('FCM token fetch error: $e');
    }

    // Token refresh
    FirebaseMessaging.instance.onTokenRefresh.listen((newToken) async {
      await AppPrefs.instance.setFcmToken(newToken);
      debugPrint('FCM token refreshed: $newToken');
    });

    // Listen in foreground
    FirebaseMessaging.onMessage.listen((message) {
      debugPrint('FCM onMessage (foreground): ${message.toMap()}');
      onForeground?.call(message);
    });

    // App opened from background via notification tap
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      debugPrint(
        'FCM onMessageOpenedApp (background->foreground): ${message.toMap()}',
      );
      onOpenedApp?.call(message);
    });

    // App opened from terminated via notification tap
    final initial = await FirebaseMessaging.instance.getInitialMessage();
    if (initial != null) {
      debugPrint(
        'FCM getInitialMessage (terminated->opened): ${initial.messageId}',
      );
      onOpenedApp?.call(initial);
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
