import 'package:flutter/material.dart';

Widget Button(
  String text,
  Color backgroundcolor,
  Color textcolor,
  Color bordercolor,
) {
  return TextButton(
    onPressed: () {},
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(backgroundcolor),
      padding: WidgetStateProperty.all(

        EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      ),
      side: WidgetStateProperty.all(
        BorderSide(color: bordercolor, width: 1),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    child: Text(text, style: TextStyle(color: textcolor)),
  );
}
