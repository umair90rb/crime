import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResCard extends StatelessWidget {
  final String title;
  final List content;
  final bool textContent;
  final String text;
  final FontWeight weight;
  final double fontSize;
  final Color selectedColor;
  final bool iconTitle;
  final IconData icon;
  final Function onTap;
  final bool ok;
  final String subText;

  ResCard({this.title, this.onTap, this.subText, this.icon, this.ok = false, this.iconTitle = false, this.text, this.textContent = false, this.content, this.weight = FontWeight.bold, this.fontSize = 18, this.selectedColor = Colors.amber});
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        scrollable: true,
        title: iconTitle ? Icon(
          Icons.check_circle,
          size: 120,
          color: Colors.black,
          )  : Text(
          title,
          textAlign: TextAlign.center,
        ),
        content:Column(
          children:
            textContent ? [
              SizedBox(height: 10,),
              Text(text, textAlign: TextAlign.center, style: TextStyle(fontSize: 18, color: Colors.black),),
              SizedBox(height: 20,),
              Text(subText, style: TextStyle(fontSize: 16, color: Colors.blueGrey),),
              SizedBox(height: 10),
              InkWell(
                onTap: () => Navigator.pop(context),
                splashColor: selectedColor,
                highlightColor: selectedColor,
                borderRadius: BorderRadius.circular(20),
                child: Center(child: Padding(
                  padding: const EdgeInsets.symmetric(vertical:10.0),
                  child: Text('OK'),
                )),
              )
              ] : content.map((e) => InkWell(
              onTap: ()=>onTap('$e'),
              splashColor: selectedColor,
              highlightColor: selectedColor,
              borderRadius: BorderRadius.circular(20),
              child: Center(child: Padding(
                padding: const EdgeInsets.symmetric(vertical:10.0),
                child: Text(e),
              )),
            ),).toList(),
        )
    );
  }
}
