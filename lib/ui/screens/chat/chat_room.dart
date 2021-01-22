import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import './chat_room_app_bar.dart';
import './chat_thread.dart';
import '../../../models/thread.dart';
import './send_message_bar.dart';

class ChatRoom extends StatefulWidget {
  final String uid;
  final String peerId;
  final String avatar;
  final String name;

  ChatRoom({this.uid, this.peerId, this.name, this.avatar});
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> with TickerProviderStateMixin {
  final List<ChatThread> _chatThreads = [];
  List<QueryDocumentSnapshot> listMessage = new List.from([]);
  int _limit = 20;
  final int _limitIncrement = 20;
  String groupChatId;

  ChatThread _buildChatThread(Thread thread) {
    final ct = ChatThread(
      thread,
      AnimationController(
        vsync: this,
        duration: Duration(milliseconds: 250),
      ),
    );

    return ct;
  }

  Widget _buildMessageDisplay() {
    return ListView.builder(
      itemCount: _chatThreads.length,
      reverse: true,
      itemBuilder: (context, index) {
        final ct = _chatThreads.reversed.toList()[index];

        return Column(
          children: [
            SizedBox(
              height: 8.0,
            ),
            ct,
          ],
        );
      },
    );
  }

  void _handleSubmitted(String text) {
    final ct = _buildChatThread(Thread(
      fromSelf: true,
      message: text,
    ));

    setState(() {
      _chatThreads.add(ct);
    });

    ct.animationController.forward();
  }

  @override
  void initState() {
    final threads = [
      Thread(fromSelf: false, message: 'Aloha !'),
      Thread(fromSelf: false, message: 'Nei dim ah'),
      Thread(fromSelf: true, message: '未死'),
      Thread(fromSelf: false, message: 'lets hang out a bit ?'),
      Thread(fromSelf: true, message: '好'),
    ];

    threads.forEach((thread) {
      final ct = _buildChatThread(thread);
      _chatThreads.add(ct);
      ct.animationController.forward();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFECE5DD),
      appBar: buildChatRoomAppBar(ClipOval(child: Image.network(widget.avatar),), widget.name),
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: _buildMessageDisplay()
            ),
            SendMessageBar(_handleSubmitted),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _chatThreads.forEach((ct) {
      ct.animationController.dispose();
    });

    super.dispose();
  }
}
