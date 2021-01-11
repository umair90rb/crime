import 'package:community_support/main.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class AppDrawer extends StatefulWidget {


  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {

  Map<String, dynamic> decodedProfile;
  Future getProfile;
  List icons;
  List drawer;
  List onTap;

  _getProfile() async {
    print('here');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic profile = await prefs.get('profile');
    print(profile);
    decodedProfile = jsonDecode(profile);
    print(decodedProfile);

    icons = [
      Icons.person_outline,
      Icons.notifications_none,
      decodedProfile['type'] == 'security' || decodedProfile['type'] == 'police' ? Icons.check_box  : Icons.comment_bank_outlined,
      Icons.chat,
      Icons.info_outlined,
      Icons.translate_outlined
    ];


    drawer = [
      'My Profile',
      'Alerts',
      decodedProfile['type'] == 'security' || decodedProfile['type'] == 'police' ? 'Case Solved' : 'My Posts',
      'Chat',
      'About Us',
      'Change Language'
    ];

    onTap = [
          (){Navigator.pushNamed(context, '/profile', arguments: decodedProfile);},
          (){},
          (){Navigator.pushNamed(context, decodedProfile['type'] == 'security' || decodedProfile['type'] == 'police' ? '/caseSolved' : '/myReports');},
          (){ Navigator.pushNamed(context, '/chat');},
          (){},
          (){ Navigator.pushNamed(context, '/language');}
    ];
    return true;
  }

  @override
  void initState() {
    print('state');
    getProfile = _getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    return FutureBuilder(
      future: getProfile,
      builder: (context, snapshot) {
        if(snapshot.hasData){

        return SizedBox(
          width: MediaQuery.of(context).size.width*0.95,
          child: Drawer(
            elevation: 0.0,
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 150,
                  child: DrawerHeader(

                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Material(
                            borderRadius: BorderRadius.circular(30),
                            elevation: 4,
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.transparent,
                              child: ClipOval(
                                child: Image.network(decodedProfile['avatar']),
                              ),
                            ),
                          ),
                          Center(child: Text(
                            decodedProfile['full_name'].toUpperCase(),
                            style: TextStyle(
                                fontSize: 16
                            ),
                          ),)

                        ],
                      )
                  ),
                ),

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
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove('user');
                    await prefs.remove('profile');
                    await prefs.setBool('isLoggedIn', false);
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
        return Drawer(
          child: Column(
            children: [
              LinearProgressIndicator(
                minHeight: 1.75,
                backgroundColor: Colors.white,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.amber),
              )
            ],
          ),
        );
      }
    );
  }
}
