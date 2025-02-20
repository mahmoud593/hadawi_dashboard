import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_cubit.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_states.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/widgets/notification_management_view_body.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';

class NotificationManagementScreen extends StatelessWidget {
  const NotificationManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.rtl,
      child: BlocProvider(
        create: (context) => NotificationCubit(getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt())
            ..getNotificationComplete()..getNotificationDone()..getNotificationRemember()..getNotificationThanks(),
        child: BlocConsumer<NotificationCubit,NotificationStates>(
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = context.read<NotificationCubit>();
            return Scaffold(
              backgroundColor: Colors.grey[200],
              appBar: dashboardAppBarWidget('إدارة التنبيهات والرسائل المرسلة للمستخدمين'),
              body: cubit.notificationThanksEntities == null ||
                  cubit.notificationCompleteEntities == null ||
                  cubit.notificationDoneEntities == null ||
                  cubit.notificationRememberEntities == null ?
                  Center(child:  CircularProgressIndicator(),)
                  : NotificationManagementViewBody()
            );
          },
        ),
      )
    );
  }
}
