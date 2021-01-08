import 'package:community_support/arguments/report_argument.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/res_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ReportView extends StatefulWidget {
  final ReportArgument arg;
  ReportView({this.arg});
  @override
  _ReportViewState createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView>{

  DbServices db = DbServices();

  TextEditingController type;
  TextEditingController details;



  @override
  void initState() {
    super.initState();
    type = TextEditingController(text: widget.arg.incidentType);
    details = TextEditingController(text: widget.arg.incidentDetails);

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
                controller: type,
                decoration: InputDecoration(
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    labelText: 'From'
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
                          image: widget.arg.incidentVisuals == null ? null : NetworkImage(widget.arg.incidentVisuals)
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
                print(widget.arg.uid);
                db.updateDoc('crimes', widget.arg.uid, {
                  'incidentType':type.text,
                  'incidentDetails': details.text,
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
                        text: 'Report has been Updated!',
                        subText: 'Report is now approved',
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
