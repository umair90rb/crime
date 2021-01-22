import 'package:community_support/localization/demo_localization.dart';
import 'package:community_support/ui/widget/heading.dart';
import 'package:flutter/material.dart';

class Terms extends StatefulWidget {
  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
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
              text:DemoLocalization.of(context).getTranslatedValue('terms_and_condition'),
              fontSize: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text(
                DemoLocalization.of(context).getTranslatedValue('terms_and_condition_detail'),
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
