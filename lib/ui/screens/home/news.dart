import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:community_support/services/db_services.dart';
import 'package:community_support/ui/widget/input_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:share/share.dart';


class News extends StatefulWidget {
  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> with SingleTickerProviderStateMixin {

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

  newsRow(DocumentSnapshot doc) {
    DateTime createdAt = DateTime.parse(doc['createdAt']);
    String formattedDate = DateFormat('dd MMMM yyyy').format(createdAt);

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.black12,
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
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                    Text(
                      doc['details'],
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          "At ${createdAt.hour}:${createdAt.minute}",
                          style: TextStyle(
                              fontSize: 13, color: Colors.blueAccent),
                        ),
                        VerticalDivider(
                          color: Colors.black,
                          width: 1,
                          thickness: 10,
                        ),
                        Text(
                          formattedDate,
                          style: TextStyle(
                              fontSize: 13, color: Colors.blueAccent),
                        ),
                        VerticalDivider(
                          color: Colors.black,
                          width: 1,
                          thickness: 10,
                        ),
                        Text(
                          doc['status'],
                          style: TextStyle(
                              fontSize: 13, color: Colors.blueAccent),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 15),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(doc['photoUrl']))),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                LikeButton(
                  likeCount: doc['likes'],
                  onTap: (bool isLiked) async{
                    await db.updateDoc('news', doc.id, {
                      'likes': isLiked ? doc['likes']-1 : doc['likes']+1
                    });
                    return !isLiked;
                  },
                ),
                IconButton(
                    color: Colors.green,
                    icon: Icon(Icons.comment),
                    onPressed: () {
                        return showCupertinoDialog(context: context, builder: (context){
                          TextEditingController comment = TextEditingController();
                          return InputCard(
                            backgroundColor: Colors.amberAccent,
                            actionTitle: 'Add Comment',
                            maxLines: 3,
                            title: 'Add Your Comment',
                            controller: comment,
                            validation: true,
                            onPressedAction: () async {
                              await db.updateDoc('news', doc.id, {
                                'comments': FieldValue.arrayUnion([{'${doc['uid']}':comment.text}])
                              }).then((value) => Navigator.pop(context));
                            },
                          );
                        });
                    }),
                IconButton(
                    color: Colors.deepOrange,
                    icon: Icon(Icons.share),
                    onPressed: () => Share.share('https://example.com/news/${doc.id}', subject: doc['subject'])
                    )
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
          builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                List<QueryDocumentSnapshot> dataList = snapshot.data;
                return SingleChildScrollView(
                  child: Column(
                    children: [for (var doc in dataList) newsRow(doc)],
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
        ));
  }
}
