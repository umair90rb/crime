import 'package:community_support/ui/widget/full_row.dart';
import 'package:community_support/ui/widget/heading.dart';
import 'package:flutter/material.dart';
import 'dart:core';
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  final Uri _sendEmail = Uri(
      scheme: 'mailto',
      // path: 'smith@example.com',
      // queryParameters: {
      //   'subject': 'Example Subject & Symbols are allowed!'
      // }
  );

  final Uri _writeUs = Uri(
    scheme: 'mailto',
    // path: 'smith@example.com',
    queryParameters: {
      'subject': 'Write Us your opinion and reviews'
    }
  );

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Heading(
                text: 'Purchase',
                fontSize: 16,
              ),
            ),
            FullWidget(
              text: 'Buy Pro Version',
              icon: Icons.lock,
              onTap: () => Navigator.pushNamed(context, '/upgradeToPro'),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Heading(
                text: 'Contact Us',
                fontSize: 16,
              ),
            ),
            FullWidget(
              text: 'Send Email',
              icon: Icons.chat,
              onTap: () => launch(_sendEmail.toString()),
            ),


            FullWidget(
              text: 'Rate App',
              icon: Icons.thumb_up,
              onTap: () => Share.share('https://play.google.com/store/apps'),
            ),

            FullWidget(
              text: 'Share App',
              icon: Icons.share,
              onTap: () => Share.share('https://play.google.com/store/apps'),
            ),

            FullWidget(
              text: 'Write Us',
              icon: Icons.announcement,
              onTap: () => launch(_writeUs.toString()),
            ),

            SizedBox(height: 10,),

            FullWidget(
              text: 'Terms and conditions',
              icon: Icons.article_sharp,
              onTap: () => Navigator.pushNamed(context, '/terms'),
            ),

            FullWidget(
              text: 'Privacy Policy',
              icon: Icons.lock_open,
              onTap: () => Navigator.pushNamed(context, '/privacy'),
            ),



          ],
        ),
    );
  }
}
