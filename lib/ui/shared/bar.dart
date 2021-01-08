import 'package:flutter/material.dart';

class Bar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(100);

  final bool isHelpIcon;
  final double size;
  final String title;
  final bottom;
  final GlobalKey<ScaffoldState> scafoldKey;
  Bar({this.isHelpIcon = true, this.size = 25, this.title = '', this.bottom = null, this.scafoldKey});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      bottom: bottom,
      toolbarHeight: 100,
      leading: IconButton(
       icon: Icon(
         Icons.sort,
         size: size+7,
       ),
        onPressed: () => scafoldKey.currentState.openDrawer(),
      ),
      backgroundColor: Colors.amber,
      elevation: 0.0,
      centerTitle: true,
      title: Text(
        title,
        style: TextStyle(
          fontSize: size
        ),
      ),
      actions: [
        isHelpIcon ? IconButton(
          icon: Icon(
            Icons.live_help_outlined,
            size: size+7,
          ),
          splashColor: Colors.amber,
          onPressed: (){},
        ) : null ,
      ],
    );
  }
}


