import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/localization/demo_localization.dart';
import 'package:community_support/services/db_services.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AuthorityNews extends StatefulWidget {
  @override
  _AuthorityNewsState createState() => _AuthorityNewsState();
}

class _AuthorityNewsState extends State<AuthorityNews> {

  DbServices db = DbServices();
  Future getNewses;
  getNews() async {
    List<QueryDocumentSnapshot> snapshot = await db.getSnapshot('news');
    return snapshot;
  }

  @override
  void initState() {
    getNewses = getNews();
    super.initState();
  }

  newsRow(DocumentSnapshot doc){

    DateTime createdAt = DateTime.parse(doc['createdAt']);
    String formattedDate = DateFormat('dd MMMM yyyy').format(createdAt);

    return Container(
      margin:EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 1),
            color: Colors.black,
            blurRadius: 15
          )
        ]
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      doc['subject'],
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.black
                      ),
                    ),
                    SizedBox(height: 25),
                    Text(
                      doc['details'],
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          DemoLocalization.of(context).getTranslatedValue('at')+" ${createdAt.hour}:${createdAt.minute}",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.blueAccent
                          ),
                        ),
                        VerticalDivider(color: Colors.black, width: 1, thickness: 10,),
                        Text(
                          formattedDate,
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.blueAccent
                          ),
                        ),
                        VerticalDivider(color: Colors.black, width: 1, thickness: 10,),
                        Text(
                          doc['status'],
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.blueAccent
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  width: 125,
                  height: 125,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(doc['photoUrl'])
                      )
                  ),
                )
              ],
            ),
            SizedBox(height: 10,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    color: Colors.blue,
                    icon: Icon(Icons.thumb_up_alt_outlined),
                    onPressed: (){

                    }),
                IconButton(
                    color: Colors.green,
                    icon: Icon(Icons.comment),
                    onPressed: (){

                    }),
                IconButton(
                    color: Colors.deepOrange,
                    icon: Icon(Icons.share),
                    onPressed: (){

                    })
              ],
            )
          ],
        ),
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: FutureBuilder(
          future: getNewses,
          builder:
              (context, AsyncSnapshot snapshot) {
            if(snapshot.hasData){
              List<QueryDocumentSnapshot> dataList = snapshot.data;
              return SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 10,),
                    for(var doc in dataList) newsRow(doc)
                  ],
                ),
              );
            }
            if (snapshot.hasError) {
              return Center(child: Text(DemoLocalization.of(context).getTranslatedValue('something_wrong')+snapshot.error.toString()));
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
    );
  }
}
