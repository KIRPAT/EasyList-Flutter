//Libraries
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//Scoped-Model model.
import '../scoped-models/products_scoped_model.dart';
//Models
import '../models/product_model.dart';
//Pages
import './product_edit_page.dart';

class ProductListPage extends StatelessWidget{
  //Constructor

  //Widgets
  Widget _editButton ({@required BuildContext context, @required int index}){
    return ScopedModelDescendant<ProductsModel>(builder: (context, child, model) {
      return IconButton(
        icon: Icon(Icons.edit), onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) {
              model.selectProduct(index: index);
              return ProductEditPage();
            },
          ));
        },
      );
    });
  }

  ListTile _listTile({@required BuildContext context, @required int index, @required Product product}) {
    return ListTile(
      leading: CircleAvatar(
      backgroundImage: AssetImage(product.image)),
      title: Text(product.title),
      subtitle: Text('\$${product.price.toString()}'
      ),
      trailing: _editButton(context: context, index: index),
    );
  }
  //Style

  //Rendered Widgets
  Widget _render (){
    return ScopedModelDescendant<ProductsModel>(builder: (BuildContext context, Widget child, ProductsModel model){
      return ListView.builder(
        itemBuilder: (BuildContext context, int index){
          return Dismissible(
            direction: DismissDirection.startToEnd,
            onDismissed: (DismissDirection direction){
              model.deleteProduct(index: index);
              },
            background: Container(color: Colors.red[200]),
            key: Key(model.products[index].title), //Title is not the best identifier. We need an id
            child: Column(
              children: <Widget>[
                _listTile(context: context, index: index, product: model.products[index]),
                Divider(),
              ],
            ),
          );
        },
        itemCount: model.products.length,
      );
    },);
  }

  //Build Method
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _render();
  }
}