import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/constants/app_constants.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/widgets/analysis_card_widget.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/widgets/drawer_widget.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/widgets/welcome_widget.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/controller/occasions_cubit.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/occasions_screen.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/screens/payments_screen.dart';
import 'package:hadawi_dathboard/features/settings/presentation/view/screens/settings_screen.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_states.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/users_view_body.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';
import 'package:shimmer/shimmer.dart';

class HomeViewBody extends StatefulWidget {
   HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
   TextEditingController searchController = TextEditingController();

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(getIt(),getIt(),getIt(),getIt())..getAllUsers(desending: false)..getAnalysis(),
      child: BlocConsumer<UserCubit,UserStates>(
        builder: (context, state) {
          var cubit = context.read<UserCubit>();
          return Container(
            height:  MediaQuery.sizeOf(context).height,
            width:  MediaQuery.sizeOf(context).width,
            child: Row(
              children: [

                /// drawer
                Container(
                    height:  MediaQuery.sizeOf(context).height,
                    width:  MediaQuery.sizeOf(context).width*0.2,
                    child: DrawerWidget()
                ),

                Container(
                  height:  MediaQuery.sizeOf(context).height,
                  width:  MediaQuery.sizeOf(context).width*0.8,
                  child: Column(
                    children: [

                      SizedBox( height:  MediaQuery.sizeOf(context).height*0.02,),

                      /// welcome widget
                      Container(
                        height:  MediaQuery.sizeOf(context).height*0.1,
                        width:  MediaQuery.sizeOf(context).width,
                        margin:  EdgeInsets.symmetric(
                            horizontal: MediaQuery.sizeOf(context).height*0.03,
                            vertical:  MediaQuery.sizeOf(context).height*0.00
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            WelcomeWidget(),

                            SizedBox( width:  MediaQuery.sizeOf(context).height*0.025,),

                            Container(
                              width:  MediaQuery.sizeOf(context).width*0.4,

                              child: DefaultTextField(
                                  onChanged: (value){
                                    cubit.filterName(value,false);
                                  },
                                  controller: searchController,
                                  hintText: 'بحث في الجدول (الاسم - البريد الالكتروني - رقم الهاتف) ....',
                                  validator: (value) {
                                  },
                                  keyboardType: TextInputType.text,
                                  textInputAction: TextInputAction.done,
                                  fillColor: ColorManager.white
                              ),
                            ),

                            SizedBox(width:  MediaQuery.sizeOf(context).width*0.2,),

                            // Container(
                            //   decoration: BoxDecoration(
                            //       color: ColorManager.white,
                            //       borderRadius: BorderRadius.circular(5)
                            //   ),
                            //   child: DropdownButton(
                            //      underline: Container(),
                            //       padding: EdgeInsets.symmetric(horizontal:  MediaQuery.sizeOf(context).height*0.04),
                            //       style: TextStyles.textStyle18Medium.copyWith(color: ColorManager.black),
                            //       icon: Icon(Icons.arrow_drop_down,
                            //         color: ColorManager.black,
                            //       ),
                            //       borderRadius:  BorderRadius.circular(5),
                            //       dropdownColor: ColorManager.white,
                            //       hint: Text('المدينه'),
                            //       items: [
                            //         DropdownMenuItem(
                            //           value: "City 1",
                            //           child: Text("City 1"),
                            //         ),
                            //         DropdownMenuItem(
                            //           value: "City 2",
                            //           child: Text("City 2"),
                            //         ),
                            //         DropdownMenuItem(
                            //           value: "City 3",
                            //           child: Text("City 3"),
                            //         ),
                            //       ],
                            //       onChanged: (String? newValue) {
                            //
                            //       }
                            //   ),
                            // ),

                            SizedBox(width: MediaQuery.sizeOf(context).height*0.015,),

                            GestureDetector(
                              onTap: (){
                                customPushNavigator(context, SettingsScreen());
                              },
                              child: Image(
                                height:  MediaQuery.sizeOf(context).height*0.06,
                                image: AssetImage('assets/images/administrator.png'),
                              )
                            )

                          ],
                        ),
                      ),

                      /// analysis cards
                      cubit.analysisModel == null ? Row(
                        children: [
                          SizedBox(width:  MediaQuery.sizeOf(context).height*0.02,),
                          Container(
                            height:  MediaQuery.sizeOf(context).height*0.2,
                            width:  MediaQuery.sizeOf(context).width*0.15,
                            child: Shimmer.fromColors(
                              baseColor:  Colors.grey.shade300,
                              highlightColor:  Colors.grey.shade100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  border:Border.all(color: ColorManager.primaryBlue),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width:  MediaQuery.sizeOf(context).height*0.02,),
                          Container(
                            height:  MediaQuery.sizeOf(context).height*0.2,
                            width:  MediaQuery.sizeOf(context).width*0.15,
                            child: Shimmer.fromColors(
                              baseColor:  Colors.grey.shade300,
                              highlightColor:  Colors.grey.shade100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  border:Border.all(color: ColorManager.primaryBlue),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width:  MediaQuery.sizeOf(context).height*0.02,),
                          Container(
                            height:  MediaQuery.sizeOf(context).height*0.2,
                            width:  MediaQuery.sizeOf(context).width*0.15,
                            child: Shimmer.fromColors(
                              baseColor:  Colors.grey.shade300,
                              highlightColor:  Colors.grey.shade100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  border:Border.all(color: ColorManager.primaryBlue),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width:  MediaQuery.sizeOf(context).height*0.02,),
                          Container(
                            height:  MediaQuery.sizeOf(context).height*0.2,
                            width:  MediaQuery.sizeOf(context).width*0.15,
                            child: Shimmer.fromColors(
                              baseColor:  Colors.grey.shade300,
                              highlightColor:  Colors.grey.shade100,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: ColorManager.white,
                                  border:Border.all(color: ColorManager.primaryBlue),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width:  MediaQuery.sizeOf(context).height*0.02,)
                        ],
                      ) :
                      Container(
                        height:  MediaQuery.sizeOf(context).height*0.2,
                        width:  MediaQuery.sizeOf(context).width,
                        child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) => AnalysisCardWidget(
                              index: index,
                              usersCount: cubit.users.length.toString(),
                              occusionsCountClose: cubit.analysisModel!.closeOccasions.toString(),
                              occusionsCountOpen:  cubit.analysisModel!.openOccasions.toString(),
                              paymentCount: 0.toString(),
                            ),
                            separatorBuilder: (context, index) => SizedBox(width:  MediaQuery.sizeOf(context).height*0.02,),
                            itemCount: 4
                        ),
                      ),

                      SizedBox( height:  MediaQuery.sizeOf(context).height*0.02,),

                      /// users table
                      Container(
                          height:  MediaQuery.sizeOf(context).height*0.6,
                          width:  MediaQuery.sizeOf(context).width,
                          child: UsersViewBody(isScreen: false,)
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      listener: (context, state) {

      },
    )
    );
  }
}
