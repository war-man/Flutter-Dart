import 'package:flutter/material.dart';

class ShowTimePickerHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowTimePickerHomePageState();
}

class _ShowTimePickerHomePageState extends State<ShowTimePickerHomePage> {
  TimeOfDay time = TimeOfDay.now();
  Future<Null> selectDate(BuildContext context) async {
    final TimeOfDay? selected =
    await showTimePicker(context: context, initialTime: this.time);

    if (selected != null && selected != this.time) {
      setState(() {
        this.time = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Demo showTimePicker()'),
    ),
    body: Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Text('Waktu yang dipilih: ${this.time.toString()}'),
          RaisedButton(
            child: Text('Pilih Waktu'),
            onPressed: () {
              selectDate(context);
            },
          )
        ],
      ),
    ),
  );
}