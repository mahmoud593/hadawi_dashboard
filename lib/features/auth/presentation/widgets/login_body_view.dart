import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/auth/presentation/widgets/login_form.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/screens/home_screen.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';

class LoginBodyView extends StatelessWidget {
  const LoginBodyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery
            .sizeOf(context)
            .height * .6,
        width: MediaQuery
            .sizeOf(context)
            .height * 1,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: ColorManager.black.withOpacity(0.1),
              spreadRadius: 5,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          children: [
            /// logo
            Container(
              height: MediaQuery
                  .sizeOf(context)
                  .height * .6,
              decoration: BoxDecoration(
                color: ColorManager.primaryBlue,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12),
                  bottomLeft: Radius.circular(12),
                ),
              ),
              child: Center(
                child: Image.asset(
                  AssetsManager.darkLogo,
                  height: MediaQuery
                      .sizeOf(context)
                      .height * .3,
                  width: MediaQuery
                      .sizeOf(context)
                      .height * .3,
                ),
              ),
            ),
            /// login form
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    Text(
                      'مرحباً بك في هداوى',
                      style: TextStyles.textStyle24Regular,

                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: MediaQuery
                        .sizeOf(context)
                        .height * .09,),
                    LoginForm(),

                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
