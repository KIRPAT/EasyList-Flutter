import 'package:flutter/material.dart';

import '../components/ui/side_drawer.dart';
import '../pages/product_create_page.dart';
import '../pages/product_list_page.dart';


class ProductAdminPage extends StatelessWidget {
  Widget _productAdminPageRender(BuildContext context){
    return DefaultTabController(
      length: 2,
      child:  Scaffold(
        drawer: sideDrawer(context),
        appBar: AppBar(
          title: Text('Product Management'),
          bottom: TabBar(tabs: <Widget> [
            Tab(text: 'Create Products', icon: Icon(Icons.create),),
            Tab(text: 'MyProducts', icon: Icon(Icons.view_list),),
          ]),
        ),
        body: TabBarView(children: <Widget>[
          ProductCreatePage(),
          ProductListPage(),
        ]),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _productAdminPageRender(context);
  }
}