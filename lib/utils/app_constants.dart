
// ignore_for_file: non_constant_identifier_names

import '../models/language.dart';

class AppConstants{
  static String LANGUAGE_CODE = 'laguage_code';

  static List<LanguageModel> Languages =[
    LanguageModel(languageName: 'English', languageCode: 'en'),
    LanguageModel(languageName: 'తెలుగు', languageCode: 'te'),
    LanguageModel(languageName: 'हिंदी', languageCode: 'hi'),
    LanguageModel(languageName: 'ಕನ್ನಡ', languageCode: 'ka'),
    


  ];
}