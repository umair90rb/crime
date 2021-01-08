import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class AdminDrawer extends StatefulWidget {


  @override
  _AdminDrawerState createState() => _AdminDrawerState();
}

class _AdminDrawerState extends State<AdminDrawer> {

  Map<String, dynamic> decodedProfile;

  List icons = [
    Icons.person_outline,
    Icons.article,
    CupertinoIcons.chart_bar_square_fill,
    Icons.code,
    CupertinoIcons.lock,
    CupertinoIcons.chat_bubble_fill,
    CupertinoIcons.square_list,
  ];
  List drawer = [
    'Registration',
    'News',
    'Reports',
    'Generate Code',
    'Premium',
    'Live Chat',
    'Terms & Conditions'
  ];



  _getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    String profile = prefs.getString('profile');
    decodedProfile = jsonDecode(profile);
    return true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

        List onTap  = [
              (){Navigator.pushNamed(context, '/admin');},
              (){Navigator.pushNamed(context, '/allNews');},
              (){Navigator.pushNamed(context, '/allReports');},
              (){Navigator.pushNamed(context, '/code');},
              (){},
              (){},
              (){}
        ];


    return SizedBox(
          width: 200,
          child: Drawer(
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                SizedBox(height: 50,),


                Expanded(
                  flex: 2,
                  child: ListView.builder(
                      itemCount: drawer.length,
                      itemBuilder: (context, i){
                        return ListTile(
                          onTap: onTap[i],
                          leading: Icon(icons[i]),
                          title: Text(drawer[i]),
                        );
                      }),
                ),

                InkWell(
                  onTap: () async {
                    // final prefs = await SharedPreferences.getInstance();
                    // prefs.remove('user');
                    // prefs.remove('profile');
                    // prefs.setBool('isLoggedIn', false);
                    print('logout');
                    Navigator.pushNamed(context, '/loginAs');
                  },
                  child: ListTile(
                      leading: Icon(Icons.logout),
                      title: Text('Log Out')
                  ),
                )

              ],
            ),
          ),
        );
  }
}
