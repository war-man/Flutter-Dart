import 'package:flutter/material.dart';

const kTitle = 'Drawer';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                kTitle,
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.title!.fontSize,
                  color: Colors.white,
                ),
              ),
            ),
            decoration: BoxDecoration(
              color: Colors.teal,
            ),
          ),
          getListTile('Home',context),
          getLine(),
          getListTile('About',context),
          getLine(),
          getListTile('Settings',context),
        ],
      ),
    );
  }

  Widget getLine() {
    return SizedBox(
      height: 0.5,
      child: Container(
        color: Colors.grey,
      ),
    );
  }

  Widget getListTile(title,BuildContext context ) {
    print(title);
    return ListTile(
      title: Text(title),
      onTap: () {
        if(title == 'Home'){
          Navigator.pushReplacementNamed(context, '/');
        }
        if(title == 'About'){
          Navigator.pushReplacementNamed(context, '/about');
        }
        if(title == 'Settings'){
          Navigator.pushReplacementNamed(context, '/settings');
        }
        print("Click");
      },
    );
  }
}