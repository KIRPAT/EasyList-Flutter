import 'package:flutter/material.dart';

Widget sideDrawer(BuildContext context){
  return Drawer(child: Column(children: <Widget>[
    AppBar(title: Text('Choose!'), automaticallyImplyLeading: false,),
    ListTile(title: Text('Products'), subtitle: Text('yolo'),
      onTap: (){
        Navigator.pushReplacementNamed(context, '/');
      },
    ),
    ListTile(title: Text('Manage Products'), subtitle: Text('yolo'),
      onTap: (){
        Navigator.pushReplacementNamed(context, '/adminPage');
      },
    ),
  ],),);
}