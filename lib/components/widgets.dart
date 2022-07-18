import 'package:flutter/material.dart';

Widget IconAndTextWidget(
    IconData icon, String text, Color iconColor, Color textColor) {
  return Container(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Icon(
          icon,
          color: iconColor,
        ),
        SizedBox(width: 5),
        Text(
          text,
          style: TextStyle(color: textColor),
        ),
      ],
    ),
  );
}
