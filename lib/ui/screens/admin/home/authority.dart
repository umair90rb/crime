import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/arguments/register_authority_argument.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/screens/admin/home/authority_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';

class AuthorityUserList extends StatefulWidget {
  @override
  _AuthorityUserListState createState() => _AuthorityUserListState();
}

class _AuthorityUserListState extends State<AuthorityUserList> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  DbServices db = DbServices();
  Future getAuthorityUser;
  getAuthorityUsers() async {
    List<QueryDocumentSnapshot> snapshot = await db.getSnapshotWithQuery('profile', 'type', ['security', 'police']);
    return snapshot;
  }

  @override
  void initState() {
    getAuthorityUser = getAuthorityUsers();
    super.initState();
  }

  newsRow(DocumentSnapshot doc){
    print(doc.data());

    // DateTime createdAt = DateTime.parse(doc['createdAt']);
    // String formattedDate = DateFormat('dd MMMM yyyy').format(createdAt);

    return ListTile(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => AuthorityView(arg: RegisterAuthorityArguments(
              fullName: doc['full_name'],
              familyName: doc['family_name'],
              dob: doc['dob'],
              createdAt: doc['createdAt'].toDate(),
              martialStatus: doc['martial_status'],
              title: doc['title'],
              nextToKin: doc['next_of_kin'],
              phone: doc['phone'],
              email: doc['email'],
              village: doc['village'],
              photo: doc['avatar'],
              id: doc['id'],
              serviceNo: doc['service_no'],
              docId: doc.id
          ),),
        )
        );
      },
      leading:  CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(doc['avatar'])
      ),
      title: Text(doc['phone']),
      subtitle: Text("${doc['full_name']} - Abagana Njikoka Local Government"),
      isThreeLine: false,
      // dense: true,
      trailing: Column(
        children: [
          Container(
            width: 60,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.amber,
            ),
            child: Center(child: Text(doc['status'], style: TextStyle(fontSize: 10),)),
          ),
          Text('01 Dec 2007')
        ],
      ),
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
    return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: FutureBuilder(
          future: getAuthorityUser,
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
    );
  }
}
