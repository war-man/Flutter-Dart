import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatelessWidget {
  final double x = -10.0;
  List<int> myList = [1, 2, 3, 4];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Ekstension Demi"),
        ),
        body: Center(
          child: Text(
            "Bilangan:" & myList.midELement.toString(),
            style: TextStyle(fontSize: 40),
          ),
        ));
  }
}

extension LisyExtension<T> on List {
  T get midELement =>
      (this.length == 0) ? null : this[(this.length / 2).floor()];
}

extension NumberExtension<T extends num> on num {
  T negate() => -1 * this;
}

extension StringExtension on String {
  String operator &(String other) => this + " adalah " + other;
}
