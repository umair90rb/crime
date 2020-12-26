import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final int fontWeight;
  final double letterSpacing;
  final TextAlign align;


  Heading({this.text, this.color = Colors.black, this.fontSize, this.fontWeight = 5, this.letterSpacing = 0, this.align = TextAlign.start});


  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.all(10),
      child: Text(
        text,
        textAlign: align,
        style: TextStyle(
          fontWeight: FontWeight.values[fontWeight],
          color: color,
          fontSize: fontSize,
          letterSpacing: letterSpacing
        ),
      ),
    );
  }
}
