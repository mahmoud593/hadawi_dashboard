import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/screens/user_info_screen.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/show_dialog_widget.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UsersViewBody extends StatelessWidget {
  UsersViewBody({super.key});

  TextEditingController controller = TextEditingController();
  TextEditingController whatsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserStates>(
        builder: (context, state) {
          var cubit = context.read<UserCubit>();
          return ModalProgressHUD(
            inAsyncCall: state is GetUserLoadingState,
            child: Container(
              margin: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10
              ),

              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15.0),
                  topRight: Radius.circular(15.0),
                ),
                color: ColorManager.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery.sizeOf(context).height * 0.05,
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    decoration: BoxDecoration(
                      color: ColorManager.primaryBlue,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15.0),
                        topRight: Radius.circular(15.0),
                      ),
                    ),
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          buildHeaderText('رقم المستخدم'),
                          SizedBox( width:  SizeConfig.height*0.02,),
                          buildHeaderText('رقم الهاتف'),
                          buildHeaderText('اسم المستخدم'),
                          buildHeaderText('البريد الالكتروني'),
                          buildHeaderText('تاريخ الميلاد'),
                          buildHeaderText('العمليات'),
                        ],
                      ),
                    ),
                  ),

                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context,index){
                        return Divider(color: ColorManager.black,);
                      },
                      itemCount: cubit.users.length,
                      itemBuilder: (context, index) => Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [

                            buildContentText(cubit.users[index].uId),
                            SizedBox( width:  SizeConfig.height*0.02,),
                            buildContentText(cubit.users[index].phone),
                            buildContentText(cubit.users[index].name),
                            buildContentText(cubit.users[index].email),
                            buildContentText(cubit.users[index].brithDate),

                            Expanded(
                              child: Row(
                                children: [

                                  /// view details
                                  IconButton(
                                    onPressed: (){
                                      customPushNavigator(context, BlocProvider(
                                        create: (context) => UserCubit(getIt(),getIt(),getIt(),getIt()),
                                        child: UserInfoScreen(userEntities: cubit.users[index],),
                                      ));
                                    },
                                    icon: Icon(
                                      Icons.visibility,
                                      color: ColorManager.gray,
                                      size: SizeConfig.height*0.03,
                                    ),
                                  ),

                                  SizedBox(width:  SizeConfig.height*0.01,),

                                  /// send to whatsapp
                                  IconButton(
                                    onPressed: (){
                                      showDialogWidget(
                                          context: context,
                                          controller: whatsController,
                                          buttonText: 'ارسال',
                                          title: 'ارسل رسالة للمستخدم عبر واتساب',
                                          body: 'ادخل الرساله للمستخدم',
                                          onPressed: (){
                                            cubit.launchWhatsApp(
                                                phoneNumber: cubit.users[index].phone,
                                                message: whatsController.text
                                            );
                                          }
                                      );

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
                  )
                ],
              ),
            ),
          );
        },
        listener: (context, state) {

        }
    );
  }
}


Widget buildHeaderText(String text) {
  return Expanded(
    child: Text(text,
        style: TextStyles.textStyle18Medium.copyWith(color: ColorManager.white)),
  );
}

Widget buildContentText(String text) {
  return  Expanded(
    child: Text(
      text,
      style: TextStyles.textStyle18Medium.copyWith(
        color: Colors.black
      ),
      overflow: TextOverflow.ellipsis,
    ),
  );
}

