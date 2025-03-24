import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_cubit.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_states.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/screens/payments_screen.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:hadawi_dathboard/widgets/toastification_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toastification/toastification.dart';

class SendPaymentsViewBody extends StatefulWidget {
  const SendPaymentsViewBody({super.key});

  @override
  State<SendPaymentsViewBody> createState() => _SendPaymentsViewBodyState();
}

class _SendPaymentsViewBodyState extends State<SendPaymentsViewBody> {

  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ibanController = TextEditingController();
  TextEditingController balanceNumController = TextEditingController();
  TextEditingController moneyController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentsCubit, PaymentsStates>(
      listener: (context, state) {
        if(state is CreateBalanceSuccessState){
          context.read<PaymentsCubit>().getBalance().then((value) {
            toastificationWidget(context: context, title: 'طلب تحويل اموال', body: 'تم انشاء طلب تحويل اموال', type: ToastificationType.success);
          });
          customPushAndRemoveUntil(context, PaymentsScreen());
        }
      },
      builder: (context, state) {
        var cubit = context.read<PaymentsCubit>();
        return ModalProgressHUD(
          inAsyncCall: state is CreateBalanceLoadingState,
          child: Container(
            margin:  EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10
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
                  alignment: Alignment.topLeft,
                  child: SizedBox(
                    width: SizeConfig.height*0.3,
                    child: DefaultButton(
                        buttonText: 'تحويل',
                        onPressed: (){
                          cubit.createBalance(
                              userName: userNameController.text,
                              phone: phoneController.text,
                              accountNumber: balanceNumController.text,
                              iban: ibanController.text,
                              paymentAccount: moneyController.text,
                              paymentDescription: descriptionController.text
                          );

                        },
                        buttonColor: ColorManager.primaryBlue
                    ),
                  ),
                ),

                SizedBox( height: SizeConfig.height*0.02,),

                Row(
                  mainAxisAlignment:  MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextField('اسم المستخدم'),

                          SizedBox( height: SizeConfig.height*0.01,),

                          DefaultTextField(
                              controller: userNameController,
                              hintText: 'ادخل اسم المستخدم',
                              validator: (value) {},
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              fillColor: ColorManager.gray
                          ),
                        ],
                      ),
                    ),


                    SizedBox( width: SizeConfig.height*0.03,),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          buildTextField('رقم الهاتف'),

                          SizedBox( height: SizeConfig.height*0.01,),

                          DefaultTextField(
                              controller: phoneController,
                              hintText: 'ادخل رقم الهاتف',
                              validator: (value) {},
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              fillColor: ColorManager.gray
                          ),

                        ],
                      ),
                    )

                  ],
                ),

                SizedBox( height: SizeConfig.height*0.05,),

                Row(
                  mainAxisAlignment:  MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildTextField('رقم الجساب'),

                          SizedBox( height: SizeConfig.height*0.01,),

                          DefaultTextField(
                              controller: balanceNumController,
                              hintText: 'ادخل رقم الجساب',
                              validator: (value) {},
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              fillColor: ColorManager.gray
                          ),
                        ],
                      ),
                    ),


                    SizedBox( width: SizeConfig.height*0.03,),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          buildTextField('رمز IBAN'),

                          SizedBox( height: SizeConfig.height*0.01,),

                          DefaultTextField(
                              controller: ibanController,
                              hintText: 'ادخل رمز IBAN',
                              validator: (value) {},
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              fillColor: ColorManager.gray
                          ),

                        ],
                      ),
                    )

                  ],
                ),

                SizedBox( height: SizeConfig.height*0.05,),

                buildTextField('المبلغ المحوَّل'),

                SizedBox( height: SizeConfig.height*0.01,),

                DefaultTextField(
                    controller: moneyController,
                    hintText: 'ادخل المبلغ المحوَّل',
                    validator: (value) {},
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray
                ),

                SizedBox( height: SizeConfig.height*0.05,),

                buildTextField('وصف العملية (اختياري، مثل "دفعة لخدمة" أو "تحويل لصديق")'),

                SizedBox( height: SizeConfig.height*0.01,),

                DefaultTextField(
                    controller: descriptionController,
                    hintText: 'ادخل وصف العملية',
                    validator: (value) {},
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildTextField(String text) {
  return Text(text,style: TextStyles.textStyle18Medium.copyWith(
    color: ColorManager.black
  ),);
}