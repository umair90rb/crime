import 'package:community_support/ui/shared/bar.dart';
import 'package:community_support/ui/shared/drawer.dart';
import 'package:flutter/material.dart';
import './chat_list_tile.dart';
import './chat_room.dart';

class ChatList extends StatelessWidget {
  final double listLeadingAvatarRadius = 25.0;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  _onTileTap(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (BuildContext context) {
        return ChatRoom();
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      floatingActionButton: FloatingActionButton(
        heroTag: 'btn4',
        child: Icon(Icons.add),
        onPressed: (){},
      ),
      drawer: AppDrawer(),
      appBar: Bar(
        title: 'Chat',
        scafoldKey: _scaffoldKey,
      ),
      body: ListView.builder(
        itemCount: 30,
        itemBuilder: (BuildContext context, int index) {
          return ChatListTile(
            Icon(Icons.person),
            'Contact $index',
            'hi there',
            '2:53 in the afternoon',
            () => _onTileTap(context),
            avatarRadius: listLeadingAvatarRadius,
          );
        },
      ),
    );
  }
}
