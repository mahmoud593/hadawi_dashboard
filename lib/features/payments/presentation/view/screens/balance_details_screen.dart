import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/payments/data/models/balance_model.dart';
import 'package:hadawi_dathboard/features/payments/data/models/payment_model.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/balance_details_view_body.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/payment_details_view_body.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/user_info_view_body.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';

class BalanceDetailsScreen extends StatelessWidget {
  const BalanceDetailsScreen({super.key,required this.balanceModel});

 final  BalanceModel balanceModel ;

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: dashboardAppBarWidget(context: context, text:'عمليات السحب'),
        body: BalanceDetailsViewBody(balanceModel: balanceModel,),
      ),
    );
  }
}
