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
      child: Column(
        children: const [
          Text(
            "S E A F",
            style: TextStyle(
              fontFamily: "BrunoAce",
              fontSize: 80,
              color: Color.fromRGBO(34, 73, 87, 1),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Summit Eagle Accounting & Finance',
            style: TextStyle(color: Color.fromRGBO(34, 73, 87, 1)),
          )
        ],
      ),
    );

Hero logoSmall({bool withsubtitle = false}) => Hero(
      tag: "logoSmall",
      child: Column(children: [
        const Text(
          "S E A F",
          style: TextStyle(
            fontFamily: "BrunoAce",
            fontSize: 50,
            color: Color.fromRGBO(34, 73, 87, 1),
            fontWeight: FontWeight.bold,
          ),
        ),
        if (withsubtitle) ...{
          const Text(
            'Summit Eagle Accounting & Finance',
            style:
                TextStyle(color: Color.fromRGBO(34, 73, 87, 1), fontSize: 13),
          )
        }
      ]),
    );

Hero get logoMed => Hero(
      tag: "logoMed",
      child: Column(children: const [
        Text(
          "S E A F",
          style: TextStyle(
            fontFamily: "BrunoAce",
            fontSize: 50,
            color: Color.fromRGBO(34, 73, 87, 1),
            fontWeight: FontWeight.bold,
          ),
        )
      ]),
    );
