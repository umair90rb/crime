import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/input_button.dart';
import 'package:community_support/ui/widget/res_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Code extends StatefulWidget {
  @override
  _CodeState createState() => _CodeState();
}

class _CodeState extends State<Code> {
  int code;
  DbServices db = DbServices();
  bool loading = false;
  Future getCodes;

  generateCode(){
    Random random = Random.secure();
    return random.nextInt(99999999);
  }

  getCode() async {
   List<QueryDocumentSnapshot> serviceNo = await db.getSnapshot('service');
   print(serviceNo);
   return serviceNo;
  }

  @override
  void initState() {
    getCodes = getCode();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
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

          SizedBox(height: 100,),

          InputButton(
            label:code == null ? '' : code.toString(),
            elevation: true,
          ),

          SizedBox(height: 20,),

          RoundedButton(
              label: 'Generate Code',
              onPressed: () async {
                int c = generateCode();
                setState(() {
                  code = c;
                  loading = true;
                });
                await db.addData('service', {
                  'service_no': c
                });
                showCupertinoDialog(
                    barrierDismissible: true,
                    context: context,
                    builder: (context) => ResCard(
                      iconTitle: true,
                      textContent: true,
                      text: c.toString(),
                      subText: 'Code Generated Successfully and saved to database!',

                    )
                );

                setState(() {
                  loading = false;
                });
              },
          ),

          SizedBox(height: 20,),

          SingleChildScrollView(
            child: FutureBuilder(
              future: getCodes,
              builder: (context, snapshot){
                if(snapshot.hasData){
                  List<QueryDocumentSnapshot> list = snapshot.data;
                  return Column(
                   children: list.map((element) { return Center(child: Text(element['service_no'].toString()),);}).toList(),
                 );
                }
                if(snapshot.hasError){
                  return Center(child: Text('${snapshot.error}'),);
                }
                return Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),),);
              },
            ),
          )


        ],
      ),
    );
  }
}
