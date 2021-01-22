
import 'dart:io';
import 'dart:ui';

import 'package:community_support/arguments/register_arguments.dart';
import 'package:community_support/ui/screens/auth/register_as_public_otp.dart';
import 'package:community_support/ui/widget/button.dart';
// import 'package:file_picker/file_picker.dart';
import 'package:community_support/ui/widget/dropdown.dart';
import 'package:community_support/ui/widget/input.dart';
import 'package:community_support/ui/widget/input_button.dart';
import 'package:community_support/ui/widget/link.dart';
import 'package:community_support/ui/widget/radio.dart';
import 'package:community_support/ui/widget/date_button.dart';
import 'package:community_support/ui/widget/res_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import '../../widget/heading.dart';

import 'package:flutter/material.dart';

class RegisterAsPublic extends StatefulWidget {

  @override
  _RegisterAsPublicState createState() => _RegisterAsPublicState();
}

class _RegisterAsPublicState extends State<RegisterAsPublic> {

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController familyName = TextEditingController();
  String martialStatus = 'unmarried';
  String village;
  String title;
  final TextEditingController nextOfKin = TextEditingController();
  final TextEditingController phone = TextEditingController();
  final TextEditingController email = TextEditingController();
  String showId;
  File id;
  File photo;
  DateTime dob;


  Future chooseImage(scaffoldKey, file) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source:ImageSource.gallery);
    if(pickedFile == null){
      scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('No file chosen!'))
      );
      return;
    }
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
    return cropped;
  }


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

                RoundedInput(
                  validation: true,
                  controller: fullName,
                  label: "Full Name",
                  textInputType: TextInputType.name,
                  backgroundColor: Colors.black45,
                  labelColor: Colors.white,
                ),


                RoundedInput(
                  validation: true,
                  controller: familyName,
                  label: "Family Name",
                  textInputType: TextInputType.name,
                  backgroundColor: Colors.black45,
                  labelColor: Colors.white,
                ),

                DatePicker(
                  firstDate: DateTime(1875, 1),
                  selectedDate: dob,
                  themeColor: Colors.amber,
                  labelColor: Colors.white,
                  label: dob == null ? "Date of Birth" : "${dob.day}/${dob.month}/${dob.year}",
                  backgroundColor: Colors.black45,
                  onDateSelect: (value){
                    print(value);
                    setState(() {
                      dob = value;
                    });
                    print('${dob.day}/${dob.month}/${dob.year}');
                  },
                ),


                RadioButton(
                  groupValue: martialStatus,
                  onChanged: (value){
                    setState(() {
                      martialStatus = value;
                    });
                  },
                  color: Colors.white,
                  activeColor: Colors.white,
                  radios: [
                    {
                      'label':'Married',
                      'value':'married'
                    },
                    {
                      'label':'Unmarried',
                      'value':'unmarried'
                    }
                  ],
                ),

                RoundedDropdown(
                  backgroundColor: Colors.black45,
                  hintColor: Colors.white,
                  textColor: Colors.white,
                  dropdownValue: title,
                  dropdownItems: [
                    'Mr.', 'Mrs.', 'Miss', 'Prof.', 'Ozo', 'Lord', 'Lady', 'Sir', 'Fr.', 'Sr.', 'Elder','Dr', 'Engr.', 'Chief'
                  ],
                  hint: 'Title',
                  onChanged: (value){
                    setState(() {
                      title = value;
                    });
                  },
                ),

                RoundedInput(
                  validation: true,
                  controller: nextOfKin,
                  label: "Next of Kin",
                  textInputType: TextInputType.text,
                  backgroundColor: Colors.black45,
                  labelColor: Colors.white,
                ),

                RoundedInput(
                  validation: true,
                  controller: phone,
                  label: "Phone Number",
                  textInputType: TextInputType.phone,
                  backgroundColor: Colors.black45,
                  labelColor: Colors.white,
                ),

                RoundedInput(
                  validation: true,
                  controller: email,
                  label: "Email Address",
                  textInputType: TextInputType.emailAddress,
                  backgroundColor: Colors.black45,
                  labelColor: Colors.white,
                ),

                RoundedDropdown(
                  backgroundColor: Colors.black45,
                  hintColor: Colors.white,
                  textColor: Colors.white,
                  dropdownValue: village,
                  dropdownItems: [
                    'Adagbe', 'Akpu', 'Amaenye', 'Orofia', 'Uru', 'Uruokpala', 'Umudunu'
                  ],
                  hint: 'Village',
                  onChanged: (value){
                    setState(() {
                      village = value;
                    });
                  },
                ),

                InputButton(
                  onTap: (){
                    showCupertinoDialog(

                      barrierDismissible: true,
                        context: context,
                        builder: (context) => ResCard(
                          onTap: (value){
                            setState(() {
                              showId = value;
                            });
                            Navigator.pop(context);
                          },
                          title: 'Select',
                          content: ['Voters Card', 'Driver\s Licence', 'International Passport', 'Student ID', 'National ID Card'],
                        )
                    );
                  },
                  backgroundColor: Colors.black45,
                  label: "ID",
                  labelColor: Colors.white,
                ),

                Visibility(
                  visible: showId == null ? false : true,
                  child: FlatButton.icon(
                    onPressed: () async {
                      id = await chooseImage(_scaffoldKey, id);
                    },
                    icon: Icon(Icons.camera),
                    label: Text(
                        'Upload Your $showId',
                      style: TextStyle(
                          color: Colors.white,
                          decoration: TextDecoration.underline
                      ),
                    ),
                  ),
                ),


                FlatButton.icon(
                    onPressed: () async {
                      photo = await chooseImage(_scaffoldKey, photo);
                    },
                    icon: Icon(Icons.camera),
                    label: Text(
                      'Upload Your Image',
                      style: TextStyle(
                        color: Colors.white,
                        decoration: TextDecoration.underline
                      ),
                    ),
                ),

                SizedBox(
                  height: 5,
                ),

                RoundedButton(
                    label: 'Create',
                    onPressed: (){
                      if(_formKey.currentState.validate()
                          && title != null
                          && village != null
                          && photo != null
                          && id != null
                      ){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegisterOtp(
                              arg:RegisterArguments(
                                  fullName: fullName.text,
                                  familyName: familyName.text,
                                  dob: "${dob.day}/${dob.month}/${dob.year}",
                                  martialStatus: martialStatus,
                                  title: title,
                                  nextToKin: nextOfKin.text,
                                  phone: phone.text,
                                  email: email.text,
                                  village: village,
                                  id: id,
                                  photo: photo,
                                  createdAt: DateTime.now()
                              )
                          )),
                        );

                      }
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text('Please fill all fields and add images also!'),

                        )
                      );
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
