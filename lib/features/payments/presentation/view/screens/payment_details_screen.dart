import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/payment_details_view_body.dart';
import 'package:hadawi_dathboard/features/users/domain/entities/user_entities.dart';
import 'package:hadawi_dathboard/features/users/presentation/widgets/user_info_view_body.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';

class PaymentDetailsScreen extends StatelessWidget {
  const PaymentDetailsScreen({super.key,});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[300],
        appBar: dashboardAppBarWidget('تفاصيل المدفوعات'),
        body: PaymentDetailsViewBody(),
      ),
    );
  }
}
