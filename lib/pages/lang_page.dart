import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iot_mobile_app/Controller/lang_controller.dart';

import 'lang_widget.dart';

class Langscreen extends StatelessWidget {
  const Langscreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title:  Text('select_language'.tr, style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
      ),
      body: SafeArea(

        child: GetBuilder<LangController>(builder: (langController) {
          return Column(
            children: [
              Expanded(
                child: Scrollbar(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.all(5),
                    child: Center(
                      child: SizedBox(
                        width: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                  "assets/icon_theja.png", width: 220),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10),
                              child: Text('select_language'.tr,style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                            ),
                            const SizedBox(height: 10),
                            GridView.builder(
                              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 2.5,
                              ),
                              itemCount: 2,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (context, index) =>
                                  // Container(width: 300,
                                  //   height: 300,
                                  //   color: index == 0 ? Colors.red : Colors
                                  //       .green,),
                              Langget(

                                langController: langController,
                                languageModel: langController.languages[index],
                                index: index,

                              )
                            ),
                            SizedBox(height: 10),

                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),


      ),
    );
  }
}
