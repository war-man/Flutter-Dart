import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Theme Data',
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue[800],
        accentColor: Colors.cyan[600],
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 50.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
        ),
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Theme Data'),
      ),
      body: Center(
        child: Theme(
          data: Theme.of(context).copyWith(
            textTheme: TextTheme(
              headline5: TextStyle(
                fontSize: 100.0,
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
          ),
          child: Text(
            'Hello World',
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
      ),
      floatingActionButton: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme.copyWith(secondary: Colors.green),
        ),
        child: FloatingActionButton(
          onPressed: (){
            print('+');
          },
          child: Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}