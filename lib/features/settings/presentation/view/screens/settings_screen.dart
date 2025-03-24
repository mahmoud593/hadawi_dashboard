import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/privacy/presentation/controller/privacy_cubit.dart';
import 'package:hadawi_dathboard/features/privacy/presentation/controller/privacy_states.dart';
import 'package:hadawi_dathboard/features/privacy/presentation/view/widgets/privacy_view_body.dart';
import 'package:hadawi_dathboard/features/settings/presentation/controller/settings_cubit.dart';
import 'package:hadawi_dathboard/features/settings/presentation/controller/settings_states.dart';
import 'package:hadawi_dathboard/features/settings/presentation/view/widgets/settings_view_body.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:  TextDirection.rtl,
        child: BlocProvider(
          create: (context) => SettingCubit()..getAdminCredentials(),
          child: BlocConsumer<SettingCubit,SettingsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                  backgroundColor: Colors.grey[200],
                  appBar: dashboardAppBarWidget(context: context, text:'الاعدادات'),
                  body: SettingsViewBody(),
              );
            },
          ),
        )
    );
  }
}
