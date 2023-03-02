// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:myactivity_project/logout/timeout.dart';

// enum SessionState { startListening, stopListening }

// class SessionTimeoutManager extends StatefulWidget {
//   final SessionConfig _sessionConfig;
//   final Widget child;

//   /// (Optional) Used for enabling and disabling the SessionTimeoutManager
//   ///
//   /// you might want to disable listening, is specific cases as user could be reading, waiting for OTP
//   /// where there is no user activity but you don't want to redirect user to login page
//   /// in such cases SessionTimeoutManager can be disabled and re-enabled when necessary
//   final Stream<SessionState>? _sessionStateStream;

//   /// Since updating [DateTime] fir all user interactions could be expensive, user activity are recorded
//   /// only after [userActivityDateTime] interval, by default its 1 minute
//   final DateTime userActivityDatetime;
//   const SessionTimeoutManager(
//       {Key? key,
//       required sessionConfig,
//       required this.child,
//       sessionStateStream,
//       this.userActivityDatetime =  DateTime.now()})
//       : _sessionConfig = sessionConfig,
//         _sessionStateStream = sessionStateStream,
//         super(key: key);

//   @override
//   _SessionTimeoutManagerState createState() => _SessionTimeoutManagerState();
// }

// class _SessionTimeoutManagerState extends State<SessionTimeoutManager>
//     with WidgetsBindingObserver {
//   DateTime? _userInactivityDateTime;



 


//  DateTime _setTimeout(callback) {
//     return DateTime(callback);
//   }

//   void _clearTimeout(DateTime t) {
//     t.day;
//   }
// }
