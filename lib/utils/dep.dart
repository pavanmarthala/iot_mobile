
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:iot_mobile_app/Controller/lang_controller.dart';
import 'package:iot_mobile_app/models/language.dart';
import 'package:iot_mobile_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Map<String,Map<String,String>>> init() async{
  final sharedPreference = await SharedPreferences.getInstance();
  Get.lazyPut(()=>sharedPreference);
  Get.lazyPut(() => LangController(sharedPreferences: Get.find()));

   Map<String, Map<String,String>> languages =Map();
   for(LanguageModel languageModel in AppConstants.Languages){
     String jsonStringValues = await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
     Map<String,dynamic> mappedJson = json.decode(jsonStringValues);
     Map<String,String> _json = Map();
     mappedJson.forEach((key, value) {
       _json[key] = value.toString();

     });
     languages[languageModel.languageCode] = _json;
   }
   return languages;

}