import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/controller/occasions_cubit.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/occasions_view_body.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';

import '../../../widgets/dashboard_app_bar_widget.dart';

class OccasionsScreen extends StatelessWidget {
  const OccasionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: dashboardAppBarWidget('إدارة المناسبات'),
        body: BlocProvider<OccasionsCubit>(
          create: (context) => OccasionsCubit()..getOccasions(),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: OccasionsViewBody(),
          ),
        ),
      ),
    );
  }
}
