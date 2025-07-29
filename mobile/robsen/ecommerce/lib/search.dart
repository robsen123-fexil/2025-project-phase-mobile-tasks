import 'package:ecommerce/widgets/product.dart';
import 'package:ecommerce/widgets/text_field.dart';
import 'package:ecommerce/widgets/textbutton.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _categoryController = TextEditingController();
  RangeValues _range = RangeValues(10, 60);

  void _showFilterSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      barrierColor: Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(0)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 20,
            left: 16,
            right: 16,
          ),
          child: StatefulBuilder(
            builder: (context, setModalState) {
              return SizedBox(
                height: 250,
                child: filter(
                  categoryController: _categoryController,
                  currentRangeValues: _range,
                  onRangeChanged: (val) {
                    setModalState(() {
                      _range = val;
                    });
                  },
                  onApply: () {
                    // Handle filter action
                    Navigator.pop(context);
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(14.0),
          child: IconButton(
            onPressed: () => context.go('/'),
            icon: Icon(Icons.arrow_back_ios, color: Colors.blue),
          ),
        ),
        title: Text(
          'Search Product',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 48,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Leather',
                            style: TextStyle(color: Colors.black54),
                          ),
                          Icon(
                            Icons.arrow_right_alt_outlined,
                            color: Colors.blue,
                            size: 25,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 8),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: _showFilterSheet,
                    icon: Icon(
                      Icons.filter_list_rounded,
                      color: const Color.fromARGB(255, 255, 255, 255),
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: () => context.go('/detail'),
              child: productcard(
                Image(image: AssetImage('assets/show.webp')),
                'Derby Cotton shoes',
                'Men\'s Shoe',
                100,
                4.0,
              ),
            ),
            SizedBox(height: 5),
            GestureDetector(
              onTap: () => context.go('/detail'),
              child: productcard(
                Image(image: AssetImage('assets/show.webp')),
                'Derby',
                'Men\'s Shoe',
                100,
                4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Reusable filter widget
Widget filter({
  required TextEditingController categoryController,
  required RangeValues currentRangeValues,
  required Function(RangeValues) onRangeChanged,
  required VoidCallback onApply,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      Text('Category'),
      SizedBox(height: 8),
      Text_field(true, false),
      SizedBox(height: 16),
      Text('Price'),
      RangeSlider(
        values: currentRangeValues,
        min: 0,
        max: 100,
        divisions: 10,
        activeColor: Colors.blue,
        labels: RangeLabels(
          currentRangeValues.start.toStringAsFixed(0),
          currentRangeValues.end.toStringAsFixed(0),
        ),
        onChanged: onRangeChanged,
      ),
      SizedBox(height: 16),
      textbutton('Apply', Colors.blue, Colors.white, Colors.blue),
    ],
  );
}
