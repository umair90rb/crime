import 'dart:ui';

import 'package:community_support/localization/demo_localization.dart';
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
                {"text":DemoLocalization.of(context).getTranslatedValue('abagana'), "color":Colors.amber},
                {"text":DemoLocalization.of(context).getTranslatedValue('security'), "color":Colors.black},
              ],
            ),
            Heading(
              fontWeight: 7,
              text: DemoLocalization.of(context).getTranslatedValue('community_neighborhood_watch'),
              fontSize: 15,
            ),
            SizedBox(height: 80),
            Heading(
              text:DemoLocalization.of(context).getTranslatedValue('login_as'),
              letterSpacing: 3,
              fontSize: 16,
            ),
            SizedBox(height: 10),
            RoundedButton(
              label: DemoLocalization.of(context).getTranslatedValue('authority'),
              onPressed: () => Navigator.pushNamed(context, '/login')
            ),
            SizedBox(height: 10),
            Colored(
              fontWeight: 4,
              fontSize: 20,
              text: [
                {"text":DemoLocalization.of(context).getTranslatedValue('or'), "color":Colors.amber},
              ],
            ),
            SizedBox(height: 10),
            RoundedButton(
              width: 55,
              label: DemoLocalization.of(context).getTranslatedValue('public'),
              onPressed: () => Navigator.pushNamed(context, '/login'),
            ),
            SizedBox(height: 10),
            TextWithLink(

              text: DemoLocalization.of(context).getTranslatedValue('dont_have_an_account'),
              link: DemoLocalization.of(context).getTranslatedValue('register_now'),
              onTap: () => Navigator.pushNamed(context, '/registerAs'),
            ),
            SizedBox(height: 80),

          ],
        ),
      ),
    );
  }
}
