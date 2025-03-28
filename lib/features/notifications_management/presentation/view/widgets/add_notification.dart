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

class AddNotificationScreen extends StatefulWidget {
  const AddNotificationScreen({super.key,});


  @override
  State<AddNotificationScreen> createState() => _TaxsViewBodyState();
}

class _TaxsViewBodyState extends State<AddNotificationScreen> {

  TextEditingController messageController = TextEditingController();
  TextEditingController purposeController = TextEditingController();
  bool statusValue = false;

  List<bool> checkList = [false,false,false];

  List<String> titles = ['التذكير بعد 12 ','التذكير بعد 24 ','التذكير بعد 48 '];

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NotificationCubit,NotificationStates>(
      builder:  (context, state) {
        var cubit = context.read<NotificationCubit>();
        return ModalProgressHUD(
          inAsyncCall: state is AddNewNotificationLoadingState,
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

                buildTextField('الهدف من الاشعار'),

                SizedBox( height: SizeConfig.height*0.01,),

                DefaultTextField(
                    maxLines: 3,
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
                    controller: messageController,
                    hintText: 'ادخل الرساله',
                    validator: (value) {},
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray
                ),

                SizedBox( height: SizeConfig.height*0.03,),

                buildTextField('الحاله'),

                SizedBox( height: SizeConfig.height*0.03,),

                Expanded(
                  child: Switch(
                      activeColor: ColorManager.primaryBlue,
                      inactiveTrackColor: ColorManager.gray,
                      value: statusValue,
                      onChanged: (value){

                          setState(() {
                            statusValue=value;
                          });

                      }
                  ),
                ),

                SizedBox( height: SizeConfig.height*0.05,),

                buildTextField('التذكيرات'),

                Container(
                  height: SizeConfig.height*0.15,
                  child: ListView.separated(
                      itemBuilder: (context, index) => Container(
                        child: Row(
                          children: [
                            Checkbox(
                                value: checkList[index],
                                onChanged: (value){
                                  setState(() {
                                    checkList=[false,false,false];
                                    checkList[index]=value!;
                                  });
                                }
                            ),
                            SizedBox(width: SizeConfig.height*0.02,),
                            Text(titles[index],
                              style: TextStyle(color: ColorManager.black,
                                  fontSize: 15, fontWeight: FontWeight.bold
                              ),),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox( height: SizeConfig.height*0.01,),
                      itemCount: 3
                  ),
                ),

                SizedBox( height: SizeConfig.height*0.03,),


                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: SizeConfig.height*0.5,
                    child: DefaultButton(
                        buttonText: 'اضافه',
                        onPressed: (){
                          cubit.addNewNotification(
                              description: messageController.text,
                              title: purposeController.text,
                              status: statusValue,
                              remind12: checkList[0],
                                remind24: checkList[1],
                              remind48: checkList[2]
                          );
                        },
                        buttonColor: ColorManager.primaryBlue
                    ),
                  ),
                )

              ],
            ),
          ),
        );
      },
      listener: (context, state) {

        if(state is AddNewNotificationSuccessState){
          customToast(title: 'تم اضافه الاشعار بنجاح', color: ColorManager.primaryBlue);
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