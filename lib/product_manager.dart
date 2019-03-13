//Packages
import 'package:flutter/material.dart';

//Widgets we wrote
import './products.dart';
import './models/product_model.dart';

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
    //WIDGETS
  Widget productManagerRender(){
    return Column( // Used to be a button at the top, and the rest was a Column of Cards. Now there are only cards.
      children: [
        Expanded(child: Products()), // The Product widget that we defined in the. (Look how shorter it is now. <3)
      ],
    );
  }

  //BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return productManagerRender();
  }
}