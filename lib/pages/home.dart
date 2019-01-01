import 'package:flutter/material.dart';
import '../product_manager.dart';

class HomePage extends StatelessWidget {
  Widget scaffold(){
    return Scaffold( // Home is the first widget that get's loaded, Scaffhold is AppBar, the white background etc. So? This Scaffhold is the home page.
      appBar: AppBar(
        title: Text("EasyList"), // AppBar Title
      ),
      body: ProductManager(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold();
  }
}