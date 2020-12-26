import 'package:community_support/ui/widget/input.dart';
import 'package:flutter/material.dart';

class Map extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage('assets/png/home.png')
        )
      ),
      child: Column(
        children: [
          RoundedInput(
            elevation: true,
            label: 'Search',
            preIcon: Icons.search,
          ),
        ],
      ),
    );
  }
}
