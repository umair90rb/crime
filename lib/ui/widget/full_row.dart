import 'package:flutter/material.dart';

class FullWidget extends StatelessWidget {
  final bool elevation;
  final IconData icon;
  final String text;
  final Color color;
  final Function onTap;

  FullWidget({this.elevation = false, this.icon, this.text = '', this.color = Colors.white, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          color: color,
          boxShadow: elevation == true ? <BoxShadow>[
            BoxShadow(
              color: Colors.black54,
              offset: Offset(0, 20), //(x,y)
              blurRadius: 15.0,
            ),
          ] : null ,
        ),
        child: Row(
          children: [
            SizedBox(width: 20,),
            Icon(
              icon,
              color: Colors.amber,
            ),
            Spacer(flex: 1,),
            Text(
              text,
              style: TextStyle(
                color: Colors.black
              ),
            ),
            Spacer(flex: 15,),
            Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
            SizedBox(width: 20,)
          ],
        ),
      ),
    );
  }
}
