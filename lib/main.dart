import 'package:community_support/routes.dart';
import 'package:community_support/ui/screens/auth/otp.dart';
import 'package:community_support/ui/widget/res_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  final String profile = prefs.getString('profile') ?? '';
  final Map<String, dynamic> decoded = profile == '' ? Map() : jsonDecode(profile);
  runApp(MyApp(isLoggedIn, decoded));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  final Map<String, dynamic> profile;
  MyApp(this.isLoggedIn, this.profile);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: isLoggedIn ? (profile['type'] == 'security' || profile['type'] == 'police' ? '/authorityHome' : '/home') : '/loginAs' ,
    );
  }
}
