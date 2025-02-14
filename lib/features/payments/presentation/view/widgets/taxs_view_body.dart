import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_cubit.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_states.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:hadawi_dathboard/widgets/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TaxsViewBody extends StatefulWidget {
   TaxsViewBody({super.key});

  @override
  State<TaxsViewBody> createState() => _TaxsViewBodyState();
}

class _TaxsViewBodyState extends State<TaxsViewBody> {

  TextEditingController serviceController = TextEditingController();
  TextEditingController deliveryController = TextEditingController();
  TextEditingController packingController = TextEditingController();

  @override
  void initState() {
    super.initState();
    serviceController.text= context.read<PaymentsCubit>().taxEntities!.service_tax;
    deliveryController.text= context.read<PaymentsCubit>().taxEntities!.delivery_tax;
    packingController.text= context.read<PaymentsCubit>().taxEntities!.packaging_tax;
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentsCubit,PaymentsStates>(
      builder:  (context, state) {
        var cubit = context.read<PaymentsCubit>();
        return ModalProgressHUD(
          inAsyncCall: context.read<PaymentsCubit>().taxEntities ==null || state is UpdateTaxsLoadingState,
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
                  alignment: Alignment.center,
                  child: Image(
                    image: AssetImage(AssetsManager.logoWithoutBackground),
                    height: SizeConfig.height*0.15,
                  ),
                ),

                SizedBox( height: SizeConfig.height*0.02,),

                buildTextField('رسوم الخدمه'),

                SizedBox( height: SizeConfig.height*0.01,),

                DefaultTextField(
                    controller: serviceController,
                    hintText: 'ادخل رسوم الخدمة',
                    validator: (value) {},
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray
                ),

                SizedBox( height: SizeConfig.height*0.03,),

                buildTextField('رسوم التوصيل'),

                SizedBox( height: SizeConfig.height*0.01,),

                DefaultTextField(
                    controller: deliveryController,
                    hintText: 'ادخل رسوم التوصيل',
                    validator: (value) {},
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray
                ),

                SizedBox( height: SizeConfig.height*0.03,),

                buildTextField('رسوم التغليف'),

                SizedBox( height: SizeConfig.height*0.01,),

                DefaultTextField(
                    controller: packingController,
                    hintText: 'ادخل رسوم التغليف',
                    validator: (value) {},
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray
                ),

                Spacer(),

                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: SizeConfig.height*0.5,
                    child: DefaultButton(
                        buttonText: 'حفظ',
                        onPressed: (){
                          cubit.updateTaxs(
                              deliveryTax: deliveryController.text,
                              serviceTax: serviceController.text,
                              packageTax: packingController.text
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
        if(state is UpdateTaxsSuccessState){
          Navigator.pop(context);
          customToast(title: 'تم تعديل الرسوم بنجاح', color: ColorManager.primaryBlue);
        }
        if(state is UpdateTaxsErrorState){
          customToast(title: state.error, color: ColorManager.primaryBlue);
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