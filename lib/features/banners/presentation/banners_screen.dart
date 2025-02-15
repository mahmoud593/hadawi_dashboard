import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/banners/presentation/controller/banners_cubit.dart';
import 'package:hadawi_dathboard/features/banners/presentation/widgets/banners_screen_body.dart';

import '../../../widgets/dashboard_app_bar_widget.dart';

class BannersScreen extends StatelessWidget {
  const BannersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: dashboardAppBarWidget('إدارة التسويق والإعلانات'),
        body: BlocProvider<BannersCubit>(
          create: (context) => BannersCubit()..getBanners(),
          child: BannersScreenBody(),
        ),
      ),
    );
  }
}
