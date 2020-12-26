import 'package:flutter/material.dart';

class IconCard extends StatelessWidget {
  final String icon;
  final String title;
  final int width;
  final int height;
  final Color color;

  IconCard({this.icon, this.title = '', this.height = 100, this.width = 100, this.color = Colors.white});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  offset: Offset(0.0, 3.0), //(x,y)
                  blurRadius: 8.0,
                ),
              ]
            ),
            width: 100,
            height: 100,
            child: Center(
              child: Image.asset(
                'assets/png/${icon}.png',
                color: Colors.amber,
              ),
            ),
          ),
          SizedBox(height: 15,),
          Text(
              title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
            ),
          )
        ],
      ),
    );
  }
}
