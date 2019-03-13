import 'package:flutter/material.dart';

final String _regExpEmail = r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
final String _regExpPrice = r'^(?:[1-9]\d*|0)?(?:[.,]\d+)?$';

final Map<String, String> regLib = {
  'email' : _regExpEmail,
  'price' : _regExpPrice,
};