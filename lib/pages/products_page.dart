import 'package:flutter/material.dart';

import '../product_manager.dart';

class ProductsPage extends StatelessWidget {
  final List<Map<String, String>> products;
  final Function addProduct;
  final Function deleteProduct;
  ProductsPage(this.products, this.addProduct, this.deleteProduct);

  Widget scaffold(context){
    return Scaffold( // Home is the first widget that get's loaded, Scaffhold is AppBar, the white background etc. So? This Scaffhold is the home page.
      drawer: Drawer(child: Column(children: <Widget>[
        AppBar(title: Text('Choose!'), automaticallyImplyLeading: false,),
        ListTile(title: Text('Manage Products'), subtitle: Text('yolo'),
          onTap: (){
            Navigator.pushReplacementNamed(context, '/adminPage');
          },
        )
      ],),),
      appBar: AppBar(
        title: Text("EasyList"), // AppBar Title
      ),
      body: ProductManager(products, addProduct, deleteProduct),
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(context);
  }
}