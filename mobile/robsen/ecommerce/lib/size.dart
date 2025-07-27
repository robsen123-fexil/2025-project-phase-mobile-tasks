
import 'package:flutter/material.dart';

Widget Size() {
  return TextButton(
    onPressed: () {},
    child: Container(
      height: 50,
      width: 50,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Center(
        child: Text(
          '31',
          style: TextStyle(
            color: const Color.fromARGB(255, 0, 0, 0),
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
    ),
  );
}
