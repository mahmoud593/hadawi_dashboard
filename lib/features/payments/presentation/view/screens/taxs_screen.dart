import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_cubit.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_states.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/taxs_view_body.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class TaxsScreen extends StatelessWidget {
  const TaxsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PaymentsCubit,PaymentsStates>(
      builder: (context, state) {
        return Directionality(
          textDirection:  TextDirection.rtl,
          child: Scaffold(
            backgroundColor: Colors.grey[300],
            appBar: dashboardAppBarWidget(context: context, text:'الرسوم الاداريه'),
            body: Directionality(
                textDirection: TextDirection.rtl,
                child: context.read<PaymentsCubit>().taxEntities !=null?
                TaxsViewBody():Center(child: CircularProgressIndicator(),)
            ),
          ),
        );
      },
    );
  }
}
