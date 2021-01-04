import 'dart:io';

import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/res_card.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddNews extends StatefulWidget {
  @override
  _AddNewsState createState() => _AddNewsState();
}

class _AddNewsState extends State<AddNews> {

  TextEditingController subject = TextEditingController();
  TextEditingController from = TextEditingController();
  TextEditingController details = TextEditingController();
  DateTime createdAt = DateTime.now();
  File photo;
  DbServices db = DbServices();
  bool loading = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  Future chooseImage(scaffoldKey) async {
    File result = await FilePicker.getFile();
    if(result != null) {
      File file = File(result.path);
      return file;
    } else {
      scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text('No file chosen!'))
      );
      return;
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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

            SizedBox(height: 20,),
            Row(children: [BackButton()],),
            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: subject,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Subject'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: from,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'From'
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: TextFormField(
                controller: details,
                maxLines: 5,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Details'
                ),
              ),
            ),

            SizedBox(height: 50,),

            Center(
              child: FlatButton.icon(
                  onPressed: () async {
                    photo = await chooseImage(_scaffoldKey);
                  },
                  icon: Icon(Icons.camera_alt),
                  label: Text('Upload Photos/Videos'),
              ),
            ),

            SizedBox(height: 100,),
            
            RoundedButton(
                label: 'Upload News',
                onPressed: () async {
                  setState(() {
                    loading = true;
                  });
                  final prefs = await SharedPreferences.getInstance();
                  String uid = prefs.getString('user');

                  String photoUrl = await db.uploadFile('newsFile', photo);
                  bool dataInserted = await db.addData('news',{
                    'uid': uid,
                    'subject':subject.text,
                    'from':from.text,
                    'details':details.text,
                    'photoUrl':photoUrl,
                    'status':'Pending',
                    'views':0,
                    'createdAt': createdAt.toString(),
                  });
                  if(dataInserted){
                    setState(() {
                      loading = false;
                    });
                    showCupertinoDialog(
                        barrierDismissible: true,
                        context: context,
                        builder: (context) => ResCard(
                          iconTitle: true,
                          textContent: true,
                          text: 'NEWS HAS BEEN SUBMITTED',
                          subText: 'This News will be broadcast to all app user.',

                        )
                    );
                  }
                }
            )


          ],
        ),
      ),
    );
  }
}
