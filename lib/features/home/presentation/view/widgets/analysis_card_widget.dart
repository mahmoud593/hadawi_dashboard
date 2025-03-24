import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/constants/app_constants.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';

class AnalysisCardWidget extends StatelessWidget {
   AnalysisCardWidget({super.key,required this.index,required this.usersCount,required this.occusionsCountOpen,required this.occusionsCountClose,required this.paymentCount});

  final int index;
  final String usersCount;
  final String occusionsCountOpen;
  final String occusionsCountClose;
  final String paymentCount;

  List images = [
    'assets/images/active.png',
    'assets/images/open-box.png',
    'assets/images/close.png',
    'assets/images/pay.png',
  ];

   List strings = [
     'المستخدمين النشطين',
     'المناسبات النشطه',
     'المناسبات المغلقه',
     'اجمالي الدفوعات',
   ];

   List values = [
     '35',
     '22',
     '8',
     '560 \$',
   ];
  @override
  Widget build(BuildContext context) {
    return Container(

      padding:  EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).height*0.02,
          vertical:  MediaQuery.sizeOf(context).height*0.00
      ),
      width:MediaQuery.sizeOf(context).height*0.35,
      decoration: BoxDecoration(
        color: ColorManager.white,
        border:Border.all(color: ColorManager.primaryBlue),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
           mainAxisAlignment: MainAxisAlignment.center,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             Text(
              index==0?
              usersCount:
              index==1?
              occusionsCountOpen:
              index==2?
              occusionsCountClose:
              paymentCount,
               style: TextStyle(color: ColorManager.primaryBlue,
                 fontSize: MediaQuery.sizeOf(context).height*0.04,
                 fontWeight:  FontWeight.bold,
               ),
               textAlign: TextAlign.center,
             ),
             SizedBox(height:  MediaQuery.sizeOf(context).height*0.02,),
             Text(strings[index],
               style: TextStyle(color: ColorManager.black,
                   fontSize: MediaQuery.sizeOf(context).height*0.012,
                   fontWeight:  FontWeight.bold
               ),
             ),
           ],
         ),
          Spacer(),
          Image(
            image: AssetImage(images[index]),
            height:  MediaQuery.sizeOf(context).height*0.07,
          ),
        ],
      ),
    );
  }
}
