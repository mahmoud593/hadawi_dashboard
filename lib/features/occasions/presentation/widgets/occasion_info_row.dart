import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/styles/colors/color_manager.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';

class OccasionInfoColumn extends StatelessWidget {
  final String title;
  final String occasionValue;

  const OccasionInfoColumn({
    super.key,
    required this.title,
    required this.occasionValue,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              ":$title",
              textAlign: TextAlign.start,
              style: TextStyles.textStyle18Medium.copyWith(
                color: ColorManager.black,
                fontWeight: FontWeight.normal,
              ),
            ),
          ),
          const SizedBox(width: 8),

          Expanded(
            flex: 4,
            child: Text(
              occasionValue,
              textAlign: TextAlign.start,
              style: TextStyles.textStyle18Bold.copyWith(
                color: ColorManager.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

        ],
      ),
    );
  }
}

