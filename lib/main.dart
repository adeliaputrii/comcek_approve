import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_history.dart';
import 'package:myactivity_project/ramayana_signup.dart';
import 'package:myactivity_project/ramayana_splashscreen.dart';
import 'package:myactivity_project/ramayana_history.dart';
import 'package:myactivity_project/ramayana_activity.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_login.dart';
import 'package:myactivity_project/ramayana_profile.dart';
import 'package:myactivity_project/ramayana_void.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'database/database.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  var username =prefs.getString("username");
  print(username);
  runApp(MaterialApp(
     builder: (context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 1200,
        minWidth: 480,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.autoScale(600, name : PHONE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.autoScale(1200, name : DESKTOP),
      ],
    ),
    title: 'rals-tools',
    debugShowCheckedModeBanner: false,
    home: DefaultBottomBarController(child: Ramayana())
    // username == null ? SplashScreenRamayana() : DefaultBottomBarController(child: Ramayana()),
    ));
   }


