import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/screens/home_screen.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_cubit.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_states.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/widgets/notification_management_view_body.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';

import '../../../../home/presentation/view/screens/home_screen.dart';

class NotificationManagementScreen extends StatelessWidget {
  const NotificationManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.rtl,
      child: BlocProvider(
        create: (context) => NotificationCubit(getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt())
            ..getNotification(),
        child: BlocConsumer<NotificationCubit,NotificationStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = context.read<NotificationCubit>();
            return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar:  AppBar(
                iconTheme: IconThemeData(
                    color: Colors.white
                ) ,
                leading: IconButton(
                    onPressed: (){
                      customPushReplacement(context, HomeScreen());
                    },
                    icon: Icon(Icons.arrow_back_ios)
                ),
                backgroundColor: ColorManager.primaryBlue,
                centerTitle: true,
                title: Text('إدارة التنبيهات والرسائل المرسلة للمستخدمين',
                    style: TextStyles.textStyle18Medium
                        .copyWith(color: ColorManager.white)),
              ),
                body: cubit.notificationList.isEmpty ?
                  Center(child:  CircularProgressIndicator(),)
                  : NotificationManagementViewBody()
            );
          },
        ),
      )
    );
  }
}
