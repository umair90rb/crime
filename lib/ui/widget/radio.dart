import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  final List radios;
  final groupValue;
  final Color color;
  final Function onChanged;
  final Color activeColor;

  RadioButton({this.radios, @required this.groupValue, this.color = Colors.black, this.onChanged, this.activeColor});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for(var a in radios) Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Radio(
              activeColor: activeColor,
              onChanged: onChanged,
              value: a['value'],
              groupValue: groupValue,
            ),
            Text(a['label'],
              style: TextStyle(
                color: color
              ),
            ),
            SizedBox(width: 20,)
          ],
        )
      ],
    );
  }
}
