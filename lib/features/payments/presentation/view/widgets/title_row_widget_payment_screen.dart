import 'package:flutter/cupertino.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/size_config/app_size_config.dart';

class TitleRowWidgetPaymentScreen extends StatelessWidget {
  const TitleRowWidgetPaymentScreen({super.key,required this.image,required this.title});

  final String image;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Image(
            height: SizeConfig.height*0.05,
            image: AssetImage(image),
          ),
          SizedBox(width: SizeConfig.height*0.02,),
          Text(title,
            style: TextStyle(color: ColorManager.primaryBlue,
                fontSize: 15,
                fontWeight: FontWeight.bold
            ),),
        ],
      ),
    );
  }
}
