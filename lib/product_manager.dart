//Packages
import 'package:flutter/material.dart';

//Widgets we wrote
import './products.dart';

import './product_control.dart';
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
class ProductManager extends StatefulWidget{
  /* Note_1
  Let's assume we are pulling some data from outside for our stateful widget.
  We don not do that from the State itself (for some reason)
  Instead, we take that data in the StatefulWidget first,
  then pass it into the State. For more info, goTo => ProductManagerState, Note_3
  */
  final String startingProduct;
  ProductManager({this.startingProduct});
  /*
  If you don't wanna pass data to constructor,
  or
  Pass custom default data if the constructor left empty
  Place curly bracelets around the constructor.
  ProductManager({this.startingProduct="Linux Placeholder"});
  */
  @override
  State<StatefulWidget> createState() {
    return _ProductManagerState();
  }
}

class _ProductManagerState extends State<ProductManager> {
  //STATES
  /* Note_1
  A State Widget has a build() method, but It must be connected to a StatefulWidget to do it's job.
  (That stateful widget is the ProductManager in this case.)

  Note_2
  From here to the @override, we will store State Data.
  Note: By default flutter does not know that the following data are states, so it doesn't watch them.
  Why? Cus doing so would be inefficient.
  What if some data never changes, we initialize them at the beginning and never look back,
  but we still watch them anyway? We would be wasting resources.
  So? We add setState((){}) or getState() functions to make that connection. (If needed.)

  Note_3
  We used a dummy List here before;
  List<String> _products = ['Food Tester'];
  But we hard coded it here. What if we needed to pass it from outside?
  We can create a constructor for the Stateful Widget adn pass it into the state,
  but that approach is cumbersome.

  We need a better approach. We can actually directly access into the Stateful Widget properties
  from the state. an that is initState().
   */
  List<String> _products = [];

  //STATE CHANGERS
  /*
  initState is only called whenever the State is first created.
  Remember, changing states are only stored here, in the State, not in the Stateful Widget.
  Stateful Widget can also store data but it doesn't change (unless the parent stateful widget asks for a re-render)
  It passes the data through the initState() function and be done with it.

  For this case, if we were to pass no data, that would main startingProduct property in the Product Manager state would be null.
  You can not add "null" to a string array. That would cause an error.
  So we made an if condition in the initState for that job.
   */
  @override
  void initState() {
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
    super.initState();
  }
  /*
  What if I wanted the "Add Product" button outside,
  and use it from somewhere else to add products into Product Manager state.
  Think of it as adding a product to shopping cart
  without being on the ShoppingCart state.
   */
  void _addProduct(String product){
    setState((){ // Since the state got changed through setState() function, this Widget will be rendered again.
      _products.add(product);
    });
  }

  //WIDGETS
  Widget productManagerRender(){
    return Column( // A Button at the top, and the rest is a Column of Cards.
      children: [
        Container( // Container of the button
          margin: EdgeInsets.all(10.0),
          child: ProductControl(_addProduct), // ProductControl widget can now use _addProduct method.
        ),
        /*
        ListView requires a certain "height".
        Either a container with height value,
        or a Expanded widget that takes all the remaining height.
        */
        Expanded(
            child: Products(_products)
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