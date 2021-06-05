import 'package:flutter/material.dart';
import 'ShowDatePickerHomePage.dart';
import 'ShowTimePickerHomePage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Demo Flutter',
    theme: ThemeData(
        primarySwatch: Colors.pink
    ),
    home: ShowDatePickerHomePage(),
  );
}