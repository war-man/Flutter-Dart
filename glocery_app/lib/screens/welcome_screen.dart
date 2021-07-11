import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:glocery_app/screens/onboard_screen.dart';

class WelcomeScreen extends StatelessWidget {
  bool _validphoneNumber = false;

  void showBottomSheet(context){
    showModalBottomSheet(context: context, builder: (context) =>
      StatefulBuilder(builder: (context,StateSetter myState){
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('LOGIN',style: TextStyle(fontSize: 25),),
                Text('Enter your phone number to process',style: TextStyle(fontSize: 13, color: Colors.grey),),
                SizedBox(height: 20,),
                TextField(
                    decoration: InputDecoration(
                      prefixText: '+91',
                      labelText: '10 digit phone number',
                    ),
                    autofocus: true,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    onChanged: (value){
                      if(value.length==10){
                        myState((){
                          _validphoneNumber =true;
                        });
                      }else{
                        myState((){
                          _validphoneNumber =false;
                        });
                      }
                    }
                ),
                SizedBox(height: 10,),
                Row(children:[
                  Expanded(
                    child: AbsorbPointer(
                      absorbing: _validphoneNumber ? false : true,
                      child: TextButton(
                        onPressed: (){},
                        child: Text(!_validphoneNumber?'ENTER PHONE NUMBER':'CONTINUE'),
                        style: TextButton.styleFrom(primary: _validphoneNumber ? Theme.of(context).primaryColor: Colors.grey),),
                    ),
                  )
                ] )
              ],
            ),
          ),
        );
        }
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          children: [
            Positioned(child: TextButton(
              onPressed: () {  },
              child: Text("SKIP"),
              style: TextButton.styleFrom(primary: Colors.deepOrangeAccent),
            ),
            right: 0.0,
            top: 10.0,),
            Column(
              children: [
                Expanded(child: OnBoardScreen()),
                Text("Ready to order from your nearest shop"),
                SizedBox(height: 20,),
                TextButton(
                  onPressed: (){

                  },
                  child: Text('SET DELIVERY LOCATION'),
                  style: TextButton.styleFrom(
                      primary: Colors.black
                  ),
                ),
                SizedBox(height: 20),
                TextButton(
                  onPressed: () { showBottomSheet(context); },
                  child: RichText(text: TextSpan(
                      text: "Already a Customer ?",
                      style: TextStyle(fontWeight: FontWeight.w700, color: Colors.deepOrange),
                      children: [
                        TextSpan(
                            text: 'Login', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blueAccent)
                        )
                      ]
                  ),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
