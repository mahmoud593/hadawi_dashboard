import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_cubit.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_states.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/screens/balance_details_screen.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/screens/payment_details_screen.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/screens/send_payments_screen.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/screens/taxs_screen.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/balance_details_view_body.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/taxs_view_body.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/title_row_widget_payment_screen.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/screens/user_info_screen.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/show_dialog_widget.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PaymentsViewBody extends StatelessWidget {
  PaymentsViewBody({super.key});

  TextEditingController controller = TextEditingController();
  TextEditingController whatsController = TextEditingController();
  TextEditingController searchTable1Controller = TextEditingController();
  TextEditingController searchTable2Controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PaymentsCubit,PaymentsStates>(
      listener: (context, state){},
      builder: (context, state) {
        var cubit = context.read<PaymentsCubit>();
        return SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10
            ),
            padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Row(
                    children: [
                      Spacer(),
                      SizedBox(
                        width: SizeConfig.height*0.3,
                        child: DefaultButton(
                            buttonText: 'الرسوم الادارية',
                            onPressed: (){
                              customPushNavigator(context,
                                  BlocProvider(
                                      create:  (context) => PaymentsCubit(getIt(),getIt())..getTaxs(),
                                      child: BlocBuilder<PaymentsCubit,PaymentsStates>(builder: (context, state) {
                                        return TaxsScreen();
                                      })
                                  ));
                            },
                            buttonColor: ColorManager.warning
                        ),
                      ),

                      SizedBox(width:  SizeConfig.height*0.02,),

                      SizedBox(
                        width: SizeConfig.height*0.3,
                        child: DefaultButton(
                            buttonText: 'تحويل اموال',
                            onPressed: (){
                              customPushNavigator(context, BlocProvider(
                                  create:  (context) => PaymentsCubit(getIt(),getIt()),
                                  child: SendPaymentsScreen(),
                              ));
                            },
                            buttonColor: ColorManager.primaryBlue
                        ),
                      ),

                      SizedBox(width:  SizeConfig.height*0.02,),
                    ]
                ),

                SizedBox(height:  SizeConfig.height*0.03,),

                TitleRowWidgetPaymentScreen(image:'assets/images/money.png' ,title: 'المدفوعات',),

                SizedBox(height:  SizeConfig.height*0.03,),

                Container(
                  width: SizeConfig.width*0.5,
                  child: DefaultTextField(
                      onChanged: (value){
                        print('value $value');
                        cubit.filterPayments(filter: value);
                      },
                      controller: cubit.searchPaymentsController,
                      hintText: 'بحث في الجدول (اسم المناسبه) ....',
                      validator: (value) {
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      fillColor: ColorManager.white
                  ),
                ),

                SizedBox(height:  SizeConfig.height*0.025,),

                Container(
                  decoration: BoxDecoration(
                    color:  ColorManager.white,
                    border:  Border.all(color: ColorManager.primaryBlue),
                  ),
                  padding:  EdgeInsets.symmetric(
                      horizontal: SizeConfig.height*0.02,
                      vertical: SizeConfig.height*0.02
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.01,
                                  vertical: SizeConfig.height*0.01
                              ),
                              child: Text(
                                'رقم العمليه',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),

                          SizedBox(width:  SizeConfig.height*0.02,),

                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.0,
                                  vertical: SizeConfig.height*0.01
                              ),

                              child: Text(
                                'الاسم',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          SizedBox(width:  SizeConfig.height*0.02,),

                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.01,
                                  vertical: SizeConfig.height*0.01
                              ),

                              child: Text(
                                'المبلغ المدفوع',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),


                          SizedBox(width:  SizeConfig.height*0.02,),

                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.01,
                                  vertical: SizeConfig.height*0.01
                              ),

                              child: Text(
                                'اسم المناسبه',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          SizedBox(width:  SizeConfig.height*0.02,),

                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.01,
                                  vertical: SizeConfig.height*0.01
                              ),

                              child: Text(
                                'تاريخ الدفع',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          SizedBox(width:  SizeConfig.height*0.02,),

                          Expanded(
                            flex: 1,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.01,
                                  vertical: SizeConfig.height*0.01
                              ),

                              child: Text(
                                'العمليات',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                        ],
                      ),
                      Divider(color: ColorManager.white,),

                      Container(
                        height:  SizeConfig.height*0.5,
                        child: ListView.separated(
                          separatorBuilder: (context,index){
                            return Divider(color: ColorManager.primaryBlue,);
                          },
                          itemCount: cubit.paymentsData.length,
                          itemBuilder: (context, index) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:  SizeConfig.height*0.2,
                                child: Row(
                                  children: [
                                    Container(
                                      alignment:  Alignment.center,
                                      width:  SizeConfig.height*0.05,
                                      height:  SizeConfig.height*0.05,
                                      decoration: BoxDecoration(
                                        border:  Border.all(color: ColorManager.primaryBlue),
                                        color: ColorManager.warning,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text('${index+1}',style: TextStyle(color: ColorManager.primaryBlue),),
                                    ),
                                    SizedBox(width:  SizeConfig.height*0.01,),
                                    Expanded(
                                      child: Text(
                                        cubit.paymentsData[index].paymentId!,
                                        style: TextStyle(
                                          color: ColorManager.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              SizedBox(
                                width:  SizeConfig.height*0.15,
                                child: Text(
                                  cubit.paymentsData[index].personName!,
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),


                              SizedBox(
                                width:  SizeConfig.height*0.15,
                                child: Text(
                                  '${cubit.paymentsData[index].paymentAmount} \$',
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(
                                width:  SizeConfig.height*0.15,
                                child: Text(
                                  cubit.paymentsData[index].occasionName!,
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(
                                width:  SizeConfig.height*0.15,
                                child: Text(
                                  DateFormat('yyyy-MM-dd').format(DateTime.parse(cubit.paymentsData[index].paymentDate!)),
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(
                                width:  SizeConfig.height*0.15,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        customPushNavigator(context, BlocProvider(
                                            create: (context) => PaymentsCubit(getIt(),getIt()),
                                            child: BlocBuilder<PaymentsCubit,PaymentsStates>(builder: (context, state) {
                                              return PaymentDetailsScreen(paymentModel:  cubit.paymentsData[index],);
                                            })),
                                        );
                                      },
                                      icon: Icon(
                                        Icons.visibility,
                                        color: ColorManager.gray,
                                        size: SizeConfig.height*0.03,
                                      ),
                                    ),
                                    SizedBox(width:  SizeConfig.height*0.01,),

                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Container(
                  height:  SizeConfig.height*0.1,
                ),

                SizedBox(height:  SizeConfig.height*0.03,),

                TitleRowWidgetPaymentScreen(image:'assets/images/smartphone.png' ,title: 'عمليات السحب',),

                SizedBox(height:  SizeConfig.height*0.03,),


                Container(
                  width: SizeConfig.width*0.5,
                  child: DefaultTextField(
                      onChanged: (value){
                        cubit.filterBalance(filter: value);
                      },
                      controller: cubit.searchBalanceController,
                      hintText: 'بحث في الجدول (بوابات الدفع) ....',
                      validator: (value) {
                      },
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.done,
                      fillColor: ColorManager.white
                  ),
                ),

                SizedBox(height:  SizeConfig.height*0.025,),

                Container(
                  decoration: BoxDecoration(
                    color:  ColorManager.white,
                    border:  Border.all(color: ColorManager.primaryBlue),
                  ),
                  padding:  EdgeInsets.symmetric(
                      horizontal: SizeConfig.height*0.02,
                      vertical: SizeConfig.height*0.02
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.01,
                                  vertical: SizeConfig.height*0.01
                              ),
                              child: Text(
                                'رقم العمليه',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),

                          SizedBox(width:  SizeConfig.height*0.02,),

                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.0,
                                  vertical: SizeConfig.height*0.01
                              ),

                              child: Text(
                                'الاسم',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          SizedBox(width:  SizeConfig.height*0.02,),

                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.01,
                                  vertical: SizeConfig.height*0.01
                              ),

                              child: Text(
                                'المبلغ',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),


                          SizedBox(width:  SizeConfig.height*0.02,),

                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.01,
                                  vertical: SizeConfig.height*0.01
                              ),

                              child: Text(
                                'رقم الحساب',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          SizedBox(width:  SizeConfig.height*0.02,),

                          Expanded(
                            flex: 2,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.01,
                                  vertical: SizeConfig.height*0.01
                              ),

                              child: Text(
                                'تاريخ الدفع',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                          SizedBox(width:  SizeConfig.height*0.02,),

                          Expanded(
                            flex: 1,
                            child: Container(
                              padding:  EdgeInsets.symmetric(
                                  horizontal: SizeConfig.height*0.01,
                                  vertical: SizeConfig.height*0.01
                              ),

                              child: Text(
                                'العمليات',
                                style: TextStyle(
                                  color: ColorManager.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),

                        ],
                      ),
                      Divider(color: ColorManager.white,),
                      Container(
                        height:  SizeConfig.height*0.5,
                        child: ListView.separated(
                          separatorBuilder: (context,index){
                            return Divider(color: ColorManager.primaryBlue,);
                          },
                          itemCount: cubit.balanceData.length,
                          itemBuilder: (context, index) => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width:  SizeConfig.height*0.2,
                                child: Row(
                                  children: [
                                    Container(
                                      alignment:  Alignment.center,
                                      width:  SizeConfig.height*0.05,
                                      height:  SizeConfig.height*0.05,
                                      decoration: BoxDecoration(
                                        border:  Border.all(color: ColorManager.primaryBlue),
                                        color: ColorManager.warning,
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: Text('${index+1}',style: TextStyle(color: ColorManager.primaryBlue),),
                                    ),
                                    SizedBox(width:  SizeConfig.height*0.01,),
                                    Expanded(
                                      child: Text(
                                        cubit.balanceData[index].balanceId!,
                                        style: TextStyle(
                                          color: ColorManager.black,
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal,
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              ),


                              SizedBox(
                                width:  SizeConfig.height*0.15,
                                child: Text(
                                  cubit.balanceData[index].userName!,
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),


                              SizedBox(
                                width:  SizeConfig.height*0.15,
                                child: Text(
                                  '${cubit.balanceData[index].paymentAccount} \$',
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(
                                width:  SizeConfig.height*0.15,
                                child: Text(
                                  cubit.balanceData[index].accountNumber!,
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(
                                width:  SizeConfig.height*0.15,
                                child: Text(
                                  cubit.balanceData[index].date!,
                                  style: TextStyle(
                                    color: ColorManager.black,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(
                                width:  SizeConfig.height*0.15,
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: (){
                                        customPushNavigator(context, BlocProvider(
                                            create: (context) => PaymentsCubit(getIt(),getIt()),
                                            child: BalanceDetailsScreen(balanceModel: cubit.balanceData[index])),);
                                      },
                                      icon: Icon(
                                        Icons.visibility,
                                        color: ColorManager.gray,
                                        size: SizeConfig.height*0.03,
                                      ),
                                    ),
                                    // SizedBox(width:  SizeConfig.height*0.01,),
                                    // IconButton(
                                    //   onPressed: (){
                                    //
                                    //
                                    //   },
                                    //   icon: Icon(
                                    //     Icons.send,
                                    //     color: ColorManager.primaryBlue,
                                    //     size: SizeConfig.height*0.03,
                                    //   ),
                                    // ),
                                  ],
                                ),
                              )

                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
          ),
        );
      },
    );
  }
}
