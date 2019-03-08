import 'package:flutter/material.dart';

import '../product_manager.dart';
import '../components/ui/side_drawer.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, dynamic>> products;

  ProductsPage(this.products);

  Widget scaffold(context){
    return Scaffold( // Home is the first widget that get's loaded, Scaffold is AppBar, the white background etc. So? This Scaffhold is the home page.
      drawer: sideDrawer(context),
      appBar: AppBar(
        //leading: IconButton(icon: Icon(Icons.dehaze, color: Colors.white)),
        title: Text("EasyList", style: TextStyle(color: Colors.white),),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite, color: Colors.white,),
            onPressed: (){},
          ),
        ],// AppBar Title
      ),
      body: ProductManager(products),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(context);
  }
}