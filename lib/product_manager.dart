//Packages
import 'package:flutter/material.dart';

//Widgets we wrote
import './products.dart';

import 'package:flutter_course/components/buttons/accent_button.dart';
/* Note_1
What's going on here?
Short answer: Stateless Widget 1 > Stateful Widget > Stateless Widget 2
SW2 can make SflW render itself again, even though SW1, a stateless widget is SflW's parent.

Long answer: The body from of MyApp>home>body is entirely became the ProductManager, a stateful widget.
And the product manager's product rendering code is no longer residing here,
we also made yet another widget in another file (products.dart) and called it from here.
MyApp is no longer the parent of Products, ProductManager is.
The MyApp is now the root of the entire App and the parent of ProductManager instead.
*/
class ProductManager extends StatelessWidget{
  //CONSTRUCTOR
  final List<Map<String,String>> products;
  final Function addProduct;
  final Function deleteProduct;
  ProductManager(this.products, this.addProduct, this.deleteProduct);

  //WIDGETS
  Widget productManagerRender(){
    return Column( // A Button at the top, and the rest is a Column of Cards.
      children: [
       Container( // Container of the button
          margin: EdgeInsets.all(10.0),
          child: AccentButton(
            buttonName: "Add Product",
            buttonPress: addProduct,
            data: {'title':'Chocolate','image':'assets/lmr.png'},
          ), // ProductControl widget can now use _addProduct method.
        ),
        /*
        ListView requires a certain "height".
        Either a container with height value,
        or a Expanded widget that takes all the remaining height.
        */
        Expanded( // products.dart
            child: Products(products, deleteProduct: deleteProduct)
        ), // The Product widget that we defined in the. (Look how shorter it is now. <3)
      ],
    );
  }

  //BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return productManagerRender();
  }
}