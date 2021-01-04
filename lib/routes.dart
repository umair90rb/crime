import 'package:community_support/ui/screens/auth/login.dart';
import 'package:community_support/ui/screens/auth/login_as.dart';
import 'package:community_support/ui/screens/auth/register_as.dart';
import 'package:community_support/ui/screens/auth/register_as_authority.dart';
import 'package:community_support/ui/screens/auth/register_as_authority_as.dart';
import 'package:community_support/ui/screens/auth/register_as_public.dart';
import 'package:community_support/ui/screens/authority_home/authority_home_bottom_navigation.dart';
import 'package:community_support/ui/screens/case_solved/case_solved.dart';
import 'package:community_support/ui/screens/home/home_bottom_navigation.dart';
import 'package:community_support/ui/screens/incidents/add_incident.dart';
import 'package:community_support/ui/screens/news/add_news.dart';
import 'package:community_support/ui/screens/pro/upgrade_to_pro.dart';
import 'package:community_support/ui/screens/setting/setting.dart';
import 'package:community_support/ui/screens/splash.dart';
import 'package:flutter/material.dart';
import './ui/screens/profile/profile.dart';
import './ui/screens/my_reports/my_reports.dart';


  final routes = <String, WidgetBuilder>{
    '/splash': (BuildContext context) => Splash(),

    '/loginAs': (BuildContext context) => LoginAs(),
    '/registerAs': (BuildContext context) => RegisterAs(),

    '/login': (BuildContext context) => Login(),

    '/registerAsPublic': (BuildContext context) => RegisterAsPublic(),
    '/registerAsAuthority': (BuildContext context) => RegisterAsAuthority(),
    '/registerAsAuthorityAs': (BuildContext context) => RegisterAsAuthorityAs(),

    '/home': (BuildContext context) => Home(),
    '/reportIncident': (BuildContext context) => AddIncident(),
    '/myReports': (BuildContext context) => MyReports(),

    '/authorityHome': (BuildContext context) => AuthorityHome(),

    '/caseSolved': (BuildContext context) => CaseSolved(),
    '/addNews': (BuildContext context) => AddNews(),

    '/setting': (BuildContext context) => Setting(),
    '/upgradeToPro': (BuildContext context) => UpgradeToPro(),
    '/profile': (BuildContext context) => Profile(),

  };

