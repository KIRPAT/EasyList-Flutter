import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

import './components/cards/product_card.dart';
import './scoped-models/products_scoped_model.dart';
import './models/product_model.dart';
class Products extends StatelessWidget {
  //CONSTRUCTOR (We don't need one, not anymore. Take a look at the build method, you will see the ScopedModelDescendant )

  //WIDGETS
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

  Update_1 - List builder got outsourced!

  This is the old product card builder. Now we are outsourcing it to another file, and calling it from there.
  That widget is not taking the entire List, only one particular map from that list according to the "index".

  Widget _buildProductItem(BuildContext context, int index){
    return Card(
      child: Column( // Takes more than one child, it takes children! #CaptainObvious
        children: <Widget>[ // This array will only hold Widgets.
          //IMAGE
          Image.asset(products[index]['image']),
          //TITLE, PRICE
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Text(
                    products[index]['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20.0,
                        fontFamily: 'Oswald'
                    ),
                  ),
                  constraints:BoxConstraints(maxWidth: 200.0),
                ),
                SizedBox(width: 8.0),
                PriceTag(products[index]['price']) //Custom Widget
            ],),
          ),
          //LOCATION
          DecoratedBox(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 4),
              child: Text(products[index]['location']),
            ),
            decoration: BoxDecoration(
              border:Border.all(),
              borderRadius: BorderRadius.circular(5.0)
            ),
          ),
          //BUTTON
          ButtonBar(
            alignment: MainAxisAlignment.center,
            children: <Widget>[
              /*
              Push is a generic type,
              that will eventually return a boolean as a future.
              (When the pushed page is popped.)
              You can chain a .then(...) for that boolean, if you want.
              */
              IconButton(
                onPressed: () => Navigator.pushNamed<bool>(context,'/productDetailsPage/' + index.toString()),
                icon: Icon(Icons.info, color: Colors.blue,),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.favorite_border, color: Colors.pinkAccent,),
              )
            ],
          ),
        ],
      ),
    );
  }
   */
  ListView _products({@required List<Product> products}){
    return ListView.builder(
      itemBuilder: (BuildContext context, int index) =>
          ProductCard(products[index], index),
      itemCount: products.length,
    );
  }

  //Rendered Widget
  Widget _render(List<Product>products){
    return products.length > 0 ? _products(products: products) : Center(child: Text("No Products to see here."));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(
      builder:(BuildContext context, Widget child, ProductsModel model){
        return _render(model.products);
      },
    );
  }
}