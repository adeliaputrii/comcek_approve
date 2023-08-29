
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:form_field_validator/form_field_validator.dart';  
import 'package:screen_brightness/screen_brightness.dart';
import 'package:myactivity_project/settingsralstools.dart';

class RamayanaVoid extends StatefulWidget {
    static const routeName = '/RamayanaVoid';
  const RamayanaVoid({super.key});

  @override
  State<RamayanaVoid> createState() => _RamayanaVoidState();
}

class _RamayanaVoidState extends State<RamayanaVoid> with RouteAware {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _udid = 'Unknown';
    var dio = Dio();
  UserData userData = UserData();
  bool _isKeptOn = true;
  double _brightness = 1.0;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    print('123');
  }
//adel kalo void apa?


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


  TextEditingController myController = TextEditingController();

  String _scanBarcode = '';
  bool _visible = false;

  @override
  void didPush() {
    super.didPush();
    ScreenBrightness().setScreenBrightness(1.0);
  }

  @override
  void didPopNext() {
    super.didPopNext();
    ScreenBrightness().setScreenBrightness(1.0);
  }

  Future<String> _getLogikaVoid() async {
    // user id
    UserData userData = UserData();
    await userData.getPref();
    String userId = userData.getUsernameID();
    // String userId = '460545';
    String? randomAngka = myController.text;
    print('grgr 123');
    print(userId);
    
    late int numberStepOne;
    late int numberStepTwo;

    late String result;

    if (randomAngka != null && userId != null) {
    numberStepOne = stepOne(input: randomAngka);
    numberStepTwo = stepTwo(input: numberStepOne);
    result = stepThree(
      angkaKedua: numberStepTwo.toString(), angkaPertama: userId);
    print('Hasil : ${result}');
  }
  return result;
}

  int stepOne({required String input}) {
  int current = 1;
  for (int i = 0; i < input.length; i++) {
    print('Check number :${input[i]} at index $i');
    if (input[i] == '0') {
      print('catch 1');
      print('current = $current * ${i + 1}');
      current = current * (i + 1);
      print('coba current if');
      print(current);
    } else {
      print('catch 2');
      print('current = $current * ${int.parse(input[i])}');
      current = current * int.parse(input[i]);
      print('coba current else');
      print(current);
    }
    print('current val is $current');
  }
  return current;
}

int stepTwo({required int input}) {
  print('coba hasil input');
  print(input);
  return (input * 121) - 100;
}

String stepThree({required String angkaPertama, required String angkaKedua}) {
  int prefixNumber = 0;
  int postNumber = 0;
  if (angkaPertama.length >= 3) {
    prefixNumber = int.parse(angkaPertama.substring(0, 3)) + 13;
    postNumber = int.parse(angkaPertama.substring(3, angkaPertama.length)) + 18;
  }
   else if (angkaPertama.length > 0) {
    prefixNumber = 
      int.parse(angkaPertama.substring(0, angkaPertama.length)) + 13;
  } 
  else {}
  return '${prefixNumber}X${angkaKedua}B${postNumber}';
}
  
  String data = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
        appBar: AppBar(
           leading: 
           IconButton(onPressed: () {
             Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DefaultBottomBarController(child: Ramayana()),), (Route<dynamic> route) => false);
           },
          icon: Icon(Icons.arrow_back, size: 30,),),
          title: Text('Void', style: TextStyle(fontSize: 23)),
          backgroundColor: Color.fromARGB(255, 255, 17, 17),
          elevation: 7.20  ,
          toolbarHeight: 90,
          ),
    
        body: 
        
        ListView(
          children: [
            Stack(
                children: <Widget>[
    
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    color: Color.fromARGB(255, 253, 249, 249)
                  ),
    
                  Container(
                    width: MediaQuery.of(context).size.width/1,
                    height: 170,
                    color: Color.fromARGB(255, 255, 17, 17),
                  ),
                  
                  Container(
                  margin: EdgeInsets.fromLTRB(30, 30,30, 0),
                  
                  child:
                    Text(
                    'Approval Void & Return', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23, color: Colors.white),
                     ),
                    ),
    
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 100, 10, 0),  
                    height: 200,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [BoxShadow( 
                      blurRadius: 5
                      )]
                      ),
                ),
                    
                  SizedBox(
                  height: 30,
                  width: 30,
                  ),
                          
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 130, 30, 0),
                    child:
    
                      Form(
                        key: _formKey,
                          child: 
    
                          TextFormField(
                            controller: myController,
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            validator: (value) {
                            if(value!.isEmpty){
                            return "Required";
                           }
                          },
                            keyboardType: TextInputType.number,
                            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                            decoration: InputDecoration(
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                              color: Colors.black, 
                              width: 5.0),
                              borderRadius: BorderRadius.circular(25)
                             ),
                            errorBorder: OutlineInputBorder( 
                              borderSide: BorderSide(color: Color.fromARGB(255, 255, 17, 17),), borderRadius: BorderRadius.circular(25)),
                            errorStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 14, fontWeight: FontWeight.w400),
                            labelStyle: TextStyle(
                             color: Colors.black87
                              ),
                            prefixIcon: Icon(
                             Icons.keyboard,
                             color: Color.fromARGB(255, 255, 17, 17),
                             size: 30,
                            ),
                            hintStyle: TextStyle(
                             color:  Colors.black,
                             fontSize: 20
                             ),
                            enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(25)),
                            focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25),
                            borderSide: new BorderSide(color: Colors.black),
                            )
                            )      
                          )
                      )
                    ),
    
                    Container(
                      margin: EdgeInsets.fromLTRB(160, 230, 160, 0),
                      width: 150,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 17, 17),
                        borderRadius: BorderRadius.circular(30)
                        ),
                        height: 40,
                        child: 
                         
                            TextButton(
                              child: 
                               Text(
                              'GENERATE', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),
                               ),
                              onPressed: () async {
                            didPush();
                            didPopNext();
                                AndroidDeviceInfo info = await deviceInfo.androidInfo;
                          var formData = FormData.fromMap({
                                'progname': 'RALS_TOOLS ',
                                'versi': '${versi}',
                                'date_run': '${DateTime.now()}',
                                'info1': 'Aktivitas Void - Menu Void',
                                ' info2': '${_udid} ',
                                'userid': '${userData.getUsernameID()}',
                                ' toko': '${userData.getUserToko()}',
                                ' devicename': '${info.device}',
                                'TOKEN': 'R4M4Y4N4'
                              });
                              
                               
                              var response = await dio.post(
                                  '${tipeurl}v1/activity/createmylog',
                                  data: formData);   
                                  
                                  print('berhasil $_udid');    
                                 if (_formKey.currentState!.validate()) {
                                  data = await _getLogikaVoid(); 
                                  setState(() {   
                                 _visible = true;
                                  });
                                 }
                                },
                              ),
                          
                            ),
                     
                    Container(
                     margin: EdgeInsets.fromLTRB(10, 350, 10, 0),
                     child: 
                     AnimatedOpacity(
                     opacity: _visible ? 1.0 : 0.0,
                     duration: const Duration(milliseconds: 500),
                     child: 
                     
                     Container(
                         margin: EdgeInsets.fromLTRB(10, 0,10, 0),
                          child: 
                            Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
    
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 0,10, 0),
                                     child: 
                                      Center(
                                        child: 
                                        BarCodeImage(
                                          backgroundColor: Colors.white,
                                          params: Code128BarCodeParams(
                                          "${data}",
                                          lineWidth: 1.5,                // width for a single black/white bar (default: 2.0)
                                          barHeight: 100,               // height for the entire widget (default: 100.0)
                                          withText: false,                // Render with text label or not (default: false)
                                         ),
                                        padding: EdgeInsets.only(bottom: 7),
                                        onError: (error) {               // Error handler
                                          print('error = $error');
                                        },
                                    ),
                                   )
                                ),
                             
                    Container(
                      margin: EdgeInsets.fromLTRB(100,30, 100, 0),
                      child: 
                      PrettyQr(
                        image: AssetImage('assets/ramayana(C).png'),
                        size: 200,
                        data: '$data',
                        errorCorrectLevel: QrErrorCorrectLevel.M,
                        typeNumber: 7,
                        roundEdges: false,
                      ),
                      )
                   ],
                  ),
                  )
                     )
                  ),
                
              ]
              ),
          ],
        ),
      );
      }
      ),
      onWillPop: () async {
        if (true) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
              return DefaultBottomBarController(child: Ramayana());
            }), (route) => false);
            return true;
        }
      },
    );
  }
}




