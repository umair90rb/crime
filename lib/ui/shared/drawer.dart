import 'package:flutter/material.dart';


class AppDrawer extends StatelessWidget {


  List drawer = [
    'My Profile',
    'Alerts',
    'My Posts',
    'About Us',
    'Change Language'
  ];

  List icons = [
    Icons.person_outline,
    Icons.notifications_none,
    Icons.comment_bank_outlined,
    Icons.info_outlined,
    Icons.translate_outlined
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 200,
      child: Drawer(
        elevation: 0.0,
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 100,
              child: DrawerHeader(

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Image.asset('assets/icon/icon.png'),
                    ),
                    Center(child: Text('<Name>'))

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
                        leading: Icon(icons[i]),
                        title: Text(drawer[i]),
                      );
              }),
            ),

            InkWell(
              onTap: (){},
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
