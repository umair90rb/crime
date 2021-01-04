import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/widget/input.dart';
import 'package:flutter/material.dart';

class AuthorityReport extends StatefulWidget {
  @override
  _AuthorityReportState createState() => _AuthorityReportState();
}

class _AuthorityReportState extends State<AuthorityReport> {
  DbServices db = DbServices();
  List<DocumentSnapshot> profiles = List();

  Future getCrime;
  getCrimes() async {
    List<QueryDocumentSnapshot> snapshot = await db.getSnapshot('crimes');
    // for(var i = 0; i < snapshot.length; i++){
    //   DocumentSnapshot profile = await db.getDoc('profile', snapshot[i]['uid']);
    //   profiles.add(profile);
    // }
    return snapshot;
  }

  @override
  void initState() {
    getCrime = getCrimes();
    super.initState();
  }

  crimeRow(DocumentSnapshot doc){


      return ListTile(
        leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(doc['userAvatar'])
        ),
        title: Text(
          doc['userName'],
          style: TextStyle(fontSize: 20, color: Colors.black),

        ),
        subtitle: RichText(
          softWrap: true,
          text: TextSpan(
            style: TextStyle(fontSize: 20, color: Colors.black),
            children: [
              TextSpan(
                  text: doc['incidentType'],
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: ' - '),
              TextSpan(text: 'Abagana Njkoka Local Government')
            ],
          ),
        ),
        isThreeLine: true,
        trailing: Chip(
          label: Text('New'),
          backgroundColor: Colors.green,
        ),
      );



    // return Padding(
    //   padding: const EdgeInsets.all(10.0),
    //   child: Column(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: [
    //       RichText(
    //         softWrap: true,
    //
    //           text: TextSpan(
    //             style: TextStyle(
    //               fontSize: 20,
    //               color: Colors.black
    //             ),
    //             children: [
    //               TextSpan(text: doc['incidentType'], style: TextStyle(fontWeight: FontWeight.bold)),
    //               TextSpan(text: ' - ' ),
    //               TextSpan(text: 'Abagana Njkoka Local Government')
    //               // TextSpan(
    //               //     text: doc['incidentLocation'],
    //               // )
    //             ]
    //           )
    //       ),
    //       SizedBox(height: 5,),
    //       Text(
    //           'Status: '+doc['status'],
    //         style: TextStyle(
    //           fontSize: 17,
    //           color: Colors.orange
    //         ),
    //       ),
    //       SizedBox(height: 5,),
    //       Row(
    //         children: [
    //           Icon(Icons.remove_red_eye, semanticLabel: doc['views'].toString(),),
    //           SizedBox(width: 2,),
    //           Text(doc['views'].toString()),
    //           Spacer(flex: 3,),
    //           Text(
    //               doc['incidentDate'],
    //               style: TextStyle(
    //                   fontSize: 16,
    //                 color: Colors.blueAccent
    //               ),
    //           ),
    //           SizedBox(width: 10,),
    //           Text(
    //               doc['incidentTime'],
    //               style: TextStyle(
    //                   fontSize: 16,
    //                   color: Colors.blueAccent
    //               ),
    //           ),
    //           Spacer(flex: 1,)
    //         ],
    //       ),
    //       Divider(),
    //     ],
    //   ),
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: FutureBuilder(
          future: getCrime,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              List<QueryDocumentSnapshot> dataList = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    RoundedInput(
                      elevation: true,
                      label: 'Search',
                      preIcon: Icons.search,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    for(var i = 0; i < snapshot.data.length; i++) crimeRow(snapshot.data[i])
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(
                  child:
                      Text("Something went wrong" + snapshot.error.toString()));
            }

            return Column(
              children: [
                LinearProgressIndicator(
                  minHeight: 1.75,
                  backgroundColor: Colors.white,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
                )
              ],
            );
          },
        ));
  }
}
