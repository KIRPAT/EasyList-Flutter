import 'package:flutter/material.dart';

class PriceTag extends StatelessWidget{
  //Constructor
  final double price;
  PriceTag(this.price);

  //Widgets
  Widget _priceTag (BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 2.0),
      padding: EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5.0),
        color: Theme.of(context).accentColor,
      ),
      child: Text(
        price.toString() + ' TL',
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  //BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return _priceTag(context);
  }
}