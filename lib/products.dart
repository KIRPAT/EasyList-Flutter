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
  final List<String> products; // First we create the place that holds the product info, the products list. This is *the property* I mentioned.
  Products(this.products); // And this is the constructor that takes info from the parent and passes it into the products list.

  Widget _buildProductItem(BuildContext context, int index){
    return Card(
      child: Column( // Takes more than one child, it takes children! #CaptainObvious
        children: <Widget>[ // This array will only hold Widgets.
          Image.asset('assets/lmr.png'),
          Text(products[index]),
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

  //Keep the build method clean.
  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}