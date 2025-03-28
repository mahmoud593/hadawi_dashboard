import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/send_user_notification_body.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/user_info_view_body.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';

class SendUserNotificationScreen extends StatelessWidget {
  const SendUserNotificationScreen({super.key,required this.userEntities});

  final UserEntities userEntities;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl ,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.white
          ) ,
          backgroundColor: ColorManager.primaryBlue,
          centerTitle: true,
          title: Text('ارسال اشعار للمستخدم',
              style: TextStyles.textStyle18Medium
                  .copyWith(color: ColorManager.white)),
        ),
        body: SendUserNotificationBody(userEntities:  userEntities,),
      ),
    );
  }
}
