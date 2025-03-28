import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/screens/home_screen.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/widgets/home_view_body.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_cubit.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/screens/send_user_notification_screen.dart';
import 'package:hadawi_dathboard/features/users/presentation/screens/send_user_notification_screen.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/show_dialog_widget.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/utiles/services/notification_services.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/utiles/shared_preferences/shared_preference.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:hadawi_dathboard/widgets/toast.dart';
import 'package:hadawi_dathboard/widgets/toastification_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toastification/toastification.dart';

import '../../../../styles/text_styles/text_styles.dart';

class UserInfoViewBody extends StatelessWidget {
   UserInfoViewBody({super.key,required this.userEntities});

  final UserEntities userEntities;

  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserStates>(
        builder: (context, state) {
          var cubit = context.read<UserCubit>();
          return ModalProgressHUD(
            inAsyncCall: state is GetUserLoadingState
                || state is SendNotificationLoadingState
                || state is BlockUserLoadingState
                || state is DeleteUserLoadingState,
            child: Container(
              height: SizeConfig.height*0.85,
              margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10
              ),
              padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10
              ),
              decoration: BoxDecoration(
                color: ColorManager.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox( height: SizeConfig.height*0.02,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      // buildUserInfo('صورة المستخدم'),
                      //
                      // SizedBox( height: SizeConfig.height*0.01,),
                      //
                      // Image(
                      //   fit: BoxFit.cover,
                      //   width:  SizeConfig.height*0.6,
                      //   height:  SizeConfig.height*0.3,
                      //   image: NetworkImage('https://cdn.pixabay.com/photo/2021/09/20/03/24/skeleton-6639547_1280.png'),
                      // ),
                      //
                      // SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('رقم المستخدم :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(userEntities.uId),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('اسم المستخدم :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(userEntities.name),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('البريد الالكتروني :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(userEntities.email),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('رقم الهاتف :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(userEntities.phone),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('الجنس :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(userEntities.gender),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo(' تاريخ الميلاد :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(userEntities.brithDate),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                    ],
                  ),

                  Spacer(),

                  Align(
                    alignment: AlignmentDirectional.bottomStart,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: SizeConfig.height*0.2,
                          child: DefaultButton(
                              buttonText: 'ارسال الاشعارات',
                              onPressed: ()async {
                                customPushNavigator(context, MultiBlocProvider(
                                    providers: [

                                      BlocProvider(create:  (context) => UserCubit(getIt(),getIt(),getIt(),getIt(),),),
                                      BlocProvider(create:  (context) => NotificationCubit(getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),getIt(),)..getNotification()),
                                    ],
                                    child: SendUserNotificationScreen(userEntities:  userEntities,)));
                                // showDialogWidget(
                                //     context: context,
                                //     controller: messageController,
                                //     buttonText: 'ارسال اشعار',
                                //     title: 'ارسال اشعار',
                                //     body: 'ادخل الرسالة التي تريد ارسالها',
                                //     onPressed: () async {
                                //       Navigator.pop(context);
                                //       if(messageController.text.isEmpty) {
                                //         toastificationWidget(context: context, title: 'حدث خطا', body: 'ادخل الرسالة التي تريد ارسالها', type: ToastificationType.error);
                                //       }else {
                                //         NotificationServices().sendNotifications(
                                //             fcmToken:userEntities.token,
                                //             title: 'اشعار جديد',
                                //             body: messageController.text,
                                //             userId: userEntities.uId
                                //         );
                                //         cubit.sendNotification(
                                //             message: messageController.text,
                                //             userId: userEntities.uId
                                //         );
                                //         messageController.clear();
                                //       }
                                //
                                //     }
                                // );
                              },
                              buttonColor: ColorManager.success
                          ),
                        ),

                        SizedBox( width:  SizeConfig.height*0.02,),

                        SizedBox(
                          width:  SizeConfig.height*0.2,
                          child: DefaultButton(
                              buttonText: 'حذف المستخدم',
                              onPressed: (){
                                 showDialogWidget(
                                     context: context,
                                     controller: messageController,
                                     buttonText: 'حذف',
                                     title: 'حذف المستخدم',
                                     body: 'ادخل الرسالة التي تريد ارسالها',
                                     onPressed:  (){
                                       if(messageController.text.isEmpty) {
                                         toastificationWidget(context: context, title: 'حدث خطا', body: 'ادخل الرسالة التي تريد ارسالها', type: ToastificationType.error);
                                       }else{
                                         NotificationServices().sendNotifications(
                                             fcmToken:userEntities.token,
                                             title: 'حذف الحساب',
                                             body: messageController.text,
                                             userId: userEntities.uId
                                         );
                                         cubit.deleteUser(userId: userEntities.uId,message: messageController.text);
                                         messageController.clear();
                                       }

                                     }
                                 ).then((value) => Navigator.pop(context));
                              },
                              buttonColor: ColorManager.red
                          ),
                        ),
                        SizedBox(width:  SizeConfig.height*0.02,),

                        SizedBox(
                          width:  SizeConfig.height*0.2,
                          child: DefaultButton(
                              buttonText: 'حظر المستخدم',
                              onPressed: (){
                                showDialogWidget(
                                  context: context,
                                  controller: messageController,
                                  buttonText: 'حظر المستخدم',
                                  title: 'حظر المستخدم',
                                  body: 'ادخل الرسالة التي تريد ارسالها',
                                  onPressed:  (){
                                    if(messageController.text.isEmpty) {
                                      toastificationWidget(context: context, title: 'حدث خطا', body: 'ادخل الرسالة التي تريد ارسالها', type: ToastificationType.error);
                                    }else{
                                      NotificationServices().sendNotifications(
                                          fcmToken:userEntities.token,
                                          title: 'حظر الحساب',
                                          body: messageController.text,
                                          userId: userEntities.uId
                                      );
                                      cubit.blockUser(userId: userEntities.uId,message: messageController.text);
                                      messageController.clear();
                                    }
                                  }
                                ).then((value) => Navigator.pop(context));
                              },
                              buttonColor: ColorManager.warning
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) async{
          if(state is SendNotificationErrorState){
            customToast(title: state.message, color: ColorManager.error);
          }
          if(state is SendNotificationSuccessState){
            customToast(title: 'الاشعار تم ارساله بنجاح', color: ColorManager.success);
          }
          if(state is BlockUserErrorState){
            customToast(title: state.message, color: ColorManager.error);
          }
          if(state is BlockUserSuccessState){
            customPushAndRemoveUntil(context, HomeScreen());
            customToast(title: 'المستخدم تم حظر', color: ColorManager.success);
          }
          if(state is DeleteUserErrorState){
            customToast(title: state.message, color: ColorManager.error);
          }
          if(state is DeleteUserSuccessState){
            customPushAndRemoveUntil(context, HomeScreen());
            customToast(title: 'تم حذف المستخدم', color: ColorManager.success);
          }
        }
    );
  }
}

Widget buildUserInfo(String text) {
  return Text('$text ',
    style: TextStyles. textStyle18Medium.copyWith(
        color: ColorManager.black,
  ),);
}