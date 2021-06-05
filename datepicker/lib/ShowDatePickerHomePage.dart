import 'package:flutter/material.dart';

class ShowDatePickerHomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShowDatePickerHomePageState();
}

class _ShowDatePickerHomePageState extends State<ShowDatePickerHomePage> {
  DateTime date = DateTime.now();

  Future<Null> selectedDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
        context: context,
        initialDate: this.date,
        firstDate: DateTime(2019),
        lastDate: DateTime(2129));

    if (selected != null && selected != this.date) {
      setState(() {
        this.date = selected;
      });
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text('Demo showDatePicker()'),
    ),
    body: Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        children: <Widget>[
          Text('Tanggal yang dipilih: ${this.date.toString()}'),
          // ignore: deprecated_member_use
          RaisedButton(
            child: Text('Pilih Tanggal'),
            onPressed: () {
              selectedDate(context);
            },
          )
        ],
      ),
    ),
  );
}