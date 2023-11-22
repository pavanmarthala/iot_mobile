// ignore_for_file: avoid_types_as_parameter_names, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Auth/splash.dart';
import 'utils/dep.dart' as dep;
import 'package:iot_mobile_app/Controller/lang_controller.dart';
import 'package:iot_mobile_app/pages/tabs/dash.dart';
import 'package:iot_mobile_app/utils/app_constants.dart';
import 'package:iot_mobile_app/utils/messages.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Map<String, Map<String, String>> languages = await dep.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => SwitchState(),
      child: MyApp(languages: languages),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.languages});
  final Map<String, Map<String, String>> languages;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LangController>(builder: (LangController) {
      return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
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
