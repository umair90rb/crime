import 'package:community_support/ui/shared/bar.dart';
import 'package:flutter/material.dart';
import '../../../services/db_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../widget/input.dart';

class CaseSolved extends StatefulWidget {
  @override
  _CaseSolvedState createState() => _CaseSolvedState();
}

class _CaseSolvedState extends State<CaseSolved> {

  DbServices db = DbServices();
  List<DocumentSnapshot> profiles = List();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future getCrime;
  getCrimes() async {
    List<QueryDocumentSnapshot> snapshot = await db.getSnapshotWithQuery('crimes', 'status', 'Solved');
    print(snapshot.first.data());
    for(var i = 0; i < snapshot.length; i++){
      DocumentSnapshot profile = await db.getDoc('profile', snapshot[i]['uid']);
      print(profile.data());
      print(snapshot[i]['uid']);
      profiles.add(profile);
    }
    return snapshot;
  }

  @override
  void initState() {
    getCrime = getCrimes();
    super.initState();
  }

  crimeRow(DocumentSnapshot doc, int i) {
    return ListTile(
      leading: CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(profiles[i]['avatar'])
      ),
      title: Text(
        profiles[i]['full_name'],
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
        label: Text(doc['status']),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Bar(
        title: 'Case Solved',
        isHelpIcon: false,
        scafoldKey: _scaffoldKey,
      ),
      body: Container(
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
                      // RoundedInput(
                      //   elevation: true,
                      //   label: 'Search',
                      //   preIcon: Icons.search,
                      // ),
                      SizedBox(
                        height: 10,
                      ),
                      for(var i = 0; i < snapshot.data.length; i++) crimeRow(snapshot.data[i], i)
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
          )),
    );
  }
}
