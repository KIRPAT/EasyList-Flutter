import 'package:flutter/material.dart';

class ProductCreatePage extends StatefulWidget {
@override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _ProductCreatePageState();
  }
}

class _ProductCreatePageState extends State<ProductCreatePage>{
  //STATES
  String titleValue= '';
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
  //WIDGETS
  Widget _render(context){
    return Column(
      children: <Widget>[
        TextField(
          onChanged: (String value ){
            setState(() {
              titleValue = value;
            });
          },
        ),
        Text(titleValue),
      ],
    );
  }
  //BUILD
  @override
  Widget build(BuildContext context) {
    return _render(context);
  }
}