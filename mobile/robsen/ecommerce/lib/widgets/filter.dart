import 'package:flutter/material.dart';

Widget filter({
  required TextEditingController categoryController,
  required RangeValues currentRangeValues,
  required Function(RangeValues) onRangeChanged,
  required VoidCallback onApply,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Category'),
      TextField(
        controller: categoryController,
        decoration: InputDecoration(border: OutlineInputBorder()),
      ),
      SizedBox(height: 16),
      Text('Price'),
      RangeSlider(
        values: currentRangeValues,
        min: 0,
        max: 100,
        divisions: 10,
        labels: RangeLabels(
          currentRangeValues.start.toStringAsFixed(0),
          currentRangeValues.end.toStringAsFixed(0),
        ),
        onChanged: onRangeChanged,
      ),
      SizedBox(height: 16),
      ElevatedButton(
        onPressed: onApply,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
        ),
        child: Text('APPLY'),
      ),
    ],
  );
}
