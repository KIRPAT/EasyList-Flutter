import 'package:flutter/material.dart';

Widget sideDrawer(BuildContext context, {Color color = Colors.white}){
  return Drawer(
    child: Column(
      children: <Widget>[
        AppBar(title: Text('Choose!',style: TextStyle(color: color),), automaticallyImplyLeading: false,),
        ListTile(
          leading: Icon(Icons.home),
          title: Text('Products'),
          subtitle: Text('List of all products.'),
          onTap: (){
            Navigator.pushReplacementNamed(context, '/home');
          },
        ),
        ListTile(
          leading: Icon(Icons.mode_edit),
          title: Text('Manage Products'),
          subtitle: Text('Add new ones.'),
          onTap: (){
            Navigator.pushReplacementNamed(context, '/adminPage');
          },
        ),
        Container(
          height: 0.5,
          width: 100,
          color: Colors.black,
        ),
        ListTile(
          leading: Icon(Icons.adb),
          title: Text('AuthPage'),
          subtitle: Text('No validation yet, DEV only.'),
          onTap: (){
            Navigator.pushReplacementNamed(context, '/');
          },
        ),
      ],
    ),
  );
}