import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StyaleResources
{

  static TextStyle primaryTextstyle = TextStyle(
      fontWeight: FontWeight.bold,fontSize: 18
  );

  static InputDecoration primaryTextFeld = InputDecoration(

    border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(15)),
  );

  static Decoration primaryContainerdecoration =  BoxDecoration(
    color: Colors.blue.shade100,
    border: Border.all(
      color: Colors.black,
      width: 1,
    ),
    borderRadius: BorderRadius.circular(12),
  );
}