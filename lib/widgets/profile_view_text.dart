import 'package:flutter/material.dart';

SizedBox ProfileViewText(BuildContext context, String text, FontWeight fontWeight, double fontSize) {
  return SizedBox(
    width: MediaQuery.of(context).size.width - 50.0,
    height: 40.0,
    child: Text(
      text,
      style: TextStyle(
        fontWeight: fontWeight,
        fontSize: fontSize,
      ),
    ),
  );
}