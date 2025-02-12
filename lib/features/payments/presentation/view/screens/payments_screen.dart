import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/payments_view_body.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: const Text('إدارة المدفوعات والمحفظة',
            style:  TextStyle(color: ColorManager.primaryBlue),
          ),
        ),
        body: PaymentsViewBody(),
      ),
    );
  }
}
