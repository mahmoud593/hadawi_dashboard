import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/constants/app_constants.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';

class AnalysisCardWidget extends StatelessWidget {
  const AnalysisCardWidget({super.key,required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).height*0.03,
          vertical:  MediaQuery.sizeOf(context).height*0.00
      ),
      padding:  EdgeInsets.symmetric(
          horizontal: MediaQuery.sizeOf(context).height*0.03,
          vertical:  MediaQuery.sizeOf(context).height*0.00
      ),
      width:MediaQuery.sizeOf(context).height*0.25,
      decoration: BoxDecoration(
        color: ColorManager.white,
        border:Border.all(color: ColorManager.primaryBlue),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(AppConstants().dividerIcons[index]),
            height:  MediaQuery.sizeOf(context).height*0.05,

          ),
          SizedBox(height:  MediaQuery.sizeOf(context).height*0.025,),
          Text(AppConstants().dividerTitles[index],
            style: TextStyle(color: ColorManager.primaryBlue,
              fontWeight:  FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height:  MediaQuery.sizeOf(context).height*0.02,),
          Text('100',
            style: TextStyle(color: ColorManager.black,
                fontSize: MediaQuery.sizeOf(context).height*0.022,
                fontWeight:  FontWeight.bold
            ),
          ),
        ],
      ),
    );
  }
}
