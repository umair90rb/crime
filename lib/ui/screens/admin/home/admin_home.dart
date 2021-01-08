import 'package:community_support/ui/screens/admin/home/authority.dart';
import 'package:community_support/ui/screens/admin/home/public.dart';
import 'package:community_support/ui/screens/admin/news/news.dart';
import 'package:community_support/ui/screens/admin/shared/drawer.dart';
import 'package:community_support/ui/shared/bar.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> with TickerProviderStateMixin {

  GlobalKey<ScaffoldState> _scaffold = GlobalKey<ScaffoldState>();

  TabController tab;

  List<bool> _selection;
  @override
  void initState() {
    _selection = [true,false];
    tab = TabController(length: 2, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffold,
      drawer: AdminDrawer(),
      appBar: Bar(
        title: 'Admin Panel',
        isHelpIcon: true,
        scafoldKey: _scaffold,
      ),
      body: Column(
        children: [
          SizedBox(height: 10,),
          Center(
            child: ToggleButtons(
              children: [
                Text('User'),
                Text('Authority')
              ],
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderWidth: 0,
              fillColor: Colors.black,
              selectedColor: Colors.white,
              splashColor: Colors.amber,
              color: Colors.black,
              constraints: BoxConstraints(
                  minWidth: 150,
                  minHeight: 40
              ),
              onPressed: (int index){
                print('index $index');
                print('previous ${tab.previousIndex}');
                setState(() {
                  _selection[index == 0 ? 1 : 0] = !_selection[index == 0 ? 1 : 0];
                  _selection[index] = true;
                });
                tab.animateTo(index);
              },
              isSelected: _selection,

            ),
          ),

          SizedBox(
            height: 10,
          ),

          Expanded(
            child: TabBarView(
              controller: tab,
              children: [
                PublicUsersList(),
                AuthorityUserList(),
            ],),
          )
        ],
      ),
    );
  }
}
