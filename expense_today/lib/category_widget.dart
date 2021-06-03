import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoryWidget extends StatefulWidget {
  CategoryWidget({Key? key, required this.rowNumber, required this.callback}) : super(key: key);

  int rowNumber;
  Function(int,double) callback;

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                "${widget.rowNumber + 1}.",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                onChanged: (text) {
                  print(text);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Category',
                ),
              ),
            ),
            Icon(Icons.attach_money),
            Expanded(
              child: TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9]+(\.){0,1}[0-9]*'))
                ],
                onChanged: (text) {
                  double val = 0.0;
                  try {
                    val = double.parse(text);
                  } catch (e) {
                    print("text is not convertible to double");
                  }

                  widget.callback(widget.rowNumber, val);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Cost',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}