// ignore_for_file: no_leading_underscores_for_local_identifiers

import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/firebase_options.dart';
import 'package:iot_mobile_app/providers/firebase_message.dart';
import 'Auth/splash.dart';
import 'utils/dep.dart' as dep;
import 'package:iot_mobile_app/Controller/lang_controller.dart';
import 'package:iot_mobile_app/pages/tabs/dash.dart';
import 'package:iot_mobile_app/utils/app_constants.dart';
import 'package:iot_mobile_app/utils/messages.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    if (kDebugMode) {
      print("Error initializing Firebase: $e");
    }
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Subscribe to the "power_status" topic
  await _subscribeToPowerStatusTopic();

  Map<String, Map<String, String>> _languages = await dep.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<SwitchState>(create: (context) => SwitchState()),
      ],
      child: MyApp(languages: _languages),
    ),
  );
}

Future<void> _subscribeToPowerStatusTopic() async {
  try {
    final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

    // Replace 'power_status' with the topic name you want to subscribe to
    await _firebaseMessaging.subscribeToTopic('power_status');

    if (kDebugMode) {
      print('Subscribed to power status topic');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error subscribing to topic: $e');
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatelessWidget {
  const MyApp({required this.languages});
  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LangController>(builder: (LangController) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        locale: LangController.locale, // Corrected access to LangController
        translations: Messages(languages: languages),
        fallbackLocale: Locale(AppConstants.Languages[0].languageCode),
      );
    });
  }
}
