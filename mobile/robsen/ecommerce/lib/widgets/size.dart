import 'package:flutter/material.dart';

Widget Sizes(String size , bool isSelected) {
  return TextButton(
    onPressed: () {},
    child: Container(
      height: 50,
      width: 50,

      decoration: BoxDecoration(
        color: isSelected? const Color.fromARGB(255, 0, 86, 235) : Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Center(
        child: Text(
          size,
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    ),
  );
}
