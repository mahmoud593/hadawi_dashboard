import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class UserInfoViewBody extends StatelessWidget {
  const UserInfoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserCubit,UserStates>(
        builder: (context, state) {
          var cubit = context.read<UserCubit>();
          return ModalProgressHUD(
            inAsyncCall: state is GetUserLoadingState,
            child: Container(
              height: SizeConfig.height*0.85,
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
                      Text('User Form Details',
                        style: TextStyle(color: ColorManager.white,fontSize: 18,fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                  SizedBox( height: SizeConfig.height*0.01,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Profile Picture',
                        style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                        ),),
                      SizedBox( height: SizeConfig.height*0.01,),
                      Image(
                        fit: BoxFit.cover,
                        width:  SizeConfig.height*0.6,
                        height:  SizeConfig.height*0.3,
                        image: NetworkImage('https://cdn.pixabay.com/photo/2021/09/20/03/24/skeleton-6639547_1280.png'),
                      ),

                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('uId :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text('gnirTEuYuEYxmTaYYtGE4DdUCqz2',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('User Name :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text('Ahmed Ali',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('Email :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text('mahmoudreda1811@gmail.com',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('Phone :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text('+201277556432',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('Gender :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text('Male',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                      Row(
                        children: [
                          Text('Birth Date :',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                          SizedBox( width: SizeConfig.height*0.025,),
                          Text('18/11/2000',
                            style: TextStyle(color: ColorManager.white,fontSize: 13,fontWeight: FontWeight.bold
                            ),),
                        ],
                      ),
                      SizedBox( height: SizeConfig.height*0.025,),

                    ],
                  ),
                  Spacer(),
                  Align(
                    alignment: AlignmentDirectional.bottomEnd,
                    child: Row(
                      children: [
                        Container(
                          width:  SizeConfig.height*0.2,
                          child: DefaultButton(
                              buttonText: 'Delete User',
                              onPressed: (){},
                              buttonColor: ColorManager.red
                          ),
                        ),
                        SizedBox(width:  SizeConfig.height*0.02,),

                        Container(
                          width:  SizeConfig.height*0.2,
                          child: DefaultButton(
                              buttonText: 'Block User',
                              onPressed: (){},
                              buttonColor: ColorManager.primaryBlue
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
        listener: (context, state) {

        }
    );
  }
}
