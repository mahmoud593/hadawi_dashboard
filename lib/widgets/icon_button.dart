import 'package:flutter/material.dart';

Widget buildIconButton(IconData icon, Color color, VoidCallback onPressed) {
  return IconButton(icon: Icon(icon, color: color), onPressed: onPressed);
}
