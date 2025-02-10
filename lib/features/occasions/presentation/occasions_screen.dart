import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/controller/occasions_cubit.dart';
import 'package:hadawi_dathboard/features/occasions/presentation/widgets/occasions_view_body.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';

class OccasionsScreen extends StatelessWidget {
  const OccasionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: ColorManager.primaryBlue,
        centerTitle: true,
        title: Text('إدارة المناسبات',
            style: TextStyles.textStyle18Medium
                .copyWith(color: ColorManager.white)),
      ),
      body: BlocProvider<OccasionsCubit>(
        create: (context) => OccasionsCubit()..getOccasions(),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: OccasionsViewBody(),
        ),
      ),
    );
  }
}
