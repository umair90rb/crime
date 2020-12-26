import 'package:flutter/material.dart';

class BackButton extends StatelessWidget {
  final IconData icon;

  BackButton({this.icon = Icons.arrow_back});

  @override
  Widget build(BuildContext context) {
    return Padding(
          padding: const EdgeInsets.all(20.0),
          child: IconButton(
              icon: Icon(icon),
              onPressed: () => Navigator.pop(context)
          ),
        );
  }
}
