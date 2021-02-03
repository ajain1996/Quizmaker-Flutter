import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget appBar(BuildContext context) {
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 22),
      children: <TextSpan>[
        TextSpan(
          text: 'Quiz',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        TextSpan(
          text: 'Maker',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.blue,
          ),
        ),
      ],
    ),
  );
}

Widget blueButton({BuildContext context, String label, buttonWidth}) {
  return Container(
    decoration: BoxDecoration(
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30.0),
    ),
    padding: EdgeInsets.symmetric(
      vertical: 18.0,
    ),
    width:
        buttonWidth != null ? buttonWidth : MediaQuery.of(context).size.width,
    alignment: Alignment.center,
    child: Text(
      label,
      style: TextStyle(
        fontSize: 16.0,
        color: Colors.white,
      ),
    ),
  );
}
