import 'package:bloc_plain/color_bloc.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ColorBloc bloc = ColorBloc();

  @override
  void dispose() {
    // ignore: unnecessary_statements
    bloc.dispose;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("BLoc tanpa Library"),
        ),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              backgroundColor: Colors.amber,
              onPressed: () {
                bloc.eventSink.add(ColorEvent.to_amber);
              },
            ),
            SizedBox(
              width: 10,
            ),
            FloatingActionButton(
              backgroundColor: Colors.lightBlue,
              onPressed: () {
                bloc.eventSink.add(ColorEvent.to_lightblue);
              },
            ),
          ],
        ),
        body: Center(
          child: StreamBuilder(
              stream: bloc.stateStream,
              initialData: Colors.amber,
              builder: (context, snapshot) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 500),
                  width: 100,
                  height: 100,
                  color: snapshot.data,
                );
              }),
        ),
      ),
    );
  }
}
