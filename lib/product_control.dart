import 'package:flutter/material.dart';

class ProductControl extends StatelessWidget {
  /*
  Following constructor takes a function as an argument.
   */
  final Function addProduct;
  ProductControl(this.addProduct);

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      color: Theme.of(context).primaryColor,
      child: Text("Add Product"),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      onPressed: (){
        addProduct("Linuxy");
      },
    );
  }
}