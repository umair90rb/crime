
import 'dart:io';
import 'dart:ui';

import 'package:community_support/arguments/register_arguments.dart';
import 'package:community_support/localization/demo_localization.dart';
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
          SnackBar(content: Text( DemoLocalization.of(context).getTranslatedValue('no_file_chosen')))
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
          toolbarTitle:  DemoLocalization.of(context).getTranslatedValue('crop_image'),
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
                  text: DemoLocalization.of(context).getTranslatedValue('lets_get_started'),
                  letterSpacing: 3,
                  fontSize: 22,
                ),

                RoundedInput(
                  validation: true,
                  controller: fullName,
                  label:  DemoLocalization.of(context).getTranslatedValue('full_name'),
                  textInputType: TextInputType.name,
                  backgroundColor: Colors.black45,
                  labelColor: Colors.white,
                ),


                RoundedInput(
                  validation: true,
                  controller: familyName,
                  label:  DemoLocalization.of(context).getTranslatedValue('family_name'),
                  textInputType: TextInputType.name,
                  backgroundColor: Colors.black45,
                  labelColor: Colors.white,
                ),

                DatePicker(
                  firstDate: DateTime(1875, 1),
                  selectedDate: dob,
                  themeColor: Colors.amber,
                  labelColor: Colors.white,
                  label: dob == null ?  DemoLocalization.of(context).getTranslatedValue('dob') : "${dob.day}/${dob.month}/${dob.year}",
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
                      'label': DemoLocalization.of(context).getTranslatedValue('married'),
                      'value':'married'
                    },
                    {
                      'label': DemoLocalization.of(context).getTranslatedValue('unmarried'),
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
                  label: DemoLocalization.of(context).getTranslatedValue('next_of_kin'),
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

                // RoundedInput(
                //   validation: true,
                //   controller: email,
                //   label: DemoLocalization.of(context).getTranslatedValue('email_address'),
                //   textInputType: TextInputType.emailAddress,
                //   backgroundColor: Colors.black45,
                //   labelColor: Colors.white,
                // ),

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
                          content: [
                            DemoLocalization.of(context).getTranslatedValue('voters_card'),
                            DemoLocalization.of(context).getTranslatedValue('drivers_licence'),
                            DemoLocalization.of(context).getTranslatedValue('international_passport'),
                            DemoLocalization.of(context).getTranslatedValue('nation_id_card')
                          ],
                        )
                    );
                  },
                  backgroundColor: Colors.black45,
                  label: DemoLocalization.of(context).getTranslatedValue('id'),
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
                      DemoLocalization.of(context).getTranslatedValue('upload_your')+'$showId',
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
                      DemoLocalization.of(context).getTranslatedValue('upload_your')+"Image",
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
                    label: DemoLocalization.of(context).getTranslatedValue('create'),
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
                                  // email: email.text,
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
                          content: Text(DemoLocalization.of(context).getTranslatedValue('fill_all_field')),

                        )
                      );
                    },
                ),

                SizedBox(height: 20),

                TextWithLink(
                  fontSize: 15,
                  text: DemoLocalization.of(context).getTranslatedValue('already_have_an_account'),
                  link: DemoLocalization.of(context).getTranslatedValue('login_here'),
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
