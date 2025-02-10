import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/screens/home_screen.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/widgets/home_view_body.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/show_dialog_widget.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:hadawi_dathboard/widgets/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

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
                color: ColorManager.primaryBlue,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: Colors.white,
                        size: SizeConfig.height*0.03,
                      ),
                      SizedBox( width: SizeConfig.height*0.01,),
                      Text('User Form Details',
                        style: TextStyle(color: ColorManager.white,fontSize: 15,fontWeight: FontWeight.bold
                        ),),
                      Spacer(),
                      SizedBox(
                        width: SizeConfig.height*0.2,
                        child: DefaultButton(
                            buttonText: 'Send notification',
                            onPressed: (){
                              showDialogWidget(
                                context: context,
                                controller: messageController,
                                buttonText: 'Send notification',
                                title: 'Send notification',
                                body: 'Enter notification to send',
                                onPressed: (){
                                  Navigator.pop(context);
                                  cubit.sendNotification(
                                      message: messageController.text,
                                      userId: userEntities.uId
                                  );
                                }
                              );
                            },
                            buttonColor: ColorManager.success
                        ),
                      )
                    ],
                  ),
                  SizedBox( height: SizeConfig.height*0.02,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Profile Picture',
                        style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                        ),),
                      SizedBox( height: SizeConfig.height*0.01,),
                      Image(
                        fit: BoxFit.cover,
                        width:  SizeConfig.height*0.6,
                        height:  SizeConfig.height*0.3,
                        image: NetworkImage('https://cdn.pixabay.com/photo/2021/09/20/03/24/skeleton-6639547_1280.png'),
                      ),

                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('uId :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text(userEntities.uId,
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('User Name :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text(userEntities.name,
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('Email :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text(userEntities.email,
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('Phone :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text(userEntities.phone,
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('Gender :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text(userEntities.gender,
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('Birth Date :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text(userEntities.brithDate,
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
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
                          width:  SizeConfig.height*0.2,
                          child: DefaultButton(
                              buttonText: 'Delete User',
                              onPressed: (){
                                 showDialogWidget(
                                     context: context,
                                     controller: messageController,
                                     buttonText: 'Delete',
                                     title: 'Delete User',
                                     body: 'Enter message to send',
                                     onPressed:  (){
                                       cubit.deleteUser(userId: userEntities.uId);
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
                              buttonText: 'Block User',
                              onPressed: (){
                                showDialogWidget(
                                  context: context,
                                  controller: messageController,
                                  buttonText: 'Block',
                                  title: 'Block User',
                                  body: 'Enter message to send',
                                  onPressed:  (){
                                    cubit.blockUser(userId: userEntities.uId);
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
            customToast(title: 'Notification sent successfully', color: ColorManager.success);
          }
          if(state is BlockUserErrorState){
            customToast(title: state.message, color: ColorManager.error);
          }
          if(state is BlockUserSuccessState){
            customPushAndRemoveUntil(context, HomeScreen());
            customToast(title: 'User blocked successfully', color: ColorManager.success);
          }
          if(state is DeleteUserErrorState){
            customToast(title: state.message, color: ColorManager.error);
          }
          if(state is DeleteUserSuccessState){
            customPushAndRemoveUntil(context, HomeScreen());
            customToast(title: 'User Deleted successfully', color: ColorManager.success);
          }
        }
    );
  }
}
