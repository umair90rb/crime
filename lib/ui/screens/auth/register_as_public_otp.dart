import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

import 'package:community_support/arguments/register_arguments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/link.dart';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import '../../widget/heading.dart';

import 'package:flutter/material.dart';

class RegisterOtp extends StatefulWidget {
  final RegisterArguments arg;
  RegisterOtp({this.arg});

  @override
  _RegisterOtpState createState() => _RegisterOtpState();
}

class _RegisterOtpState extends State<RegisterOtp> {

  final CountDownController _controller = CountDownController();
  int duration = 90;
  final TextEditingController pin = TextEditingController();
  bool resendVisible = false;
  String _verificationCode;

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.amber,
    borderRadius: BorderRadius.circular(50.0),
    border: Border.all(
      color: Colors.amber,
    ),
  );

  Future uploadFile(File file) async {
    String name = basename(file.path);
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref('images/$name');
    try {
      await ref.putFile(file);
      dynamic url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      print(e.toString());
    }
  }

  Future createProfile(RegisterArguments arg, dynamic avatar, String uid){
    DocumentReference profile = FirebaseFirestore.instance.collection('profile').doc(uid);
    return profile.set({
      'full_name': arg.fullName, // John Doe
      'family_name': arg.familyName, // Stokes and Sons
      'martial_status': arg.martialStatus,
      'title': arg.title,
      'next_of_kin': arg.nextToKin,
      'email':arg.email,
      'village': arg.village,
      'id_no': arg.id,
      'avatar':avatar
    }).then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  bool loggedIn = false;

  @override
  Widget build(BuildContext context) {
    if(loggedIn){
      Navigator.pushNamed(context, '/home');
    }

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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10),
              Row(
                children: [
                  BackButton(),
                ],
              ),
              SizedBox(height: 20),
              Heading(
                text:'Verification',
                letterSpacing: 3,
                fontSize: 22,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Heading(
                  align: TextAlign.center,
                  text:'We sent you a 6 digit code to verify your phone number',
                  color: Colors.amber,
                  fontSize: 14,
                ),
              ),

              Heading(
                text: widget.arg.phone,
                fontSize: 12,
              ),

              Heading(
                text: 'Enter your otp code.',
                fontSize: 12,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal:20.0),
                child: PinPut(
                  withCursor: true,
                  fieldsCount: 6,
                  controller: pin,

                  keyboardType: TextInputType.number,
                  eachFieldHeight: 50,
                  eachFieldWidth: 50,
                  eachFieldPadding: EdgeInsets.only(left: 5),
                  submittedFieldDecoration: pinPutDecoration,
                  selectedFieldDecoration: pinPutDecoration,
                  followingFieldDecoration: pinPutDecoration,
                  pinAnimationType: PinAnimationType.fade,
                ),
              ),

              Visibility(
                visible: !resendVisible,
                child: CircularCountDownTimer(
                    controller: _controller,
                    width: 100,
                    height: 100,
                    duration: duration,
                    fillColor: Colors.amber,
                    color: Colors.white30,
                    strokeWidth: 5.0,
                    onComplete: () {
                      setState(() {
                        resendVisible = true;
                      });
                    },
                    textStyle: TextStyle(
                        fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                    isReverse: true,
                    isReverseAnimation: true
                ),
              ),

              Visibility(
                visible: resendVisible,
                child: TextWithLink(
                  text: "Don't receive code?",
                  link: "Resend",
                  onTap: (){
                    setState(() {
                      resendVisible = false;
                      duration = duration +60;
                      _controller.getTime();
                    });
                  },
                ) ,
              ),


              SizedBox(height: 10),


              RoundedButton(label: 'Log In', onPressed: () async {

              }),

              SizedBox(height: 20),

              // TextWithLink(
              //   fontSize: 15,
              //   text: "Don't have an account?",
              //   link: "Register Now",
              //   onTap: () => Navigator.pushNamed(context, '/registerAs'),
              // ),

            ],
          ),
        ),
      ),
    );
  }

  _verifyPhone() async {
    print(widget.arg.phone);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '${widget.arg.phone}',
      timeout: Duration(seconds: 120),
      verificationCompleted: (credential) async {

        print(widget.arg.photo.path);

        dynamic url = await uploadFile(widget.arg.photo);
        await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
          if(value.user != null){
            await createProfile(widget.arg, url, value.user.uid);
            print(value.user.toString());
            setState(() {
              loggedIn = true;
            });
          }
        });
      },
      verificationFailed: (e){
        print(e.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]){
        print('code sent');
        print(verificationId);
      },
      codeAutoRetrievalTimeout: (String str){
        print(str);
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _verifyPhone();

  }
}
