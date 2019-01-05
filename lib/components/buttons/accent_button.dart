import 'package:flutter/material.dart';

class AccentButton extends StatelessWidget {
  //CONSTRUCTOR
  /*
  Note_1 - Passing functions as an argument
  Since the "Add Product" button is no longer in the related widget, ProductManager,
  we can no longer use it's methods in the onPressed(){}.
  We need to pass a function in the constructor.
  Like this: ProductControl(addProduct);
  so that we can use the addProduct.

  I will go ahead and also make the button name passable in the constructor.

  The best part of this practice is that we can use the same button design in different places,
  and that button would act differently each time depending on the passed method.

  Reminder_1 - Styling
  I will further expand the constructor for styling.
  When I have a coloring style sheet.
   */
  final String buttonName;
  final Function buttonPress;
  final data;
  AccentButton({
    this.buttonName = "Button",
    this.buttonPress,
    this.data //null data.
  });

  //WIDGETS
  Widget _orangeButton(BuildContext context){
    return RaisedButton(
      color: Theme.of(context).accentColor,
      child: Text(buttonName, style: TextStyle(color: Colors.white)),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(4.0)),
      onPressed: (){
        buttonPress(data); //"data" can be anything. It's implicit.
      },
    );
  }

  //BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return _orangeButton(context);
  }
}