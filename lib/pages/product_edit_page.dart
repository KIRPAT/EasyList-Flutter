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
  void _submitForm({@required Function formSubmit, int index}){
    //Is the form valid? If not, does not execute the rest of the form.
    if (!_productFormKey.currentState.validate()){return;}
    _productFormKey.currentState.save();

    formSubmit(
      formData: Product( //Map to Product
        title: _formData['title'],
        description: _formData['description'],
        price: _formData['price'],
        image: _formData['image'],
        location: _formData['location']
      ),
      index: index,
    );
    //When done, get back to home.
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
  Widget _titleField (){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ScopedModelDescendant<ProductsModel>(builder: (context, child, model){
        return TextFormField(
          initialValue: model.selectedProductIndex == null ? '' : model.selectedProduct.title,
          decoration: _formInputDecoration('Title'),
          validator: (String value){
            if (value.isEmpty || value.length <= 5)
              return '*Title is required, and it should be at least 5 characters long.';
          },
          onSaved: (String value) {_formData['title'] = value;},
        );
      })
    );
  }

  Widget _descriptionField(){

    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ScopedModelDescendant<ProductsModel>(builder: (BuildContext context, Widget child, ProductsModel model){
        return TextFormField(
          initialValue: model.isSelected ? model.selectedProduct.description : '',
          decoration: _formInputDecoration('Description'),
          maxLines: 4,
          validator: (String value){
            if (value.isEmpty || value.length <= 10)
              return '*Description is required, and it should be at least 10 characters long.';
          },
          onSaved: (String value) {_formData['description'] = value;},
        );
      }),
    );
  }

  Widget _priceField({@required String priceRegExp}){
    return ScopedModelDescendant<ProductsModel>(
      builder:(BuildContext context, Widget child, ProductsModel model){
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: TextFormField(
            initialValue: model.selectedProductIndex == null ? '' : model.selectedProduct.price.toString(),
            decoration: _formInputDecoration('Price'),
            keyboardType: TextInputType.number,
            validator: (String value){
              if (value.isEmpty || !RegExp(priceRegExp).hasMatch(value))
                return 'Price should be a valid number.';
            },
            onSaved: (String value) {_formData['price'] = double.parse(value);},
            //Called NOT on every key stroke, but whenever we call the save() method.
          ),
        );
      }
    );
  }

  Widget _submitButton(){
    return ScopedModelDescendant<ProductsModel>(
      builder: (BuildContext context, Widget child, ProductsModel model){
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 80),
          child: RaisedButton(
            color: Theme.of(context).accentColor,
            onPressed: () => _submitForm(formSubmit: model.formSubmit, index: model.selectedProductIndex),
            child: Text('Submit', style: TextStyle(color: Colors.white)
            ),
          ),
        );
      }
    );
  }

  Widget _form({int selectedIndex, Product selectedProduct}){
    //Media Query (for screen rotation)
    final _width = MediaQuery.of(context).size.width;
    final _targetWidth = _width > 550 ? 500.0 : _width * 0.9;
    final _targetPadding = _width - _targetWidth;

    return Form(
      key: _productFormKey,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: _targetPadding / 1.5),
        children: <Widget>[
          _titleField(),
          _descriptionField(),
          _priceField(priceRegExp: regExpLib['price']),
          _submitButton(),
        ],
      ),
    );
  }

  // RENDERED WIDGET
  Widget _render(context) {
    return GestureDetector(
      onTap: (){FocusScope.of(context).requestFocus(FocusNode());}, //to close keyboard when tap on empty space
      child: Container(
        width: 300,
        child: _form()
      ),
    );
  }

  //BUILD
  Widget build(BuildContext context) {
    return ScopedModelDescendant<ProductsModel>(builder: (BuildContext context, Widget child, ProductsModel model){
      Widget render = _render(context);
      return model.selectedProductIndex == null ? render : Scaffold(appBar: AppBar(title: Text('Edit Product'),), body: render,);;
    },);
  }
}