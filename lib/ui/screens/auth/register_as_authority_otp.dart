import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:community_support/localization/demo_localization.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/arguments/register_authority_argument.dart';
import 'package:path/path.dart' as path;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/link.dart';

import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


import '../../widget/heading.dart';
import 'package:community_support/global.dart' as global;

class RegisterAuthorityOtp extends StatefulWidget {
  final RegisterAuthorityArguments arg;
  RegisterAuthorityOtp({this.arg});

  @override
  _RegisterAuthorityOtpState createState() => _RegisterAuthorityOtpState();
}

class _RegisterAuthorityOtpState extends State<RegisterAuthorityOtp> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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
    String name = path.basename(file.path);
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

  Future createProfile(RegisterAuthorityArguments arg, dynamic avatar, dynamic id, String uid){
    DocumentReference profile = FirebaseFirestore.instance.collection('profile').doc(uid);
    return profile.set({
      'family_name': arg.familyName,
      'dob': arg.dob,
      'martial_status': arg.martialStatus,
      'title': arg.title,
      'next_of_kin': arg.nextToKin,
      'village':arg.village,
      'type': arg.type,
      'phone': arg.phone,
      'full_name': arg.fullName, // John Doe
      // 'email':arg.email,
      'service_no':arg.serviceNo,
      'avatar':avatar,
      'id':id,
      'createdAt':arg.createdAt,
      'status':'New',
      'package':'free'
    }).then((value) async {
      DocumentReference service = FirebaseFirestore.instance.collection('service').doc(arg.profileDocId);
      await service.delete();
      final prefs = await SharedPreferences.getInstance();
      Map<String, dynamic> pro = {
        'uid': uid,
        'family_name': arg.familyName,
        'dob': arg.dob,
        'martial_status': arg.martialStatus,
        'title': arg.title,
        'next_to_kin': arg.nextToKin,
        'village':arg.village,
        'type': arg.type,
        'phone': arg.phone,
        'full_name': arg.fullName,
        // 'email':arg.email,
        'service_no':arg.serviceNo,
        'avatar':avatar,
        'id':id,
        'createdAt':arg.createdAt.toString(),
        'status':'New',
        'package':'free'
      };
      await prefs.setString('profile', jsonEncode(pro));
      global.profile = pro;
    })
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
                text: DemoLocalization.of(context).getTranslatedValue('verification'),
                letterSpacing: 3,
                fontSize: 22,
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Heading(
                  align: TextAlign.center,
                  text: DemoLocalization.of(context).getTranslatedValue('6_digit_code'),
                  color: Colors.amber,
                  fontSize: 14,
                ),
              ),

              Heading(
                text: widget.arg.phone,
                fontSize: 12,
              ),

              Heading(
                text:  DemoLocalization.of(context).getTranslatedValue('enter_your_otp_code'),
                fontSize: 12,
              ),

              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal:20.0),
                  child: PinPut(
                    validator: (value){
                      if(value.isEmpty){
                        return  DemoLocalization.of(context).getTranslatedValue('pin_is_required');
                      }
                      return null;
                    },
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
                    onSubmit: (pin) async {
                      print(pin);
                      try {
                        await FirebaseAuth.instance
                            .signInWithCredential(PhoneAuthProvider.credential(
                            verificationId: _verificationCode, smsCode: pin))
                            .then((value) async {
                          if (value.user != null) {
                            dynamic url = await uploadFile(widget.arg.photo);
                            dynamic id = await uploadFile(widget.arg.id);
                            dynamic profile = await createProfile(widget.arg, url, id, value.user.uid);
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.setString('user', jsonEncode(value.user.uid));
                            await prefs.setBool('isLoggedIn', true);
                            Navigator.pushNamed(context, '/authorityHome');
                          }
                        });
                      } catch (e) {
                        print(e);
                        FocusScope.of(context).unfocus();
                        _scaffoldKey.currentState
                            .showSnackBar(SnackBar(content: Text( DemoLocalization.of(context).getTranslatedValue('invalid_otp'))));
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
                  text:  DemoLocalization.of(context).getTranslatedValue('dont_receive_code'),
                  link:  DemoLocalization.of(context).getTranslatedValue('resend'),
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


              RoundedButton(label: 'Log In',
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    try {
                      await FirebaseAuth.instance
                          .signInWithCredential(PhoneAuthProvider.credential(
                          verificationId: _verificationCode, smsCode: pin.text))
                          .then((value) async {
                        if (value.user != null) {
                          dynamic url = await uploadFile(widget.arg.photo);
                          dynamic id = await uploadFile(widget.arg.id);
                          dynamic profile = await createProfile(widget.arg, url, id, value.user.uid);
                          print(profile);
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString('user', jsonEncode(value.user.uid));
                          await prefs.setBool('isLoggedIn', true);
                          Navigator.pushNamed(context, '/authorityHome');
                        }
                      });
                    } catch (e) {
                      print(e);
                      FocusScope.of(context).unfocus();
                      _scaffoldKey.currentState
                          .showSnackBar(SnackBar(content: Text( DemoLocalization.of(context).getTranslatedValue('invalid_otp'),),),);
                    }
                  }
                },
              ),

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
        dynamic id = await uploadFile(widget.arg.id);

        await FirebaseAuth.instance.signInWithCredential(credential).then((value) async {
          if(value.user != null){
            dynamic profile = await createProfile(widget.arg, url, id, value.user.uid);
            final prefs = await SharedPreferences.getInstance();
            await prefs.setString('user', jsonEncode(value.user.uid));
            await prefs.setBool('isLoggedIn', true);
            Navigator.pushNamed(context, '/authorityHome');
          }
        });
      },
      verificationFailed: (e){
        print(e.message);
      },
      codeSent: (String verificationId, [int forceResendingToken]){
        print('code sent');
        setState(() {
          _verificationCode = verificationId;
        });
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
