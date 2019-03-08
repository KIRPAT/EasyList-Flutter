import 'package:flutter/material.dart';

class LocationTag extends StatelessWidget{
  final String location;
  LocationTag(this.location);

  Widget _locationTag (){
    return DecoratedBox(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6.0,vertical: 4),
        child: Text(location),
      ),
      decoration: BoxDecoration(
          border:Border.all(),
          borderRadius: BorderRadius.circular(5.0)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _locationTag();
  }
}