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
  TextEditingController packing2Controller = TextEditingController();
  String image1='';
  String image2='';

  @override
  void initState() {
    super.initState();
    serviceController.text= context.read<PaymentsCubit>().taxEntities!.service_tax;
    deliveryController.text= context.read<PaymentsCubit>().taxEntities!.delivery_tax;
    packingController.text= context.read<PaymentsCubit>().taxEntities!.packaging_tax[0];
    packing2Controller.text= context.read<PaymentsCubit>().taxEntities!.packaging_tax[1];
    image1= context.read<PaymentsCubit>().taxEntities!.pakaging_image[0];
    image2= context.read<PaymentsCubit>().taxEntities!.pakaging_image[1];
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentsCubit,PaymentsStates>(
      builder:  (context, state) {
        var cubit = context.read<PaymentsCubit>();
        return ModalProgressHUD(
          inAsyncCall: context.read<PaymentsCubit>().taxEntities ==null || state is UpdateTaxsLoadingState
          || state is UploadImageLoadingState || state is UploadImageLoadingState2,
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


                SizedBox( height: SizeConfig.height*0.03,),

                DefaultTextField(
                    controller: packing2Controller,
                    hintText: 'ادخل رسوم التغليف',
                    validator: (value) {},
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    fillColor: ColorManager.gray
                ),

                SizedBox( height: SizeConfig.height*0.03,),

                buildTextField('صور التغليف'),

                SizedBox( height: SizeConfig.height*0.02,),

                Row(
                  children: [
                    Container(
                      height:  SizeConfig.height*0.15,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                        border: Border.all(
                          color: ColorManager.black
                        )
                      ),
                      child: cubit.webImageBytes!=null?
                      Image.memory(cubit.webImageBytes!):
                      Image(
                        image: NetworkImage(image1),
                      ),
                    ),
                    SizedBox( width:  SizeConfig.height*0.01,),
                    IconButton(
                        onPressed:()async{
                          cubit.pickBannerImage().then((value) => cubit.uploadImage());
                        } ,
                        icon: Icon(Icons.upload)
                    ),
                    SizedBox( width:  SizeConfig.height*0.08,),
                    Container(
                      height:  SizeConfig.height*0.15,
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                          border: Border.all(
                              color: ColorManager.black
                          )
                      ),
                      child: cubit.webImageBytes2!=null?
                      Image.memory(cubit.webImageBytes2!):
                      Image(
                        image: NetworkImage(image2),
                      ),
                    ),
                    SizedBox( width:  SizeConfig.height*0.01,),
                    IconButton(
                        onPressed:()async{
                          cubit.pickBannerImage2().then((value) => cubit.uploadImage2());
                        } ,
                        icon: Icon(Icons.upload)
                    ),
                  ],
                ),
                Spacer(),

                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: SizeConfig.height*0.5,
                    child: DefaultButton(
                        buttonText: 'حفظ',
                        onPressed: ()async{
                          cubit.updateTaxs(
                              pakaging_image: cubit.downloadUrl !='' && cubit.downloadUrl2 !=''?
                              [cubit.downloadUrl,cubit.downloadUrl2] :cubit.downloadUrl ==''?
                              [image1,cubit.downloadUrl2]:cubit.downloadUrl2 ==''?
                              [cubit.downloadUrl,image2]:[image1,image2],
                              deliveryTax: deliveryController.text,
                              serviceTax: serviceController.text,
                              packageTax: [packingController.text, packing2Controller.text]
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