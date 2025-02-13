import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/constants/app_constants.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/widgets/analysis_card_widget.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/widgets/drawer_widget.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/widgets/welcome_widget.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/occasions_screen.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/screens/payments_screen.dart';
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
          return Expanded(
            child: Row(
              children: [

                /// drawer
                Expanded(
                  flex: 1,
                  child: DrawerWidget(),
                ),

                Expanded(
                  flex: 4,
                  child: Column(
                    children: [

                      SizedBox( height:  MediaQuery.sizeOf(context).height*0.02,),

                      /// welcome widget
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

                                WelcomeWidget(),

                                SizedBox( width:  MediaQuery.sizeOf(context).height*0.025,),

                                Expanded(
                                  child: DefaultTextField(
                                      onChanged: (value){
                                        cubit.filterName(value);
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

                      /// analysis cards
                      Expanded(
                          flex: 2,
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) => AnalysisCardWidget(index: index),
                              separatorBuilder: (context, index) => SizedBox(width:  MediaQuery.sizeOf(context).height*0.0,),
                              itemCount: 5
                          )
                      ),

                      SizedBox( height:  MediaQuery.sizeOf(context).height*0.02,),

                      /// users table
                      Expanded(
                          flex: 6,
                          child: UsersViewBody()
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
