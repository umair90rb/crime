import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/screens/admin/news/news.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

import 'package:community_support/ui/screens/admin/shared/drawer.dart';
import 'package:community_support/ui/shared/bar.dart';

import 'package:community_support/arguments/news_argument.dart';

class AllNews extends StatefulWidget {
  @override
  _AllNewsState createState() => _AllNewsState();
}

class _AllNewsState extends State<AllNews> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  DbServices db = DbServices();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  Future getAllNews;
  getNews() async {
    List<QueryDocumentSnapshot> snapshot = await db.getSnapshot('news');
    return snapshot;
  }

  @override
  void initState() {
    getAllNews = getNews();
    super.initState();
  }

  newsRow(DocumentSnapshot doc){
    print(doc.data());

    DateTime createdAt = DateTime.parse(doc['createdAt']);
    String formattedDate = DateFormat('dd MMMM yy').format(createdAt);

    return Column(
      children: [
        ListTile(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(
                builder: (context) => NewsView(arg: NewsArgument(
                    createdAt: createdAt,
                    details: doc['details'],
                    subject: doc['subject'],
                    from: doc['from'],
                    uid: doc['uid'],
                    photoUrl: doc['photoUrl'],
                    status: doc['status'],
                    views: doc['views'],
                    docId: doc.id
                ),),
            )
            );
          },
          shape: Border.fromBorderSide(BorderSide(width: 1)),
          tileColor: doc['status'] == 'Approved'? Colors.green : Colors.blueGrey,
          leading:  Text(doc['from']),
          title: Text(doc['subject']),
          // dense: true,
          trailing: Text(formattedDate)
        ),
        Divider(
          height: 1,
          thickness: 5,
        ),
      ],
    );

    // return Container(
    //   margin:EdgeInsets.only(bottom: 10),
    //   decoration: BoxDecoration(
    //     color: Colors.black12,
    //     // boxShadow: [
    //     //   BoxShadow(
    //     //     offset: Offset(0, 1),
    //     //     color: Colors.black,
    //     //     blurRadius: 15
    //     //   )
    //     // ]
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.all(10.0),
    //     child: Column(
    //       children: [
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             Column(
    //               // mainAxisAlignment: MainAxisAlignment.start,
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               children: [
    //                 Text(
    //                   doc['subject'],
    //                   style: TextStyle(
    //                       fontSize: 20,
    //                       color: Colors.black
    //                   ),
    //                 ),
    //                 Text(
    //                   doc['details'],
    //                   style: TextStyle(
    //                       fontSize: 16,
    //                       color: Colors.grey
    //                   ),
    //                 ),
    //                 SizedBox(height: 25,),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceAround,
    //                   children: [
    //                     Text(
    //                       "At ${createdAt.hour}:${createdAt.minute}",
    //                       style: TextStyle(
    //                           fontSize: 13,
    //                           color: Colors.blueAccent
    //                       ),
    //                     ),
    //                     VerticalDivider(color: Colors.black, width: 1, thickness: 10,),
    //                     Text(
    //                       formattedDate,
    //                       style: TextStyle(
    //                           fontSize: 13,
    //                           color: Colors.blueAccent
    //                       ),
    //                     ),
    //                     VerticalDivider(color: Colors.black, width: 1, thickness: 10,),
    //                     Text(
    //                       doc['status'],
    //                       style: TextStyle(
    //                           fontSize: 13,
    //                           color: Colors.blueAccent
    //                       ),
    //                     ),
    //
    //                   ],
    //                 ),
    //
    //               ],
    //             ),
    //             SizedBox(height: 15),
    //             Container(
    //               width: 100,
    //               height: 100,
    //               decoration: BoxDecoration(
    //                   borderRadius: BorderRadius.circular(10),
    //                   image: DecorationImage(
    //                       fit: BoxFit.fill,
    //                       image: NetworkImage(doc['photoUrl'])
    //                   )
    //               ),
    //             ),
    //
    //           ],
    //         ),
    //         SizedBox(height: 10,),
    //         Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             IconButton(
    //                 color: Colors.blue,
    //                 icon: Icon(Icons.thumb_up_alt_outlined),
    //                 onPressed: (){
    //
    //                 }),
    //             IconButton(
    //                 color: Colors.green,
    //                 icon: Icon(Icons.comment),
    //                 onPressed: (){
    //
    //                 }),
    //             IconButton(
    //                 color: Colors.deepOrange,
    //                 icon: Icon(Icons.share),
    //                 onPressed: (){
    //
    //                 })
    //           ],
    //         )
    //       ],
    //     ),
    //   ),
    // );

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
  }
}
