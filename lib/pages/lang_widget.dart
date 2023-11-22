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
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.all(5),
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
                  const SizedBox(height: 5),
                  Text(languageModel.languageName,style: const TextStyle(fontSize: 20),),
                ],
              ),
            ),
            langController.selectIndex == index
                ? const Positioned(
              right: 8, // Adjust the position of the check icon as needed
              top: 8,
              child: Icon(Icons.check_circle, color: Colors.white, size: 24), // Adjust the position of the check icon as needed
            )
                : const SizedBox(), // An empty container when not selected
          ],
        ),
      ),
    );
  }
}
