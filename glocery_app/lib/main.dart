import 'dart:async';

import 'package:flutter/material.dart';

import 'package:glocery_app/screens/welcome_screen.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.deepOrangeAccent
      ),
      home: SplashScreen(),
    );
  }
}
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    print("SplashScreen Starting ....");
    Timer(
      Duration(
        seconds: 10
      ),(){
        Navigator.pushReplacement(context,MaterialPageRoute(
            builder: (context) => WelcomeScreen()
            )
        );
      }
    );
    print("SplashScreen Closing ....");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('images/logo.png'),
              Text("Glocery App")
            ],
          )
      ),
    );
  }
}

