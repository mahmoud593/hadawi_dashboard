import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/constants/app_constants.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/screens/payments_screen.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/users_view_body.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';

class HomeViewBody extends StatelessWidget {
   HomeViewBody({super.key});

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(getIt(),getIt(),getIt(),getIt())..getAllUsers(),
      child: BlocConsumer<UserCubit,UserStates>(
        builder: (context, state) {
          var cubit = context.read<UserCubit>();
          return Container(
              child: Expanded(
                child: Row(
                  children: [

                    Expanded(
                      flex: 1,
                      child: Container(
                        margin:  EdgeInsets.only(
                           left: 15,
                            right: 10,
                            top: 10,
                            bottom: 10
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            SizedBox(height:  MediaQuery.sizeOf(context).height*0.02,),

                            Image(
                              height:  MediaQuery.sizeOf(context).height*0.15,
                              width:  MediaQuery.sizeOf(context).height*0.15,
                              image: AssetImage(AssetsManager.logoWithoutBackground),
                            ),

                            SizedBox(height:  MediaQuery.sizeOf(context).height*0.02,),

                            Divider(
                              color: ColorManager.primaryBlue,
                            ),

                            SizedBox(height:  MediaQuery.sizeOf(context).height*0.02,),

                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: MediaQuery.sizeOf(context).height*0.03,
                                    vertical:  MediaQuery.sizeOf(context).height*0.02
                                ),
                                child: ListView.separated(
                                    itemBuilder: (context, index) => GestureDetector(
                                      onTap: (){
                                        if(index == 0){

                                        }else if(index == 2){
                                          customPushNavigator(context, PaymentsScreen());
                                        }
                                      },
                                      child: Row(
                                        children: [
                                          Image(
                                            color: ColorManager.primaryBlue,
                                            height:  MediaQuery.sizeOf(context).height*0.03,
                                            image: AssetImage(AppConstants().dividerIcons[index]),
                                          ),
                                          SizedBox(width:  MediaQuery.sizeOf(context).height*0.015,),
                                          Text(AppConstants().dividerTitles[index],style: TextStyle(
                                              color: ColorManager.primaryBlue,
                                              fontSize: MediaQuery.sizeOf(context).height*0.02
                                          ))
                                        ],
                                      ),
                                    ),
                                    separatorBuilder: (context, index) => SizedBox( height: MediaQuery.sizeOf(context).height*0.04,),
                                    itemCount: AppConstants().dividerTitles.length
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: [
                          SizedBox( height:  MediaQuery.sizeOf(context).height*0.02,),
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin:  EdgeInsets.symmetric(
                                    horizontal: MediaQuery.sizeOf(context).height*0.03,
                                    vertical:  MediaQuery.sizeOf(context).height*0.00
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      children: [
                                        Row(
                                          children: [
                                            Text('اهلا وسهلا',style: TextStyle(
                                              color: ColorManager.primaryBlue,
                                            ),),

                                            SizedBox( width:  MediaQuery.sizeOf(context).height*0.02,),

                                            Image(
                                                height:  MediaQuery.sizeOf(context).height*0.05,
                                                image: AssetImage('assets/images/wave.png')
                                            ),
                                          ],
                                        ),
                                        SizedBox( height:  MediaQuery.sizeOf(context).height*0.01,),
                                        Text('اهلا بك في لوحة التحكم',style: TextStyle(
                                          color: ColorManager.primaryBlue,
                                        ),),
                                      ],
                                    ),

                                    SizedBox( width:  MediaQuery.sizeOf(context).height*0.025,),

                                    Expanded(
                                      child: DefaultTextField(
                                          onChange: (value){
                                            cubit.filterName(value);
                                          },
                                          controller: searchController,
                                          hintText: 'Search in table (name,email,phone)',
                                          validator: (value) {
                                          },
                                          keyboardType: TextInputType.text,
                                          textInputAction: TextInputAction.done,
                                          fillColor: ColorManager.white
                                      ),
                                    ),

                                    Spacer(),

                                    DropdownButton(
                                        borderRadius:  BorderRadius.circular(5),
                                        dropdownColor: ColorManager.white,
                                        hint: Text('المدينه'),
                                        items: [
                                          DropdownMenuItem(
                                            value: "City 1",
                                            child: Text("City 1"),
                                          ),
                                          DropdownMenuItem(
                                            value: "City 2",
                                            child: Text("City 2"),
                                          ),
                                          DropdownMenuItem(
                                            value: "City 3",
                                            child: Text("City 3"),
                                          ),
                                        ],
                                        onChanged: (String? newValue) {

                                        }
                                    ),

                                    SizedBox(width:  MediaQuery.sizeOf(context).height*0.02,),

                                    CircleAvatar(
                                      radius:  MediaQuery.sizeOf(context).height*0.03,
                                      backgroundImage: AssetImage('assets/images/person.png'),
                                    )

                                  ],
                                ),
                              )
                          ),

                          Expanded(
                              flex: 2,
                              child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder: (context, index) => Container(
                                    margin:  EdgeInsets.symmetric(
                                        horizontal: MediaQuery.sizeOf(context).height*0.03,
                                        vertical:  MediaQuery.sizeOf(context).height*0.00
                                    ),
                                    padding:  EdgeInsets.symmetric(
                                        horizontal: MediaQuery.sizeOf(context).height*0.03,
                                        vertical:  MediaQuery.sizeOf(context).height*0.00
                                    ),
                                    width:MediaQuery.sizeOf(context).height*0.25,
                                    decoration: BoxDecoration(
                                      color: ColorManager.white,
                                      border:Border.all(color: ColorManager.primaryBlue),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image(
                                          image: AssetImage(AppConstants().dividerIcons[index]),
                                          height:  MediaQuery.sizeOf(context).height*0.05,

                                        ),
                                        SizedBox(height:  MediaQuery.sizeOf(context).height*0.025,),
                                        Text(AppConstants().dividerTitles[index],
                                          style: TextStyle(color: ColorManager.primaryBlue,
                                            fontWeight:  FontWeight.bold,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height:  MediaQuery.sizeOf(context).height*0.02,),
                                        Text('100',
                                            style: TextStyle(color: ColorManager.primaryBlue,
                                            fontSize: MediaQuery.sizeOf(context).height*0.02
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  separatorBuilder: (context, index) => SizedBox(width:  MediaQuery.sizeOf(context).height*0.0,),
                                  itemCount: 5
                              )
                          ),
                          Expanded(
                              flex: 6,
                              child: UsersViewBody()
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
          );
        },
      listener: (context, state) {

      },
    )
    );
  }
}
