import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/constants/app_constants.dart';
import 'package:hadawi_dathboard/features/auth/presentation/login_screen.dart';
import 'package:hadawi_dathboard/features/banners/presentation/banners_screen.dart';
import 'package:hadawi_dathboard/features/notifications_management/presentation/view/screens/notification_management_screen.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/occasions_screen.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/screens/payments_screen.dart';
import 'package:hadawi_dathboard/features/privacy/presentation/view/screens/privacy_screen.dart';
import 'package:hadawi_dathboard/features/promocode/presentation/promocode_screen.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/show_users_view_body.dart';
import 'package:hadawi_dathboard/styles/assets/asset_manager.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';

import '../../../../../utiles/helper/material_navigation.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
            height:  MediaQuery.sizeOf(context).height*0.13,
            width:  MediaQuery.sizeOf(context).height*0.13,
            image: AssetImage(AssetsManager.logoWithoutBackground),
          ),

          SizedBox(height:  MediaQuery.sizeOf(context).height*0.02,),

          Padding(
            padding:  EdgeInsets.symmetric(
              horizontal: MediaQuery.sizeOf(context).height*.03,
            )  ,
            child: Divider(
              color: ColorManager.primaryBlue,
            ),
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
                      if(index == 0){}
                      else if(index == 1){
                        customPushNavigator(context, ShowUsersViewBodyScreen());
                      }
                      else if(index == 3){
                        customPushNavigator(context, PaymentsScreen());
                      }else if(index == 2){
                        customPushNavigator(context, OccasionsScreen());
                      }else if(index == 4){
                        customPushNavigator(context, BannersScreen());
                      }else if(index == 5){
                        customPushNavigator(context, NotificationManagementScreen());
                      } else if(index == 7){
                        customPushNavigator(context, PrivacyScreen());
                      } else if(index == 6){
                        customPushNavigator(context, PromoCodeScreen());
                      } else if(index == 8){
                        customPushAndRemoveUntil(context, LoginScreen());
                      }
                    },
                    child: Row(
                      children: [
                        Image(
                          color: ColorManager.black,
                          height:  MediaQuery.sizeOf(context).height*0.03,
                          image: AssetImage(AppConstants().dividerIcons[index]),
                        ),
                        SizedBox(width:  MediaQuery.sizeOf(context).height*0.015,),
                        Text(AppConstants().dividerTitles[index],style: TextStyle(
                            color: ColorManager.black,
                            fontSize: MediaQuery.sizeOf(context).height*0.02
                        ))
                      ],
                    ),
                  ),
                  separatorBuilder: (context, index) => SizedBox( height: MediaQuery.sizeOf(context).height*0.05,),
                  itemCount: AppConstants().dividerTitles.length
              ),
            ),
          )
        ],
      ),
    );
  }
}
