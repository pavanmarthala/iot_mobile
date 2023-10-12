import 'package:get/get.dart';

class Messages extends Translations{
  final Map<String, Map<String,String>> languages;
  Messages({required this.languages});


  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys {
    return languages;

  }
}