import 'package:app_notifications/features/home/view/home_page.dart';
import 'package:app_notifications/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/services/app_prefs.dart';
import 'core/services/fcm_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await AppPrefs.instance.init();

  // Initialize FCM and persist token
  final fcmService = FcmService();

  // Register background message handler early
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Setup lifecycle listeners
  await fcmService.initializeListeners(
    onForeground: (message) {
      debugPrint(
        'Foreground notification: \\nTitle: ${message.notification?.title}\nBody: ${message.notification?.body}\nData: ${message.data}',
      );
    },
    onOpenedApp: (message) {
      debugPrint('Opened from notification: ${message.data}');
      // Navigate to the profile screen based on data
    },
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notifications',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(),
    );
  }
}
