import 'package:flutter/material.dart';

import '../styles/colors/color_manager.dart';
import '../styles/text_styles/text_styles.dart';

Widget buildHeaderText(String text) {
  return Expanded(
    child: Text(text,
        style:
        TextStyles.textStyle18Medium.copyWith(color: ColorManager.white)),
  );
}