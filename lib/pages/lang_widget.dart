import 'package:flutter/material.dart';
import 'package:iot_mobile_app/Controller/lang_controller.dart';
import 'package:iot_mobile_app/models/language.dart';
import 'package:iot_mobile_app/utils/app_constants.dart';

class Langget extends StatelessWidget {
  final LanguageModel languageModel;
  final LangController langController;
  final int index;


  Langget({required this.langController, required this.languageModel, required this.index});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Handle onTap event here
        langController.setLanguage(Locale(
          AppConstants.Languages[index].languageCode,

        ));
        langController.setSelectIndex(index);

      },
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(

          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.green[400]!,  spreadRadius: 1)],
        ),
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(height: 5),
                  Text(languageModel.languageName,style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            langController.selectIndex == index
                ? Positioned(
              child: Icon(Icons.check_circle, color: Colors.white, size: 24), // Adjust the size as needed
              right: 8, // Adjust the position of the check icon as needed
              top: 8, // Adjust the position of the check icon as needed
            )
                : SizedBox(), // An empty container when not selected
          ],
        ),
      ),
    );
  }
}
