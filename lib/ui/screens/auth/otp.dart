import 'dart:ui';
import 'dart:convert';

import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/link.dart';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


import '../../widget/heading.dart';

import 'package:flutter/material.dart';

class Otp extends StatefulWidget {
  final String phone;
  Otp({this.phone});

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {

  final CountDownController _controller = CountDownController();
  int duration = 60;
  final TextEditingController pin = TextEditingController();
  bool resendVisible = false;
  String _verificationCode;
  bool loggedIn = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final BoxDecoration pinPutDecoration = BoxDecoration(
    color: Colors.amber,
    borderRadius: BorderRadius.circular(50.0),
    border: Border.all(
      color: Colors.amber,
    ),
  );


  @override
  Widget build(BuildContext context) {
    // if(loggedIn){
    //   Navigator.pushNamed(context, '/home');
    // }
    return Scaffold(
      key: _scaffoldKey,
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
                text: widget.phone,
                fontSize: 12,
              ),

              Heading(
                text: 'Enter your OTP code.',
                fontSize: 12,
              ),

              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: PinPut(
                    withCursor: true,
                    fieldsCount: 6,
                    controller: pin,
                    validator: (value){
                      if(value.isEmpty){
                        return "Pin is required!";
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                    eachFieldHeight: 50,
                    eachFieldWidth: 50,
                    eachFieldPadding: EdgeInsets.only(left: 5),
                    submittedFieldDecoration: pinPutDecoration,
                    selectedFieldDecoration: pinPutDecoration,
                    followingFieldDecoration: pinPutDecoration,
                    pinAnimationType: PinAnimationType.fade,
                    onSubmit: (pin) async {
                      print(pin);
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode, smsCode: pin))
                            .then((value) async {
                          if (value.user != null) {
                            dynamic profile = await FirebaseFirestore.instance
                                .collection('profile').doc(value.user.uid)
                                .get();
                            print(profile.data());

                            final prefs = await SharedPreferences.getInstance();
                            prefs.setString('user', jsonEncode(value.user.uid));
                            prefs.setString('profile', jsonEncode(profile.data()));
                            prefs.setBool('isLoggedIn', true);
                            profile['type'] == 'police' || profile['type'] == 'security' ? Navigator.pushNamed(context, '/authorityHome') : Navigator.pushNamed(context, '/home');
                          }
                        });
                      } catch (e) {
                        print(e);
                        FocusScope.of(context).unfocus();
                        _scaffoldKey.currentState
                            .showSnackBar(SnackBar(content: Text('Invalid OTP')));
                      }
                    },
                  ),
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
                if(_formKey.currentState.validate()){
                  print(pin.text);
                  try {
                    await FirebaseAuth.instance
                        .signInWithCredential(PhoneAuthProvider.credential(
                        verificationId: _verificationCode, smsCode: pin.text))
                        .then((value) async {
                      if (value.user != null) {
                        DocumentSnapshot profile = await FirebaseFirestore.instance
                            .collection('profile').doc(value.user.uid)
                            .get();

                        print(profile.data());
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString('user', jsonEncode(value.user.uid));
                        prefs.setString('profile', jsonEncode(profile.data()));
                        prefs.setBool('isLoggedIn', true);
                        profile['type'] == 'police' || profile['type'] == 'security' ? Navigator.pushNamed(context, '/authorityHome') : Navigator.pushNamed(context, '/home');

                      }
                    });
                  } catch (e) {
                    FocusScope.of(context).unfocus();
                    _scaffoldKey.currentState
                        .showSnackBar(SnackBar(content: Text('Invalid OTP')));
                  }
                }

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
    print(widget.phone);
    await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: '${widget.phone}',
        timeout: Duration(seconds: 120),
        verificationCompleted: (credential) async {

          await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
            if(value.user != null){
              print(value.user.toString());
              dynamic profile = await FirebaseFirestore.instance
                  .collection('profile').doc(value.user.uid)
                  .get();
              print(profile);
              final prefs = await SharedPreferences.getInstance();
              prefs.setString('user', value.user.uid);
              await prefs.setString('profile', jsonEncode({
                'type': profile['type'],
                'phone': profile['phone'],
                'dob':profile['dob'],
                'full_name': profile['full_name'], // John Doe
                'family_name': profile['family_name'], // Stokes and Sons
                'martial_status': profile['martial_status'],
                'title': profile['title'],
                'next_of_kin': profile['next_of_kin'],
                'email':profile['email'],
                'village': profile['village'],
                'id': profile['id'],
                'avatar':profile['avatar'],
                'createdAt': profile['createdAt'].toString(),
                'status':profile['status'],
                'package':profile['package'],
              }));
              await prefs.setBool('isLoggedIn', true);
              profile['type'] == 'police' || profile['type'] == 'security' ? Navigator.pushNamed(context, '/authorityHome') : Navigator.pushNamed(context, '/home');
              // setState(() {
              //   loggedIn = true;
              // });
            }
          });
        },
        verificationFailed: (e){
          print(e.message);
        },
        codeSent: (String verificationId, [int forceResendingToken]){
          print('code sent');
          print(verificationId);
          setState(() {
            _verificationCode = verificationId;
          });
        },
        codeAutoRetrievalTimeout: (String str){
          print(str);
        },
    );
  }

  @override
  void initState() {
    super.initState();
    _verifyPhone();
  }
}
