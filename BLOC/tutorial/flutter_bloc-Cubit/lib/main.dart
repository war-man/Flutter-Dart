
import 'package:cubitbloc/screens/cubitScreens/movies.dart';
import 'package:flutter/material.dart';

import 'screens/blocScreens/movieBloc.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(body: SafeArea(child: MoviesTwo())),
    );
  }
}
