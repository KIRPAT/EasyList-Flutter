import 'package:flutter/material.dart';

class Products extends StatelessWidget {
  //CONSTRUCTOR
  final List<Map<String, String>> products; // First we create the place that holds the product info, the products list. This is *the property* I mentioned.
  final Function deleteProduct;
  Products(this.products,{this.deleteProduct}); // And this is the constructor that takes info from the parent and passes it into the products list.

  //WIDGETS
  /*
  Note_1:
  Following widget carries heavy importance for routing.
  See the following line;
  '/productDetailsPage/' + index.toString()
  Those '/' symbols are FUCKING IMPORTANT.
  I was about to freak out cus my Details page was not loading.

  Navigator.pushNamed<> has a future that returns a generic type that we should specify.

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
                     if (value){deleteProduct(index);} //if true, delete away the product
                  }),
                child: Text("Details"),
              )
            ],
          ),
        ],
      ),
    );
  }

  /*
  Note_1 - Large ListViews can eat your RAM and CPU, slow down your phone.
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

  Note_2 - Widgets CAN NOT render null!
  We can return an empty Container(), but we can not return "null".

  Note_3 - Context carries your current location.
  BuildContext context, knows which page we are and how to navigate around.
  Basically Navigation is tied to context.
   */
  Widget _buildProductList(){
    if (products.length>0){
      return ListView.builder(
        itemBuilder: _buildProductItem, //pass the method, but DO NOT EXECUTE with "()"
        itemCount: products.length,
      );
    } else {
      return Center(
          child: Text("No Products to see here.")
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return _buildProductList();
  }
}