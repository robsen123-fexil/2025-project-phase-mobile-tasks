import 'package:flutter/material.dart';

Widget productcard(
  Image image,
  String name,
  String type,
  double price,
  double rate,
) {
  return Container(
    height: 270,
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10), // Rounded corners
      color: const Color.fromARGB(255, 233, 236, 234),
      boxShadow: [
        BoxShadow(color: Colors.grey, offset: Offset(0, 5), blurRadius: 6),
      ],
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(10), // Apply rounding inside
      child: Column(
        children: [
          image,
          SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [Text(name , style: TextStyle(fontWeight: FontWeight.w800 , fontSize: 16)), SizedBox(height: 3), Text(type , style: TextStyle(color: const Color.fromARGB(255, 129, 128, 128)),)]),
                Column(
                  children: [
                    Text('\$'+price.toString() ,
                      style: TextStyle(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 3),
                    Text('⭐ ''($rate)' , style: TextStyle(color: Colors.grey),),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
