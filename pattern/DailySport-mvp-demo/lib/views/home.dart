
import 'package:daily_sport_mvp_flutter/utils/DBmanager.dart';
import 'package:daily_sport_mvp_flutter/model/Record.dart';
import 'package:daily_sport_mvp_flutter/presenters/RecordsHelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  final _globalKey = new GlobalKey<ScaffoldState>();

  //minutes counter
  int _counter = 0;
  //today's total minutes
  int todayTotal = 0;

  void _incrementCounter(){
    setState(() {
      if(_counter == 2000) return;
      _counter++;
    });
  }

  void _decrementCounter(){
    setState(() {
      if(_counter == 0) return;
      _counter--;
    });
  }

  void _saveRecord() {
    if(_counter >= 2) {
      //save counter value
      RecordsHelper.saveRecord(_counter).then((status) {
          //reset views
          setState(() {
            _counter = 0;
          });
          _load();
      });
    } else {
      SnackBar snackbar = new SnackBar(content: Text('At least exercise for 2 minutes!'));
      _globalKey.currentState.showSnackBar(snackbar);
    }
  }

  void _load(){
    //get today's total minutes
    RecordsHelper.getTodayRecords().then((v){
      setState(() {
        todayTotal = v;
      });
    });
  }

  @override
  void initState() {
    super.initState();

    //load data
    _load();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _globalKey,
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Your today total active minutes are:',
            ),
            Text(
              todayTotal.toString()
            ),
            SizedBox(height: 40),
            Text(
              'set how many minutes you have exercised today',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  child: Text('+'),
                  color: Colors.lightGreen,
                  onPressed: _incrementCounter,
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.display1,
                  ),
                ),

                FlatButton(
                  child: Text('-'),
                  color: Colors.deepOrangeAccent,
                  onPressed: _decrementCounter,
                ),
            ],
            ),

            FlatButton(
              child: Text('Save'),
              color: Colors.yellow,
              onPressed: _saveRecord,
            )
          ],
        ),
      ),
    );
  }
}