import 'package:community_support/localization/demo_localization.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'dart:io';
import 'dart:ui';

import 'package:community_support/ui/widget/dropdown.dart';
import 'package:community_support/ui/widget/input.dart';
import 'package:community_support/ui/widget/radio.dart';
import 'package:community_support/ui/widget/date_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  final Map<String, dynamic> arg;

  Profile({@required this.arg});

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {



  DbServices db = DbServices();


  Future chooseImage(scaffoldKey, file) async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source:ImageSource.gallery);
    if(pickedFile == null){
      scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(DemoLocalization.of(context).getTranslatedValue('no_file_chosen')))
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
          toolbarTitle: DemoLocalization.of(context).getTranslatedValue('crop_image'),
          statusBarColor: Colors.black,
          backgroundColor: Colors.white,
        )
    );
    return cropped;
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController fullName;
  TextEditingController familyName;
  String martialStatus;
  String village;
  String title;
  String pDob;
  TextEditingController nextOfKin;
  TextEditingController phone;
  TextEditingController email;
  DateTime dob;

  @override
  void initState() {
    email = TextEditingController(text: widget.arg['email']);
    phone = TextEditingController(text: widget.arg['phone']);
    nextOfKin = TextEditingController(text: widget.arg['next_of_kin']);
    pDob = widget.arg['dob'];
    title = widget.arg['title'];
    village = widget.arg['village'];
    martialStatus = widget.arg['martial_status'];
    familyName = TextEditingController(text: widget.arg['family_name']);
    fullName = TextEditingController(text: widget.arg['full_name']);
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.amber,
      body: SingleChildScrollView(
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
              Material(
                borderRadius: BorderRadius.circular(50),
                elevation: 4,
                child: CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
                  child: ClipOval(
                    child: Image.network(widget.arg['avatar']),
                  ),
                ),
              ),
              RoundedInput(
                validation: true,
                controller: fullName,
                label:DemoLocalization.of(context).getTranslatedValue('full_name'),
                textInputType: TextInputType.name,
                backgroundColor: Colors.black45,
                labelColor: Colors.white,
              ),


              RoundedInput(
                validation: true,
                controller: familyName,
                label: DemoLocalization.of(context).getTranslatedValue('family_name'),
                textInputType: TextInputType.name,
                backgroundColor: Colors.black45,
                labelColor: Colors.white,
              ),

              DatePicker(
                firstDate: DateTime(1975, 1),
                selectedDate: dob,
                themeColor: Colors.amber,
                labelColor: Colors.white,
                label: pDob,
                backgroundColor: Colors.black45,
                onDateSelect: (value){
                  print(value);
                  dob = value;
                  pDob = "${dob.day}/${dob.month}/${dob.year}";
                  setState(() {});
                  print(pDob);
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
                    'label':DemoLocalization.of(context).getTranslatedValue('married'),
                    'value':'married'
                  },
                  {
                    'label':DemoLocalization.of(context).getTranslatedValue('unmarried'),
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
                  DemoLocalization.of(context).getTranslatedValue('mr'),
                  DemoLocalization.of(context).getTranslatedValue('mrs'),
                  DemoLocalization.of(context).getTranslatedValue('miss'),
                  DemoLocalization.of(context).getTranslatedValue('prof'),
                  DemoLocalization.of(context).getTranslatedValue('ozo'),
                  DemoLocalization.of(context).getTranslatedValue('lord'),
                  DemoLocalization.of(context).getTranslatedValue('lady'),
                  DemoLocalization.of(context).getTranslatedValue('sir'),
                  DemoLocalization.of(context).getTranslatedValue('fr'),
                  DemoLocalization.of(context).getTranslatedValue('sr'),
                  DemoLocalization.of(context).getTranslatedValue('elder'),
                  DemoLocalization.of(context).getTranslatedValue('dr'),
                  DemoLocalization.of(context).getTranslatedValue('engr'),
                  DemoLocalization.of(context).getTranslatedValue('chief')
                ],
                hint: DemoLocalization.of(context).getTranslatedValue('title'),
                onChanged: (value){
                  setState(() {
                    title = value;
                  });
                },
              ),

              RoundedInput(
                validation: true,
                controller: nextOfKin,
                label: DemoLocalization.of(context).getTranslatedValue('next_to_kin'),
                textInputType: TextInputType.text,
                backgroundColor: Colors.black45,
                labelColor: Colors.white,
              ),

              RoundedInput(
                validation: true,
                controller: phone,
                label: DemoLocalization.of(context).getTranslatedValue('phone_number'),
                textInputType: TextInputType.phone,
                backgroundColor: Colors.black45,
                labelColor: Colors.white,
              ),

              RoundedInput(
                validation: true,
                controller: email,
                label: DemoLocalization.of(context).getTranslatedValue('email_address'),
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
                hint: DemoLocalization.of(context).getTranslatedValue('village'),
                onChanged: (value){
                  setState(() {
                    village = value;
                  });
                },
              ),

              // InputButton(
              //   onTap: (){
              //     showCupertinoDialog(
              //
              //         barrierDismissible: true,
              //         context: context,
              //         builder: (context) => ResCard(
              //           onTap: (value){
              //             setState(() {
              //               showId = value;
              //             });
              //             Navigator.pop(context);
              //           },
              //           title: 'Select',
              //           content: ['Voters Card', 'Driver\s Licence', 'International Passport', 'Student ID', 'National ID Card'],
              //         )
              //     );
              //   },
              //   backgroundColor: Colors.black45,
              //   label: "ID",
              //   labelColor: Colors.white,
              // ),

              // Visibility(
              //   visible: showId == null ? false : true,
              //   child: FlatButton.icon(
              //     onPressed: () async {
              //       id = await chooseImage(_scaffoldKey, id);
              //     },
              //     icon: Icon(Icons.camera),
              //     label: Text(
              //       'Upload Your $showId',
              //       style: TextStyle(
              //           color: Colors.white,
              //           decoration: TextDecoration.underline
              //       ),
              //     ),
              //   ),
              // ),


              // FlatButton.icon(
              //   onPressed: () async {
              //     photo = await chooseImage(_scaffoldKey, photo);
              //   },
              //   icon: Icon(Icons.camera),
              //   label: Text(
              //     'Upload Your Image',
              //     style: TextStyle(
              //         color: Colors.white,
              //         decoration: TextDecoration.underline
              //     ),
              //   ),
              // ),

              SizedBox(
                height: 5,
              ),

              RoundedButton(
                label: DemoLocalization.of(context).getTranslatedValue('update'),
                onPressed: () async {
                  print("title $title, village $village");
                  if(_formKey.currentState.validate()){
                    print("$title $village");
                    if(title != null && village != null){
                      final prefs = await SharedPreferences.getInstance();
                      String uid = await prefs.get('user');
                      uid = uid.replaceAll('"', '');
                      print(uid);
                      await db.updateDoc('profile', uid, {
                        'full_name': fullName.text,
                        'family_name': familyName.text,
                        'dob': pDob,
                        'martial_status': martialStatus,
                        'title': title,
                        'next_of_kin': nextOfKin.text,
                        'phone': phone.text,
                        'email': email.text,
                        'village': village,
                      });
                      return _scaffoldKey.currentState.showSnackBar(
                          SnackBar(
                            content: Text(DemoLocalization.of(context).getTranslatedValue('profile_updated')),

                          )
                      );
                    }
                    _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          content: Text(DemoLocalization.of(context).getTranslatedValue('fill_all_field')),

                        )
                    );
                  }
                },
              ),

              SizedBox(height: 20),

              // TextWithLink(
              //   fontSize: 15,
              //   text: "Already have an account?",
              //   link: "Login Here",
              //   onTap: () => Navigator.pushNamed(context, '/loginAs'),
              // ),

            ],
          ),
        ),
      ),
    );
  }

  //
  // @override
  // Widget build(BuildContext context) {
  //   Map<String, dynamic> arg = ModalRoute.of(context).settings.arguments;
  //
  //   return Scaffold(
  //     backgroundColor: Colors.amber,
  //     body: SingleChildScrollView(
  //       child: Column(
  //         // crossAxisAlignment: CrossAxisAlignment.stretch,
  //         // mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           SizedBox(height: 15,),
  //           Row(
  //             children: [
  //               BackButton(),
  //             ],
  //           ),
  //           Material(
  //             borderRadius: BorderRadius.circular(50),
  //             elevation: 4,
  //             child: CircleAvatar(
  //               radius: 50,
  //               backgroundColor: Colors.transparent,
  //               child: ClipOval(
  //                 child: Image.network(arg['avatar']),
  //               ),
  //             ),
  //           ),
  //           SizedBox(height: 10,),
  //           Center(child: Text(
  //             arg['full_name'].toUpperCase(),
  //             style: TextStyle(
  //                 fontSize: 18
  //             ),
  //           ),),
  //           RoundedButton(
  //             label: arg['email'],
  //             backgroundColor: Colors.white,
  //           ),
  //           InputButton(
  //             label: arg['phone'],
  //             elevation: true,
  //             backgroundColor: Colors.white,
  //           ),
  //           InputButton(
  //             labelColor: Colors.white,
  //             label: 'Upgrade to PRO',
  //             elevation: true,
  //             backgroundColor: Colors.amber,
  //           ),
  //           InputButton(
  //             label: 'Logout',
  //             labelColor: Colors.white,
  //             elevation: true,
  //             backgroundColor: Colors.orange,
  //             onTap: () async {
  //               final prefs = await SharedPreferences.getInstance();
  //               prefs.remove('user');
  //               prefs.remove('profile');
  //               prefs.setBool('isLoggedIn', false);
  //               print('logout');
  //               Navigator.pushNamed(context, '/loginAs');
  //             },
  //           ),
  //
  //
  //
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
