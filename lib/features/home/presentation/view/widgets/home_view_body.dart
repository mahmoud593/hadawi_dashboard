import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/users_view_body.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
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
                            right: 5,
                            top: 10,
                            bottom: 10
                        ),
                        decoration: BoxDecoration(
                          color: ColorManager.primaryBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image(
                                  height:  MediaQuery.sizeOf(context).height*0.15,
                                  width:  MediaQuery.sizeOf(context).height*0.15,
                                  image: AssetImage(AssetsManager.darkLogo),
                                ),
                                Text("Welcome to \nHadawi Dashboard",style: TextStyle(
                                    fontSize: MediaQuery.sizeOf(context).height*0.02,
                                    color: ColorManager.white,
                                    fontWeight:  FontWeight.bold
                                ),
                                  textAlign: TextAlign.center ,

                                ),
                              ],
                            ),
                            Divider(
                              color: ColorManager.white,
                            ),


                            Expanded(
                              child: Padding(
                                padding:  EdgeInsets.symmetric(
                                    horizontal: MediaQuery.sizeOf(context).height*0.03,
                                    vertical:  MediaQuery.sizeOf(context).height*0.02
                                ),
                                child: ListView.separated(
                                    itemBuilder: (context, index) => Container(
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.people,
                                            color: ColorManager.white,
                                            size:  MediaQuery.sizeOf(context).height*0.03,
                                          ),
                                          SizedBox(width:  MediaQuery.sizeOf(context).height*0.01,),
                                          Text("Users",style: TextStyle(
                                              color: ColorManager.white,
                                              fontSize: MediaQuery.sizeOf(context).height*0.02
                                          ))
                                        ],
                                      ),
                                    ),
                                    separatorBuilder: (context, index) => SizedBox( height:  MediaQuery.sizeOf(context).height*0.03,),
                                    itemCount: 10
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
                          Expanded(
                              flex: 1,
                              child: Container(
                                margin:  EdgeInsets.symmetric(
                                    horizontal: MediaQuery.sizeOf(context).height*0.03,
                                    vertical:  MediaQuery.sizeOf(context).height*0.00
                                ),
                                child: Row(
                                  children: [
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
                                          fillColor: ColorManager.gray
                                      ),
                                    ),

                                    Spacer(),

                                    DropdownButton(
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

                                  ],
                                ),
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
