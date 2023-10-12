import 'dart:ui';

import 'package:get/get.dart';
import 'package:iot_mobile_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/language.dart';

class LangController extends GetxController implements GetxService{
  final SharedPreferences sharedPreferences;
  LangController({
    required this.sharedPreferences
})
  {
    loadCurrentLanguage();
  }
  Locale _locale =Locale(AppConstants.Languages[1].languageCode);
  Locale get locale => _locale;
  int _selectIndex =0;
  int get selectIndex => _selectIndex;
  List<LanguageModel> _languges =[];

  List<LanguageModel> get languages => _languges;
  
  void loadCurrentLanguage()async {
    _locale = Locale(sharedPreferences.getString(AppConstants.LANGUAGE_CODE)?? AppConstants.Languages[1].languageCode);

    for (int index = 0; index< AppConstants.Languages.length; index++){
      if (AppConstants.Languages[index].languageCode == _locale.languageCode){
        _selectIndex =index;
        break;
      }
    }
    _languges = [];
    _languges.addAll(AppConstants.Languages);
    update();
  }
 void setLanguage(Locale locale){
    Get.updateLocale(locale);
    _locale = locale;
    saveLanguage(_locale);
    update();
 }
 void setSelectIndex(int index){
    _selectIndex = index;
 }
 void saveLanguage(Locale locale)async{
    sharedPreferences.setString(AppConstants.LANGUAGE_CODE, locale.languageCode);
 }
}
