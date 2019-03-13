import 'package:flutter/material.dart';

import '../product_manager.dart';
import '../components/ui/side_drawer.dart';

class ProductsPage extends StatelessWidget {

  Widget scaffold(context){
    return Scaffold( // Home is the first widget that get's loaded, Scaffold is AppBar, the white background etc. So? This Scaffhold is the home page.
      drawer: sideDrawer(context),
      appBar: AppBar(
        title: Text("EasyList", style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white,),
            onPressed: (){},
          ),
        ],// AppBar Title
      ),
      body: ProductManager(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(context);
  }
}