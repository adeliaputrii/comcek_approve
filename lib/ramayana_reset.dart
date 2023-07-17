import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:flutter/material.dart';
import 'package:myactivity_project/ramayana_login.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/settingsralstools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RamayanaReset extends StatefulWidget {
  const RamayanaReset({Key? key}) : super(key: key);

  @override
  State<RamayanaReset> createState() => _RamayanaResetState();
}

class _RamayanaResetState extends State<RamayanaReset> {
  TextEditingController email = TextEditingController();
  var dio = Dio();
  bool _isLoading = false;
  String _udid = 'Unknown';
  UserData userData = UserData();

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String udid;
    try {
      udid = await FlutterUdid.consistentUdid;
    } on PlatformException {
      udid = 'Failed to get UDID.';
    }

    if (!mounted) return;

    setState(() {
      _udid = udid;
    });
  }

  // void _displayCenterMotionToastSuccess() {
  //       MotionToast(
  //         toastDuration: Duration(seconds: 10),
  //         icon: IconlyBold.tickSquare,
  //         primaryColor: Color.fromARGB(255, 250, 66, 41),
  //         title: Text(
  //           message,
  //           style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
  //         ),
  //         width: 350,
  //         backgroundType: BackgroundType.lighter,
  //         height: 100,
  //         description: const Text(
  //           '',
  //           style: TextStyle(fontSize: 15),
  //         ),
  //         //description: "Center displayed motion toast",
  //         position: MotionToastPosition.top,
  //       ).show(context);
  //     }

  fetchDataApi({required String user_name}) async {
    AndroidDeviceInfo info = await deviceInfo.androidInfo;
    final SharedPreferences pref = await SharedPreferences.getInstance();
    var reset2 = pref.getString("Reset Username");

    void _displayCenterMotionToastEmail() {
      MotionToast(
        toastDuration: Duration(seconds: 10),
        icon: IconlyBold.tickSquare,
        primaryColor: Color.fromARGB(255, 250, 66, 41),
        title: Text(
          "Email Tidak Terdaftar",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
        ),
        width: 350,
        backgroundType: BackgroundType.lighter,
        height: 100,
        description: const Text(
          '',
          style: TextStyle(fontSize: 15),
        ),
        //description: "Center displayed motion toast",
        position: MotionToastPosition.top,
      ).show(context);
    }

    try {
      final responseku = await http.post(
          Uri.parse('${tipeurl}api/v1/auth/reset.password'),
          body: {'user_name': reset2, 'email': email.text});

      var data = jsonDecode(responseku.body);
      var message = "${data['message']}";

      void _displayCenterMotionToastSuccess() {
        MotionToast(
          toastDuration: Duration(seconds: 10),
          icon: IconlyBold.tickSquare,
          primaryColor: Color.fromARGB(255, 47, 221, 4),
          title: Text(
            message,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          width: 350,
          backgroundType: BackgroundType.lighter,
          height: 100,
          description: const Text(
            '',
            style: TextStyle(fontSize: 15),
          ),
          //description: "Center displayed motion toast",
          position: MotionToastPosition.top,
        ).show(context);
      }

      // var message = "${data['message']}";
      void _displayCenterMotionToastFailed() {
        MotionToast(
          toastDuration: Duration(seconds: 10),
          icon: IconlyBold.tickSquare,
          primaryColor: Color.fromARGB(255, 250, 66, 41),
          title: Text(
            message,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
          ),
          width: 350,
          backgroundType: BackgroundType.lighter,
          height: 100,
          description: const Text(
            '',
            style: TextStyle(fontSize: 15),
          ),
          //description: "Center displayed motion toast",
          position: MotionToastPosition.top,
        ).show(context);
      }

      if (data['status'] == 200) {
        print("API Success oooo");
        print(data);
        var formData = FormData.fromMap({
          'progname': 'RALS_TOOLS ',
          'versi': '${versi}',
          'date_run': '${DateTime.now()}',
          'info1': 'Reset Password Aplikasi Rals',
          ' info2': '${_udid} ',
          'userid': '${reset2}',
          ' toko': '${userData.getUserToko()}',
          ' devicename': '${info.device}',
          'TOKEN': 'R4M4Y4N4'
        });

        var response =
            await dio.post('${tipeurl}v1/activity/createmylog', data: formData);
        print('berhasil $_udid');
        _displayCenterMotionToastSuccess();
        // ResetPassword.hidden.add(username.text);
      } else if (data['status'] != 200) {
        print(message);
        print("ini yang salah");
        _displayCenterMotionToastFailed();
      } else {
        print("No Data");
      }
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {
        return RamayanaLogin();
      }));
    } on Exception {
      _displayCenterMotionToastEmail();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 238, 34, 34),
        title: Center(
          child: Text(
            "Forgot Password",
          ),
        ),
      ),
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                margin: EdgeInsets.only(top: 100),
                child: CircleAvatar(
                  child: Image.asset('assets/gembok.png'),
                  backgroundColor: Color.fromARGB(157, 238, 182, 178),
                  radius: 100,
                ),
              ),
              // Container(
              //     margin: EdgeInsets.only(top: 100),
              //     child: Image.asset('assets/affah.png')),
              Container(
                margin: EdgeInsets.only(left: 60, right: 60, top: 50),
                child: TextFormField(
                  controller: email,
                  decoration: InputDecoration(
                    hintText: "Email",
                  ),
                ),
              ),
              // Container(
              //   margin: EdgeInsets.only(left: 60, right: 60, top: 50),
              //   child: TextFormField(
              //     decoration: InputDecoration(
              //       hintText: "Username",
              //     ),
              //   ),
              // ),
              Container(
                  margin: EdgeInsets.only(left: 150, right: 150, top: 20),
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(100)),
                  child: _isLoading
                      ? SpinKitFadingCircle(
                          // itemBuilder: (BuildContext context, int index) {
                          //   return DecoratedBox(
                          //     decoration: BoxDecoration(
                          //       color: index.isEven ? Colors.red : Colors.green,
                          //     ),
                          //   );
                          // },
                          color: Colors.red,
                        )
                      : MaterialButton(
                          color: Color.fromARGB(255, 241, 200, 75),
                          child: Text("Kirim"),
                          onPressed: () async {
                            setState(() {
                              _isLoading = true;
                            });
                            await Future.delayed(const Duration(seconds: 3));

                            SharedPreferences pref =
                                await SharedPreferences.getInstance();
                            var reset = pref.getString("Reset Username");
                            var formData = FormData.fromMap({
                              'user_name': reset,
                              'email': email.text,
                            });
                            var response = await dio.post(
                                '${tipeurl}api/v1/auth/reset.password',
                                data: formData);
                            print('Berhasil, ${reset}, ${email.text}');

                            setState(() {
                              _isLoading = false;
                            });

                            // pref.remove("Reset Username");
                            if (reset != null) {
                              fetchDataApi(user_name: reset);
                              print(reset);
                            }
                            // _displayCenterMotionToastSuccess();
                            Duration(seconds: 10);
                          }))
            ],
          )
        ],
      ),
    );
  }
}
