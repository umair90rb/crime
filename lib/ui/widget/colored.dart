import 'package:flutter/material.dart';

class Colored extends StatelessWidget {
  final List text;
  final double fontSize;
  final int fontWeight;
  
  Colored({this.text, this.fontSize, this.fontWeight = 5});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: RichText(
        text: TextSpan(
          children: text.map((e) => TextSpan(
            text: e['text']+" ",
            style: TextStyle(
              fontWeight: FontWeight.values[fontWeight],
              fontSize: fontSize,
              color: e['color']
            )
          )).toList()
        ),
      )
    );
  }
}
