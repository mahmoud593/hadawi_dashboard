import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';

Future showDialogWidget({
  required BuildContext context,
  required TextEditingController controller,
  required String buttonText,
  required String title,
  required String body,
  required Function onPressed,
}) {
  return showDialog(
      context: context,
      builder: (context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(title),
            content: SizedBox(
              width:  SizeConfig.width*0.5,
              height: SizeConfig.height*0.1,
              child: Column(
                children: [
                  DefaultTextField(
                      maxLines: 3,
                      controller: controller,
                      hintText: body,
                      validator: (value) {},
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      fillColor: ColorManager.gray
                  )
                ],
              ),
            ),
            actions: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    width: SizeConfig.width*0.1,
                    child: DefaultButton(
                        buttonText: 'اغلاق',
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        buttonColor: Colors.red
                    ),
                  ),
                  SizedBox(width: SizeConfig.width*0.02,),
                  Container(
                    width: SizeConfig.width*0.1,
                    child: DefaultButton(
                        buttonText: buttonText,
                        onPressed: (){
                          onPressed();
                        },
                        buttonColor: ColorManager.primaryBlue
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }
  );

}