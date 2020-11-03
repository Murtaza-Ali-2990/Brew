import 'package:flutter/material.dart';

final textInputDecor = InputDecoration(
    hintText: '',
    fillColor: Colors.brown[200],
    filled: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.brown[400], width: 4.0),
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.brown[600], width: 4.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0))));
