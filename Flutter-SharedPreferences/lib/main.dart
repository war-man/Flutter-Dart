import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  TextEditingController controller = TextEditingController(text: "No Name");
  bool isON = false;

  void saveData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString("nama", controller.text);
    pref.setBool("ison", isON);
  }

  Future<String> getNama() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("nama") ?? "No Name";
  }

  Future<bool> getIsON() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getBool("ison") ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Shared Preference Exampe"),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextField(
                controller: controller,
              ),
              Switch(
                  value: isON,
                  onChanged: (newValue) {
                    setState(() {
                      isON = newValue;
                    });
                  }),
              RaisedButton(
                onPressed: () {
                  saveData();
                },
                child: Text("Save"),
              ),
              RaisedButton(
                onPressed: () {
                  getNama().then((value) {
                    controller.text = value;
                    setState(() {});
                  });
                  getIsON().then((value) {
                    isON = value;
                    setState(() {});
                  });
                },
                child: Text("Load"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
