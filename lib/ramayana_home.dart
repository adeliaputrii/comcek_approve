import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:intl/intl.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myactivity_project/models/model_approval_return.dart';
import 'package:myactivity_project/models/model_idcash.dart';
import 'package:myactivity_project/models/model_tabel_approve.dart';
import 'package:myactivity_project/models/models_approval_return_list.dart';
import 'package:myactivity_project/ramayana_approval.dart';
import 'package:myactivity_project/ramayana_approval_submenu.dart';
import 'package:myactivity_project/ramayana_comcheck_cek.dart';
import 'package:myactivity_project/ramayana_device_info.dart';
import 'package:myactivity_project/ramayana_id_cash_riwayat.dart';
import 'package:myactivity_project/ramayana_idcash.dart';
import 'package:myactivity_project/ramayana_splashscreen.dart';
import 'package:myactivity_project/service/API_service/LogAPI_service.dart';
import 'package:myactivity_project/service/service_api/auth.dart';
import 'package:path/path.dart' as Path;
import 'package:relative_scale/relative_scale.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:myactivity_project/ramayana_login.dart';
import 'package:myactivity_project/ramayana_profile.dart';
import 'package:myactivity_project/ramayana_void.dart';
import 'package:myactivity_project/service/API_service/API_service.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Ramayana extends StatefulWidget {
  
  const Ramayana({super.key});

  @override
  State<Ramayana> createState() => _RamayanaState();
}

class _RamayanaState extends State<Ramayana> {
DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
Timer? timer;
  List akses = ["${userData.getUserAkses()}"];
  String? _timeString;
  String _udid = 'Unknown';
    var dio = Dio();
     bool _enabled = true;
  int _status = 0;
  List<DateTime> _events = [];

   Future<void> dapetinData() async {
  UserData userData = UserData();
    await userData.getPref();
    String userId = userData.getUsernameID();
    print('grgr 123');
    print(userId);
  }   

  static UserData userData = UserData();
  @override
   void initState() {
    super.initState();
     initPlatformState();
     ApprovalReturnMenu.approvalmenu.clear();
     ApprovalReturnMenu.idcashmenu.clear();
     ApprovalIdcash.approvalidcash.clear();
     dapetinData();
     UserData userData = UserData();
    //  print(userData.getUserAkses());
     print('tes 555'); 
     print('uutt66');

   }
    // List<String> split = userData.getUserAkses();  

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

  kondisiJam() async {
    const dateTimeString = '2023-02-16 16:41:30.000';
    final dateTime = DateTime.parse(dateTimeString);
    final format = DateFormat('HH:mm:ss');
    final clockString = format.format(dateTime);
    if(_timeString == clockString) {
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.remove('username');
     
    }
  }


  
  logoutPressed() async {
    SharedPreferences pref =await SharedPreferences.getInstance();
      pref.remove('username');
       pref.remove('waktuLogin');
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
        return RamayanaLogin();
       }));
  }

  
  

 void sweatAlert(BuildContext context) {

  Alert(
    context: context,
    type: AlertType.warning,
    title: "Log Out",
    desc: "Are you sure you want to log out?",
    buttons: [
      DialogButton(
        color: Colors.green,
        onPressed: () { 
          Navigator.pop(context);
         },
        child: 
         Text( "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 14),
             ),
            ),

      DialogButton(
      color: Color.fromARGB(255, 255, 17, 17),
      onPressed: () async { 
         AndroidDeviceInfo info = await deviceInfo.androidInfo;
                                   var formData = FormData.fromMap({
                              'progname': 'RALS_TOOLS ',
                              'versi': '2.12 v.2',
                              'date_run': '${DateTime.now()}',
                              'info1': 'Logout Aplikasi RALS',
                              ' info2': '${_udid} ',
                              'userid': '${userData.getUsernameID()}',
                              ' toko': '${userData.getUserToko()}',
                              ' devicename': '${info.device}',
                              'TOKEN': 'R4M4Y4N4'
                            });
                            var prod = 'https://';
                            var dev = 'https://dev-';
                            var tipeurl = '${prod}';
                            var response = await dio.post(
                                '${tipeurl}android-api.ramayana.co.id:8305/v1/activity/createmylog',
                                data: formData);   
                                print('berhasil $_udid');    
        logoutPressed();
         Navigator.pop(context);
      },
        child: 
         Text( "Log Out",
          style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ),
       ],
    ).show();
  return;
}

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      


  
  String _convertToJsonStringQuotes() {
    /// remove space
    String jsonString = userData.getUserAkses();

    /// add quotes to json string
    jsonString = jsonString.replaceAll('{', '');
    jsonString = jsonString.replaceAll('[', '');
    // jsonString = jsonString.replaceAll('],', '], "');
    jsonString = jsonString.replaceAll('}', '');

    // /// remove quotes on object json string
    // jsonString = jsonString.replaceAll('"{"', '{"');
    // jsonString = jsonString.replaceAll('"}"', '"}');

    // /// remove quotes on array json string
    // jsonString = jsonString.replaceAll('"[{', '[{');
    // jsonString = jsonString.replaceAll('}]"', '}]');
  print("Test 1: $jsonString");
    return jsonString;
  }
  print(_convertToJsonStringQuotes());

  List<dynamic> split = _convertToJsonStringQuotes().split("],");
  print(split);
  print(split.length);

  String value = "${userData.getUserAkses()}";
  
  
  


  // for (var item in importedData1) {
  //   map1[item[0]] = item[1];
  //   print(map1);
  // }
  
  // final Map<dynamic, dynamic> result = json.decode(jsonString);
  // print('Test 2: $result');

  
      
      // Map<String,String> mapData = Map();
      // dataSp.forEach((element) => mapData[element.split(':')[0]] = element.split(':')[1]);

      Map<String, List<String>> myMap = 
      {'void': ['void'],'approval': ['checkedapproval', 'cilukba', 'checkedhistory'],'idcash': ['checkedkartu'],}; 
List<dynamic> getKeys(Map<String, List<String>> map) {
  return map.keys.toList();
}




/*
{approval: [return, history], idcash: [nokartu, transaksi], void: [void]}
change to
  {'approval': ['return', 'history'], 'idcash': ['nokartu', 'transaksi'], 'void': ['void']}
*/
      
      return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          extendBody: true,
          appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 17, 17),
           elevation: 0  ,
          toolbarHeight: 1,
        ),
       
      // Lets use docked FAB for handling state of sheet
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
        onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
        child: FloatingActionButton.extended(
          label: AnimatedBuilder(
            animation: DefaultBottomBarController.of(context).state,
            builder: (context, child) => Row(
              children: [
                Text(
                  DefaultBottomBarController.of(context).isOpen
                      ? "Pull"
                      : "Pull",
                ),
                const SizedBox(width: 4.0),
                AnimatedBuilder(
                  animation: DefaultBottomBarController.of(context).state,
                  builder: (context, child) => Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.diagonal3Values(
                      1,
                      DefaultBottomBarController.of(context).state.value * 2 -
                      1,
                      1,
                    ),
                    child: child,
                  ),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          elevation: 2,
          backgroundColor: Color.fromARGB(255, 255, 17, 17),
          foregroundColor: Colors.white,
          //Set onPressed event to swap state of bottom bar
          onPressed: () => DefaultBottomBarController.of(context).swap(),
        ),
      ),
      // Actual expandable bottom bar
      bottomNavigationBar: 
      BottomExpandableAppBar(
        horizontalMargin: 16,
        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),    
        expandedBackColor: Color.fromARGB(255, 255, 245, 245),
        expandedBody: 
        ListView(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(50, 50, 50, 0),
            child: Center(child: Text('My Activity Fitur', style: TextStyle(fontSize: 25, color:Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.bold),)),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(50, 40, 50, 30),
            child: Wrap(
           spacing: 10.0, // spacing between adjacent children
            runSpacing: 7.0, // spacing between rows of children
            alignment: WrapAlignment.spaceAround, // horizontal alignment
            runAlignment: WrapAlignment.spaceEvenly, 
          // sadadsadasdas ngelek 
          //kalo sebelumnya saya kasi sini pak
             children: split.map((e) {
              //sinii
                print('hihi 555');
                var namaAkses = e;
          
                      getNameLog() {
                        var namaAkses = '${e}';
                        List menu1 = namaAkses.split(':');
                        print('menu0 = ${menu1[0]}');
                        if (menu1[0] == ' idcash') {
                          return 'ID CASH';
                        } else if (menu1[0] == 'idcash') {
                          return 'IDCASH';
                        } else if (menu1[0] == 'approval') {
                          return 'Approval Return';
                        } else if (menu1[0] == ' approval') {
                          return 'Approval Return';
                        } else if (menu1[0] == 'void') {
                          return 'VOID';
                        }  else if (menu1[0] == ' void') {
                          return 'VOID';
                        }else 'yuhu';
                        return namaAkses;
                      }
          
                       getIcon() {
                         var namaAkses = '${e}';
                        List menu1 = namaAkses.split(':');
                        print(menu1);
                        if (menu1[0] == ' idcash') {
                          return  
                          Icon(Icons.credit_score_rounded,
                            size: 35,
                            color: Colors.white,
                            );
                        } else if (menu1[0] == 'idcash') {
                          return 
                          Icon(Icons.credit_score_rounded,
                            size: 35,
                            color: Colors.white,
                            );
                        } else if (menu1[0] == 'approval') {
                          return 
                          Icon(Icons.edit_document,
                            size: 35,
                            color: Colors.white,
                            );
                        }  else if (menu1[0] == ' approval') {
                          return 
                          Icon(Icons.edit_document,
                            size: 35,
                            color: Colors.white,
                            );
                        }else if (menu1[0] == ' void') {
                          return 
                           Icon(Icons.document_scanner_rounded,
                            size: 35,
                            color: Colors.white,
                            );
                        
                        }else if (menu1[0] == 'void') {
                          return 
                           Icon(Icons.document_scanner_rounded,
                            size: 35,
                            color: Colors.white,
                            );
                        
                        } else return 
                         Icon(Icons.menu,
                            size: 35,
                            color: Colors.white,
                            );
                      }
          
                return
              Column(
                children: [
                  MaterialButton(
                                        minWidth:  MediaQuery.of(context).size.width/6,
                                        height:  MediaQuery.of(context).size.height/13,
                                        shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(50)
                                        ),
                                        color: Color.fromARGB(255, 255, 17, 17),
                                        onPressed: ()async {
                                           AndroidDeviceInfo info = await deviceInfo.androidInfo;
                                           var formData = FormData.fromMap({
                                      'progname': 'RALS_TOOLS ',
                                      'versi': '2.12 v.2',
                                      'date_run': '${DateTime.now()}',
                                      'info1': '${getNameLog()}',
                                      ' info2': '${_udid} ',
                                      'userid': '${userData.getUsernameID()}',
                                      ' toko': '${userData.getUserToko()}',
                                      ' devicename': '${info.device}',
                                      'TOKEN': 'R4M4Y4N4'
                                    });
                                    var prod = 'https://';
                                    var dev = 'https://dev-';
                                    var tipeurl = '${prod}';
                                    var response = await dio.post(
                                        '${tipeurl}android-api.ramayana.co.id:8305/v1/activity/createmylog',
                                        data: formData);   
                                        print('berhasil $_udid');   
                                           Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                                            var namaAkses = '${e}';
                                            List menu1 = namaAkses.split(':');
                                          if (menu1[0] == ' idcash') {
                                              ApprovalReturnMenu.idcashmenu.add(menu1[1]);
                                              print(ApprovalReturnMenu.idcashmenu);
                                              if (ApprovalReturnMenu.idcashmenu.isNotEmpty) {
                                                ApprovalReturnMenu.idcashmenu.removeWhere((element) => element == menu1[1]);
                                                ApprovalReturnMenu.idcashmenu.add(menu1[1]);
                                              }
                                            return RamayanaIDCash();
                                          } else  if (menu1[0] == 'idcash') {
                                              ApprovalReturnMenu.idcashmenu.add(menu1[1]);
                                              print(ApprovalReturnMenu.idcashmenu);
                                               if (ApprovalReturnMenu.idcashmenu.isNotEmpty) {
                                                ApprovalReturnMenu.idcashmenu.removeWhere((element) => element == menu1[1]);
                                                ApprovalReturnMenu.idcashmenu.add(menu1[1]);
                                              }
                                            return RamayanaIDCash();
                                          } else if (menu1[0] == 'approval') {
                                            ApprovalReturnMenu.approvalmenu.add(menu1[1]);
                                              print(ApprovalReturnMenu.approvalmenu);
                                               if (ApprovalReturnMenu.approvalmenu.isNotEmpty) {
                                                ApprovalReturnMenu.approvalmenu.removeWhere((element) => element == menu1[1]);
                                                ApprovalReturnMenu.approvalmenu.add(menu1[1]);
                                              }
                                            return RamayanaApprovalSubmenu();
                                           } else if (menu1[0] == ' approval') {
                                            ApprovalReturnMenu.approvalmenu.add(menu1[1]);
                                              print(ApprovalReturnMenu.approvalmenu);
                                               if (ApprovalReturnMenu.approvalmenu.isNotEmpty) {
                                                ApprovalReturnMenu.approvalmenu.removeWhere((element) => element == menu1[1]);
                                                ApprovalReturnMenu.approvalmenu.add(menu1[1]);
                                              }
                                            return RamayanaApprovalSubmenu();
                                           } else if (menu1[0] == ' void') {
                                             return Blank();
                                          } else if (menu1[0] == 'void') {
                                             return Blank();
                                          } else return Ramayana();
                                            }));
                                        },
                                        child:  
                                       getIcon()
                                        ),
               
                
                                    SizedBox(
                                    height: 10,
                                    ),
                
                                    Text('${getNameLog()}',
                                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                    )
                                     ],
              );
              }).toList(), 
            
            ),
          )
        ],       
 
 
     ),
      ),

      body: 
      ListView(
        children: [
          Stack(
           fit: StackFit.loose,
           children: <Widget>[ 
            Container(
              margin: EdgeInsets.only(top: 0),
              height: 180,
              width: 2000,
              color: Color.fromARGB(255, 255, 17, 17),
              ),
                      
            Container(
              margin: EdgeInsets.only(top: 5,left: 20, right: 20),
              child:
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                
                    IconButton(
                    icon: Icon(Icons.power_settings_new_rounded),
                    color: Colors.white,
                    iconSize: 28,
                    onPressed: () {
                    sweatAlert(context);
                    }
                    ),

                    Text('Dashboard My Activity',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                     Row(
                       children: [
                         IconButton(onPressed: () async {
                          setState(() {
                           dapetinData();
                          });
                          // SystemNavigator.pop();
                         Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Profilee();
                          }
                          ));
                          },
                    icon: Icon(Icons.person,
                    color: Colors.white,
                    size: 30,
                    ),
                    ),
                      
                  
                       ],
                     ),
                   
                    ]
                    )
                    ),

              Container(
              margin: EdgeInsets.only(top: 100, left: 20, right: 20),       
                child:AnimatedTextKit(
                isRepeatingAnimation: true,
                animatedTexts: [

                TyperAnimatedText('Halo ${userData.getFullname()}',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                TyperAnimatedText('Welcome to Ramayana My Activity',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                TyperAnimatedText('Halo ${userData.getFullname()} ',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                TyperAnimatedText('Welcome to Ramayana My Activity',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                TyperAnimatedText('Halo ${userData.getFullname()}',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                TyperAnimatedText('Welcome to Ramayana My Activity',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),   
                ]
               ),
               ),

              Container(
              margin: EdgeInsets.fromLTRB(10, 195, 10, 0),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.white,
              boxShadow: [BoxShadow(
              color: Colors.black12,
              spreadRadius: 3,
              blurRadius: 3
              ),]
              ),
              height: 270,   
              width: 2000,  
              child:
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Image.asset(
                       'assets/rama(C).png',
                        width: 180,
                       ),
                       
                      
                      ],
                    ),   
                    ),
                    ],
                  ),
                ],
              )
              );
            });
          }
      void _getTime() {
    final DateTime now = DateTime.now();
    final String formattedDateTime = _formatDateTime(now);

  setState(() {
    _timeString = formattedDateTime;
  });
    
      }

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }
 
}
        