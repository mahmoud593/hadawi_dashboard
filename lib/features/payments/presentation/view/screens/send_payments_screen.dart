import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/send_payments_view_body.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';

class SendPaymentsScreen extends StatelessWidget {
  const SendPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:TextDirection.rtl,
      child: Scaffold(
        appBar: dashboardAppBarWidget(context: context, text:'تحويل اموال'),
        backgroundColor: Colors.grey[100],
        body: SendPaymentsViewBody() ,
      ),
    );
  }
}
