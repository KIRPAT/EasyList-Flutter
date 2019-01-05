import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget{
  Widget authPageRender(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("login"),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('login'),
          onPressed: (){
            Navigator.pushReplacementNamed(context, '/productsPage');
          }
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return authPageRender(context);
  }
}