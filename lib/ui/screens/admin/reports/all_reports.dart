import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/arguments/report_argument.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/screens/admin/reports/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:community_support/ui/screens/admin/shared/drawer.dart';
import 'package:community_support/ui/shared/bar.dart';


class AllReports extends StatefulWidget {


  @override
  _AllReportsState createState() => _AllReportsState();
}

class _AllReportsState extends State<AllReports> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  DbServices db = DbServices();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future getAllNews;
  getNews() async {
    List<QueryDocumentSnapshot> snapshot = await db.getSnapshot('crimes');
    return snapshot;
  }

  newsRow(DocumentSnapshot doc) {
    print(doc.data());
    return Column(
      children: [
        ListTile(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) =>
                    ReportView(arg: ReportArgument(
                      views: doc['views'],
                      status: doc['status'],
                      incidentVoices: doc['incidentVoices'],
                      incidentVisuals: doc['incidentVisuals'],
                      incidentTime: doc['incidentTime'],
                      incidentLong: doc['incidentLong'],
                      incidentLocation: doc['incidentLocation'],
                      incidentLat: doc['incidentLat'],
                      incidentDetails: doc['incidentDetails'],
                      incidentDate: doc['incidentDate'],
                      incidentType: doc['incidentType'],
                      reportingUserLocation: doc['reportingUserLocation'],
                      reportingTime: doc['reportingTime'],
                      reportingDate: doc['reportingDate'],
                      uid:doc.id,
                      userAvatar: doc['userAvatar'],
                      userName: doc['userName']
                    ),),
              )
              );
            },
            shape: Border.fromBorderSide(BorderSide(width: 1)),
            tileColor: Colors.blueGrey,
            leading:doc['status'] == 'Solved' ? Icon(Icons.check_circle, color: Colors.green,) : Container(width: 1, height: 1,),
            title: Text(doc['incidentType']),
            trailing: Text(doc['incidentDate'])
        ),
        Divider(
          height: 1,
          thickness: 5,
        ),
      ],
    );
  }

    @override
  void initState() {
    getAllNews = getNews();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      drawer: AdminDrawer(),
      appBar: Bar(
        title: 'Admin Panel',

        isHelpIcon: true,
        scafoldKey: _scaffoldKey,
      ),
      body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: FutureBuilder(
            future: getAllNews,
            builder:
                (context, AsyncSnapshot snapshot) {

              if(snapshot.hasData){
                List<QueryDocumentSnapshot> dataList = snapshot.data;
                print(dataList);
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      for(var doc in dataList) newsRow(doc)
                    ],
                  ),
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
  }}
