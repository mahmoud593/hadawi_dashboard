import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/promocode/presentation/controller/promocode_cubit.dart';
import 'package:hadawi_dathboard/features/promocode/presentation/widgets/promocode_body_view.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';

class PromoCodeScreen extends StatelessWidget {
  const PromoCodeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: BlocProvider(
          create: (context) => PromoCodeCubit()..getPromoCodes(),
          child: Scaffold(
            backgroundColor: Colors.grey[100],
            appBar: dashboardAppBarWidget(context: context, text: 'إدارة أكواد الخصم'),
            body: PromoCodeBodyView(),
          ),
        ));
  }
}
