import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_cubit.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_states.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/screens/add_notification_screen.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/screens/notification_details_screen.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/widgets/add_notification.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/screens/user_info_screen.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/show_dialog_widget.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/toastification_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toastification/toastification.dart';

class NotificationManagementViewBody extends StatefulWidget {
  const NotificationManagementViewBody({super.key});

  @override
  State<NotificationManagementViewBody> createState() => _NotificationManagementViewBodyState();
}

class _NotificationManagementViewBodyState extends State<NotificationManagementViewBody> {
  bool notitifcationCompleteValue = false;

  bool notitifcationThanksValue = false;

  bool notitifcationDoneValue = false;

  bool notitifcationRememberValue = false;

  List<bool> notitifcationNewValue = [];

  @override
  void initState() {
    super.initState();
    // notitifcationCompleteValue=context.read<NotificationCubit>().notificationCompleteEntities!.status;
    // notitifcationThanksValue=context.read<NotificationCubit>().notificationThanksEntities!.status;
    // notitifcationDoneValue=context.read<NotificationCubit>().notificationDoneEntities!.status;
    // notitifcationRememberValue=context.read<NotificationCubit>().notificationRememberEntities!.status;
    // notitifcationNewValue.addAll(context.read<NotificationCubit>().notificationList!.);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
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
      child: BlocConsumer<NotificationCubit,NotificationStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = context.read<NotificationCubit>();
          return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox( height:  SizeConfig.height*0.02,),

              Container(
                width:  MediaQuery.sizeOf(context).width*0.1,
                child: DefaultButton(
                    width: MediaQuery.sizeOf(context).width*0.2 ,
                    buttonText: 'اضافه اشعار جديد',
                    onPressed: (){
                       customPushNavigator(context, BlocProvider(
                         create:  (context) => NotificationCubit(
                           getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),
                         ),
                         child: AddNotificationDetailsScreen(),
                       ));
                    },
                    buttonColor: ColorManager.primaryBlue
                ),
              ),

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
                    buildHeaderText('الهدف من الاشعار'),
                    SizedBox( width:  SizeConfig.height*0.25,),
                    buildHeaderText('الرساله'),
                    SizedBox( width:  SizeConfig.height*0.25,),
                    buildHeaderText('العمليات'),
                    SizedBox( width:  SizeConfig.height*0.09,),
                  ],
                ),
              ),

              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) =>  Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                
                          buildContentText(cubit.notificationList[index].description),
                
                          SizedBox( width:  SizeConfig.height*0.05,),
                
                          buildContentText(cubit.notificationList[index].title),
                
                          Expanded(
                            child: Row(
                              children: [
                
                                /// view details
                                IconButton(
                                  onPressed: (){
                
                                    customPushNavigator(context, BlocProvider(
                                        create: (context) => NotificationCubit(
                                          getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),
                                        ),
                                        child: BlocBuilder<NotificationCubit,NotificationStates>(
                                          builder: (context, state) {
                                            return NotificationDetailsScreen(
                                              message: cubit.notificationList[index].title,
                                              purpose:  cubit.notificationList[index].description,
                                              status:  cubit.notificationList[index].status,
                                              remind12:   cubit.notificationList[index].remind12,
                                              uId:  cubit.notificationList[index].uId,
                                              remind24:   cubit.notificationList[index].remind24,
                                              remind48:   cubit.notificationList[index].remind48,
                                              isEdit: false,
                                            );
                                          },
                                        )
                                    ));
                
                                  },
                                  icon: Icon(
                                    Icons.visibility,
                                    color: ColorManager.gray,
                                    size: SizeConfig.height*0.03,
                                  ),
                                ),
                                SizedBox(width: SizeConfig.height*.02 ,),
                
                                /// edit
                                IconButton(
                                  onPressed: (){
                
                                    customPushNavigator(context, BlocProvider(
                                        create: (context) => NotificationCubit(
                                          getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),
                                        ),
                                        child: BlocBuilder<NotificationCubit,NotificationStates>(
                                          builder: (context, state) {
                                            return NotificationDetailsScreen(
                                              message: cubit.notificationList[index].title,
                                              purpose:  cubit.notificationList[index].description,
                                              status:  cubit.notificationList[index].status,
                                              uId:  cubit.notificationList[index].uId,
                                              remind12:   cubit.notificationList[index].remind12,
                                              remind24:   cubit.notificationList[index].remind24,
                                              remind48:   cubit.notificationList[index].remind48,
                                              isEdit: true,
                                            );
                                          },
                                        )
                                    ));
                
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: ColorManager.primaryBlue,
                                    size: SizeConfig.height*0.03,
                                  ),
                                ),

                                SizedBox(width: SizeConfig.height*.02 ,),

                                /// delete
                                IconButton(
                                  onPressed: (){

                                    cubit.deleteNotification(uId: cubit.notificationList[index].uId);
                                    cubit.getNotification();
                                    toastificationWidget(context: context, title: ' حذف الاشعار', body: 'تم حذف الاشعار بنجاح', type: ToastificationType.success);

                                  },
                                  icon: Icon(
                                    Icons.delete,
                                    color: ColorManager.error,
                                    size: SizeConfig.height*0.03,
                                  ),
                                ),
                
                              ],
                            ),
                          )
                
                        ],
                      ),
                    ),
                    separatorBuilder: (context, index) => Divider(color: Colors.grey,),
                    itemCount: cubit.notificationList.length
                ),
              )


            ],
          );
        },
      )
    );
  }
}


Widget buildHeaderText(String text) {
  return Expanded(
    child: Text(text,
        style: TextStyles.textStyle18Medium.copyWith(color: ColorManager.white)),
  );
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

