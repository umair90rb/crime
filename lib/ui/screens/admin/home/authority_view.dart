import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/arguments/register_arguments.dart';
import 'package:community_support/arguments/register_authority_argument.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/res_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class AuthorityView extends StatefulWidget {
  RegisterAuthorityArguments arg;
  AuthorityView({this.arg});
  @override
  _AuthorityViewState createState() => _AuthorityViewState();
}

class _AuthorityViewState extends State<AuthorityView>{

  DbServices db = DbServices();
  TextEditingController name;
  TextEditingController family;
  TextEditingController dob;
  TextEditingController martial;
  TextEditingController title;
  TextEditingController nextToKin;
  TextEditingController phone;
  TextEditingController village;
  TextEditingController email;
  TextEditingController service;

  @override
  void initState() {
    super.initState();
    name = TextEditingController(text:widget.arg.fullName);
    family = TextEditingController(text:widget.arg.familyName);
    dob = TextEditingController(text:widget.arg.dob);
    martial = TextEditingController(text:widget.arg.martialStatus);
    title = TextEditingController(text:widget.arg.title);
    nextToKin = TextEditingController(text:widget.arg.nextToKin);
    phone = TextEditingController(text:widget.arg.phone);
    village = TextEditingController(text:widget.arg.village);
    email = TextEditingController(text: widget.arg.email);
    service = TextEditingController(text: widget.arg.serviceNo);
  }

  bool loading = false;


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
              visible: loading,
              child: LinearProgressIndicator(
                backgroundColor: Colors.white,
                minHeight: 1.75,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              ),
            ),

            Row(children: [BackButton()],),
            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: name,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Name'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: family,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Family Name'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                enabled: false,
                controller: dob,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'DOB'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: martial,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Martial Status'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: title,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Title'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: nextToKin,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Next to Kin'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: phone,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Phone'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: village,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Village'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: service,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Service'
                ),
              ),
            ),

            SizedBox(height: 20,),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: widget.arg.id == null ? null : BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.arg.id)
                      )
                  ),
                )
            ),

            SizedBox(height: 20,),

            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40),
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: widget.arg.photo == null ? null : BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.arg.photo)
                      )
                  ),
                )
            ),


            SizedBox(height: 30,),

            RoundedButton(
              label: 'Approve',
              onPressed: () async {
                setState(() {
                  loading = true;
                });
                print(widget.arg.docId);
                db.updateDoc('profile', widget.arg.docId, {
                  'phone': phone.text,
                  'full_name': name.text, // John Doe
                  'family_name': family.text, // Stokes and Sons
                  'martial_status': martial.text,
                  'title': title.text,
                  'next_of_kin': nextToKin.text,
                  'email': email.text,
                  'village': village.text,
                  'service_no': service.text,
                  'status':'Approved',
                }).then((value){
                  print(true);
                  setState(() {
                    loading = false;
                  });

                  showCupertinoDialog(
                      barrierDismissible: true,
                      context: context,
                      builder: (context) => ResCard(
                        iconTitle: true,
                        textContent: true,
                        text: 'User has been Updated!',
                        subText: 'User is now approved',
                      )
                  );

                });

              },
            ),

            SizedBox(height: 20,)





          ],
        ),
      ),
    );

  }
}
