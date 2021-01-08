import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../shared/bar.dart';
class MyReports extends StatefulWidget {
  @override
  _MyReportsState createState() => _MyReportsState();
}

class _MyReportsState extends State<MyReports> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  DbServices db = DbServices();
  Future getCrime;
  getCrimes() async {
    final prefs = await SharedPreferences.getInstance();
    String uid = prefs.getString('user');

    List<QueryDocumentSnapshot> snapshot = await db.getSnapshotWithQuery('crimes', 'uid', [uid]);
    return snapshot;
  }

  @override
  void initState() {
    getCrime = getCrimes();
    super.initState();
  }

  crimeRow(DocumentSnapshot doc){

    return Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            RichText(
                softWrap: true,

                text: TextSpan(
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black
                    ),
                    children: [
                      TextSpan(text: doc['incidentType'], style: TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: ' - ' ),
                      TextSpan(text: 'Abagana Njkoka Local Government')
                      // TextSpan(
                      //     text: doc['incidentLocation'],
                      // )
                    ]
                )
            ),
            SizedBox(height: 5,),
            Text(
              'Status: '+doc['status'],
              style: TextStyle(
                  fontSize: 17,
                  color: Colors.orange
              ),
            ),
            SizedBox(height: 5,),
            Row(
              children: [
                Icon(Icons.remove_red_eye, semanticLabel: doc['views'].toString(),),
                SizedBox(width: 2,),
                Text(doc['views'].toString()),
                Spacer(flex: 3,),
                Text(
                  doc['incidentDate'],
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent
                  ),
                ),
                SizedBox(width: 10,),
                Text(
                  doc['incidentTime'],
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.blueAccent
                  ),
                ),
                Spacer(flex: 1,)
              ],
            ),
            Divider(),
          ],
        ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
            'My Reported Incidents',
          style: TextStyle(
              fontSize: 25
          ),
        ),
        elevation: 0.0,
        toolbarHeight: 100,
        backgroundColor: Colors.amber,
        centerTitle: true,

      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: FutureBuilder(
            future: getCrime,
            builder:
                (context, AsyncSnapshot snapshot) {
              if(snapshot.hasData){
                List<QueryDocumentSnapshot> dataList = snapshot.data;
                if(dataList.length < 1) {
                  return Center(
                    child: Text('You have no incidents reported!'),
                  );
                }
                return Column(
                  children: [
                    for(var doc in dataList) crimeRow(doc)
                  ],
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text("Something went wrong"+snapshot.error.toString()));
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
          )
      ),
    );
  }
}
