import 'package:flutter/material.dart';
import 'package:summiteagle/globals/app.dart';

class TextFieldDesign extends AppConfig {
  InputDecoration defaultDecoration(
      {required String hintText,
      required String labelText,
      Widget? suffixIcon}) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(
        color: black.withOpacity(.5),
      ),
      labelStyle: TextStyle(
        color: black,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.grey.shade800,
        ),
      ),
      focusColor: black,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: black,
          width: 2,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          color: Colors.grey.withOpacity(.6),
        ),
      ),
    );
  }
}


