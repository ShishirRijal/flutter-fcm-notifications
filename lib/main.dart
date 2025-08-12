import 'package:app_notifications/features/home/view/home_page.dart';
import 'package:app_notifications/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'core/services/app_prefs.dart';
import 'core/services/fcm_service.dart';
import 'core/services/local_notification_service.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'core/navigation/app_router.dart';
import 'features/chat/view/chat_screen.dart';
import 'features/friend_requests/view/friend_requests_screen.dart';
import 'features/profile/view/profile_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase with default options
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize app preferences
  await AppPrefs.instance.init();

  // Initialize local notifications
  await LocalNotificationService().initialize();

  // Initialize FCM and persist token
  final fcmService = FcmService();

  // Register background message handler
  // This is called when the app is in the background or terminated
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  // Setup lifecycle listeners
  await fcmService.initializeListeners();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Notifications',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 155, 145, 171),
        ),
      ),
      navigatorKey: navigatorKey, // Navigator key for managing navigation
      routes: {
        '/': (_) => const HomePage(),
        '/friendRequests': (_) => const FriendRequestsScreen(),
        '/chat': (_) => const ChatScreen(),
        '/profile': (_) => const ProfileScreen(),
      },
    );
  }
}
