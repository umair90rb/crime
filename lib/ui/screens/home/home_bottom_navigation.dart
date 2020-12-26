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

class _HomeState extends State<Home> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Map(),
    Text('Index 1: Reports'),
    Text('Index 2: News'),
    Text('Index 3: Setting')
  ];




  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<String> title = [
    'ABAGANA SECURITY',
    'REPORTS',
    'NEWS',
    'SETTING'
  ];

  List<String> navigation = [
    'Map',
    'Report',
    'News',
    'Setting'
  ];

  List<IconData> navigationIcon = [
    Icons.add_location,
    Icons.assignment_sharp,
    Icons.chat_outlined,
    Icons.settings
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: Bar(
        scafoldKey: _scaffoldKey,
        title: title.elementAt(_selectedIndex),
      ),
      drawer: AppDrawer(),
      floatingActionButton: FloatingActionButton(
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
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
    );
  }
}
