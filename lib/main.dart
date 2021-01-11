import 'package:community_support/localization/demo_localization.dart';
import 'package:community_support/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  print(isLoggedIn);
  String profile = await prefs.get('profile') ?? '';
  print('profile $profile');
  final Map<String, dynamic> decoded = profile == '' ? Map() : jsonDecode(profile);
  print(decoded);
  runApp(MyApp(isLoggedIn, decoded));
}

class MyApp extends StatefulWidget {
  final bool isLoggedIn;
  final Map<String, dynamic> profile;
  MyApp(this.isLoggedIn, this.profile);
  static void setLocale(BuildContext context, Locale locale){
    _MyAppState state = context.findAncestorStateOfType<_MyAppState>();
    state.setLocale(locale);
  }


  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

  Locale _locale;

  void setLocale(Locale locale){
    setState(() {
      _locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        localizationsDelegates: [
          DemoLocalization.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        locale: _locale,
        supportedLocales: [
          const Locale('en', 'US'), // English, no country code
          const Locale('ng', 'NG'), // Bengali, no country code
        ],
        localeResolutionCallback: (deviceLocale, supportedLocales){
          for(var locale in supportedLocales){
            if(locale.languageCode == deviceLocale.languageCode &&
                locale.countryCode == deviceLocale.countryCode){
              return deviceLocale;
            }
          }
          return supportedLocales.first;
        },
        debugShowCheckedModeBanner: false,
      routes: routes,
      initialRoute: widget.isLoggedIn ? (widget.profile['type'] == 'security' || widget.profile['type'] == 'police' ? '/authorityHome' : '/home') : '/loginAs' ,
    );
  }
}
