import 'package:flutter/material.dart';

Widget IconAndTextWidget(IconData icon, String text, Color iconColor,
    Color textColor, FontWeight fontWeight) {
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
          style: TextStyle(color: textColor, fontWeight: fontWeight),
        ),
      ],
    ),
  );
}

Widget SmallText(String text) {
  return Text(
    text,
    style: TextStyle(
      color: Colors.black.withOpacity(0.3),
      height: 1.8,
    ),
  );
}

Widget BigText(String text) {
  return Text(
    text,
    style: TextStyle(
      fontSize: 26,
      fontWeight: FontWeight.bold,
    ),
  );
}
