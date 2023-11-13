// ignore_for_file: no_leading_underscores_for_local_identifiers, prefer_const_constructors

import 'dart:ui';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/Auth/singin.dart';
import 'package:iot_mobile_app/firebase_options.dart';
import 'package:iot_mobile_app/pages/Home_page.dart';
import 'package:iot_mobile_app/pages/admin_landing_pages/landing.dart';
import 'package:iot_mobile_app/pages/landing_page.dart';
import 'package:iot_mobile_app/pages/settings/settings.dart';
import 'package:iot_mobile_app/pages/user_landing.dart';
import 'package:iot_mobile_app/providers/firebase_message.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Auth/splash.dart';
import 'utils/dep.dart' as dep;
import 'package:iot_mobile_app/Controller/lang_controller.dart';
import 'package:iot_mobile_app/pages/tabs/dash.dart';
import 'package:iot_mobile_app/utils/app_constants.dart';
import 'package:iot_mobile_app/utils/messages.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Now you have the list of device IDs as strings in the deviceIds variable
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
        routes: {
          '/splash': (cotext) => SplashScreen(),
          '/user_landing': (context) => Landingpage(
                id: "",
              ),
          '/homepage': (context) =>
              Homepage(ModalRoute.of(context)?.settings.arguments as String),
          '/settings': (context) => Settings(),
          '/signin': (context) => SingIN(),
          '/adminlandingpage': (context) => Adminlandingpage(),
          '/landingpage': (context) => Landingpage(
                id: '',
              ),
        },
        initialRoute: '/splash',

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
