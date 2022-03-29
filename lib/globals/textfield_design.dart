import 'package:flutter/material.dart';

class TextFieldDesign {
  InputDecoration defaultDecoration(
      {required String hintText,
      required String labelText,
      Widget? suffixIcon}) {
    return InputDecoration(
      suffixIcon: suffixIcon,
      labelText: labelText,
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white.withOpacity(.5),
      ),
      labelStyle: const TextStyle(
        color: Colors.white,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.grey,
        ),
      ),
      focusColor: Colors.white,
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: const BorderSide(
          color: Colors.white,
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
