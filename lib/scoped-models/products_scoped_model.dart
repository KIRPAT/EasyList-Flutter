import 'package:scoped_model/scoped_model.dart';
import '../models/product_model.dart';

/*
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
 */
class ProductsModel extends Model {
  List<Product> _products =[];

  List<Product> get products {
    return List.from(_products);
  }

  void addProduct(Product product){
    _products.add(product);
  }

  void deleteProduct(int index){
    _products.removeAt(index);
  }

  void updateProduct({int index, Product product}){
    _products[index] = product;
  }
}