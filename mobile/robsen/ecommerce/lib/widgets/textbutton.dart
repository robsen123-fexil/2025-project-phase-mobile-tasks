import 'package:flutter/material.dart';
Widget textbutton(
  String text,
  Color backcolor,
  Color textcolor,
  Color bordercolor,
) {
  return SizedBox(
    width:double.infinity,
    child: TextButton(
      onPressed: () {
       
      },
      style: TextButton.styleFrom(
        backgroundColor: backcolor,
        foregroundColor:
            textcolor, 
        padding: EdgeInsets.symmetric(horizontal: 140, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: BorderSide(color: bordercolor, width: 2),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textcolor, // still needed to ensure custom text color
          fontSize: 11,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}
