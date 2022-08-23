import 'package:flutter/material.dart';

Widget loader({
  Color color = Colors.blue,
}) =>
    Container(
      width: double.maxFinite,
      height: double.maxFinite,
      color: Colors.black26,
      child: Center(
        child: CircularProgressIndicator.adaptive(
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );

Hero get logo => Hero(
      tag: "logo",
      child: Image.asset(
        "assets/images/logo.png",
      ),
    );
