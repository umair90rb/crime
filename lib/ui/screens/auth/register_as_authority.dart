
import 'dart:io';
import 'dart:ui';

import 'package:community_support/arguments/register_arguments.dart';
import 'package:community_support/ui/screens/auth/register_as_public_otp.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/dropdown.dart';
import 'package:community_support/ui/widget/input.dart';
import 'package:community_support/ui/widget/link.dart';
import 'package:community_support/ui/widget/radio.dart';
import 'package:community_support/ui/widget/date_button.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../widget/heading.dart';

import 'package:flutter/material.dart';

class RegisterAsAuthority extends StatefulWidget {

  @override
  _RegisterAsAuthorityState createState() => _RegisterAsAuthorityState();
}

class _RegisterAsAuthorityState extends State<RegisterAsAuthority> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController id = TextEditingController();
  File photo;


  final picker = ImagePicker();
  Future chooseImage() async {
    final pickedFile = await picker.getImage(source:ImageSource.gallery);
    File cropped = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatio: CropAspectRatio(
            ratioX: 1, ratioY: 1),
        compressQuality: 100,
        maxWidth: 700,
        maxHeight: 700,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
          toolbarColor: Colors.blue,
          toolbarTitle: "Crop Image",
          statusBarColor: Colors.black,
          backgroundColor: Colors.white,
        )
    );

    this.setState((){
      photo = cropped;
    });

  }





  @override
  Widget build(BuildContext context) {
    final String args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            color: Colors.amber,
            image: DecorationImage(
                colorFilter: ColorFilter.mode(Colors.white54, BlendMode.overlay),
                fit: BoxFit.fill,
                image: AssetImage('assets/png/map.png')
            )
        ),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              // mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    BackButton(),
                  ],
                ),
                Heading(
                  text:'Let\'s Get Started!',
                  letterSpacing: 3,
                  fontSize: 22,
                ),

                SizedBox(height: 10,),

                RoundedButton(
                    label: args,
                    onPressed: (){},
                ),

                SizedBox(height: 10,),

                RoundedInput(
                  validation: true,
                  controller: fullName,
                  label: "Full Name",
                  textInputType: TextInputType.name,
                  backgroundColor: Colors.amber.withOpacity(0.75),
                  labelColor: Colors.white,
                ),

                RoundedInput(
                  validation: true,
                  controller: phone,
                  label: "Phone Number",
                  textInputType: TextInputType.phone,
                  backgroundColor: Colors.amber.withOpacity(0.75),
                  labelColor: Colors.white,
                ),

                RoundedInput(
                  validation: true,
                  controller: email,
                  label: "Email Address",
                  textInputType: TextInputType.emailAddress,
                  backgroundColor: Colors.amber.withOpacity(0.75),
                  labelColor: Colors.white,
                ),


                RoundedInput(

                  validation: true,
                  controller: id,
                  label: "ID",
                  textInputType: TextInputType.number,
                  backgroundColor: Colors.amber.withOpacity(0.75),
                  labelColor: Colors.white,
                ),

                Visibility(
                  visible: args == 'Security' ? true : false,
                    child: RoundedInput(
                      validation: true,
                      controller: id,
                      label: "Service No",
                      textInputType: TextInputType.number,
                      backgroundColor: Colors.amber.withOpacity(0.75),
                      labelColor: Colors.white,
                    ),
                ),

                FlatButton.icon(
                  onPressed: chooseImage,
                  icon: Icon(Icons.camera),
                  label: Text(
                      'Upload You Full Image with Uniform',
                    style: TextStyle(
                      decoration: TextDecoration.underline
                    ),
                  ),
                ),

                RoundedButton(
                  label: 'Create',
                  onPressed: (){
                    if(_formKey.currentState.validate()
                        && photo != null
                    ){
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => RegisterOtp(
                      //
                      //   )),
                      // );

                    }
                  },
                ),

                SizedBox(height: 20),

                TextWithLink(
                  fontSize: 15,
                  text: "Already have an account?",
                  link: "Login Here",
                  onTap: () => Navigator.pushNamed(context, '/loginAs'),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
