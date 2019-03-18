import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../models/product_model.dart';

/*
NOTE_0: KEEP THE LOGIC HERE TOO
This is important. Being able to holding all the states here is great. But there is also another thing you need to remember;
Keep the logic here too! Keep the business logic separated from the presentation logic. Otherwise things got bloated real quick.

NOTE_ 1:
About the old private variables and functions,
they are different now.

I used to define methods using the underscore, "_", in front of them.
But they were in the main method back then.
Now they should be accessible since we are defining them in the class, and calling the class from outside.

_products stays the same though.
We don't want unauthorized tempering from outside.
Only the public methods we defined, such as "addProduct",
should be able to modify the data.

The problem is.. even though the _products can not be tempered with,
it is also can not be red from outside.
That's why we need a "getter method",
to show outside the products list.

thanks to getter we can call the methods by simply typing.
leProductsModel.products

Note_2:
List.from(<insert list here>)
Does not return the address of the _products,
Creates a copy of the products in the memory and returns it instead.

PS: Use the fat arrow notation as mush as possible, will you?

Note_3: Since I'm planning to ditch Scoped Model for Redux in the future, gonna add a reminder to myself.
----------------------
Scoped Model --> Redux
----------------------
State => Store
State Getter => Provider
Methods => Reducer
 */
class ProductsModel extends Model {
  //State
  List<Product> _products =[];
  int _selectedProductIndex;

  //State Getters
  List<Product> get products => List.from(_products);
  bool get isSelected => _selectedProductIndex == null ? false : true;
  int get selectedProductIndex => _selectedProductIndex == null ? null : _selectedProductIndex;
  Product get selectedProduct => selectedProductIndex== null ? null : _products[_selectedProductIndex]; // I do not want to pass the whole products list each time I need one item.

  //METHODS
  //Manipulators (Widget-agnostic, low level state changers. You can call them from any widget.)
  void addProduct({@required Product product}) => _products.add(product);
  void deleteProduct({@required int index}) {
    this.selectProduct(index: index);
    this._products.removeAt(_selectedProductIndex);
    this._selectedProductIndex = null;
  }
  void updateProduct({@required Product product, @required index}) {
    this.selectProduct(index: index);
    _products[_selectedProductIndex] = product;
    _selectedProductIndex = null;
  }
  void selectProduct({@required int index}) => _selectedProductIndex = index;

  //Business Logic (Widget-bound, business logic. Tailor made for specific widgets.)
  //ProductEditPage Business Logic
  void formSubmit({@required Product formData, int index}) {
    selectedProductIndex == null ? this.addProduct(product: formData) : this.updateProduct(product: formData, index: index);
  }
}

