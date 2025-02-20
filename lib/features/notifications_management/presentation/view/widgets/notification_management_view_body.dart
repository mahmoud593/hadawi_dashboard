import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_cubit.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_states.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/screens/notification_details_screen.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/screens/user_info_screen.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/show_dialog_widget.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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

  @override
  void initState() {
    super.initState();
    notitifcationCompleteValue=context.read<NotificationCubit>().notificationCompleteEntities!.status;
    notitifcationThanksValue=context.read<NotificationCubit>().notificationThanksEntities!.status;
    notitifcationDoneValue=context.read<NotificationCubit>().notificationDoneEntities!.status;
    notitifcationRememberValue=context.read<NotificationCubit>().notificationRememberEntities!.status;
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
          return  ModalProgressHUD(
            inAsyncCall: cubit.notificationThanksEntities == null ||
                cubit.notificationCompleteEntities == null ||
                cubit.notificationDoneEntities == null ||
                cubit.notificationRememberEntities == null,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                      buildHeaderText('الحاله'),
                      buildHeaderText('العمليات'),
                      SizedBox( width:  SizeConfig.height*0.09,),
                    ],
                  ),
                ),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      buildContentText(cubit.notificationCompleteEntities!.description),

                      SizedBox( width:  SizeConfig.height*0.05,),

                      buildContentText(cubit.notificationCompleteEntities!.title),

                      Expanded(
                        child: Switch(
                            activeColor: ColorManager.primaryBlue,
                            inactiveTrackColor: ColorManager.gray,
                            value: notitifcationCompleteValue,
                            onChanged: (value){
                              setState(() {
                                notitifcationCompleteValue=value;
                              });
                            }
                        ),
                      ),


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
                                          message: cubit.notificationCompleteEntities!.title,
                                          purpose: cubit.notificationCompleteEntities!.description,
                                          status: notitifcationCompleteValue,
                                          type: 1,
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
                                          message: cubit.notificationCompleteEntities!.title,
                                          purpose: cubit.notificationCompleteEntities!.description,
                                          status: notitifcationCompleteValue,
                                          type: 1,
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

                          ],
                        ),
                      )

                    ],
                  ),
                ),

                Divider(color: ColorManager.black,),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      buildContentText(cubit.notificationDoneEntities!.description),
                      SizedBox( width:  SizeConfig.height*0.02,),
                      buildContentText(cubit.notificationDoneEntities!.title),

                      Expanded(
                        child: Switch(
                            activeColor: ColorManager.primaryBlue,
                            inactiveTrackColor: ColorManager.gray,
                            value: notitifcationDoneValue,
                            onChanged: (value){
                              setState(() {
                                notitifcationDoneValue=value;
                              });
                            }
                        ),
                      ),

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
                                        message: cubit.notificationDoneEntities!.title,
                                        purpose: cubit.notificationDoneEntities!.description,
                                        status: notitifcationDoneValue,
                                        type: 2,
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

                            SizedBox(width: SizeConfig.height*.02  , ),

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
                                        message: cubit.notificationDoneEntities!.title,
                                        purpose: cubit.notificationDoneEntities!.description,
                                        status: notitifcationDoneValue,
                                        type: 2,
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
                          ],
                        ),
                      )

                    ],
                  ),
                ),

                Divider(color: ColorManager.black,),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      buildContentText(cubit.notificationRememberEntities!.description),
                      SizedBox( width:  SizeConfig.height*0.02,),
                      buildContentText(cubit.notificationRememberEntities!.title),

                      Expanded(
                        child: Switch(
                            activeColor: ColorManager.primaryBlue,
                            inactiveTrackColor: ColorManager.gray,
                            value: notitifcationRememberValue,
                            onChanged: (value){
                              setState(() {
                                notitifcationRememberValue=value;
                              });
                            }
                        ),
                      ),

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
                                          message: cubit.notificationRememberEntities!.title,
                                          purpose: cubit.notificationRememberEntities!.description,
                                          status: notitifcationRememberValue,
                                          type: 3,
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

                            SizedBox(width: SizeConfig.height*.02  , ),

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
                                          message: cubit.notificationRememberEntities!.title,
                                          purpose: cubit.notificationRememberEntities!.description,
                                          status: notitifcationRememberValue,
                                          type: 3,
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


                          ],
                        ),
                      )

                    ],
                  ),
                ),

                Divider(color: ColorManager.black,),

                Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      buildContentText(cubit.notificationThanksEntities!.description),
                      SizedBox( width:  SizeConfig.height*0.02,),
                      buildContentText(cubit.notificationThanksEntities!.title),

                      Expanded(
                        child: Switch(
                            activeColor: ColorManager.primaryBlue,
                            inactiveTrackColor: ColorManager.gray,
                            value: notitifcationThanksValue,
                            onChanged: (value){
                              setState(() {
                                notitifcationThanksValue=value;
                              });
                            }
                        ),
                      ),

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
                                          message: cubit.notificationThanksEntities!.title,
                                          purpose: cubit.notificationThanksEntities!.description,
                                          status: notitifcationThanksValue,
                                          type: 4,
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

                            SizedBox(width: SizeConfig.height*.02  , ),

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
                                          message: cubit.notificationThanksEntities!.title,
                                          purpose: cubit.notificationThanksEntities!.description,
                                          status: notitifcationThanksValue,
                                          type: 4,
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

                          ],
                        ),
                      )

                    ],
                  ),
                ),

              ],
            ),
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

