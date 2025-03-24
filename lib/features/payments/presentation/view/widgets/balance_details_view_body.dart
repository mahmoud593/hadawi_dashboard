import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/screens/home_screen.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/widgets/home_view_body.dart';
import 'package:hadawi_dathboard/features/payments/data/models/balance_model.dart';
import 'package:hadawi_dathboard/features/payments/data/models/payment_model.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_cubit.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_states.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/screens/payments_screen.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/show_dialog_widget.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:hadawi_dathboard/widgets/toast.dart';
import 'package:hadawi_dathboard/widgets/toastification_widget.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toastification/toastification.dart';

class BalanceDetailsViewBody extends StatelessWidget {
  BalanceDetailsViewBody({super.key,required this.balanceModel});

  final BalanceModel balanceModel;


  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentsCubit,PaymentsStates>(
       listener: (context, state){
         if(state is DeleteBalanceSuccessState){
           toastificationWidget(context: context, title: 'حذف المعامله', body: 'تم حذف المعامله بنجاح', type: ToastificationType.success);
         }
       },
        builder: (context, state) {
          var cubit = context.read<PaymentsCubit>();
          return ModalProgressHUD(
            inAsyncCall: state is DeleteBalanceLoadingState,
            child: Container(
              alignment: Alignment.center,
              height: SizeConfig.height*0.6,
              margin: EdgeInsets.symmetric(
                  horizontal: SizeConfig.height*0.05,
                  vertical: SizeConfig.height*0.13
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('رقم العمليه :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(balanceModel.balanceId.toString()),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('الاسم :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(balanceModel.userName.toString()),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('الهاتف :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(balanceModel.phone.toString()),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('رقم الحساب :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(balanceModel.accountNumber.toString()),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('تاريخ الدفع :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo('${balanceModel.date} \$'),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('رقم ال IBAN :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(balanceModel.iban.toString()),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('المبلغ المدفوع :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(balanceModel.paymentAccount.toString()),

                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [

                          buildUserInfo('وصف العمليه :'),

                          SizedBox( width: SizeConfig.height*0.025,),

                          buildUserInfo(balanceModel.paymentDescription.toString()),

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
                              buttonText: 'حذف',
                              onPressed: (){

                                showAdaptiveDialog(context: context,
                                    builder: (context){
                                      return AlertDialog(
                                        backgroundColor: ColorManager.white,
                                        elevation: 2,
                                        title: Text(
                                          'هل انت متأكد من حذف المعامله؟',
                                          style: TextStyles.textStyle18Medium
                                              .copyWith(color: ColorManager.black),
                                          textAlign: TextAlign.center,
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text('تأكيد',
                                                style: TextStyles.textStyle18Medium
                                                    .copyWith(color: ColorManager.red)),
                                            onPressed: () async{
                                              await cubit.deleteBalance(balanceId: balanceModel.balanceId.toString());
                                              customPushAndRemoveUntil(context, PaymentsScreen());
                                            },
                                          ),
                                          TextButton(
                                            child: Text('إلغاء',
                                                style: TextStyles.textStyle18Medium
                                                    .copyWith(color: ColorManager.black)),
                                            onPressed: () => Navigator.pop(context),
                                          ),
                                        ],
                                      );
                                    }
                                );





                              },
                              buttonColor: ColorManager.red
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

    );
  }
}

Widget buildUserInfo(String text) {
  return Text('$text ',
    style: TextStyles. textStyle18Medium.copyWith(
      color: ColorManager.black,
    ),);
}
