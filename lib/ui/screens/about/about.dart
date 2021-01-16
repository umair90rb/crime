import 'package:community_support/ui/widget/heading.dart';
import 'package:flutter/material.dart';

class About extends StatefulWidget {
  @override
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20,),
            Row(children: [
              SizedBox(height: 10,),
              BackButton()
            ],),
            SizedBox(height: 20,),
            Heading(
              text: 'About Us',
              fontSize: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text(
                """Welcome to Abgana Security, your number one source for security. We're dedicated to providing you the very best of security services.

Founded in 2021 by Abgana Security has come a long way from its beginnings in Abagana.

We hope you enjoy our services as much as we enjoy offering them to you. If you have any questions or comments, please don't hesitate to contact us.


Sincerely,

Abgana Security""",
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 16
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
