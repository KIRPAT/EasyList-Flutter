import 'package:flutter/material.dart';
import './product_edit_page.dart';
import '../models/product_model.dart';
class ProductListPage extends StatelessWidget{
  //Constructor
  final List<Product> products;
  final Function editProduct;
  final Function deleteProduct;
  ProductListPage({this.products, this.editProduct, this.deleteProduct});

  //Widgets
  IconButton _editButton ({@required BuildContext context, @required int index}){
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

  ListTile _listTile({@required BuildContext context, @required int index}) {
    return ListTile(
      leading: CircleAvatar(
      backgroundImage: AssetImage(products[index].image)),
      title: Text(products[index].title),
      subtitle: Text('\$${products[index].price.toString()}'
      ),
      trailing: _editButton(context: context, index: index),
    );
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
          key: Key(products[index].title), //Title is not the best identifier. We need an id
          child: Column(
            children: <Widget>[
              _listTile(context: context, index: index),
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