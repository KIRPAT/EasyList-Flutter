import 'package:flutter/material.dart';

/*
To be more modular, we have cut a widget definition from the main.dart file
And put it here. The Column widget that rendered the products to be precise.
*/
class Products extends StatelessWidget {
  /*
  Yes this is a stateless widget, but if the parent of this Product widget is Stateful,
  this widget will also get re-rendered each time the parent's state change.
  */
  /*
  Look at the code under the build() function. See the product.map(...) function.
  That product should come from the parent.
  So, we need a constructor that takes that info,
  and passes it into *a property* of Product Class before the rendering part even begin.
  */
  //CONSTRUCTOR
  final List<Map<String, String>> products; // First we create the place that holds the product info, the products list. This is *the property* I mentioned.
  final Function deleteProduct;
  Products(this.products,{this.deleteProduct}); // And this is the constructor that takes info from the parent and passes it into the products list.

  //METHODS

  //WIDGETS
  /*
  Note_1:
  Following widget carries heavy importance for routing.
  See the following line;
  '/productDetailsPage/' + index.toString()
  Those '/' symbols are FUCKING IMPORTANT.
  I was about to freak out cus my Details pafe was not loading.
   */
  Widget _buildProductItem(BuildContext context, int index){
    return Card(
      child: Column( // Takes more than one child, it takes children! #CaptainObvious
        children: <Widget>[ // This array will only hold Widgets.
          Image.asset(products[index]['image']),
          Text(products[index]['title']),
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: () => Navigator
                  .pushNamed<bool>( //Push is a generic type, that will eventually return a boolean.
                    context,
                    '/productDetailsPage/' + index.toString()
                   )
                  .then((bool value){ //that boolean
                     if (value){deleteProduct(index);}
                  }),
                child: Text("Details"),
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProductList(){
    if (products.length>0){
      /*
    There is a problem with ListViews alone. They render everything.
    If the amount of things are too much to handle, well, that would suck your CPU/GPU power,
    also keeping everything rendered means you are holding them in the memory.
    Not good for.. for example social media feeds. Hence the following code is irrelevant now.

     return ListView(
      children: products.map((element) => // "map()" function takes the List "elements" one by one...
      Card(
        child: Column( // Takes more than one child, it takes children! #CaptainObvious
          children: <Widget>[ // This array will only hold Widgets.
            Image.asset('assets/lmr.png'),
            Text(element),
          ],
        ),
      )
      ).toList(), //... then maps it "toList()", and returns that list. (returning part is important)
    );
     */
      return ListView.builder(
        itemBuilder: _buildProductItem, //pass the method, but DO NOT EXECUTE with "()"
        itemCount: products.length,
      );
    } else {
      /*
      We can return Container(), but we can not return "null".
      */
      return Center(
          child: Text("No Products to see here.")
      );
    }
  }

  /*
  IMPORTANT
  BuildContext context, knows which page we are and how to navigate around.
  Basically Navigation is tied to context.
   */
  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}