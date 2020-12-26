import 'package:flutter/material.dart';

class RoundedInput extends StatelessWidget {
  final String label;
  final Color labelColor;
  final double borderRadius;
  final Color backgroundColor;
  final bool obscureText;
  final TextInputType textInputType;
  final TextEditingController controller;
  final bool validation;
  final Pattern pat;
  final bool elevation;
  final IconData preIcon;
  final int maxLines;

  RoundedInput({this.label = "", this.labelColor = Colors.black, this.borderRadius = 40, this.backgroundColor = Colors.white, this.obscureText = false, this.textInputType = TextInputType.text, @required this.controller, this.validation = false, this.pat = '.', this.elevation = false, this.preIcon, this.maxLines = 1});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal:15.0, vertical: 10),
      child: Container(
        decoration: elevation == true ? BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 3.0), //(x,y)
              blurRadius: 8.0,
            ),
          ],
        ) : null,
        child: TextFormField(
          maxLines: maxLines,
          validator: (val){
            if(validation == false) {
              return null;
            }
            if(val.isEmpty) {
              return label + ' is required!';
            }
            RegExp regExp = RegExp(pat);
            if(!regExp.hasMatch(val)) {
              return 'Enter a valid ' + label;
            }
            return null;
          },
          controller: controller,
          keyboardType: textInputType,
          cursorColor: labelColor,
          style: TextStyle(
            color: labelColor
          ),
          obscureText: obscureText,
          decoration: InputDecoration(
            prefixIcon: preIcon == null ? Container() : Icon(preIcon, color: labelColor,),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: BorderSide(color: backgroundColor)
            ),
            focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                borderSide: BorderSide(color: backgroundColor)
            ),
            contentPadding: new EdgeInsets.symmetric(vertical: 12.0, horizontal: 25.0),
            isDense: true,
            filled: true,
            fillColor: backgroundColor,
            focusColor: backgroundColor,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: backgroundColor)
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                  borderSide: BorderSide(color: backgroundColor)
              ),
              labelText: label,
              floatingLabelBehavior: FloatingLabelBehavior.never,
              labelStyle: TextStyle(
                color: labelColor
              )
          ),
        ),
      ),
    );
  }
}
