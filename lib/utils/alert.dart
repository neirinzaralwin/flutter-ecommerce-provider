// ignore_for_file: deprecated_member_use

import 'package:ecommerce_app/utils/colors.dart';
import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, String title, String content,
    VoidCallback _callBackFunction) {
  // Create button
  Widget okButton = FlatButton(
    color: secondaryColor1,
    child: Text("OK"),
    onPressed: _callBackFunction,
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
