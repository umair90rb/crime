import 'package:flutter/material.dart';

class TextWithLink extends StatelessWidget {
  final String text;
  final Color textColor;
  final String link;
  final Color linkColor;
  final Function onTap;
  final double fontSize;

  TextWithLink({this.text, this.textColor = Colors.black, this.link, this.linkColor = Colors.blueAccent, this.onTap, this.fontSize = 12});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text+" ",
            style: TextStyle(
              fontSize: fontSize,
              color: textColor
            ),
          ),
          InkWell(
            onTap: onTap,
            child: Text(
              link,
              style: TextStyle(
                  fontSize: fontSize,
                  color: linkColor
              ),
            ),
          )
        ],
      ),
    );
  }
}
