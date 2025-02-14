import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/payments_view_body.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: dashboardAppBarWidget('اداره المدفوعات و المحفظه'),
        body: PaymentsViewBody(),
      ),
    );
  }
}
