import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/screens/user_info_screen.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class OccasionViewBody extends StatelessWidget {
  const OccasionViewBody({super.key});

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
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.people,
                        color: Colors.white,
                        size: SizeConfig.height*0.04,
                      ),
                      SizedBox( width: SizeConfig.height*0.01,),
                      Text('User Management',
                        style: TextStyle(color: ColorManager.white,fontSize: 18,fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                  SizedBox( height: SizeConfig.height*0.01,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Id',
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'Email',
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'User Name',
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'Phone Number',
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      Text(
                        'Operation',
                        style: TextStyle(
                          color: ColorManager.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
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
                      itemBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              cubit.users[index].uId,
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                            Text(
                              cubit.users[index].email,
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                            Text(
                              cubit.users[index].name,
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),

                            Text(
                              cubit.users[index].phone,
                              style: TextStyle(
                                color: ColorManager.white,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                              textAlign: TextAlign.start,
                            ),

                            Row(
                              children: [
                                IconButton(
                                  onPressed: (){
                                    customPushNavigator(context, BlocProvider(
                                      create: (context) => UserCubit(getIt()),
                                      child: UserInfoScreen(),
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
                                  onPressed: (){},
                                  icon: Icon(
                                    Icons.send,
                                    color: ColorManager.primaryBlue,
                                    size: SizeConfig.height*0.03,
                                  ),
                                ),
                              ],
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
