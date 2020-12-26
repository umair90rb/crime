import 'dart:ui';

import 'package:community_support/ui/widget/colored.dart';

import '../widget/heading.dart';

import 'package:flutter/material.dart';

class Splash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 5), () => Navigator.pushNamed(context, '/loginAs'));
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.amber,
          image: DecorationImage(
            colorFilter: ColorFilter.mode(Colors.white30, BlendMode.overlay),
            fit: BoxFit.fill,
            image: AssetImage('assets/png/map.png')
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Heading(
              text: "WELCOME",
              fontSize: 34,
            ),
            SizedBox(height: 40,),
            Image.asset(
              'assets/logo/logo.png',
              scale: 2,
            ),
            SizedBox(height: 20,),
            Colored(
              fontWeight: 4,
              fontSize: 32,
              text: [
                {"text":"ABAGANA", "color":Colors.amber},
                {"text":"SECURITY", "color":Colors.black},
              ],
            ),
            Heading(
              fontWeight: 7,
              text: "COMMUNITY NEIGHBORHOOD WATCH",
              fontSize: 15,
            ),
          ],
        ),
      ),
    );
  }
}
