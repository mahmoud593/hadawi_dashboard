import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';

class SectionContainer extends StatelessWidget {
  final String title;
  final int count;
  final void Function()? onTap;
  const SectionContainer({super.key, required this.title, required this.count, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: MediaQuery.sizeOf(context).height * 0.1,
        width:  MediaQuery.sizeOf(context).width * 0.15,
        decoration: BoxDecoration(
          color: ColorManager.white,
          borderRadius: BorderRadius.circular(15.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title,style: TextStyles.textStyle18Bold.copyWith(color: ColorManager.primaryBlue),),
            SizedBox(height: 10,),
            Text("$count",style: TextStyles.textStyle18Medium.copyWith(color: ColorManager.primaryBlue),),
          ],
        ),
      ),
    );
  }
}
