import 'dart:ui';

import 'package:flutter/material.dart';

Widget glassButton(
    BuildContext context, IconData icon, String text, VoidCallback onPressed) {
  Size size = MediaQuery.of(context).size;
  return InkWell(
    onTap: onPressed,
    child: ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaY: 15,
          sigmaX: 15,
        ),
        child: Container(
            height: size.width / 7,
            width: size.width / 2,
            alignment: Alignment.center,
            padding: EdgeInsets.only(right: size.width / 30),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                )),
                Icon(icon),
              ],
            )),
      ),
    ),
  );
}
