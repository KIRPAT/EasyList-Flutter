import 'package:flutter/material.dart';
import 'dart:async';

import '../components/buttons/accent_button.dart';

class ProductDetailsPage extends StatelessWidget{
  //CONSTRUCTOR
  final String title;
  final String imageURL;
  final String description;
  final double price;
  final String location;
  ProductDetailsPage(this.title, this.imageURL, this.description, this.price, this.location);

  //METHODS
  /*
  shoDialog() is dismissed through Navigation.pop() too
   */
  void _popPage(context){
    Navigator.pop(context, true);
  }

  void _onWillPop(context){
    Navigator.pop(context, false);
  }

  void _showDeleteDialog(context){
    showDialog(
      context: context,
      builder: (BuildContext context){
        return AlertDialog(
          title: Text('Are you sure?'),
          content: Text('You can not undelete it once it is gone.'),
          actions: <Widget>[
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('DISCARD')
            ),
            FlatButton(
              onPressed: (){
                Navigator.pop(context);
                _popPage(context); //pop with "true" as a second argument,
              },
              child: Text('CONTINUE')
            ),
          ],
        );
      }
    );
  }

  //WIDGETS (from component level widget, to the final composed widget that we need to render)
  Widget _scaffold(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details', style: TextStyle(color: Colors.white)),
      ),
      body:SingleChildScrollView( //Scrollable details page
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0),

          //The main Column
          child: Column(
            children: <Widget>[

              //Image
              /*
              What if the product has more than one image? Food for a thought.
               */
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Image.asset(imageURL),
                ),
              ),

              //Title and Price
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0,
                            fontFamily: 'Oswald'
                        ),
                      ),
                    ),
                    //constraints:BoxConstraints(maxWidth: 200.0),
                  ),
                  Expanded(
                    flex: 1,
                    child: Center(
                      child: Container(
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
                      ),
                    ),
                  ),
                ],
              ),

              //Location
              DecoratedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 4),
                  child: Text(location),
                ),
                decoration: BoxDecoration(
                    border:Border.all(),
                    borderRadius: BorderRadius.circular(5.0)
                ),
              ),

              //Divider
              Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(child: SizedBox(), flex:1),
                    Expanded(
                      flex: 2,
                      child: Container(
                        height: 1.0,
                        color: Colors.grey,
                      ),
                    ),
                    Expanded(child: SizedBox(), flex:1),
                  ],
                ),
              ),

              //Details
              Container(
                child: Column(children: <Widget>[
                  Text('Details:', style: TextStyle(fontStyle: FontStyle.italic, fontFamily: 'Oswald', fontSize: 15.0),),
                  SizedBox(height: 6.0,),
                  Text(description),
                ],)
              ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _listenedScaffold(BuildContext context){
    /*
    WillPopScope widget decides if the user is allowed to return from a page,
    either through the Android's back button,
    or the the app's own back button that is placed on the AppBar.
    True, False

    If we place...
    Navigator.pop(context, false);
    ...on top of the...
    return Future.value(true);
    ...something weird happens.

    We pop twice, and actually pop the homepage itself.
    Thus, a black screen.
    To prevent that from happening. we actually need to use
    Future.value(false);
    Yes, we are actually preventing the user from going back but the
    Navigator.pop(context, false); lets us go back anyways.
    */
    return WillPopScope(
      child: _scaffold(context),
      onWillPop:(){
        _onWillPop(context);
        return Future.value(false);
      }
    );
  }

  //BUILD METHOD
  @override
  Widget build(BuildContext context) {
    return _listenedScaffold(context);
  }
}