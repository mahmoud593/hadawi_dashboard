import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/controller/occasions_cubit.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/occasions_view_body.dart';
import 'package:hadawi_dathboard/features/users/presentation/controller/user_cubit.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/users_view_body.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';


class ShowUsersViewBodyScreen extends StatelessWidget {
  const ShowUsersViewBodyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: dashboardAppBarWidget(context: context, text:'المستخدمين'),
        body: BlocProvider<UserCubit>(
          create: (context) => UserCubit(getIt(),getIt(),getIt(),getIt())..getAllUsers(desending: false),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: UsersViewBody(isScreen: true,),
          ),
        ),
      ),
    );
  }
}
