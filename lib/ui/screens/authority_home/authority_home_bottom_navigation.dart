import 'authority_news.dart';
import 'package:community_support/ui/screens/setting/setting.dart';
import 'package:community_support/ui/shared/bar.dart';
import 'package:community_support/ui/shared/drawer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'authority_report.dart';

class AuthorityHome extends StatefulWidget {

  @override
  _AuthorityHomeState createState() => _AuthorityHomeState();
}

class _AuthorityHomeState extends State<AuthorityHome> with AutomaticKeepAliveClientMixin{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    AuthorityReport(),
    AuthorityNews(),
    Setting()
  ];




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  bool get wantKeepAlive => true;


  List<String> title = [
    'ABAGANA SECURITY',
    'NEWS',
    'SETTING'
  ];

  List<String> navigation = [
    'Report',
    'News',
    'Setting'
  ];

  List<IconData> navigationIcon = [
    Icons.assignment_sharp,
    Icons.chat_outlined,
    Icons.settings
  ];


  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: Bar(
        scafoldKey: _scaffoldKey,
        title: title.elementAt(_selectedIndex),
      ),
      drawer: AppDrawer(),
      floatingActionButton: _selectedIndex == 2 ? null :FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, '/addNews'),
        backgroundColor: Colors.red,
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        iconSize: 30,
        unselectedFontSize: 20,
        selectedIconTheme: IconThemeData(
          color: Colors.amber
        ),
        unselectedIconTheme: IconThemeData(
          color: Colors.white
        ),
        selectedFontSize: 20,
        showUnselectedLabels: true,
        unselectedItemColor: Colors.white,
        items: navigation.asMap().entries.map((e) {
          return BottomNavigationBarItem(
              icon: Icon(
                navigationIcon[e.key]
              ),
              label: e.value.toString()
          );
        }).toList(),
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber,
        onTap: _onItemTapped,
        backgroundColor: Colors.grey,
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
