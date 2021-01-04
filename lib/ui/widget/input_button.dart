import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  final String label;
  final Color labelColor;
  final double borderRadius;
  final Color backgroundColor;
  final bool elevation;
  final IconData preIcon;
  final Function onTap;

  InputButton({this.label = "", this.labelColor = Colors.black, this.borderRadius = 40, this.backgroundColor = Colors.white, this.elevation = false, this.preIcon, this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal:15, vertical: 10),
        child: Container(
          width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 10),
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
          child: Row(
            children: [
              Icon(
                preIcon,
                color: labelColor,
              ),
              Flexible(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 15,
                    color: labelColor
                  ),
                ),
              ),
            ],
          )
        ),
      ),
    );
  }
}
