import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';

PreferredSizeWidget? dashboardAppBarWidget({required BuildContext context,required String text}) {
  return AppBar(
    iconTheme: IconThemeData(
        color: Colors.white
    ) ,
    leading: IconButton(
        onPressed: (){
          Navigator.pop(context);
        },
        icon: Icon(Icons.arrow_back_ios)
    ),
    backgroundColor: ColorManager.primaryBlue,
    centerTitle: true,
    title: Text(text,
        style: TextStyles.textStyle18Medium
            .copyWith(color: ColorManager.white)),
  );
}