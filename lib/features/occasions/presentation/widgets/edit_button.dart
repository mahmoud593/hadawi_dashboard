import 'package:flutter/material.dart';
import 'package:hadawi_dathboard/styles/text_styles/text_styles.dart';

class DetailsButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String title;
  final IconData icon;
  final Color backGroundColor;
  final Color textColor;
  final Color foregroundColor;
  final Color iconColor;

  const DetailsButton({super.key, required this.onPressed, required this.title, required this.icon, required this.backGroundColor, required this.foregroundColor, required this.textColor, required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: backGroundColor,
        foregroundColor: foregroundColor ,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      ),
      onPressed: onPressed,
      icon:  Icon(icon, size: 20,
      color: iconColor,
      ),
      label:  Text(
        title,
        style: TextStyles.textStyle18Medium.copyWith(
          color: textColor
        ),
      ),
    );
  }
}


