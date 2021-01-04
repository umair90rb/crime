import 'package:community_support/ui/widget/full_row.dart';
import 'package:community_support/ui/widget/heading.dart';
import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
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
            ),


            FullWidget(
              text: 'Rate App',
              icon: Icons.thumb_up,
            ),

            FullWidget(
              text: 'Share App',
              icon: Icons.share,
            ),

            FullWidget(
              text: 'Write Us',
              icon: Icons.announcement,
            ),

            SizedBox(height: 10,),

            FullWidget(
              text: 'Terms and conditions',
              icon: Icons.article_sharp,
            ),

            FullWidget(
              text: 'Privacy Policy',
              icon: Icons.lock_open,
            ),



          ],
        ),
    );
  }
}
