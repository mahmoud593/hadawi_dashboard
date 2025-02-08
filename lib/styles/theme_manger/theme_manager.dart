import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';


ThemeData getApplicationTheme(BuildContext context) {
  return ThemeData(
    scaffoldBackgroundColor: ColorManager.gray,
    primaryColor: ColorManager.primaryBlue,
    useMaterial3: true,
    fontFamily: 'NanumGothic',

    // app bar theme
    appBarTheme: AppBarTheme(
        color: ColorManager.white,
        titleTextStyle: TextStyles.textStyle18Medium,
        iconTheme: const IconThemeData(
          color: ColorManager.black,
        ),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        )),

  );
}