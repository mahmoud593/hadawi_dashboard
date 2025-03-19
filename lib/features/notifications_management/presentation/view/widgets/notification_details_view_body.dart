import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_cubit.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/controller/notification_states.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/screens/notification_management_screen.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_cubit.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_states.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:hadawi_dathboard/widgets/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class NotificationDetailsViewBody extends StatefulWidget {
  const NotificationDetailsViewBody({super.key,required this.message,required this.purpose,required this.status,required this.type,required this.isEdit});
  final String message;
  final String purpose;
  final bool status;
  final int type;
  final bool isEdit;

  @override
  State<NotificationDetailsViewBody> createState() => _TaxsViewBodyState();
}

class _TaxsViewBodyState extends State<NotificationDetailsViewBody> {

  TextEditingController messageController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  bool statusValue = false;

  @override
  void initState() {
    super.initState();
    messageController.text= widget.message;
    purposeController.text= widget.purpose;
    statusValue= widget.status;
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit,NotificationStates>(
      builder:  (context, state) {
        var cubit = context.read<NotificationCubit>();
        return ModalProgressHUD(
          inAsyncCall: state is UpdateOccasionsCompleteSuccessState || state is UpdateOccasionsDoneSuccessState || state is UpdateOccasionsRememberSuccessState || state is UpdateOccasionsThanksSuccessState,
          child: Container(
            margin:  EdgeInsets.symmetric(
                horizontal: SizeConfig.height*0.05,
                vertical: SizeConfig.height*0.05
            ),
            padding:  EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10
            ),
            decoration: BoxDecoration(
              borderRadius:  BorderRadius.circular(SizeConfig.height*0.01),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment:  CrossAxisAlignment.start,
              children: [
                SizedBox( height: SizeConfig.height*0.02,),

                Align(
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage(AssetsManager.logoWithoutBackground),
                    height: SizeConfig.height*0.15,
                  ),
                ),

                SizedBox( height: SizeConfig.height*0.02,),

                buildTextField('الهدف من الاشعار'),

                SizedBox( height: SizeConfig.height*0.01,),

                DefaultTextField(
                    maxLines: 3,
                    enable: widget.isEdit==true?true:false,
                    controller: purposeController,
                    hintText: 'ادخل الهدف من الاشعار',
                    validator: (value) {},
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray
                ),

                SizedBox( height: SizeConfig.height*0.03,),

                buildTextField('الرساله'),

                SizedBox( height: SizeConfig.height*0.01,),

                DefaultTextField(
                    maxLines: 3,
                    enable: widget.isEdit==true?true:false,
                    controller: messageController,
                    hintText: 'ادخل الرساله',
                    validator: (value) {},
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray
                ),

                SizedBox( height: SizeConfig.height*0.03,),

                buildTextField('الحاله'),

                SizedBox( height: SizeConfig.height*0.01,),

                Expanded(
                  child: Switch(
                      activeColor: ColorManager.primaryBlue,
                      inactiveTrackColor: ColorManager.gray,
                      value: statusValue,
                      onChanged: (value){
                        if(widget.isEdit==true){
                          setState(() {
                            statusValue=value;
                          });
                        }else{

                        }
                      }
                  ),
                ),

                SizedBox( height: SizeConfig.height*0.03,),


                Spacer(),

                widget.isEdit==true?
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: SizeConfig.height*0.5,
                    child: DefaultButton(
                        buttonText: 'حفظ',
                        onPressed: (){
                          if(widget.type==1){
                            cubit.updateNotificationComplete(
                                title: messageController.text,
                                description: purposeController.text,
                                status: statusValue,
                            );
                          } else if(widget.type==2){
                            cubit.updateNotificationDone(
                              title: messageController.text,
                              description: purposeController.text,
                              status: statusValue,
                            );
                          } else if(widget.type==3){
                            cubit.updateNotificationRemember(
                              title: messageController.text,
                              description: purposeController.text,
                              status: statusValue,
                            );
                          }else if(widget.type==4){
                            cubit.updateNotificationThanks(
                              title: messageController.text,
                              description: purposeController.text,
                              status: statusValue,
                            );
                          }
                        },
                        buttonColor: ColorManager.primaryBlue
                    ),
                  ),
                ):
                    Container(),

              ],
            ),
          ),
        );
      },
      listener: (context, state) {
        if(state is UpdateOccasionsCompleteErrorState ){
          customToast(title: state.error, color: ColorManager.error);
        }
        if(state is UpdateOccasionsDoneErrorState ){
          customToast(title: state.error, color: ColorManager.error);
        }
        if(state is UpdateOccasionsRememberErrorState ){
          customToast(title: state.error, color: ColorManager.error);
        }
        if(state is UpdateOccasionsThanksErrorState ){
          customToast(title: state.error, color: ColorManager.error);
        }
        if(state is UpdateOccasionsCompleteSuccessState || state is UpdateOccasionsDoneSuccessState || state is UpdateOccasionsRememberSuccessState || state is UpdateOccasionsThanksSuccessState){
          customToast(title: 'تم تعديل الاشعار بنجاح', color: ColorManager.primaryBlue);
          customPushAndRemoveUntil(context, NotificationManagementScreen() );
        }
      },
    );
  }
}

Widget buildTextField(String text) {
  return Text(text,style: TextStyles.textStyle18Medium.copyWith(
    color: ColorManager.black
  ),);
}