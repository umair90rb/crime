import 'package:flutter/material.dart';

class TimeButton extends StatelessWidget {
  final String label;
  final Color labelColor;
  final double borderRadius;
  final Color backgroundColor;
  final IconData icon;
  final Function onTimeSelect;
  final TimeOfDay selectedTime;
  final Color themeColor;
  final TimeOfDay firstTime ;
  final bool elevation;

  TimeButton({@required this.firstTime, this.elevation = false, this.label = "", this.labelColor = Colors.black, this.borderRadius = 40, this.backgroundColor = Colors.white, this.icon = Icons.access_time, this.onTimeSelect, this.selectedTime, this.themeColor = Colors.blue,});

  final TimeOfDay initialTime = TimeOfDay.now();

  Future _selectDate(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: initialTime,
        helpText: 'Select your $label',
        builder: (context, child) {
          return Theme(
            data: ThemeData(
                primarySwatch: themeColor
            ), // This will change to light theme.
            child: child,
          );
        },
    );
    if(picked != null && picked != selectedTime){
      return onTimeSelect(picked);
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
