import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_cubit.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_states.dart';
import 'package:hadawi_dathboard/generated/assets.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:hadawi_dathboard/widgets/toast.dart';
import 'package:hadawi_dathboard/widgets/toastification_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:toastification/toastification.dart';

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
  TextEditingController occasionController = TextEditingController();
  TextEditingController editOccasionController = TextEditingController();
  String image1='';
  String image2='';
  List<String> occasionsType=[];

  @override
  void initState() {
    super.initState();
    serviceController.text= context.read<PaymentsCubit>().taxEntities!.service_tax;
    deliveryController.text= context.read<PaymentsCubit>().taxEntities!.delivery_tax;
    packingController.text= context.read<PaymentsCubit>().taxEntities!.packaging_tax[0];
    packing2Controller.text= context.read<PaymentsCubit>().taxEntities!.packaging_tax[1];
    image1= context.read<PaymentsCubit>().taxEntities!.pakaging_image[0];
    image2= context.read<PaymentsCubit>().taxEntities!.pakaging_image[1];
    occasionsType= context.read<PaymentsCubit>().taxEntities!.occasionType;
    print('Image 1 ${image1}');
  }


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentsCubit,PaymentsStates>(
      builder:  (context, state) {
        var cubit = context.read<PaymentsCubit>();
        return ModalProgressHUD(
          inAsyncCall: context.read<PaymentsCubit>().taxEntities ==null || state is UpdateTaxsLoadingState
          || state is UploadImageLoadingState || state is UploadImageLoadingState2,
          child: SingleChildScrollView(
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

                  buildTextField('انواع المناسبات'),

                  SizedBox( height: SizeConfig.height*0.01,),

                  Row(
                    children: [
                      Expanded(
                        child: DefaultTextField(
                            controller: occasionController,
                            hintText: 'ادخل نوع المناسبه',
                            validator: (value) {},
                            keyboardType: TextInputType.text,
                            textInputAction: TextInputAction.next,
                            fillColor: ColorManager.gray
                        ),
                      ),
                      SizedBox(width: SizeConfig.width*0.02,),

                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                          color: ColorManager.primaryBlue,
                        ),
                        child: IconButton(
                            onPressed: () {
                              setState(() {
                                occasionsType.add(occasionController.text);
                                toastificationWidget(context: context, title: 'اضافه مناسبه', body: 'تم اضافه مناسبه بنجاج لتاكيد قم بالحفظ', type: ToastificationType.success);
                                occasionController.clear();
                              });
                        }, icon: Icon(Icons.add,color: Colors.white,)),
                      )
                    ],
                  ),

                  SizedBox( height: SizeConfig.height*0.03,),

                  Container(
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.black),
                      borderRadius: BorderRadius.circular(SizeConfig.height*0.01),
                      color: ColorManager.white
                    ),
                    height: SizeConfig.height*0.3,
                    width: SizeConfig.width,
                    child: ListView.separated(
                        itemBuilder: (context,index)=> Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(child: buildTextField(occasionsType[index])),
                              Spacer(),
                              IconButton(onPressed: (){
                                setState(() {
                                  occasionsType.remove(occasionsType[index]);
                                  toastificationWidget(context: context, title: 'حذف مناسبه', body: 'تم حذف المناسبه بنجاج لتاكيد قم بالحفظ', type: ToastificationType.success);
                                });
                              }, icon: Icon(Icons.delete,color: ColorManager.error,)),
                              SizedBox(width:  SizeConfig.width*0.02,),
                              IconButton(onPressed: (){
                                setState(() {
                                  editOccasionController.text= occasionsType[index];
                                  showDialog(context: context, builder: (context) {
                                    return AlertDialog(
                                      title: Text('تعديل المناسبه',style:  TextStyles.textStyle18Medium,),
                                      content: Container(
                                        height: SizeConfig.height*0.1,
                                        child: DefaultTextField(
                                            controller: editOccasionController,
                                            hintText: 'ادخل نوع المناسبه',
                                            validator: (value) {},
                                            keyboardType: TextInputType.text,
                                            textInputAction: TextInputAction.done,
                                            fillColor: ColorManager.gray
                                        ),
                                      ),
                                      actions: [
                                        DefaultButton(
                                            buttonText: 'تعديل',
                                            onPressed: (){
                                              setState(() {
                                                occasionsType.remove(occasionsType[index]);
                                                occasionsType.add(editOccasionController.text);
                                                toastificationWidget(context: context, title: 'تعديل مناسبه', body: 'تم تعديل المناسبه بنجاج لتاكيد قم بالحفظ', type: ToastificationType.success);
                                                Navigator.pop(context);
                                              });
                                            },
                                            buttonColor: ColorManager.primaryBlue
                                        ),
                                        SizedBox(height:  SizeConfig.width*0.02,),
                                        DefaultButton(
                                            buttonText: 'الغاء',
                                            onPressed: (){
                                              Navigator.pop(context);
                                            },
                                            buttonColor: ColorManager.error
                                        ),
                                      ],
                                    );
                                  });
                                });
                              }, icon: Icon(Icons.edit,color: ColorManager.primaryBlue,)),
                            ],
                          ),
                        ),
                        separatorBuilder: (context,index)=>Divider(color: ColorManager.primaryBlue,),
                        itemCount: occasionsType.length
                    ),
                  ),

                  SizedBox( height: SizeConfig.height*0.02,),

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

                  image1 !='' && cubit.webImageBytes1 == null?
                  Row(
                    children: [
                      Container(
                        height:
                        MediaQuery.sizeOf(context).height * 0.3,
                        width:
                        MediaQuery.sizeOf(context).height * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: image1,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      SizedBox(
                        width:
                        MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      IconButton(
                          onPressed: () {
                            cubit.pickPackagingImage1();
                          },
                          icon: Icon(
                            Icons.upload,
                            color: ColorManager.primaryBlue,
                          ))
                    ],
                  ):
                  cubit.webImageBytes1 == null
                      ? Row(
                    children: [
                      Container(
                        height:
                        MediaQuery.sizeOf(context).height * 0.3,
                        width:
                        MediaQuery.sizeOf(context).height * 0.6,
                        padding:  EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              Assets.imagesEmptyImage,
                              height:
                              MediaQuery.sizeOf(context).height *
                                  0.3,
                              width:
                              MediaQuery.sizeOf(context).height *
                                  0.3,
                            ),
                            Text(
                              ' قم بإرفاق صورة التغليف',
                              style: TextStyles.textStyle18Medium
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width:
                        MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      IconButton(
                          onPressed: () {
                            cubit.pickPackagingImage1();
                          },
                          icon: Icon(
                            Icons.upload,
                            color: ColorManager.primaryBlue,
                          ))
                    ],
                  ):
                   Row(
                    children: [
                      Container(
                        height:
                        MediaQuery.sizeOf(context).height * 0.3,
                        width:
                        MediaQuery.sizeOf(context).height * 0.6,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Image.memory(
                          cubit.webImageBytes1!,
                          fit: BoxFit.fill,
                          height:
                          MediaQuery.sizeOf(context).height * .3,
                          width:
                          MediaQuery.sizeOf(context).height * 0.6,
                        ),
                      ),
                      SizedBox(
                        width:
                        MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      IconButton(
                          onPressed: () {
                            cubit.pickPackagingImage1();
                          },
                          icon: Icon(
                            Icons.upload,
                            color: ColorManager.primaryBlue,
                          ))
                    ],
                  ),

                  SizedBox( height: SizeConfig.height*0.02,),


                  image2 !='' && cubit.webImageBytes2 == null?
                  Row(
                    children: [
                      Container(
                        height:
                        MediaQuery.sizeOf(context).height * 0.3,
                        width:
                        MediaQuery.sizeOf(context).height * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: image2,
                          placeholder: (context, url) => Center(
                            child: CircularProgressIndicator(),
                          ),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),),
                      SizedBox(
                        width:
                        MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      IconButton(
                          onPressed: () {
                            cubit.pickPackagingImage1();
                          },
                          icon: Icon(
                            Icons.upload,
                            color: ColorManager.primaryBlue,
                          ))
                    ],
                  )
                      :
                  cubit.webImageBytes2 == null
                      ? Row(
                    children: [
                      Container(
                        height:
                        MediaQuery.sizeOf(context).height * 0.3,
                        width:
                        MediaQuery.sizeOf(context).height * 0.6,
                        padding:  EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Image.asset(
                              Assets.imagesEmptyImage,
                              height:
                              MediaQuery.sizeOf(context).height *
                                  0.3,
                              width:
                              MediaQuery.sizeOf(context).height *
                                  0.3,
                            ),
                            Text(
                              ' قم بإرفاق صورة التغليف',
                              style: TextStyles.textStyle18Medium
                                  .copyWith(color: Colors.black),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width:
                        MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      IconButton(
                          onPressed: () {
                            cubit.pickPackagingImage2();
                          },
                          icon: Icon(
                            Icons.upload,
                            color: ColorManager.primaryBlue,
                          ))
                    ],
                  ) :
                 Row(
                    children: [
                      Container(
                        height:
                        MediaQuery.sizeOf(context).height * 0.3,
                        width:
                        MediaQuery.sizeOf(context).height * 0.6,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Image.memory(
                          cubit.webImageBytes2!,
                          fit: BoxFit.fill,
                          height:
                          MediaQuery.sizeOf(context).height * .3,
                          width:
                          MediaQuery.sizeOf(context).height * 0.6,
                        ),
                      ),
                      SizedBox(
                        width:
                        MediaQuery.sizeOf(context).height * 0.02,
                      ),
                      IconButton(
                          onPressed: () {
                            cubit.pickPackagingImage2();
                          },
                          icon: Icon(
                            Icons.upload,
                            color: ColorManager.primaryBlue,
                          ))
                    ],
                  ),

                  SizedBox( height: SizeConfig.height*0.02,),


                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      width: SizeConfig.height*0.5,
                      child: DefaultButton(
                          buttonText: 'حفظ',
                          onPressed: ()async{
                            cubit.updateTaxs(
                                pakaging_image: cubit.webImageBytes1 != null && cubit.webImageBytes2 != null ?
                                [cubit.webImageBytes1!, cubit.webImageBytes2!]:
                                cubit.webImageBytes1 != null && cubit.webImageBytes2 == null?
                                [ cubit.webImageBytes1!]: cubit.webImageBytes1 == null && cubit.webImageBytes2 != null?[cubit.webImageBytes2!]:[],
                                deliveryTax: deliveryController.text,
                                occasionType: occasionsType,
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
          ),
        );
      },
      listener: (context, state) {
        if(state is UpdateTaxsSuccessState){
          context.read<PaymentsCubit>().webImageBytes1 = null;
          context.read<PaymentsCubit>().webImageBytes2 = null;
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