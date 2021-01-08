import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/arguments/news_argument.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/res_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class NewsView extends StatefulWidget {
  NewsArgument arg;
  NewsView({this.arg});
  @override
  _NewsViewState createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView>{

  DbServices db = DbServices();

  TextEditingController from;
  TextEditingController subject;
  TextEditingController details;



  @override
  void initState() {
    super.initState();
    from = TextEditingController(text: widget.arg.from);
    subject = TextEditingController(text: widget.arg.subject);
    details = TextEditingController(text: widget.arg.details);

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
                maxLines: 5,
                controller: details,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'Details'
                ),
              ),
            ),

            SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: widget.arg.photoUrl == null ? null : NetworkImage(widget.arg.photoUrl)
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
                  db.updateDoc('news', widget.arg.docId, {
                    'subject':subject.text,
                    'from':from.text,
                    'details':details.text,
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
                          text: 'New has been Updated!',
                          subText: 'News is now approved',
                        )
                    );

                  });

                },
            )





          ],
        ),
      ),
    );

  }
}
