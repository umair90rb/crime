import 'package:community_support/localization/demo_localization.dart';
import 'package:community_support/ui/screens/home/news.dart';
import 'package:community_support/ui/screens/home/report.dart';
import 'package:community_support/ui/screens/setting/setting.dart';
import 'package:community_support/ui/shared/bar.dart';
import 'package:community_support/ui/shared/drawer.dart';
import 'package:community_support/ui/widget/input.dart';
import 'map.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with AutomaticKeepAliveClientMixin{
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;
  List<Widget> _widgetOptions;

  @override
  void initState() {
    _widgetOptions = <Widget>[
      Map(_scaffoldKey),
      Report(),
      News(),
      Setting()
    ];
    super.initState();
  }




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  bool get wantKeepAlive => true;



  List<String> navigation = [
    'Map',
    'Report',
    'News',
    'Setting'
  ];

  List<IconData> navigationIcon = [
    Icons.location_pin,
    Icons.assignment_sharp,
    Icons.chat_outlined,
    Icons.settings
  ];


  @override
  Widget build(BuildContext context) {
    List<String> title = [
      'ABAGANA SECURITY',
      'REPORT',
      'NEWS',
      'SETTING'
    ];

    super.build(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: Bar(
        scafoldKey: _scaffoldKey,
        title: title.elementAt(_selectedIndex),
      ),
      drawer: AppDrawer(),
      floatingActionButton: _selectedIndex == 3 ? null :FloatingActionButton(
        heroTag: 'btn1',
        onPressed: () => Navigator.pushNamed(context, '/reportIncident'),
        backgroundColor: Colors.red,
        child: Icon(
          Icons.report_outlined,
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
      body:  _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
