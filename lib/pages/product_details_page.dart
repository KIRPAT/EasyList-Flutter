import 'package:flutter/material.dart';
import 'dart:async';

import '../components/buttons/accent_button.dart';

class ProductDetailsPage extends StatelessWidget{
  //CONSTRUCTOR
  final String title;
  final String imageURL;
  ProductDetailsPage(this.title, this.imageURL);

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
        title: Text(title),
      ),
      body:Column(
        //mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(imageURL),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(title),
          ),
          AccentButton(
              buttonName: 'DELETE',
              buttonPress: _showDeleteDialog,
              data: context
          ),
        ],
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