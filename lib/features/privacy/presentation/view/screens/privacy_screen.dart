import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/privacy/presentation/controller/privacy_cubit.dart';
import 'package:hadawi_dathboard/features/privacy/presentation/controller/privacy_states.dart';
import 'package:hadawi_dathboard/features/privacy/presentation/view/widgets/privacy_view_body.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection:  TextDirection.rtl,
        child: BlocProvider(
          create: (context) => PrivacyCubit()..getPrivacy(),
          child: BlocConsumer<PrivacyCubit,PrivacyState>(
            listener: (context, state) {},
            builder: (context, state) {
              var cubit = context.read<PrivacyCubit>();
              return Scaffold(
                  backgroundColor: Colors.grey[200],
                  appBar: dashboardAppBarWidget('سياسه الاستخدام و الخصوصيه'),
                  body: cubit.privacy !=''? PrivacyViewBody():Center(child:  CircularProgressIndicator(),)
              );
            },
          ),
        )
    );
  }
}
