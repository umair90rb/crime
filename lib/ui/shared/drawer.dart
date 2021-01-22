import 'package:community_support/localization/demo_localization.dart';
import 'package:community_support/main.dart';
import 'package:community_support/ui/screens/chat/chat_list.dart';
import 'package:community_support/ui/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:community_support/global.dart' as global;
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
  List<bool> _selection = [true, false];

  void _languageChanged(language, context) {
    Locale _temp;
    switch (language) {
      case 0:
        _temp = Locale('en', 'US');
        break;
      case 1:
        _temp = Locale('bn', 'BD');
        break;
      default:
        _temp = Locale('en', 'US');
    }

    MyApp.setLocale(context, _temp);
  }


  _getProfile() async {
    print('geting profile');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic profile = await prefs.get('profile');
    print(profile);
    decodedProfile = jsonDecode(profile);
    print(decodedProfile);

    icons = [
      Icons.person_outline,
      Icons.notifications_none,
      decodedProfile['type'] == 'security' || decodedProfile['type'] == 'police'
          ? Icons.check_box
          : Icons.comment_bank_outlined,
      Icons.chat,
      Icons.info_outlined,
      Icons.translate_outlined
    ];

    onTap = [
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Profile(arg: decodedProfile)));
      },
      () {
        Navigator.pushNamed(context, '/alert');
      },
      () {
        Navigator.pushNamed(
            context,
            decodedProfile['type'] == 'security' ||
                    decodedProfile['type'] == 'police'
                ? '/caseSolved'
                : '/myReports');
      },
      () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatList(decodedProfile['uid'])));
      },
      () {
        Navigator.pushNamed(context, '/about');
      },
      () {}
    ];
    return true;
  }

  Widget langButton(){
    return Builder(
      builder: (context) => ToggleButtons(
        children: [
          Text(
            'Eng',
            style: TextStyle(fontSize: 10),
          ),
          Text(
            'Igbo',
            style: TextStyle(fontSize: 10),
          )
        ],
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderWidth: 0,
        fillColor: Colors.black,
        selectedColor: Colors.white,
        splashColor: Colors.amber,
        color: Colors.black,
        constraints: BoxConstraints(minWidth: 50, minHeight: 30),
        onPressed: (int index) {
          print('index $index');
          setState(() {
            _selection[index == 0 ? 1 : 0] =
            !_selection[index == 0 ? 1 : 0];
            _selection[index] = true;
          });
          _languageChanged(index, context);
          // tab.animateTo(index);
        },
        isSelected: _selection,
      ),
    );
  }

  @override
  void initState() {
    getProfile = _getProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    drawer = [
      DemoLocalization.of(context).getTranslatedValue('my_profile'),
      DemoLocalization.of(context).getTranslatedValue('alert'),
      global.profile['type'] == 'security' || global.profile['type'] == 'police'
          ? DemoLocalization.of(context).getTranslatedValue('case_solved')
          : DemoLocalization.of(context).getTranslatedValue('my_reports'),
      DemoLocalization.of(context).getTranslatedValue('chat'),
      DemoLocalization.of(context).getTranslatedValue('about_us'),
      DemoLocalization.of(context).getTranslatedValue('change_language')
    ];
    return FutureBuilder(
        future: getProfile,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return SizedBox(
              width: MediaQuery.of(context).size.width * 0.95,
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
                          Center(
                            child: Text(
                              decodedProfile['full_name'].toUpperCase(),
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      )),
                    ),
                    Expanded(
                      flex: 2,
                      child: ListView.builder(
                          itemCount: drawer.length,
                          itemBuilder: (context, i) {
                            return ListTile(
                              onTap: onTap[i],
                              leading: Icon(icons[i]),
                              title: Text(drawer[i]),
                              trailing: i == drawer.length-1 ? langButton() : null,
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
                          leading: Icon(Icons.logout), title: Text('Log Out')),
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
        });
  }
}
