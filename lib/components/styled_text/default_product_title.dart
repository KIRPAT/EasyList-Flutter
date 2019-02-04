import 'package:flutter/material.dart';

class DefaultProductTitle extends StatelessWidget {
  final String title;
  DefaultProductTitle(this.title);

  Widget _defaultProductTitle(){
    return Text(
      title,
      style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20.0,
          fontFamily: 'Oswald'
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _defaultProductTitle();
  }
}