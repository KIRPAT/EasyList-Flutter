import 'package:flutter/material.dart';

import './pages/auth_page.dart';
import './pages/product_admin_page.dart';
import './pages/products_page.dart';
import './pages/product_details_page.dart';

main() => runApp(MyApp());
/*
Stateless Widgets are permanent after the first time they got loaded. You can not change their content.
On the other hand, if the parent widget is stateful, they also get re-rendered.

MyApp was a stateful widget once, but we made some of it's children stateful.
Now their children gets re-rendered whenever their state changes.
But MyApp stays the same.
(Unless we make yet another Stateful widget it's parent.
Then the MyApp gets re rendered each time it's parent's state change.)
*/
class MyApp extends StatefulWidget {
  /* Note_1
  Let's assume we are pulling some data from outside for our stateful widget.
  We don not do that from the State itself (for some reason)
  Instead, we take that data in the StatefulWidget first,
  then pass it into the State. For more info, goTo => ProductManagerState, Note_3
  */
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp>{
  //STATES
  /* Note_1 - Stateful Widget - State
  A State Widget has a build() method, but It must be connected to a StatefulWidget to do it's job.
  (That stateful widget is the ProductManager in this case.)

  Note_2 - State Data
  From here to the @override, we will store State Data.
  Note: By default flutter does not know that the following data are states, so it doesn't watch them.
  Why? Cus doing so would be inefficient.
  What if some data never changes, we initialize them at the beginning and never look back,
  but we still watch them anyway? We would be wasting resources.
  So? We add setState((){}) or getState()? functions to make that connection. (If needed.)

  Note_3 - initState()
  We used a dummy List here before;
  List<String> _products = ['Food Tester'];
  But we hard coded it here. What if we needed to pass it from outside?
  We can create a constructor for the Stateful Widget and pass it into the state,
  but that approach is cumbersome.

  We need a better approach. We can actually directly access into the Stateful Widget properties
  from the state. an that is initState().

  initState is only called whenever the State is first created.
  Remember, changing states are only stored here, in the State, not in the Stateful Widget.
  Stateful Widget can also store data but it doesn't change (unless the parent stateful widget asks for a re-render)
  It passes the data through the initState() function and be done with it.

  For this case, if we were to pass no data, that would main startingProduct property in the Product Manager state would be null.
  You can not add "null" to a string array. That would cause an error.
  So we made an if condition in the initState for that job.

  @override
  void initState() {
    if (widget.startingProduct != null) {
      _products.add(widget.startingProduct);
    }
    super.initState();
  }


  Note_4 - List<Map<String, dynamic>>
  What if we wanted to hold hashes(key-value pairs) in the array?
  That can be done through the Map<key_type,value_type>
  In this example, we are keeping Title and ImageURL
  So, List<Map<String,String>> _products = [];
  Wanna access any of them? _products[0]['title'];
  Returns the value, not the 'title'. For example, it can return "Chocolate".
   */
  List<Map<String, dynamic>> _products =[];

  //METHODS
  /*
  What if I wanted the same "Add Product" button somewhere else too?
  I do not wanna hard code component styles. I wanna call them,
  and pass the necessary functions as an argument if needed.

  In this case, I'm passing the name of the button,
  the function it should be executing when pressed,
  also the default product name when none given.

  Best functions have the least amount of parameters. :3
  */
  void _addProduct(Map<String, dynamic> product){
    setState((){ // Since the state got changed through setState() function, this Widget will be rendered again.
      _products.add(product);
    });
  }
  void _deleteProduct(int index){
    setState(() {
      _products.removeAt(index);
    });
  }

  //WIDGETS
  Widget app (){
    return MaterialApp( // Wraps the whole widget and give capabilities of material design app, like theme, navigation.
      theme:ThemeData(
        brightness: Brightness.light,
        canvasColor: Colors.white,
        primarySwatch: Colors.orange,
        accentColor: Colors.orangeAccent,
        primaryIconTheme: IconThemeData(color: Colors.white),
      ),
      title: 'EasyList',
      home: AuthPage(),
      routes:{
        '/home': (BuildContext context) => ProductsPage(_products),
        '/adminPage' : (BuildContext context) => ProductAdminPage(_addProduct, _deleteProduct),
      },
      /*
      --Note_1: What if we need to pass some data to a named route?
      Let's say you wanna go to a product details page using a named route.
      Those pages are not static and they are generated according to the data they are given as an argument.
      (For this project; productName and productURL are required to be passed as an argument to details page each time we call it.

      Basically, just declaring them in the "routes:" won't work!

      Fortunately flutter has a solution for us, "onGenerateRoute:"
      This widget takes a function, and that function returns a route.

      --Note_2: Routes act weird, what's going on?
      Short answer: These are NOT web page routes.
      Throw away your assumptions, let me explain.

      "/" is the home route by default,
      but you don't need "/" in anywhere of other routes.
      Let's say you named a route "adminPage", that's it!
      You don't go to "/adminPage", you go to "adminPage"
      If you want "/" between pages, you have to manually add them.

      --Note_3: Route Name Controls
      You see that "settings"?
      That thing holds a "name" property that stores our route name.

      We need analyze that route name an decide on how to load a dynamic page.
      I mean: /productDetailsPage/3
      How do we pass that 3 as an index to the productDetilsPage(...) route?

      See the following line?
      final List<String> pathElements = settings.name.split('/');

      So, normally the route name is generate like "/productDetailsPage/3"
      We are going to split this string each time we see a "/",
      and save it into te pathElements list.

      It will look like this: ['','productDetailsPage','2'];
      Yes there is going to be empty string at the beginning,
      because we are splitting into two pieces each time.
       */
      onGenerateRoute: (RouteSettings settings){
        final List<String> pathElements = settings.name.split('/');
        if (pathElements[0] != ''){
          return null;
        }

        if (pathElements[1]=='productDetailsPage') {
          final int index = int.parse(pathElements[2]);
          return MaterialPageRoute<bool>(builder: (BuildContext context) =>
            ProductDetailsPage(
                _products[index]['title'],
                _products[index]['image'],
                _products[index]['description'],
                _products[index]['price'],
                _products[index]['location'],
            )
          );
        }
        return null;
      },
      onUnknownRoute: (RouteSettings settings){
        return MaterialPageRoute(
          builder: (BuildContext context) => ProductsPage(_products)
        );
      },
    );
  }

  //BUILD METHOD
  @override
  // Build widget gets called when the widget gets loaded for the first time (for a StatelessWidget).
  Widget build(BuildContext context) { // Build takes information about the theme and color, aka overriding defaults of the returned widget.
    return app(); // I would like to keep the build function as clean as possible.
  }
}