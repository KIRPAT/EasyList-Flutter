import 'package:flutter/material.dart';

import '../components/ui/side_drawer.dart';
import '../pages/product_edit_page.dart';
import '../pages/product_list_page.dart';


class ProductAdminPage extends StatelessWidget {
  //CONSTRUCTOR
  final Function addProduct;
  final Function deleteProduct;
  final Function editProduct;
  final List<Map<String, dynamic>> products;
  ProductAdminPage({this.addProduct, this.deleteProduct, this.products, this.editProduct});

  //WIDGETS
  Widget _productAdminPageRender(BuildContext context){
    return Container(
      child: DefaultTabController(
        length: 2,
        child:  Scaffold(
          drawer: sideDrawer(context),
          appBar: AppBar(
            title: Text('Product Management', style: TextStyle(color: Colors.white),),
            bottom: TabBar(
              indicatorColor: Colors.white,
              tabs: <Widget> [
                Tab(icon: Icon(Icons.create, color: Colors.white,),),
                Tab(icon: Icon(Icons.view_list, color: Colors.white,),),
              ],
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              ProductEditPage(addProduct: addProduct, isAddButton: true,), //For adding Product
              ProductListPage(products: products, editProduct: editProduct, deleteProduct: deleteProduct),
            ]
          ),
        )
      ),
    );
  }

  //BUILD
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _productAdminPageRender(context);
  }
}