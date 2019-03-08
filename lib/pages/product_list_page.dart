import 'package:flutter/material.dart';
import './product_edit_page.dart';

class ProductListPage extends StatelessWidget{
  //Constructor
  final List<Map<String, dynamic>> products;
  final Function editProduct;
  final Function deleteProduct;
  ProductListPage({this.products, this.editProduct, this.deleteProduct});
  //Methods

  //Widgets
  IconButton _editButton ({BuildContext context, int index}){
    return IconButton(icon: Icon(Icons.edit),onPressed: (){
      Navigator.of(context).push(MaterialPageRoute(
        builder: (BuildContext context){
          return ProductEditPage(
            product: products[index],
            updateProduct: editProduct,
            isAddButton: false,
            productIndex: index,
          );
        },
      ));
    },);
  }
  //Style

  //Rendered Widgets
  Widget _render (){
    return ListView.builder(
      itemBuilder: (BuildContext context, int index){
        return Dismissible(
          direction: DismissDirection.startToEnd,
          onDismissed: (DismissDirection direction){deleteProduct(index);},
          background: Container(color: Colors.red[200]),
          key: Key(products[index]['title']),
          child: Column(
            children: <Widget>[
              ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage(products[index]['image'])),
                  title: Text(products[index]['title']),
                  subtitle: Text('\$${products[index]['price'].toString()}'
                ),
                trailing: _editButton(context: context, index: index),
              ),
              Divider(),
            ],
          ),
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