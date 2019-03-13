import 'package:flutter/material.dart';
import '../styled_text/price_tag.dart';
import '../styled_text/default_product_title.dart';
import '../styled_text/location_tag.dart';
import '../../models/product_model.dart';
/*
  Note_1:
  Following widget carries heavy importance for routing.
  See the following line;
  '/productDetailsPage/' + index.toString()
  Those '/' symbols are FUCKING IMPORTANT.
  I was about to freak out cus my Details page was not loading.

  Navigator.pushNamed<> has a future that returns a generic type that we should specify.

   */
class ProductCard extends StatelessWidget{
  /*
  Passing the whole list to the Product card would be redundant.
  We only need a single map from that list, for each card.
   */
  final Product product;
  final int index;
  ProductCard(this.product, this.index);

  Widget _productCard (BuildContext context){
    return Card(
      child: Column( // Takes more than one child, it takes children! #CaptainObvious
        children: <Widget>[ // This array will only hold Widgets.
          //IMAGE
          Image.asset(product.image),
          //TITLE, PRICE
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: DefaultProductTitle(product.title),
                  constraints:BoxConstraints(maxWidth: 200.0),
                ),
                SizedBox(width: 8.0),
                PriceTag(product.price) //Custom Widget
              ],
            ),
          ),
          //LOCATION
          LocationTag(product.location),
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

  @override
  Widget build(BuildContext context) {
    return _productCard(context);
  }
}