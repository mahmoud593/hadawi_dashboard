import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hadawi_dathboard/features/home/presentation/view/screens/home_screen.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_cubit.dart';
import 'package:hadawi_dathboard/features/payments/presentation/controller/payments_states.dart';
import 'package:hadawi_dathboard/features/payments/presentation/view/widgets/payments_view_body.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';
import 'package:hadawi_dathboard/utiles/helper/material_navigation.dart';
import 'package:hadawi_dathboard/utiles/services/service_locator.dart';
import 'package:hadawi_dathboard/widgets/dashboard_app_bar_widget.dart';

class PaymentsScreen extends StatelessWidget {
  const PaymentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection:  TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          iconTheme: IconThemeData(
              color: Colors.white
          ) ,
          leading: IconButton(
              onPressed: (){
                customPushReplacement(context, HomeScreen());
              },
              icon: Icon(Icons.arrow_back_ios)
          ),
          backgroundColor: ColorManager.primaryBlue,
          centerTitle: true,
          title: Text('اداره المدفوعات و المحفظه',
              style: TextStyles.textStyle18Medium
                  .copyWith(color: ColorManager.white)),
        ),
        body: BlocProvider(
          create: (BuildContext context) => PaymentsCubit(getIt(),getIt())..getPayments()..getBalance(),
          child: BlocConsumer<PaymentsCubit, PaymentsStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return PaymentsViewBody();
            },
          ),
        )
      ),
    );
  }
}
