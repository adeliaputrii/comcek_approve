import 'dart:async';
import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myactivity_project/ramayana_idcashbarcode.dart';
import 'package:myactivity_project/ramayanaidcash.dart';
import 'package:myactivity_project/service/API_service/LogAPI_service.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/settingsralstools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RamayanaIdcashNewPin extends StatefulWidget {
  const RamayanaIdcashNewPin({super.key});

  @override
  State<RamayanaIdcashNewPin> createState() => _RamayanaIdcashNewPinState();
}

class _RamayanaIdcashNewPinState extends State<RamayanaIdcashNewPin> {
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  UserData userData = UserData();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _udid = 'Unknown';
  bool _passwordVisible = false;
  Dio dio = Dio();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    _passwordVisible = false;
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

  snackBar(String? message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message!),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  loginPressed() async {
    print(versi);
    print('daaaaaaamn 23111');
    print(tipeurl);
    try {
      if (password.text.isNotEmpty) {
        print('oke');
        SharedPreferences pref = await SharedPreferences.getInstance();
        var username =pref.getString("username");
        print(username);
        AndroidDeviceInfo info = await deviceInfo.androidInfo;

        http.Response response =
            //  await AuthServices.login(username.text, pass.text);
            await AuthServicesLog.login(
                //' ini versi yang sama kaya diataskan ya del?
                '${username}',
                password.text,
                'RALS-TOOLS',
                '${versi}',
                '${DateTime.now()}',
                'Login Aplikasi RALS',
                '${_udid}',
                '${userData.getUsername7()}',
                'toko',
                '${info.device}',
                '${_udid}');
        Map responseMap = jsonDecode(response.body);
        print(responseMap);
        if (responseMap['userpass'] == "0") {
          await userData.setUser(data: responseMap);
          var formData = FormData.fromMap({
            'progname': 'RALS_TOOLS ',
            'versi': '${versi}',
            'date_run': '${DateTime.now()}',
            'info1': 'Enter PIN ID CASH',
            ' info2': '${_udid} ',
            'userid': '${userData.getUsernameID()}',
            ' toko': '${userData.getUserToko()}',
            ' devicename': '${info.device}',
            'TOKEN': 'R4M4Y4N4'
          });

          var response = await dio.post('${tipeurl}v1/activity/createmylog',
              data: formData);
          print('berhasil $_udid');

          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => RamayanaBarcode()),
              (Route<dynamic> route) => false);
        } else if (responseMap['status'] == 201) {
          snackBar('PIN SALAH');
        }
      }
    } on Exception {
      return snackBar('PIN TIDAK SESUAI');
      //ini buka nya dimana ya del
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, 
      
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              color: Colors.white,
            ),
            Container(
              height: 500,
              color: Color.fromARGB(255, 255, 0, 0),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 50, right: 20),
              // color: Colors.green,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context,
                          MaterialPageRoute(builder: (context) {
                        return RamayanaIDCash();
                      }), (route) => false);
                    },
                    icon: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 25,
                    ),
                  ),
                  Text(
                    'ID CASH',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.arrow_back,
                      color: Color.fromARGB(255, 255, 17, 17),
                      size: 30,
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 20, top: 140, right: 20),
              // color: Colors.green,
              height: 150,
              child: Center(child: Image.asset('assets/rama(C).png')),
            ),
            Container(
              // color: Colors.amber,
              // height: 600,
              margin:
                  EdgeInsets.only(left: 20, top: 350, right: 20, bottom: 50),
              child: Column(
                
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Color.fromARGB(255, 192, 192, 192),
                            blurRadius: 10,
                            offset: Offset(4, 8),
                          )
                        ]),
            
                    // margin: EdgeInsets.only(left: 20, top: 350, right: 20),
                    height: 400,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Masukkan Password",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          Form(
                            key: _formKey,
                            child: Container(
                              margin: EdgeInsets.only(left: 30, right: 30),
                              child: TextFormField(
                                controller: password,
                                obscureText: _passwordVisible ? false : true,
                                validator: RequiredValidator(
                                    errorText: 'Enter Password'),
                                decoration: InputDecoration(
                                    labelText: 'Enter Password',
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.black,
                                            width: 5.0),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    errorBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 255, 17, 17),
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    errorStyle: TextStyle(
                                        color: Color.fromARGB(
                                            255, 255, 17, 17),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400),
                                    labelStyle:
                                        TextStyle(color: Colors.black87),
                                         suffixIcon: IconButton(
                                    icon: Icon(
                                      // Based on passwordVisible state choose the icon
                                      _passwordVisible
                                          ? Icons.visibility
                                          : Icons.visibility_off,
                                      color: Color.fromARGB(255, 255, 17, 17),
                                    ),
                                    onPressed: () {
                                      // Update the state i.e. toogle the state of passwordVisible variable
                                      setState(() {
                                        _passwordVisible = !_passwordVisible;
                                      });
                                    },
                                  ),
                                    prefixIcon: Icon(
                                      Icons.lock,
                                      color:
                                          Color.fromARGB(255, 255, 17, 17),
                                    ),
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: new BorderSide(
                                            color: Colors.black),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:
                                          BorderRadius.circular(10),
                                      borderSide: new BorderSide(
                                          color: Colors.black),
                                    )),
                              ),
                            ),
                          ),
                          isLoading
                              ? SpinKitCircle(
                                  color: Color.fromARGB(255, 255, 17, 17),
                                  size: 60.0,
                                )
                              : MaterialButton(
                            onPressed: ()async {
                              if (_formKey.currentState!.validate()) {
                                setState(() {
                                        isLoading = true;
                                      });
                               await Future.delayed(
                                          const Duration(seconds: 3));
                                      await loginPressed();
                                      setState(() {
                                        isLoading = false;
                                      });
                              }
                            },
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            color: Color.fromARGB(255, 255, 17, 17),
                            height: 50,
                            minWidth: 200,
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )
                        ]),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 15,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Copyright RALS',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                        ),
                        Icon(
                          Icons.copyright,
                          color: Colors.black,
                          size: 18,
                        ),
                        Text(
                          '2022',
                          style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
