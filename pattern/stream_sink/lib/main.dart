import 'package:flutter/material.dart ';
import 'package:stream_sink/bloc_login.dart';

void main() async {
  runApp(MyTest());
}

class MyTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MyState();
  }
}

class MyState extends State<MyTest> {
  final myBloc = LoginBLoc();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            myBloc.them();
          },
        ),
        body: Center(
          child: StreamBuilder(
            stream: myBloc.demStream,
            builder: (context, snapshot) => Text(
                snapshot.hasData == null ? "0" : "${snapshot.data.toString()}"),
          ),
        ),
      ),
    );
  }
}
