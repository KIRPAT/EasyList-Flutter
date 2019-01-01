import 'package:flutter/material.dart';
import './pages/home.dart' ;

main() {
  runApp(MyApp());
}
/*
Stateless Widgets are permanent after the first time they got loaded. You can not change their content.
On the other hand, if the parent widget is stateful, they also get re-rendered.

MyApp was a stateful widget once, but we made some of it's children stateful.
Now their children gets re-rendered whenever their state changes.
But MyApp stays the same.
(Unless we make yet another Stateful widget it's parent.
Then the MyApp gets re rendered each time it's parent's state change.)
*/
class MyApp extends StatelessWidget{
  //WIDGETS
  Widget app (){
    return MaterialApp( // Wraps the whole widget and give capabilities of material design, like theming.
        theme:ThemeData(
          canvasColor: Colors.white,
          primarySwatch: Colors.orange,
          accentColor: Colors.orange,
        ),
        home: HomePage(),
    );
  }

  //BUILD METHOD
  @override
  // Build widget gets called when the widget gets loaded for the first time for a StatelessWidget.
  Widget build(BuildContext context) { // Build takes information about the theme and color, aka overriding defaults of the returned widget.
    return app(); // I would like to keep the build function as clean as possible.
  }
}