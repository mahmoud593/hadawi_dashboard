import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/taxs_view_body.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';

class TaxsScreen extends StatelessWidget {
  const TaxsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text('الرسوم الادارية'),
      ),
      body: Directionality(
          textDirection: TextDirection.rtl,
          child: TaxsViewBody()
      ),
    );
  }
}
