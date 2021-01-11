import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputCard extends StatelessWidget {
  final String title;
  final int maxLines;
  final Function onChanged;
  final Function onPressedAction;
  final bool validation;
  final Color labelColor;
  final Color backgroundColor;
  final IconData preIcon;
  final double borderRadius;
  final String label;
  final String pat;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String actionTitle;

  InputCard({
    this.title = '',
    this.maxLines = 1,
    this.onChanged,
    this.validation = false,
    this.labelColor = Colors.black,
    this.backgroundColor = Colors.white,
    this.preIcon,
    this.borderRadius = 24,
    this.label = '',
    this.pat = '.',
    this.controller,
    this.textInputType = TextInputType.text,
    this.onPressedAction,
    this.actionTitle = ''
  });
  @override
  Widget build(BuildContext context) {
    return AlertDialog(

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        scrollable: true,
        actions: [
          FlatButton(onPressed:() => Navigator.pop(context), child: Text('Cancel')),
          FlatButton(onPressed:onPressedAction, child: Text(actionTitle)),
        ],
        title: Text(
          title,
          textAlign: TextAlign.center,
        ),
        content:TextFormField(
          onChanged: onChanged,
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
          decoration: InputDecoration(
              prefixIcon: preIcon == null ? null : Icon(preIcon, color: labelColor,),
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
        )
    );
  }
}
