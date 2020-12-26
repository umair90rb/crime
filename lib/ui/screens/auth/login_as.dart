import 'dart:ui';

import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/colored.dart';
import 'package:community_support/ui/widget/link.dart';

import '../../widget/heading.dart';

import 'package:flutter/material.dart';

class LoginAs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            Colored(
              fontWeight: 8,
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
            SizedBox(height: 80),
            Heading(
              text:'LOG IN AS',
              letterSpacing: 3,
              fontSize: 16,
            ),
            SizedBox(height: 10),
            RoundedButton(
              label: "Authority",
              onPressed: () => Navigator.pushNamed(context, '/login'),
            ),
            SizedBox(height: 10),
            Colored(
              fontWeight: 4,
              fontSize: 20,
              text: [
                {"text":"OR", "color":Colors.amber},
              ],
            ),
            SizedBox(height: 10),
            RoundedButton(
              width: 55,
              label: "Public",
              onPressed: () => Navigator.pushNamed(context, '/login'),
            ),
            SizedBox(height: 10),
            TextWithLink(

              text: "Don't have an account?",
              link: "Register Now",
              onTap: () => Navigator.pushNamed(context, '/registerAs'),
            ),
            SizedBox(height: 80),

          ],
        ),
      ),
    );
  }
}
