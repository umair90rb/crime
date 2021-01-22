import 'dart:ui';

import 'package:community_support/localization/demo_localization.dart';
import 'package:community_support/ui/screens/auth/otp.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/colored.dart';
import 'package:community_support/ui/widget/input.dart';
import 'package:community_support/ui/widget/link.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../../widget/heading.dart';

import 'package:flutter/material.dart';

class Login extends StatelessWidget {


  final TextEditingController phone = TextEditingController();
  final TextEditingController code = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
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
              text:DemoLocalization.of(context).getTranslatedValue('log_in'),
              letterSpacing: 3,
              fontSize: 22,
            ),

            SizedBox(height: 10),

            Form(
              key: _formKey,
              child: RoundedInput(
                validation: true,
                controller: phone,
                label: DemoLocalization.of(context).getTranslatedValue('phone_no'),
                textInputType: TextInputType.phone,
                backgroundColor: Colors.white54,
              ),
            ),

            SizedBox(height: 60),

            RoundedButton(
                label: 'Send Code',
                onPressed: (){
                  if(_formKey.currentState.validate()){
                    FirebaseFirestore.instance
                        .collection('profile')
                        .where('phone', isEqualTo: phone.text)
                        .limit(1)
                        .get()
                        .then((value){

                          if(value.docs.length < 1){
                                _scaffoldKey.currentState.showSnackBar(
                                  SnackBar(
                                    content: Text(DemoLocalization.of(context).getTranslatedValue('user_not_exist')),
                                    action: SnackBarAction(
                                      label: DemoLocalization.of(context).getTranslatedValue('register_now'),
                                      onPressed: () => Navigator.pushNamed(context, '/registerAs'),
                                    ),
                                  )
                                );
                                return;
                          }
                          print(value.docs[0]);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Otp(phone: phone.text)),
                          );

                    });
                  }
                },
            ),

            SizedBox(height: 20),

            TextWithLink(
              fontSize: 15,
              text: DemoLocalization.of(context).getTranslatedValue('dont_have_an_account'),
              link: DemoLocalization.of(context).getTranslatedValue('register_now'),
              onTap: () => Navigator.pushNamed(context, '/registerAs'),
            ),

          ],
        ),
      ),
    );
  }
}
