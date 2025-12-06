import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/screens/favorites_screen.dart';
import 'package:recipe_app/screens/main_screen.dart';
import 'package:recipe_app/screens/meal_details.dart';
import 'package:recipe_app/screens/meal_screen.dart';
import 'package:recipe_app/services/api_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    requestNotificationPermission();
    getDeviceToken();
    setupForegroundNotificationListener();
  }

  void requestNotificationPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("User granted permission");
    } else {
      print("User declined or has not accepted permission");
    }
  }

  void getDeviceToken() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    String? token = await messaging.getToken();
    print("FCM Token: $token");
  }

  void setupForegroundNotificationListener() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Received a message while app is open!');
      print('Title: ${message.notification?.title}');
      print('Body: ${message.notification?.body}');
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MainScreen(),
      routes: {
        "/meal_screen": (context) => MealScreen(),
        "/meal_details": (context) => MealDetails(),
        "/favorites_screen": (context) => FavoritesScreen(),
      },
    );
  }
}
