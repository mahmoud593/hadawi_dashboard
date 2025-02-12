import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';
import 'package:hadawi_dathboard/widgets/default_button.dart';
import 'package:hadawi_dathboard/widgets/default_text_field.dart';

class TaxsViewBody extends StatelessWidget {
   TaxsViewBody({super.key});

  TextEditingController serviceController = TextEditingController();
  TextEditingController deliveryController = TextEditingController();
  TextEditingController packingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(
          horizontal: 20
          ,vertical: 10
      ),
      decoration: BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        children: [

          Text('رسوم الخدمة',
            style: TextStyle(
                color: ColorManager.white,
                fontSize: 13,fontWeight: FontWeight.bold
            ),),

          SizedBox( height: SizeConfig.height*0.01,),

          DefaultTextField(
              controller: serviceController,
              hintText: 'ادخل رسوم الخدمة',
              validator: (value) {},
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              fillColor: ColorManager.gray
          ),

          SizedBox( height: SizeConfig.height*0.02,),

          Text('رسوم التوصيل',
            style: TextStyle(
                color: ColorManager.white,
                fontSize: 13,fontWeight: FontWeight.bold
            ),),

          SizedBox( height: SizeConfig.height*0.01,),

          DefaultTextField(
              controller: deliveryController,
              hintText: 'ادخل رسوم التوصيل',
              validator: (value) {},
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              fillColor: ColorManager.gray
          ),

          SizedBox( height: SizeConfig.height*0.02,),

          Text('رسوم التغليف',
            style: TextStyle(
                color: ColorManager.white,
                fontSize: 13,fontWeight: FontWeight.bold
            ),),

          SizedBox( height: SizeConfig.height*0.01,),

          DefaultTextField(
              controller: packingController,
              hintText: 'ادخل رسوم التغليف',
              validator: (value) {},
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.next,
              fillColor: ColorManager.gray
          ),

          Spacer(),

          Align(
            alignment: Alignment.bottomLeft,
            child: DefaultButton(
                buttonText: 'حفظ',
                onPressed: (){},
                buttonColor: ColorManager.primaryBlue
            ),
          )

        ],
      ),
    );
  }
}
