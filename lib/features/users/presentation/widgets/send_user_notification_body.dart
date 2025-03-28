import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_cubit.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_states.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/screens/add_notification_screen.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/screens/notification_details_screen.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/widgets/add_notification.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/screens/user_info_screen.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/show_dialog_widget.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/utiles/services/notification_services.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/toast.dart';
import 'package:hadawi_dathboard/widgets/toastification_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toastification/toastification.dart';

class SendUserNotificationBody extends StatefulWidget {
  const SendUserNotificationBody({super.key,required this.userEntities});
  final UserEntities userEntities;

  @override
  State<SendUserNotificationBody> createState() => _NotificationManagementViewBodyState();
}

class _NotificationManagementViewBodyState extends State<SendUserNotificationBody> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10
        ),
        padding: EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10
        ),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(15.0),
            topRight: Radius.circular(15.0),
          ),
          color: ColorManager.white,
        ),
        child: BlocConsumer<UserCubit,UserStates>(
          listener: (context, state) {
            if(state is SendNotificationSuccessState){
              customToast(title: 'الاشعار تم ارساله بنجاح', color: ColorManager.success);
            }
          },
          builder: (context, state) {
            var cubit = context.read<UserCubit>();
            return  ModalProgressHUD(
              inAsyncCall: state is SendNotificationLoadingState,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:  MainAxisAlignment.start,
                children: [

                  SizedBox( height:  SizeConfig.height*0.02,),

                  buildHeaderText('اختار الاشعار لارسال'),


                  SizedBox( height:  SizeConfig.height*0.02,),

                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: ColorManager.primaryBlue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: buildHeaderText('الهدف من الاشعار')),
                        SizedBox( width:  SizeConfig.height*0.7,),
                        Expanded(child: buildHeaderText('الرساله')),
                        SizedBox( width:  SizeConfig.height*0.6,),
                        Expanded(child: buildHeaderText('العمليات')),
                        SizedBox( width:  SizeConfig.height*0.09,),
                      ],
                    ),
                  ),

                  SizedBox( height:  SizeConfig.height*0.02,),

                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(15.0),
                          bottomRight: Radius.circular(15.0),
                        ),
                        color: ColorManager.white,
                      ),
                      child:BlocBuilder<NotificationCubit,NotificationStates>(
                        builder:  (context, state) {
                          return  ListView.separated(
                              itemBuilder: (context, index) =>  Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20,
                                    vertical: 10
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [

                                    buildContentText(NotificationCubit.get(context).notificationList[index].description),

                                    SizedBox( width:  SizeConfig.height*0.05,),

                                    buildContentText(NotificationCubit.get(context).notificationList[index].title),

                                    SizedBox( width:  SizeConfig.height*0.05,),

                                    IconButton(
                                        onPressed: (){
                                          NotificationServices().sendNotifications(
                                              fcmToken:widget.userEntities.token,
                                              title: NotificationCubit.get(context).notificationList[index].title,
                                              body: NotificationCubit.get(context).notificationList[index].description,
                                              userId: widget.userEntities.uId
                                          );
                                          cubit.sendNotification(
                                              message: NotificationCubit.get(context).notificationList[index].description,
                                              userId: widget.userEntities.uId
                                          );
                                        },
                                        icon: Icon(
                                          Icons.send_outlined,
                                        )),


                                  ],
                                ),
                              ),
                              separatorBuilder: (context, index) => Divider(color: Colors.grey,),
                              itemCount: NotificationCubit.get(context).notificationList.length
                          );
                        }
                      )
                    ),
                  )


                ],
              ),
            );
          },
        )
    );
  }
}


Widget buildHeaderText(String text) {
  return Text(text,
      style: TextStyles.textStyle18Medium.copyWith(color: ColorManager.black));
}

Widget buildContentText(String text) {
  return  Expanded(
    child: Text(
      text,
      style: TextStyles.textStyle18Medium.copyWith(
          color: Colors.black
      ),
      overflow: TextOverflow.ellipsis,
    ),
  );
}

