import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/screens/user_info_screen.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/show_dialog_widget.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
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
              padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10
              ),
              decoration: BoxDecoration(
                color: ColorManager.primaryBlue,
                borderRadius: BorderRadius.circular(5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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
                          decoration: BoxDecoration(
                            border:  Border.all(color: ColorManager.white),
                          ),
                          child: Text(
                            'Id',
                            style: TextStyle(
                              color: ColorManager.white,
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
                          decoration: BoxDecoration(
                            border:  Border.all(color: ColorManager.white),
                          ),
                          child: Text(
                            'Email',
                            style: TextStyle(
                              color: ColorManager.white,
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
                          decoration: BoxDecoration(
                            border:  Border.all(color: ColorManager.white),
                          ),
                          child: Text(
                            'User Name',
                            style: TextStyle(
                              color: ColorManager.white,
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
                          decoration: BoxDecoration(
                            border:  Border.all(color: ColorManager.white),
                          ),
                          child: Text(
                            'Phone Number',
                            style: TextStyle(
                              color: ColorManager.white,
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
                          decoration: BoxDecoration(
                            border:  Border.all(color: ColorManager.white),
                          ),
                          child: Text(
                            'Operation',
                            style: TextStyle(
                              color: ColorManager.white,
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
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context,index){
                        return Divider(color: ColorManager.white,);
                      },
                      itemCount: cubit.users.length,
                      itemBuilder: (context, index) => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width:  SizeConfig.height*0.15,
                            child: Text(
                              cubit.users[index].uId,
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),


                          SizedBox(
                            width:  SizeConfig.height*0.15,
                            child: Text(
                              cubit.users[index].email,
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),


                          SizedBox(
                            width:  SizeConfig.height*0.15,
                            child: Text(
                              cubit.users[index].name,
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),

                          SizedBox(
                            width:  SizeConfig.height*0.15,
                            child: Text(
                              cubit.users[index].phone,
                              style: TextStyle(
                                color: ColorManager.white,
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
                                      child: UserInfoScreen(userEntities: cubit.users[index],),
                                    ));
                                  },
                                  icon: Icon(
                                    Icons.visibility,
                                    color: ColorManager.white,
                                    size: SizeConfig.height*0.03,
                                  ),
                                ),
                                SizedBox(width:  SizeConfig.height*0.01,),
                                IconButton(
                                  onPressed: (){
                                    showDialogWidget(
                                        context: context,
                                        controller: whatsController,
                                        buttonText: 'Send',
                                        title: 'Send to whatsapp',
                                        body: 'Enter message to send',
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
                                    color: ColorManager.white,
                                    size: SizeConfig.height*0.03,
                                  ),
                                ),
                              ],
                            ),
                          )

                        ],
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
