import 'package:community_support/localization/demo_localization.dart';
import 'package:community_support/ui/widget/full_row.dart';
import 'package:community_support/ui/widget/heading.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {


  @override
  Widget build(BuildContext context) {

    final Uri _sendEmail = Uri(
        scheme: 'mailto',
        path: 'saftyapps@gmail.com',
        queryParameters: {
          'subject': DemoLocalization.of(context).getTranslatedValue('user_review_subject')
        }
    );

    final Uri _writeUs = Uri(
        scheme: 'mailto',
        path: 'saftyapps@gmail.com',
        queryParameters: {
          'subject': DemoLocalization.of(context).getTranslatedValue('write_us_subject')
        }
    );


    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Heading(
                text: DemoLocalization.of(context).getTranslatedValue('purchase'),
                fontSize: 16,
              ),
            ),
            FullWidget(
              text: DemoLocalization.of(context).getTranslatedValue('buy_pro_version'),
              icon: Icons.lock,
              onTap: () => Navigator.pushNamed(context, '/upgradeToPro'),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Heading(
                text: DemoLocalization.of(context).getTranslatedValue('contact_us'),
                fontSize: 16,
              ),
            ),
            FullWidget(
              text: DemoLocalization.of(context).getTranslatedValue('send_email'),
              icon: Icons.chat,
              onTap: () => launch(_sendEmail.toString()),
            ),


            FullWidget(
              text: DemoLocalization.of(context).getTranslatedValue('rate_app'),
              icon: Icons.thumb_up,
              onTap: () => launch('https://play.google.com/store/apps/details?id=com.abgana.security'),
            ),

            FullWidget(
              text: DemoLocalization.of(context).getTranslatedValue('share_app'),
              icon: Icons.share,
              onTap: () => Share.share('https://play.google.com/store/apps/details?id=com.abgana.security'),
            ),

            FullWidget(
              text: DemoLocalization.of(context).getTranslatedValue('write_us'),
              icon: Icons.announcement,
              onTap: () => launch(_writeUs.toString()),
            ),

            SizedBox(height: 10,),

            FullWidget(
              text: DemoLocalization.of(context).getTranslatedValue('terms_and_condition'),
              icon: Icons.article_sharp,
              onTap: () => Navigator.pushNamed(context, '/terms'),
            ),

            FullWidget(
              text: DemoLocalization.of(context).getTranslatedValue('privacy_policy'),
              icon: Icons.lock_open,
              onTap: () => Navigator.pushNamed(context, '/privacy'),
            ),
            FullWidget(
              text: DemoLocalization.of(context).getTranslatedValue('logout'),
              icon: Icons.logout,
              onTap: () async {
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('user');
                await prefs.remove('profile');
                await prefs.setBool('isLoggedIn', false);
                print('logout');
                Navigator.pushNamed(context, '/loginAs');
              }
            ),



          ],
        ),
    );
  }
}
