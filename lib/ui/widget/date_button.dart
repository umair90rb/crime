import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  final String label;
  final Color labelColor;
  final double borderRadius;
  final Color backgroundColor;
  final IconData icon;
  final Function onDateSelect;
  final DateTime selectedDate;
  final Color themeColor;
  final DateTime firstDate ;
  final bool elevation;

  DatePicker({@required this.firstDate, this.elevation = false, this.label = "", this.labelColor = Colors.black, this.borderRadius = 40, this.backgroundColor = Colors.white, this.icon = Icons.calendar_today, this.onDateSelect, this.selectedDate, this.themeColor = Colors.blue,});

  final DateTime initialDate = DateTime.now();

  Future _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        helpText: 'Select your $label',
        errorFormatText: 'Enter valid date',
        errorInvalidText: 'Enter date in valid range',
        fieldLabelText: label,
        builder: (context, child) {
          return Theme(
            data: ThemeData(
              primarySwatch: themeColor
            ), // This will change to light theme.
            child: child,
          );
        },
        lastDate: DateTime(2101));
    if(picked != null && picked != selectedDate){
        return onDateSelect(picked);
    }

  }
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectDate(context),
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(borderRadius),
          boxShadow: elevation == true ? [
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0.0, 3.0), //(x,y)
              blurRadius: 8.0,
            ),
          ] : null ,
        ),

      
        width: double.infinity,
        margin: EdgeInsets.symmetric(horizontal:15.0, vertical: 10),
        padding: const EdgeInsets.symmetric(horizontal:25.0, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: TextStyle(
                color: labelColor
              ),
            ),
            Icon(
              icon,
              color: labelColor,
            )
          ],
        )
      ),
    );
  }
}
