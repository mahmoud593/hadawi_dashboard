import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_cubit.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_states.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/widgets/notification_details_view_body.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_cubit.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_states.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/taxs_view_body.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class NotificationDetailsScreen extends StatelessWidget {
  const NotificationDetailsScreen({super.key,required this.message,required this.purpose,required this.status,required this.type,required this.isEdit});
  final String message;
  final String purpose;
  final bool status;
  final int type;
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    return  BlocBuilder<NotificationCubit,NotificationStates>(
        builder: (context, state) {
          return Directionality(
            textDirection:  TextDirection.rtl,
            child: Scaffold(
              backgroundColor: Colors.grey[300],
              appBar: dashboardAppBarWidget(context: context, text:''),
              body: Directionality(
                  textDirection: TextDirection.rtl,
                  child: NotificationDetailsViewBody(
                    message: message,
                    purpose:purpose ,
                    status: status,
                    type: type,
                    isEdit: isEdit,
                  )
              ),
            ),
          );
        },
    );
  }
}
