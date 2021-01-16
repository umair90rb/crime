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
              text: 'Terms and Condition',
              fontSize: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
              child: Text(
                """Help Protect Your Website And Its Users With Clear And Fair Website Terms And Conditions. These Terms And Conditions For A Website Set Out Key Issues Such As Acceptable Use, Privacy, Cookies, 

Registration And Passwords, Intellectual Property, Links To Other Sites, Termination And Disclaimers Of Responsiblility. 

Terms And Conditions Are Used And Necessary To Protect A Website Owner From Liability Of A User Relying On The Information Or The Goods Provided From The Site Then Suffering A Loss.

Making Your Own Terms and Conditions For Your Website Is Hard, NOt Impossible, To Do. It Can Take A Few Hours To Few Days For A Person With No Legal Background To Make. But Worry No More; We Are Here To Help You Out.

All You Need To Do Is Fill Up The Blank Spaces And Then You Will Receive An Email With Your Personalized Terms And Conditions

The Accuracy of the generated Document on this website is not legally binding. use at your own risk.""",
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
