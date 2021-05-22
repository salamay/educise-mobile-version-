
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

InputDecoration inputDecoration=InputDecoration(
      errorStyle: TextStyle(
          color: Colors.green
      ),
      icon: Icon(
        Icons.lock,
        size: 18,
        color: HexColor("8B5FBF"),
      ),
      hintText: "password",
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1.0,
            color: HexColor("E3EBFF"),
          ),
          borderRadius: BorderRadius.all(Radius.circular(20))
      ),
    );