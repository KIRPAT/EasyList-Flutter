import 'package:flutter/material.dart';
import './product_edit_page.dart';

class ProductListPage extends StatelessWidget{
  //Constructor
  final List<Map<String, dynamic>> products;
  final Function editProduct;
  ProductListPage(this.products, this.editProduct);
  //Methods
  //Widgets

  //Style

  //Rendered Widgets
  Widget _render (){
    return ListView.builder(
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          leading: CircleAvatar(
            child: Image.asset(products[index]['image'])),
          title: Text(products[index]['title']),
          trailing: Icon(Icons.edit),
          onTap: (){
            Navigator.of(context).push(MaterialPageRoute(
              builder: (BuildContext context){
                return ProductEditPage(product: products[index], updateProduct: editProduct, isAddButton: false, productIndex: index,);
              },
            ));
          },
        );
      },
      itemCount: products.length,
    );
  }
  //Build Method
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _render();
  }
}