import 'package:community_support/ui/screens/auth/login.dart';
import 'package:community_support/ui/screens/auth/login_as.dart';
import 'package:community_support/ui/screens/auth/otp.dart';
import 'package:community_support/ui/screens/auth/register_as.dart';
import 'package:community_support/ui/screens/auth/register_as_authority.dart';
import 'package:community_support/ui/screens/auth/register_as_authority_as.dart';
import 'package:community_support/ui/screens/auth/register_as_public.dart';
import 'package:community_support/ui/screens/home/home_bottom_navigation.dart';
import 'package:community_support/ui/screens/incidents/add_incident.dart';
import 'package:community_support/ui/screens/splash.dart';
import 'package:flutter/material.dart';

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

  };

