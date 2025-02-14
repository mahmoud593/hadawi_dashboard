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
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:hadawi_dathboard/widgets/toast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class PaymentDetailsViewBody extends StatelessWidget {
  PaymentDetailsViewBody({super.key});


  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserStates>(
        builder: (context, state) {
          var cubit = context.read<UserCubit>();
          return Container(
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

                        buildUserInfo('xd520dd5'),

                      ],
                    ),
                    SizedBox( height: SizeConfig.height*0.025,),

                    Row(
                      children: [

                        buildUserInfo('الاسم :'),

                        SizedBox( width: SizeConfig.height*0.025,),

                        buildUserInfo('Mahmoud Reda'),

                      ],
                    ),
                    SizedBox( height: SizeConfig.height*0.025,),

                    Row(
                      children: [

                        buildUserInfo('المبلغ المدفوع :'),

                        SizedBox( width: SizeConfig.height*0.025,),

                        buildUserInfo('150 \$'),

                      ],
                    ),
                    SizedBox( height: SizeConfig.height*0.025,),

                    Row(
                      children: [

                        buildUserInfo('طريقه الدفع :'),

                        SizedBox( width: SizeConfig.height*0.025,),

                        buildUserInfo('Cash'),

                      ],
                    ),
                    SizedBox( height: SizeConfig.height*0.025,),

                    Row(
                      children: [

                        buildUserInfo('تاريخ الدفع :'),

                        SizedBox( width: SizeConfig.height*0.025,),

                        buildUserInfo('20/1/2022'),

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
                               showDialogWidget(
                                   context: context,
                                   controller: messageController,
                                   buttonText: 'حذف',
                                   title: 'حذف المعاملة',
                                   body: 'هل انت متاكد من حذف المعاملة',
                                   onPressed:  (){
                                   }
                               ).then((value) => Navigator.pop(context));
                            },
                            buttonColor: ColorManager.red
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
        listener: (context, state) async{

        }
    );
  }
}

Widget buildUserInfo(String text) {
  return Text('$text ',
    style: TextStyles. textStyle18Medium.copyWith(
      color: ColorManager.black,
    ),);
}
