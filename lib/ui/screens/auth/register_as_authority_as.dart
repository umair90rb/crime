import 'dart:ui';

import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/colored.dart';

import '../../widget/heading.dart';

import 'package:flutter/material.dart';

class RegisterAsAuthorityAs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.amber,
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black45, BlendMode.overlay),
                fit: BoxFit.fill,
                image: AssetImage('assets/png/colored-map.png')
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
                {"text":"ARE YOU WORKING AS", "color":Colors.white},
              ],
            ),

            SizedBox(height: 80),

            RoundedButton(
              label: "Security",
              onPressed: () => Navigator.pushNamed(context, '/registerAsAuthority', arguments: 'Security'),
            ),
            SizedBox(height: 10),
            Colored(
              fontWeight: 4,
              fontSize: 20,
              text: [
                {"text":"OR", "color":Colors.black},
              ],
            ),
            SizedBox(height: 10),
            RoundedButton(
              width: 55,
              label: "Police",
              onPressed: () => Navigator.pushNamed(context, '/registerAsAuthority', arguments: 'Police'),
            ),
            SizedBox(height: 100),

          ],
        ),
      ),
    );
  }
}
