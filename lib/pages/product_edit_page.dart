//Flutter/Dart Imports
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
//Helpers
import '../helpers/RegExpLib.dart';
//Model Imports
import '../models/product_model.dart';
//Scoped Models
import '../scoped-models/products_scoped_model.dart';

class ProductEditPage extends StatefulWidget {
  //CONSTRUCTOR
  final Function addProduct;
  final Function updateProduct;
  final Function deleteProduct;
  final int productIndex;
  final bool isAddButton;
  final Product product;
  ProductEditPage({this.addProduct, this.deleteProduct, this.updateProduct, this.product, this.isAddButton=false, this.productIndex});

  //STATE
  @override
  State<StatefulWidget> createState() {
    return _ProductEditPageState();
  }
}

class _ProductEditPageState extends State<ProductEditPage>{
  //STATES
  final Map<String, dynamic> _formData={
    'title': null,
    'description': null,
    'price': null,
    'image': 'assets/lmr.png',
    'location': 'İstanbul, Taksim',
  };

  final GlobalKey<FormState> _productFormKey = new GlobalKey<FormState>();
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
  void _submitForm(Function addProduct, Function updateProduct){
    //if the validation returns false do not save
    if (!_productFormKey.currentState.validate()){return;}
    _productFormKey.currentState.save();

    if(widget.isAddButton == true)
      addProduct(
        Product( //Map to Product
          title: _formData['title'],
          description: _formData['description'],
          price: _formData['price'],
          image: _formData['image'],
          location: _formData['location']
        )
      );
    else updateProduct(
      index: widget.productIndex,
      product:  Product( //Map to Product
          title: _formData['title'],
          description: _formData['description'],
          price: _formData['price'],
          image: _formData['image'],
          location: _formData['location']
      )
    );
    Navigator.pushReplacementNamed(context, '/home ');
  }

  //STYLE
  InputDecoration _formInputDecoration(String labelText) {
    return  InputDecoration(
      labelText: labelText ,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      )
    );
  }

  //WIDGETS
  Widget _titleField (bool doesProductExist){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: doesProductExist == false ? '' : widget.product.title,
        decoration: _formInputDecoration('Title'),
        validator: (String value){
          if (value.isEmpty || value.length <= 5) {
            return '*Title is required, and it should be at least 5 characters long.';
          }
        },
        onSaved: (String value) { //Called NOT on every key stroke, but whenever we call the save() method.
          _formData['title'] = value;
        },
      ),
    );
  }

  Widget _descriptionField(bool doesProductExist){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: doesProductExist == false ? '' : widget.product.description,
        decoration: _formInputDecoration('Description'),
        maxLines: 4,
        validator: (String value){
          if (value.isEmpty || value.length <= 10) {
            return '*Description is required, and it should be at least 10 characters long.';
          }
        },
        onSaved: (String value) { //Called NOT on every key stroke, but whenever we call the save() method.
          _formData['description'] = value;
        },
      ),
    );
  }

  Widget _priceField(bool doesProductExist, String priceRegExp){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: doesProductExist == false ? '' : widget.product.price.toString(),
        decoration: _formInputDecoration('Price'),
        keyboardType: TextInputType.number,
        validator: (String value){
          if (value.isEmpty || !RegExp(priceRegExp).hasMatch(value)) {
            return 'Price should be a valid number.';
          }
        },
        onSaved: (String value) { //Called NOT on every key stroke, but whenever we call the save() method.
          _formData['price'] = double.parse(value);
        },
      ),
    );
  }

  Widget _submitButton(String _buttonText, bool doesProductExist){
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model){
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 80),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: () => _submitForm(model.addProduct, model.updateProduct),
            child: Text(
                _buttonText,
                style: TextStyle(color: Colors.white)
            ),
          ),
        );
      }
    );
  }

  Widget _form(){
    //RegExp
    final String priceRegExp = regLib['price'];
    //Media Query (for screen rotation)
    final _width = MediaQuery.of(context).size.width;
    final _targetWidth = _width > 550 ? 500.0 : _width * 0.9;
    final _targetPadding = _width - _targetWidth;
    String _buttonText;
    bool doesProductExist;

    if (widget.isAddButton){_buttonText = 'Add Product';}
      else {_buttonText = 'Submit Changes';}
    if (widget.product == null){doesProductExist = false;}
      else doesProductExist = true;

      return Form(
      key: _productFormKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: _targetPadding / 1.5),
        children: <Widget>[
          _titleField(doesProductExist),
          _descriptionField(doesProductExist),
          _priceField(doesProductExist, priceRegExp),
          _submitButton(_buttonText, doesProductExist),
        ],
      ),
    );
  }
  /*
  This widget became too verbose and redundant.
  I need to create a text input widget and call it here.
   */
  // RENDERED WIDGET
  Widget _render(context){
    return GestureDetector(
      onTap: (){FocusScope.of(context).requestFocus(FocusNode());}, //to close keyboard when tap on empty space
      child: Container(
        width: 300,
        child: _form(),
      ),
    );
  }
  //BUILD
  @override
  Widget build(BuildContext context) {
    return widget.product == null ? _render(context) : Scaffold(appBar: AppBar(title: Text('Edit Product'),), body: _render(context),);
  }
}