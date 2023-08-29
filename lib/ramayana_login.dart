// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
// import 'package:flutter_udid/flutter_udid.dart';
// import 'dart:convert';
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:launch_review/launch_review.dart';
// import 'package:motion_toast/resources/arrays.dart';
// import 'package:myactivity_project_dev/env.dart';
// import 'package:myactivity_project_dev/ramayana_device_info.dart';
// import 'package:myactivity_project_dev/ramayana_home.dart';
// import 'package:myactivity_project_dev/ramayana_profile.dart';
// import 'package:dio/dio.dart';
// import 'package:myactivity_project_dev/ramayana_reset.dart';
// import 'package:myactivity_project_dev/ramayanavoid.dart';
// import 'package:myactivity_project_dev/service/API_service/LogAPI_service.dart';
// import 'package:myactivity_project_dev/service/SP_service/SP_service.dart';
// import 'package:myactivity_project_dev/service/API_service/API_service.dart';
// import 'dart:io';
// import 'dart:async';
// import 'package:http/http.dart' as http;
// import 'package:myactivity_project_dev/service/service_api/auth.dart';
// import 'package:platform_device_id/platform_device_id.dart';
// import 'package:rflutter_alert/rflutter_alert.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:motion_toast/motion_toast.dart';
// import 'package:myactivity_project_dev/settingsralstools.dart';

// class RamayanaLogin extends StatefulWidget {
//   const RamayanaLogin({super.key});

//   @override
//   _RamayanaLogin createState() => _RamayanaLogin();
// }

// class _RamayanaLogin extends State<RamayanaLogin> {
//   GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();

//   TextEditingController username = TextEditingController();
//   TextEditingController pass = TextEditingController();
//   TextEditingController password = TextEditingController();
//   TextEditingController passwordReEnter = TextEditingController();

//   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

//   String _udid = 'Unknown';
//   bool isLoading = false;
//   bool _passwordVisible = false;
//   Timer? timer;
//   @override
//   void initState() {
//     print(versi);
//     print('wakwaw 123');
//     super.initState();
//     initPlatformState();
//     _passwordVisible = false;
//     deleteUserData();
//   }

//   Future<void> deleteUserData() async {
//     SharedPreferences pref = await SharedPreferences.getInstance();
//     pref.remove('Reset Username');
//     print('delete username');
//   }

//   Future<void> initPlatformState() async {
//     String udid;
//     try {
//       udid = await FlutterUdid.consistentUdid;
//     } on PlatformException {
//       udid = 'Failed to get UDID.';
//     }

//     if (!mounted) return;

//     setState(() {
//       _udid = udid;
//     });
//   }

//   logout() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove('username');
//     prefs.remove('waktuLogin');
//     print('LOGOUT');
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
//       return RamayanaLogin();
//     }));
//   }

//   String? _userId;
//   String _password = '';

//   UserData userData = UserData();

//   void _displayCenterMotionToast() async {
//     MotionToast(
//       toastDuration: Duration(seconds: 4),
//       icon: Icons.error,
//       primaryColor: Colors.red,
//       title: const Text(
//         'Username/Password not found!',
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//       ),
//       width: 350,
//       backgroundType: BackgroundType.lighter,
//       height: 100,
//       description: const Text(
//         'Please Check Again',
//         style: TextStyle(fontSize: 15),
//       ),
//       //description: "Center displayed motion toast",
//       position: MotionToastPosition.center,
//     ).show(context);
//   }

//   void _displayCenterMotionUsername() async {
//     MotionToast(
//       toastDuration: Duration(seconds: 4),
//       icon: Icons.error,
//       primaryColor: Colors.red,
//       title: const Text(
//         'Username Harus Diisi!',
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//       ),
//       width: 350,
//       backgroundType: BackgroundType.lighter,
//       height: 100,
//       description: const Text(
//         'Please Check Again',
//         style: TextStyle(fontSize: 15),
//       ),
//       //description: "Center displayed motion toast",
//       position: MotionToastPosition.center,
//     ).show(context);
//   }

//   void _displayCenterMotionUsernameCheck() async {
//     MotionToast(
//       toastDuration: Duration(seconds: 4),
//       icon: Icons.error,
//       primaryColor: Colors.red,
//       title: const Text(
//         'Username Tidak Terdaftar!',
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//       ),
//       width: 350,
//       backgroundType: BackgroundType.lighter,
//       height: 100,
//       description: const Text(
//         'Please Check Again',
//         style: TextStyle(fontSize: 15),
//       ),
//       //description: "Center displayed motion toast",
//       position: MotionToastPosition.center,
//     ).show(context);
//   }

//   void _displayCenterMotionToastImei() async {
//     MotionToast(
//       toastDuration: Duration(seconds: 4),
//       icon: Icons.error,
//       primaryColor: Colors.red,
//       // title: const Text(
//       //   'ID Sudah Digunakan di Perangkat Lain',
//       //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//       // ),
//       width: 350,
//       backgroundType: BackgroundType.lighter,
//       height: 100,
//       description: const Text(
//         'Anda tidak memiliki akses',
//         style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//       ),
//       //description: "Center displayed motion toast",
//       position: MotionToastPosition.center,
//     ).show(context);
//   }

//   void _displayCenterMotionToastSuccess() {
//     MotionToast(
//       toastDuration: Duration(seconds: 10),
//       icon: IconlyBold.tickSquare,
//       primaryColor: Colors.green,
//       title: const Text(
//         "Success",
//         style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
//       ),
//       width: 350,
//       backgroundType: BackgroundType.lighter,
//       height: 100,
//       description: const Text(
//         'You can login with a new password',
//         style: TextStyle(fontSize: 15),
//       ),
//       //description: "Center displayed motion toast",
//       position: MotionToastPosition.top,
//     ).show(context);
//   }

//   void updateAplikasi(BuildContext context) {
//     Alert(
//       context: context,
//       type: AlertType.warning,
//       title: "Update Aplikasi",
//       desc: "Anda Perlu Memperbarui Aplikasi",
//       buttons: [
//         DialogButton(
//           color: Color.fromARGB(255, 255, 17, 17),
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           child: Text(
//             "Tidak",
//             style: TextStyle(color: Colors.white, fontSize: 14),
//           ),
//         ),
//         DialogButton(
//           color: Colors.green,
//           onPressed: () async {
//             AndroidDeviceInfo info = await deviceInfo.androidInfo;
//             var formData = FormData.fromMap({
//               'progname': 'RALS_TOOLS ',
//               'versi': '${versi}',
//               'date_run': '${DateTime.now()}',
//               'info1': 'Pop Up Update Aplikasi',
//               ' info2': '${_udid} ',
//               'userid': '${userData.getUsernameID()}',
//               ' toko': '${userData.getUserToko()}',
//               ' devicename': '${info.device}',
//               'TOKEN': 'R4M4Y4N4'
//             });

//             var response = await dio.post('${tipeurl}v1/activity/createmylog',
//                 data: formData);
//             print('berhasil $_udid');
//             LaunchReview.launch(
//                 androidAppId: "com.rals.myactivity_project_dev");
//             Navigator.pop(context);
//           },
//           child: Text(
//             "Ya, Perbarui Aplikasi",
//             style: TextStyle(color: Colors.white, fontSize: 14),
//           ),
//         ),
//       ],
//     ).show();
//     return;
//   }

//   String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

//   loginPressed() async {
//     print(versi);
//     print('daaaaaaamn 23111');
//     print(tipeurl);
//     try {
//       if (username.text.isNotEmpty && pass.text.isNotEmpty) {
//         SharedPreferences pref = await SharedPreferences.getInstance();
//         AndroidDeviceInfo info = await deviceInfo.androidInfo;

//         http.Response response =
//             //  await AuthServices.login(username.text, pass.text);
//             await AuthServicesLog.login(
//                 //' ini versi yang sama kaya diataskan ya del?
//                 username.text,
//                 pass.text,
//                 'RALS-TOOLS',
//                 '${versi}',
//                 '${DateTime.now()}',
//                 'Login Aplikasi RALS',
//                 '${_udid}',
//                 '${username.text}',
//                 'toko',
//                 '${info.device}',
//                 '${_udid}');
//         Map responseMap = jsonDecode(response.body);
//         if (responseMap['userpass'] == "0") {
//           await userData.setUser(data: responseMap);
//           pref.setString("username", "${username.text}");
//           pref.setString("waktuLogin", "${formattedDate}");
//           var formData = FormData.fromMap({
//             'progname': 'RALS_TOOLS ',
//             'versi': '${versi}',
//             'date_run': '${DateTime.now()}',
//             'info1': 'Login Aplikasi RALS',
//             ' info2': '${_udid} ',
//             'userid': '${userData.getUsernameID()}',
//             ' toko': '${userData.getUserToko()}',
//             ' devicename': '${info.device}',
//             'TOKEN': 'R4M4Y4N4'
//           });

//           var response = await dio.post('${tipeurl}v1/activity/createmylog',
//               data: formData);
//           print('berhasil $_udid');

//           Navigator.pushAndRemoveUntil(
//               context,
//               MaterialPageRoute(
//                 builder: (context) =>
//                     DefaultBottomBarController(child: Ramayana()),
//               ),
//               (Route<dynamic> route) => false);
//         } else if (responseMap['status'] == 909) {
//           updateAplikasi(context);
//         } else if (responseMap['userpass'] == "1") {
//           AlertDialog popup = AlertDialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(20),
//             ),
//             // shadowColor: Colors.black,
//             titlePadding: EdgeInsets.all(0),
//             title: Column(
//               children: [
//                 Container(
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(20),
//                           topRight: Radius.circular(20),
//                         ),
//                         color: Color.fromARGB(255, 254, 234, 233)),
//                     height: 190,
//                     width: 2000,
//                     child: Image.asset(
//                       'assets/adel.png',
//                     )),
//                 Container(
//                   margin: EdgeInsets.only(top: 0),
//                   color: Colors.black,
//                   height: 1,
//                   width: 2000,
//                 ),
//               ],
//             ),

//             content: Form(
//               key: _formKey2,
//               child: Container(
//                 height: 230,
//                 width: 500,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceAround,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Password:',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         TextFormField(
//                             controller: password,
//                             style: TextStyle(fontSize: 20, color: Colors.black),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Required";
//                               }

//                               if (value.length != 6) {
//                                 return "Password length must be 6 characters";
//                               }

//                               if (!value.contains(RegExp(r'[0-9]'))) {
//                                 return "Password must contain a number";
//                               }

//                               if (value == username.text) {
//                                 return "Password can't same with username";
//                               }
//                             },
//                             obscureText: true,
//                             keyboardType: TextInputType.number,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly
//                             ],
//                             decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: Colors.black, width: 5.0),
//                                     borderRadius: BorderRadius.circular(60)),
//                                 errorBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Color.fromARGB(255, 255, 17, 17),
//                                     ),
//                                     borderRadius: BorderRadius.circular(60)),
//                                 errorStyle: TextStyle(
//                                     color: Color.fromARGB(255, 255, 17, 17),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400),
//                                 labelStyle: TextStyle(color: Colors.black87),
//                                 prefixIcon: Icon(
//                                   IconlyBroken.lock,
//                                   color: Color.fromARGB(255, 255, 17, 17),
//                                 ),
//                                 hintStyle: TextStyle(
//                                     color: Colors.black, fontSize: 20),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderSide:
//                                         new BorderSide(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(60)),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide:
//                                         new BorderSide(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(60)))),
//                       ],
//                     ),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Re-Enter Password:',
//                           style: TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 15),
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         TextFormField(
//                             controller: passwordReEnter,
//                             style: TextStyle(fontSize: 20, color: Colors.black),
//                             validator: (value) {
//                               if (value!.isEmpty) {
//                                 return "Required";
//                               }

//                               if (!value.contains(RegExp(r'[0-9]'))) {
//                                 return "Password must contain a number";
//                               }

//                               if (value != password.text) {
//                                 return "Please Re-Enter password correctly";
//                               }
//                             },
//                             obscureText: true,
//                             keyboardType: TextInputType.number,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.digitsOnly
//                             ],
//                             decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: Colors.black, width: 5.0),
//                                     borderRadius: BorderRadius.circular(60)),
//                                 errorBorder: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                       color: Color.fromARGB(255, 255, 17, 17),
//                                     ),
//                                     borderRadius: BorderRadius.circular(60)),
//                                 errorStyle: TextStyle(
//                                     color: Color.fromARGB(255, 255, 17, 17),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400),
//                                 labelStyle: TextStyle(color: Colors.black87),
//                                 prefixIcon: Icon(
//                                   IconlyBroken.lock,
//                                   color: Color.fromARGB(255, 255, 17, 17),
//                                 ),
//                                 hintStyle: TextStyle(
//                                     color: Colors.black, fontSize: 20),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderSide:
//                                         new BorderSide(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(60)),
//                                 focusedBorder: OutlineInputBorder(
//                                   borderRadius: BorderRadius.circular(60),
//                                   borderSide:
//                                       new BorderSide(color: Colors.black),
//                                 )))
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//             actions: [
//               Container(
//                 margin: EdgeInsets.only(left: 20),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     Container(
//                       margin: EdgeInsets.only(left: 80, right: 80),
//                       child: MaterialButton(
//                           height: 40,
//                           padding: EdgeInsets.symmetric(horizontal: 80),
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(40),
//                           ),
//                           color: Color.fromARGB(255, 255, 17, 17),
//                           child: Text('Submit',
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w500,
//                                   fontSize: 17)),
//                           onPressed: () async {
//                             if (_formKey2.currentState!.validate()) {
//                               _displayCenterMotionToastSuccess();

//                               var formData = FormData.fromMap({
//                                 'user_name': username.text,
//                                 'password': password.text,
//                               });
//                               var response = await dio.post(
//                                   '${tipeurl}api/v1/auth/reset.password',
//                                   data: formData);

//                               print(
//                                   'Berhasil, ${username.text}, ${password.text},${password.text}, ${passwordReEnter.text}');
//                               Duration(seconds: 10);

//                               Navigator.pushAndRemoveUntil(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => RamayanaLogin(),
//                                   ),
//                                   (Route<dynamic> route) => false);
//                             }
//                           }),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       'Note : ',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'Password baru tidak boleh sama dengan username',
//                       style: TextStyle(
//                           color: Colors.black,
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//             actionsAlignment: MainAxisAlignment.start,
//             actionsPadding: EdgeInsets.only(bottom: 30),
//           );
//           showDialog(context: context, builder: (context) => popup);
//         } else if (responseMap['status'] == 201) {
//           _displayCenterMotionToast();
//         }
//       }
//     } on Exception {
//       return _displayCenterMotionToastImei();
//       //ini buka nya dimana ya del
//     }
//   }

//   var dio = Dio();

//   void showWarning() {
//     //do something if username or password isn't filled correctly
//   }

//   fetchDataCustomer({required String user_name}) async {
//     AndroidDeviceInfo info = await deviceInfo.androidInfo;
//     final responseku = await http.post(
//         Uri.parse('${tipeurl}api/v1/auth/reset.username'),
//         body: {'user_name': username.text});

//     var data = jsonDecode(responseku.body);

//     if (data['status'] == 200) {
//       print("API Success oooo");
//       print(data);
//       // ResetPassword.hidden.add(username.text);
//       final SharedPreferences pref = await SharedPreferences.getInstance();
//       pref.setString("Reset Username", "${username.text}");
//       var formData = FormData.fromMap({
//         'progname': 'RALS_TOOLS ',
//         'versi': '${versi}',
//         'date_run': '${DateTime.now()}',
//         'info1': 'Forget Password Aplikasi RALS',
//         ' info2': '${_udid} ',
//         'userid': '${username.text}',
//         ' toko': '${userData.getUserToko()}',
//         ' devicename': '${info.device}',
//         'TOKEN': 'R4M4Y4N4'
//       });

//       var response =
//           await dio.post('${tipeurl}v1/activity/createmylog', data: formData);
//       print('berhasil $_udid');
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => const RamayanaReset()),
//       );
//     } else if (data['status'] != 200) {
//       _displayCenterMotionUsernameCheck();
//     } else {
//       print("No Data");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//               width: 2000,
//               height: 2000,
//               child: Image.asset(
//                 "assets/rmy(C).png",
//                 fit: BoxFit.cover,
//               )),
//           Form(
//             key: _formKey,
//             child: ListView(
//               children: [
//                 Container(
//                     margin: EdgeInsets.fromLTRB(20, 100, 20, 0),
//                     height: 450,
//                     decoration: BoxDecoration(
//                         borderRadius: BorderRadius.circular(20),
//                         color: Colors.white70),
//                     child: Column(
//                       children: <Widget>[
//                         Container(
//                             margin: EdgeInsets.only(top: 40),
//                             height: 130,
//                             child: Image.asset(
//                               "assets/ramay.png",
//                               height: 180,
//                             )),
//                         SizedBox(
//                           height: 50,
//                         ),
//                         Container(
//                           margin: EdgeInsets.only(left: 10, right: 20),
//                           child: TextFormField(
//                             cursorColor: Colors.black,
//                             controller: username,
//                             validator:
//                                 RequiredValidator(errorText: 'Please Enter'),
//                             keyboardType: TextInputType.multiline,
//                             style: TextStyle(fontSize: 20, color: Colors.black),
//                             decoration: InputDecoration(
//                                 border: OutlineInputBorder(
//                                   borderSide: BorderSide(
//                                       color: Colors.black, width: 5.0),
//                                   borderRadius: BorderRadius.circular(25),
//                                 ),
//                                 errorBorder: OutlineInputBorder(
//                                     borderRadius: BorderRadius.circular(25),
//                                     borderSide: BorderSide(
//                                       color: Color.fromARGB(255, 255, 17, 17),
//                                     )),
//                                 errorStyle: TextStyle(
//                                     color: Color.fromARGB(255, 255, 17, 17),
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.w400),
//                                 labelStyle: TextStyle(color: Colors.black),
//                                 prefixIcon: Icon(
//                                   Icons.person,
//                                   color: Color.fromARGB(255, 255, 17, 17),
//                                   size: 30,
//                                 ),
//                                 hintText: 'Username',
//                                 hintStyle: TextStyle(
//                                     color: Colors.black, fontSize: 20),
//                                 enabledBorder: OutlineInputBorder(
//                                     borderSide:
//                                         new BorderSide(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(25)),
//                                 focusedBorder: OutlineInputBorder(
//                                     borderSide:
//                                         new BorderSide(color: Colors.black),
//                                     borderRadius: BorderRadius.circular(25))),
//                           ),
//                         ),
//                         SizedBox(height: 30),
//                         Container(
//                           margin: EdgeInsets.only(left: 10, right: 20),
//                           child: TextFormField(
//                               controller: pass,
//                               style:
//                                   TextStyle(fontSize: 20, color: Colors.black),
//                               validator: (value) {
//                                 if (value!.isEmpty) {
//                                   return "Please Enter";
//                                 }
//                               },
//                               obscureText: _passwordVisible ? false : true,
//                               keyboardType: TextInputType.multiline,
//                               decoration: InputDecoration(
//                                   border: OutlineInputBorder(
//                                     borderSide: BorderSide(
//                                         color: Colors.black, width: 5.0),
//                                     borderRadius: BorderRadius.circular(25),
//                                   ),
//                                   errorBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(25),
//                                       borderSide: BorderSide(
//                                         color: Color.fromARGB(255, 255, 17, 17),
//                                       )),
//                                   errorStyle: TextStyle(
//                                       color: Color.fromARGB(255, 255, 17, 17),
//                                       fontSize: 14,
//                                       fontWeight: FontWeight.w400),
//                                   labelStyle: TextStyle(color: Colors.black87),
//                                   prefixIcon: Icon(
//                                     Icons.lock,
//                                     color: Color.fromARGB(255, 255, 17, 17),
//                                   ),
//                                   suffixIcon: IconButton(
//                                     icon: Icon(
//                                       // Based on passwordVisible state choose the icon
//                                       _passwordVisible
//                                           ? Icons.visibility
//                                           : Icons.visibility_off,
//                                       color: Color.fromARGB(255, 255, 17, 17),
//                                     ),
//                                     onPressed: () {
//                                       // Update the state i.e. toogle the state of passwordVisible variable
//                                       setState(() {
//                                         _passwordVisible = !_passwordVisible;
//                                       });
//                                     },
//                                   ),
//                                   hintText: 'Password',
//                                   hintStyle: TextStyle(
//                                       color: Colors.black, fontSize: 20),
//                                   enabledBorder: OutlineInputBorder(
//                                       borderSide:
//                                           new BorderSide(color: Colors.black),
//                                       borderRadius: BorderRadius.circular(25)),
//                                   focusedBorder: OutlineInputBorder(
//                                       borderSide:
//                                           new BorderSide(color: Colors.black),
//                                       borderRadius:
//                                           BorderRadius.circular(25)))),
//                         ),
//                       ],
//                     )),
//                 Column(
//                   children: <Widget>[
//                     SizedBox(height: 20),
//                     FittedBox(
//                       fit: BoxFit.fill,
//                       child: Row(
//                         children: [
//                           isLoading
//                               ? SpinKitCircle(
//                                   color: Color.fromARGB(255, 255, 17, 17),
//                                   size: 60.0,
//                                 )
//                               : MaterialButton(
//                                   padding: EdgeInsets.symmetric(horizontal: 50),
//                                   height: 40,
//                                   shape: RoundedRectangleBorder(
//                                     borderRadius: BorderRadius.circular(20),
//                                   ),
//                                   child: Text(
//                                     'Sign In',
//                                     style: TextStyle(
//                                         color: Colors.white, fontSize: 18),
//                                   ),
//                                   color: Colors.red,
//                                   onPressed: () async {
//                                     if (_formKey.currentState!.validate()) {
//                                       SharedPreferences pref = await SharedPreferences.getInstance();
//                                       print(tipeurl);
//                                       setState(() {
//                                         isLoading = true;
//                                       });
//                                       await Future.delayed(
//                                           const Duration(seconds: 3));
//                                       await loginPressed();
//                                       setState(() {
//                                         isLoading = false;
//                                       });
//                                       print('huhu');
//                                     }
//                                   }),
//                         ],
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     MaterialButton(
//                         padding: EdgeInsets.symmetric(horizontal: 50),
//                         height: 40,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(20),
//                         ),
//                         child: Text(
//                           'Forget Password?',
//                           style: TextStyle(color: Colors.white, fontSize: 18),
//                         ),
//                         // color: Colors.red,
//                         onPressed: () {
//                           if (username.text.isEmpty) {
//                             _displayCenterMotionUsername();
//                           } else {
//                             fetchDataCustomer(user_name: username.text);
//                           }
//                         }),
//                     SizedBox(
//                       height: 70,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         Text(
//                           'Version ${versi} Copyright EDP',
//                           // ini pak?
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 17,
//                               fontWeight: FontWeight.w400),
//                         ),
//                         Icon(
//                           Icons.copyright,
//                           color: Colors.white,
//                           size: 18,
//                         ),
//                         Text(
//                           '2022',
//                           style: TextStyle(
//                               fontSize: 17,
//                               fontWeight: FontWeight.w500,
//                               color: Colors.white),
//                         )
//                       ],
//                     )
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
