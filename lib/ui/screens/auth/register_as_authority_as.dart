import 'dart:ui';

import 'package:community_support/localization/demo_localization.dart';
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
                {"text": DemoLocalization.of(context).getTranslatedValue('working_as'), "color":Colors.white},
              ],
            ),

            SizedBox(height: 80),

            RoundedButton(
              label:  DemoLocalization.of(context).getTranslatedValue('security'),
              onPressed: () => Navigator.pushNamed(context, '/registerAsAuthority', arguments: 'security'),
            ),
            SizedBox(height: 10),
            Colored(
              fontWeight: 4,
              fontSize: 20,
              text: [
                {"text": DemoLocalization.of(context).getTranslatedValue('or'), "color":Colors.black},
              ],
            ),
            SizedBox(height: 10),
            RoundedButton(
              width: 55,
              label:  DemoLocalization.of(context).getTranslatedValue('police'),
              onPressed: () => Navigator.pushNamed(context, '/registerAsAuthority', arguments: 'police'),
            ),
            SizedBox(height: 100),

          ],
        ),
      ),
    );
  }
}
