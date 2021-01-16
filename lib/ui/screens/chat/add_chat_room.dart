import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/screens/chat/chat_list.dart';
import 'package:community_support/ui/screens/chat/chat_list_tile.dart';
import 'package:community_support/ui/shared/bar.dart';
import 'package:community_support/ui/shared/drawer.dart';
import 'package:community_support/ui/widget/button.dart';
import 'package:community_support/ui/widget/input.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddChatRoom extends StatefulWidget {
  final String uid;
  AddChatRoom(this.uid);
  @override
  _AddChatRoomState createState() => _AddChatRoomState();
}

class _AddChatRoomState extends State<AddChatRoom> {

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController search = TextEditingController();
  DbServices db = DbServices();
  List<QueryDocumentSnapshot> result;


  _onTap(DocumentSnapshot doc) async {
    List<QueryDocumentSnapshot> result = await db.getSnapshotWithQuery('chatList/${widget.uid}/chatList', 'phone', [doc['phone']]);
    if(result.isNotEmpty){
      return Fluttertoast.showToast(msg: 'Already in Chat list.');
    }
    Map<String, dynamic> data = doc.data();
    data['uid'] = doc.id;
    return db.addData('chatList/${widget.uid}/chatList', data).then((value) => Navigator.push(context, MaterialPageRoute(builder: (context) => ChatList(widget.uid))));
  }


  @override
  Widget build(BuildContext context) {
    print('rebuild');
    return Scaffold(
      key: _scaffoldKey,
      drawer: AppDrawer(),
      appBar: Bar(
        title: 'Add Chat Room',
        scafoldKey: _scaffoldKey,
      ),
      body: Column(
        children: [

          RoundedInput(
            controller: search,
            elevation: true,
            label: 'Phone Number',
            preIcon: Icons.search,
            validation: true,
            textInputType: TextInputType.phone,
          ),
          RoundedButton(label: 'Search', onPressed: () async {
            db.getSnapshotWithQuery('profile', 'phone', [search.text]).then((value){
              print(value);
              if(value.isEmpty){
                Fluttertoast.showToast(msg: 'No contact Found!');
                return;
              }
              print('here');
              setState(() {
                result = value;
              });
            });
          }),
          ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, i)=>ChatListTile(ClipOval(child: Image.network(result[i]['avatar'])), result[i]['phone'], result[i]['full_name'], result[i]['family_name'], ()=>_onTap(result[i])),
            separatorBuilder: (context, i) => Divider(),
            itemCount: result == null ? 0 : result.length,
          )
        ],
      ),
    );
  }
}
