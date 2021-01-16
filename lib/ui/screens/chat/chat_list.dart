import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/screens/chat/add_chat_room.dart';
import 'package:community_support/ui/shared/bar.dart';
import 'package:community_support/ui/shared/drawer.dart';
import 'package:flutter/material.dart';
import './chat_list_tile.dart';
import './chat_room.dart';

class ChatList extends StatefulWidget {
  final String uid;

  ChatList(this.uid);
  @override
  _ChatListState createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  final double listLeadingAvatarRadius = 25.0;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DbServices db = DbServices();
  Future getChatRoom;

  getChatRooms() async {
    var result = await db.getSnapshot('chatList/${widget.uid}/chatList');
    print(result);
    return result;
  }

  _onTileTap(BuildContext context, doc) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return ChatRoom(uid: widget.uid, name: doc['full_name'], avatar: doc['avatar'], peerId: doc['uid'],);
      }),
    );
  }

  @override
  void initState() {
    getChatRoom = getChatRooms();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn4',
        child: Icon(Icons.add),
        onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => AddChatRoom(widget.uid))),
      ),
      drawer: AppDrawer(),
      appBar: Bar(
        title: 'Chat',
        scafoldKey: _scaffoldKey,
      ),
      body: FutureBuilder(
        future: getChatRoom,
        builder: (context, snapshot){
          print(snapshot.data);
          print('data');
          if(snapshot.hasData){
            if(snapshot.data.isEmpty){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(child: Text('No contact here! Tap plus button to add'))
                ],
              );
            }
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return ChatListTile(
                  ClipOval(
                    child: Image.network(snapshot.data[index]['avatar']),
                  ),
                  "${snapshot.data[index]['full_name']}",
                  "${snapshot.data[index]['phone']}",
                  "${snapshot.data[index]['type'] == 'public' ? '' : snapshot.data[index]['type'].toUpperCase()}",
                  () => _onTileTap(context, snapshot.data[index]),
                  avatarRadius: listLeadingAvatarRadius,
                );
              },
            );
          }

          if(snapshot.hasError){
            return Text("${snapshot.error}");
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

        }
      )
    );
  }
}
