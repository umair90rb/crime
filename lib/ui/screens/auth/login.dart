import 'dart:ui';

import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/colored.dart';
import 'package:community_support/ui/widget/input.dart';
import 'package:community_support/ui/widget/link.dart';

import '../../widget/heading.dart';

import 'package:flutter/material.dart';

class Login extends StatelessWidget {


  final TextEditingController phone = TextEditingController();
  final TextEditingController code = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.amber,
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.overlay),
                fit: BoxFit.fill,
                image: AssetImage('assets/png/colored-map.png')
            )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Row(
              children: [
                BackButton(),
              ],
            ),
            SizedBox(height: 80),
            Heading(
              text:'Log In',
              letterSpacing: 3,
              fontSize: 22,
            ),

            SizedBox(height: 10),

            Form(
              key: _formKey,
              child: RoundedInput(
                validation: true,
                controller: phone,
                label: "Phone No",
                textInputType: TextInputType.phone,
                backgroundColor: Colors.white54,
              ),
            ),

            SizedBox(height: 60),

            RoundedButton(
                label: 'Send Code',
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    Navigator.pushNamed(context, '/otp', arguments: phone.text);
                  }
                },
            ),

            SizedBox(height: 20),

            TextWithLink(
              fontSize: 15,
              text: "Don't have an account?",
              link: "Register Now",
              onTap: () => Navigator.pushNamed(context, '/registerAs'),
            ),

          ],
        ),
      ),
    );
  }
}
