import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_idcash.dart';
import 'package:myactivity_project/ramayana_splashscreen.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_login.dart';
import 'package:myactivity_project/ramayana_profile.dart';
import 'package:myactivity_project/ramayana_void.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';

@pragma('vm:entry-point')


void main() async { 
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs =await SharedPreferences.getInstance();
  String formattedDate =  DateFormat('yyyy-MM-dd').format(DateTime.now());
  print(formattedDate);
   UserData userData = UserData();
    await userData.getPref();
    String userId = userData.getUsernameID();
    print('grgr 123');
    print(userId);
  var username =prefs.getString("username");
  print(" username : ${username}");
  var waktuLogin =prefs.getString("waktuLogin");
  print("waktu login : ${waktuLogin}");
   SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => 
  runApp(
MaterialApp(
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
    home: 
    waktuLogin == formattedDate ? DefaultBottomBarController(child: Ramayana()) : SplashScreenRamayana()
    // username == null ? SplashScreenRamayana() : DefaultBottomBarController(child: Ramayana()),
    // DefaultBottomBarController(child: Ramayana())
    // SplashScreenRamayana()
    
    )),
    );
     
   }

// void main() async { 
  
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs =await SharedPreferences.getInstance();
//   var username =prefs.getString("username");
//   print(username);

//    datetime() async {
//     SharedPreferences prefs =await SharedPreferences.getInstance();
//   var username =prefs.getString("username");

//   var timeNow = DateFormat('HH:mm').format(DateTime.now());             
//   var timeSplit = timeNow.split('');
//   timeSplit.removeAt(2);
//   var timeJoin = timeSplit.join('');
//   var timeint = int.parse(timeJoin);

//   var time = 2349;
//   print(time);
//   print(timeint);

//   if (timeint > time) {
//     SharedPreferences pref =await SharedPreferences.getInstance();
//       pref.remove('username');
//     return
//     MaterialApp(
     
//      builder: (context, child) => ResponsiveWrapper.builder(
//         child,
//         maxWidth: 1200,
//         minWidth: 480,
//         defaultScale: true,
//         breakpoints: [
//           ResponsiveBreakpoint.autoScale(600, name : PHONE),
//           ResponsiveBreakpoint.autoScale(800, name: TABLET),
//           ResponsiveBreakpoint.autoScale(1200, name : DESKTOP),
//       ],
//     ),
//     title: 'rals-tools',
//     debugShowCheckedModeBanner: false,
//     home: 
//    SplashScreenRamayana()
    
//     );
//   } else {
//     return
//     MaterialApp(
//      builder: (context, child) => ResponsiveWrapper.builder(
//         child,
//         maxWidth: 1200,
//         minWidth: 480,
//         defaultScale: true,
//         breakpoints: [
//           ResponsiveBreakpoint.autoScale(600, name : PHONE),
//           ResponsiveBreakpoint.autoScale(800, name: TABLET),
//           ResponsiveBreakpoint.autoScale(1200, name : DESKTOP),
//       ],
//     ),
//     title: 'rals-tools',
//     debugShowCheckedModeBanner: false,
//     home: 
//      username == null ? SplashScreenRamayana() : DefaultBottomBarController(child: Ramayana()),
//     //DefaultBottomBarController(child: Ramayana())
    
//     );
//   }
//   }
//   runApp(
//     await datetime()
//   );
//    }



// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:local_session_timeout/local_session_timeout.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs =await SharedPreferences.getInstance();
//   var username =prefs.getString("username");
//   print(username);
//   var time =prefs.getString("waktuLogin");
//   print(time);
//    SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown,
//   ]).then((value) => 
//   runApp(
//   username == null ? RamayanaLogin() : MyAppHome()
//   ));
// }



// class MyAppHome extends StatelessWidget {
//   MyAppHome({Key? key}) : super(key: key);

//   final _navigatorKey = GlobalKey<NavigatorState>();
//   NavigatorState get _navigator => _navigatorKey.currentState!;

//   /// Make this stream available throughout the widget tree with with any state management library
//   /// like bloc, provider, GetX, ..
//   final sessionStateStream = StreamController<SessionState>();

//   @override
//   Widget build(BuildContext context) {
//     final sessionConfig = SessionConfig(
//       invalidateSessionForAppLostFocus: const Duration(seconds: 5),
//       invalidateSessionForUserInactivity: const Duration(seconds: 4),
//     );
//     sessionConfig.stream.listen((SessionTimeoutState timeoutEvent) {
//       // stop listening, as user will already be in auth page
//       sessionStateStream.add(SessionState.stopListening);
//       if (timeoutEvent == SessionTimeoutState.userInactivityTimeout) {
//         // handle user  inactive timeout
//         _navigator.push(MaterialPageRoute(
//           builder: (_) => SplashScreenRamayana(
//               sessionStateStream: sessionStateStream,),
//         ));
//       } else if (timeoutEvent == SessionTimeoutState.appFocusTimeout) {
//         // handle user  app lost focus timeout
//         _navigator.push(MaterialPageRoute(
//           builder: (_) => SplashScreenRamayana(
//               sessionStateStream: sessionStateStream,),
//         ));
//       }
//     });
//     return SessionTimeoutManager(
//       userActivityDebounceDuration: const Duration(seconds: 1),
//       sessionConfig: sessionConfig,
//       sessionStateStream: sessionStateStream.stream,
//       child: 
//       MaterialApp(
//      builder: (context, child) => ResponsiveWrapper.builder(
//         child,
//         maxWidth: 1200,
//         minWidth: 480,
//         defaultScale: true,
//         breakpoints: [
//           ResponsiveBreakpoint.autoScale(600, name : PHONE),
//           ResponsiveBreakpoint.autoScale(800, name: TABLET),
//           ResponsiveBreakpoint.autoScale(1200, name : DESKTOP),
//       ],
//     ),
//     title: 'rals-tools',
//     debugShowCheckedModeBanner: false,
//     home: 
//     DefaultBottomBarController(child: Ramayana())
//     // SplashScreenRamayana()
    
//     )
//     );
//   }
// }

