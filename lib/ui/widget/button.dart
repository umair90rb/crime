import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final String label;
  final Function onPressed;
  final double borderRadius;
  final Color textColor;
  final Color backgroundColor;
  final double width;
  final double height;

  RoundedButton({@required this.label, @required this.onPressed, this.borderRadius = 30, this.textColor = Colors.white, this.backgroundColor = Colors.black, this.width = 40, this.height = 15});

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.symmetric(horizontal: width, vertical: height),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
        ),
        color: backgroundColor,
        textColor: this.textColor,
        child: Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 1
          ),
        ),
        onPressed: onPressed
      );
  }
}
