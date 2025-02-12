import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/screens/payment_details_screen.dart';
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
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PaymentsViewBody extends StatelessWidget {
  PaymentsViewBody({super.key});

  TextEditingController controller = TextEditingController();
  TextEditingController whatsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                Container(
                  width: SizeConfig.height*0.3,
                  child: DefaultButton(
                      buttonText: 'الرسوم الادارية',
                      onPressed: (){},
                      buttonColor: ColorManager.warning
                  ),
                ),
      
                SizedBox(width:  SizeConfig.height*0.02,),
      
                Container(
                  width: SizeConfig.height*0.3,
                  child: DefaultButton(
                      buttonText: 'تحويل اموال',
                      onPressed: (){},
                      buttonColor: ColorManager.primaryBlue
                  ),
                ),
      
                SizedBox(width:  SizeConfig.height*0.02,),
              ]
            ),

            SizedBox(height:  SizeConfig.height*0.05,),

            TitleRowWidgetPaymentScreen(image:'assets/images/money.png' ,title: 'المدفوعات',),

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
                              color: ColorManager.primaryBlue,
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
                              color: ColorManager.primaryBlue,
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
                              color: ColorManager.primaryBlue,
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
                            'طريقه الدفع',
                            style: TextStyle(
                              color: ColorManager.primaryBlue,
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
                              color: ColorManager.primaryBlue,
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
                              color: ColorManager.primaryBlue,
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
                      itemCount: 10,
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
                                  child: Text('P',style: TextStyle(color: ColorManager.primaryBlue),),
                                ),
                                SizedBox(width:  SizeConfig.height*0.01,),
                                Text(
                                  'xfr52dd54',
                                  style: TextStyle(
                                    color: ColorManager.primaryBlue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),


                          SizedBox(
                            width:  SizeConfig.height*0.15,
                            child: Text(
                              'Mahmoud Reda',
                              style: TextStyle(
                                color: ColorManager.primaryBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),


                          SizedBox(
                            width:  SizeConfig.height*0.15,
                            child: Text(
                              '150 \$',
                              style: TextStyle(
                                color: ColorManager.primaryBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          SizedBox(
                            width:  SizeConfig.height*0.15,
                            child: Text(
                              'بوابه سداد',
                              style: TextStyle(
                                color: ColorManager.primaryBlue,
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
                              '10/11/2022',
                              style: TextStyle(
                                color: ColorManager.primaryBlue,
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
                                      create: (context) => UserCubit(getIt(),getIt(),getIt(),getIt()),
                                      child: PaymentDetailsScreen()),
                                    );
                                    },
                                  icon: Icon(
                                    Icons.visibility,
                                    color: ColorManager.primaryBlue,
                                    size: SizeConfig.height*0.03,
                                  ),
                                ),
                                SizedBox(width:  SizeConfig.height*0.01,),
                                IconButton(
                                  onPressed: (){


                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: ColorManager.primaryBlue,
                                    size: SizeConfig.height*0.03,
                                  ),
                                ),
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

            TitleRowWidgetPaymentScreen(image:'assets/images/smartphone.png' ,title: 'عمليات السحب',),

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
                              color: ColorManager.primaryBlue,
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
                              color: ColorManager.primaryBlue,
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
                              color: ColorManager.primaryBlue,
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
                            'طريقه الدفع',
                            style: TextStyle(
                              color: ColorManager.primaryBlue,
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
                              color: ColorManager.primaryBlue,
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
                              color: ColorManager.primaryBlue,
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
                      itemCount: 10,
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
                                  child: Text('P',style: TextStyle(color: ColorManager.primaryBlue),),
                                ),
                                SizedBox(width:  SizeConfig.height*0.01,),
                                Text(
                                  'xfr52dd54',
                                  style: TextStyle(
                                    color: ColorManager.primaryBlue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),


                          SizedBox(
                            width:  SizeConfig.height*0.15,
                            child: Text(
                              'Mahmoud Reda',
                              style: TextStyle(
                                color: ColorManager.primaryBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),


                          SizedBox(
                            width:  SizeConfig.height*0.15,
                            child: Text(
                              '150 \$',
                              style: TextStyle(
                                color: ColorManager.primaryBlue,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          SizedBox(
                            width:  SizeConfig.height*0.15,
                            child: Text(
                              'بوابه سداد',
                              style: TextStyle(
                                color: ColorManager.primaryBlue,
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
                              '10/11/2022',
                              style: TextStyle(
                                color: ColorManager.primaryBlue,
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
                                        create: (context) => UserCubit(getIt(),getIt(),getIt(),getIt()),
                                        child: PaymentDetailsScreen()),);
                                    },
                                  icon: Icon(
                                    Icons.visibility,
                                    color: ColorManager.primaryBlue,
                                    size: SizeConfig.height*0.03,
                                  ),
                                ),
                                SizedBox(width:  SizeConfig.height*0.01,),
                                IconButton(
                                  onPressed: (){


                                  },
                                  icon: Icon(
                                    Icons.send,
                                    color: ColorManager.primaryBlue,
                                    size: SizeConfig.height*0.03,
                                  ),
                                ),
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
  }
}
