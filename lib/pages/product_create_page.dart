import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
  //CONSTRUCTOR
  final Function addProduct;
  ProductCreatePage(this.addProduct);

  //STATE
  @override
  State<StatefulWidget> createState() {
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage>{
  //STATES
  String _titleValue = 'Yolo'; // You can not render null text. We need an empty one.
  String _descriptionValue;
  double _priceValue = 0.0;
  //METHODS
  /* Note_1 - Modal Example
  void _modal(context){ //modals return future too, if needed.
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: Text('This is a modal.'),
        );
      },
    );
  }

  Widget _render(context){
    return Center(
      child: RaisedButton(
        onPressed: (){
          _modal(context);
        }
      ),
    );
  }

  then BUILD METHOD
  */
  void _addProduct(){
    final Map<String, dynamic> product={
      'title': _titleValue,
      'description': _descriptionValue,
      'price': _priceValue,
      'image': 'assets/lmr.png'
    };
    widget.addProduct(product);
    Navigator.pushReplacementNamed(context, '/home ');
  }
  //WIDGETS
  /*
  This widget became too verbose and redundant.
  I need to create a text input widget and call it here.
   */
  Widget _render(context){
    return Container(
      margin: EdgeInsets.all(10.0),
      child: ListView(
        children: <Widget>[

          //PRODUCT NAME
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'ProductName' ,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
              ),
              onChanged: (String value ){
                setState(() {
                  _titleValue = value;
                });
              },
            ),
          ),

          //DESCRIPTION
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Description' ,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
              ),
              maxLines: 4,
              onChanged: (String value ){
                setState(() {
                  _descriptionValue = value;
                });
              },
            ),
          ),

          //PRICE
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Price' ,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                )
              ),
              keyboardType: TextInputType.number,
              onChanged: (String value){
                setState(() {
                  /*
                  This parts needs to be improved.
                  Write a function that checks if the input is in double format.
                  we need try-catching
                  */
                  _priceValue = double.parse(value);
                });
              },
            ),
          ),

          RaisedButton(
              color: Theme.of(context).accentColor,
              onPressed: _addProduct,
              child: Text('Add Product!'),
          ),
        ],
      ),
    );
  }
  //BUILD
  @override
  Widget build(BuildContext context) {
    return _render(context);
  }
}