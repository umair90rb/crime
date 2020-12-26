import 'package:flutter/material.dart';

class RoundedDropdown extends StatelessWidget {
  final List<String> dropdownItems;
  final String label;
  final dropdownValue;
  final Function onChanged;
  final Color textColor;
  final Color hintColor;
  final Color backgroundColor;
  final double borderRadius;
  final String hint;

  RoundedDropdown({this.dropdownItems, this.label, this.dropdownValue, this.onChanged, this.textColor, this.hintColor, this.backgroundColor, this.borderRadius = 20, this.hint = 'Select a value'});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(borderRadius)
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: backgroundColor,
          ),
          child: DropdownButton<String>(
            isDense: true,
            value: dropdownValue,
            hint: Text(hint,
              style: TextStyle(
                color: hintColor
              ),
            ),
            icon: Icon(
              Icons.arrow_drop_down,
              color: hintColor,
            ),
            isExpanded: true,
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: hintColor),
            underline: Container(),
            onChanged: onChanged,
            items: dropdownItems
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                  style: TextStyle(
                    color: textColor
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
