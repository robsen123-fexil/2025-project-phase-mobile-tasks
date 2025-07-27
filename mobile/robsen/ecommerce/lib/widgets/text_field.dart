import 'package:flutter/material.dart';

Container Text_field(bool bordercolor, bool description) {
  return Container(
    child: TextField(
      maxLines: description ? 2 : 1, // taller input when it's a description
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey[200],
        contentPadding: EdgeInsets.symmetric(
          vertical: description ? 16 : 10,
          horizontal: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide:
              bordercolor
                  ? BorderSide(
                    color: Color.fromARGB(255, 12, 12, 12),
                    width: 0.5,
                  )
                  : BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              bordercolor
                  ? BorderSide(color: Colors.blue, width: 1.5)
                  : BorderSide.none,
        ),
      ),
      style: TextStyle(color: Colors.black),
    ),
  );
}
