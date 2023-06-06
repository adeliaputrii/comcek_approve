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
import 'package:myactivity_project/models/model_hak_akses.dart';
import 'package:myactivity_project/models/model_hakakses.dart';
import 'package:myactivity_project/models/model_idcash.dart';
import 'package:myactivity_project/models/model_tabel_approve.dart';
import 'package:myactivity_project/models/models_approval_return_list.dart';
import 'package:myactivity_project/ramayana_approve_update.dart';
import 'package:myactivity_project/ramayanaapproval.dart';
import 'package:myactivity_project/ramayana_approval_submenu.dart';
import 'package:myactivity_project/ramayana_cekharga.dart';
import 'package:myactivity_project/ramayana_comcheck_cek.dart';
import 'package:myactivity_project/ramayana_device_info.dart';
import 'package:myactivity_project/ramayana_id_cash_riwayat.dart';
import 'package:myactivity_project/ramayanaidcash.dart';
import 'package:myactivity_project/ramayana_splashscreen.dart';
import 'package:myactivity_project/service/API_service/LogAPI_service.dart';
import 'package:myactivity_project/service/service_api/auth.dart';
import 'package:path/path.dart' as Path;
import 'package:relative_scale/relative_scale.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:myactivity_project/ramayana_login.dart';
import 'package:myactivity_project/ramayana_profile.dart';
import 'package:myactivity_project/ramayanavoid.dart';
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
import 'package:screen_brightness/screen_brightness.dart';
import 'package:launch_review/launch_review.dart';
import 'package:myactivity_project/settingsralstools.dart';

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

  @override
  void didPushNext() {
    ScreenBrightness().resetScreenBrightness();
  }

  @override
  void didPop() {
    ScreenBrightness().resetScreenBrightness();
  }

  static UserData userData = UserData();

   fetchDataModul({
       required String akses_menu
    }) async {
    HakAkses.hakakses.clear();
    final responseku = await http.post(
      Uri.parse('${tipeurl}v1/activity/tbl_mastermenu'),
      body: {
        'akses_menu' : '${userData.getUserRole()}'
        }
      );
    var data = jsonDecode(responseku.body);
    if (data['status'] == 200 ) {
      print("API Success");
      print(data);
      int count = data['data'].length;
      final Map<String, HakAkses> profileMap = new Map();
      for (int i = 0; i < count; i++) {
        HakAkses.hakakses.add(HakAkses.fromjson(data['data'][i]));
      } 
       HakAkses.hakakses.forEach((element) {
        profileMap[element.name_menu] = element;
        HakAkses.hakakses = profileMap.values.toList();
       });
      print('check length ${HakAkses.hakakses.length}');
      print(data['data'].toString());

    } 
     else {
      print('NO DATA');
    }
   setState(() {});
  }


  @override
   void initState() {
    UserData userData = UserData();
    fetchDataModul(akses_menu: '${userData.getUserRole()}');
    super.initState();
     initPlatformState();
     didPop();
     didPushNext();
     ApprovalReturnMenu.approvalmenu.clear();
     ApprovalReturnMenu.idcashmenu.clear();
     ApprovalIdcash.approvalidcash.clear();
     dapetinData();
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
                            
                            var response = await dio.post(
                                '${tipeurl}v1/activity/createmylog',
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
            child: 
            Center(
              child: Wrap(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                                              minWidth:  MediaQuery.of(context).size.width/6,
                                              height:  MediaQuery.of(context).size.height/13,
                                              shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50)
                                              ),
                                              color: Color.fromARGB(255, 255, 17, 17),
                                              onPressed: ()async {
                                              },
                                              child:  
                                            Icon(Icons.add_circle,
                                            size: 35,
                                            color: Colors.white,
                                            )
                                              ),
                 
                      
                                          SizedBox(
                                          height: 10,
                                          ),
                      
                                          Text('Add Activity',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          )
                                           ],
                ),

                Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                                              minWidth:  MediaQuery.of(context).size.width/6,
                                              height:  MediaQuery.of(context).size.height/13,
                                              shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(50)
                                              ),
                                              color: Color.fromARGB(255, 255, 17, 17),
                                              onPressed: ()async {
                                                //  Navigator.push(context, MaterialPageRoute(builder: (context){
                                                //   return RamayanaCekHarga();
                                                //  }));
                                              },
                                              child:  
                                            Icon(Icons.edit_document,
                                            size: 35,
                                            color: Colors.white,
                                            )
                                            // Icon(Icons.playlist_add_check_circle,
                                            // size: 35,
                                            // color: Colors.white,
                                            // )
                                              ),
                 
                      
                                          SizedBox(
                                          height: 10,
                                          ),
                      
                                          Text('List Activity',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          )
                                          // Text('Cek Promo',
                                          // style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          // )
                                           ],
                ),

                Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                            'info1': 'VOID',
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
                                                 Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
                                                 return Blank();
                                                 
                                              }));
                                              },
                                              child:  
                                            Icon(Icons.document_scanner,
                                            size: 35,
                                            color: Colors.white,
                                            )
                                              ),
                 
                      
                                          SizedBox(
                                          height: 10,
                                          ),
                      
                                          Text('VOID',
                                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                                          )
                                           ],
                ),
                    ],
                  )
                      ],
              ),
            )
          //   Wrap(
          //  spacing: 10.0, // spacing between adjacent children
          //   runSpacing: 7.0, // spacing between rows of children
          //   alignment: WrapAlignment.spaceAround, // horizontal alignment
          //   runAlignment: WrapAlignment.spaceEvenly, 
          // // sadadsadasdas ngelek 
          // //kalo sebelumnya saya kasi sini pak
          //    children: 
          //    split.map((e) {
          //     //sinii
          //       print('hihi 555');
          //       var namaAkses = e;
          
          //             getNameLog() {
          //               var namaAkses = '${e}';
          //               List menu1 = namaAkses.split(':');
          //               print('menu0 = ${menu1[0]}');
          //               if (menu1[0] == ' idcash') {
          //                 return 'ID CASH';
          //               } else if (menu1[0] == 'idcash') {
          //                 return 'IDCASH';
          //               } else if (menu1[0] == 'approval') {
          //                 return 'Approval Return';
          //               } else if (menu1[0] == ' approval') {
          //                 return 'Approval Return';
          //               } else if (menu1[0] == 'void') {
          //                 return 'VOID';
          //               }  else if (menu1[0] == ' void') {
          //                 return 'VOID';
          //               }else 'yuhu';
          //               return namaAkses;
          //             }
          
          //              getIcon() {
          //                var namaAkses = '${e}';
          //               List menu1 = namaAkses.split(':');
          //               print(menu1);
          //               if (menu1[0] == ' idcash') {
          //                 return  
          //                 Icon(Icons.credit_score_rounded,
          //                   size: 35,
          //                   color: Colors.white,
          //                   );
          //               } else if (menu1[0] == 'idcash') {
          //                 return 
          //                 Icon(Icons.credit_score_rounded,
          //                   size: 35,
          //                   color: Colors.white,
          //                   );
          //               } else if (menu1[0] == 'approval') {
          //                 return 
          //                 Icon(Icons.edit_document,
          //                   size: 35,
          //                   color: Colors.white,
          //                   );
          //               }  else if (menu1[0] == ' approval') {
          //                 return 
          //                 Icon(Icons.edit_document,
          //                   size: 35,
          //                   color: Colors.white,
          //                   );
          //               }else if (menu1[0] == ' void') {
          //                 return 
          //                  Icon(Icons.document_scanner_rounded,
          //                   size: 35,
          //                   color: Colors.white,
          //                   );
                        
          //               }else if (menu1[0] == 'void') {
          //                 return 
          //                  Icon(Icons.document_scanner_rounded,
          //                   size: 35,
          //                   color: Colors.white,
          //                   );
                        
          //               } else return 
          //                Icon(Icons.menu,
          //                   size: 35,
          //                   color: Colors.white,
          //                   );
          //             }
          
          //       return
          //     Column(
          //       children: [
          //         MaterialButton(
          //                               minWidth:  MediaQuery.of(context).size.width/6,
          //                               height:  MediaQuery.of(context).size.height/13,
          //                               shape: RoundedRectangleBorder(
          //                               borderRadius: BorderRadius.circular(50)
          //                               ),
          //                               color: Color.fromARGB(255, 255, 17, 17),
          //                               onPressed: ()async {
          //                                  AndroidDeviceInfo info = await deviceInfo.androidInfo;
          //                                  var formData = FormData.fromMap({
          //                             'progname': 'RALS_TOOLS ',
          //                             'versi': '2.12 v.2',
          //                             'date_run': '${DateTime.now()}',
          //                             'info1': '${getNameLog()}',
          //                             ' info2': '${_udid} ',
          //                             'userid': '${userData.getUsernameID()}',
          //                             ' toko': '${userData.getUserToko()}',
          //                             ' devicename': '${info.device}',
          //                             'TOKEN': 'R4M4Y4N4'
          //                           });
          //                           
          //                           
          //                           var tipeurl = '${prod}';
          //                           var response = await dio.post(
          //                               '${tipeurl}v1/activity/createmylog',
          //                               data: formData);   
          //                               print('berhasil $_udid');   
          //                                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
          //                                   var namaAkses = '${e}';
          //                                   List menu1 = namaAkses.split(':');
          //                                 if (menu1[0] == ' idcash') {
          //                                     ApprovalReturnMenu.idcashmenu.add(menu1[1]);
          //                                     print(ApprovalReturnMenu.idcashmenu);
          //                                     if (ApprovalReturnMenu.idcashmenu.isNotEmpty) {
          //                                       ApprovalReturnMenu.idcashmenu.removeWhere((element) => element == menu1[1]);
          //                                       ApprovalReturnMenu.idcashmenu.add(menu1[1]);
          //                                     }
          //                                   return RamayanaIDCash();
          //                                 } else  if (menu1[0] == 'idcash') {
          //                                     ApprovalReturnMenu.idcashmenu.add(menu1[1]);
          //                                     print(ApprovalReturnMenu.idcashmenu);
          //                                      if (ApprovalReturnMenu.idcashmenu.isNotEmpty) {
          //                                       ApprovalReturnMenu.idcashmenu.removeWhere((element) => element == menu1[1]);
          //                                       ApprovalReturnMenu.idcashmenu.add(menu1[1]);
          //                                     }
          //                                   return RamayanaIDCash();
          //                                 } else if (menu1[0] == 'approval') {
          //                                   ApprovalReturnMenu.approvalmenu.add(menu1[1]);
          //                                     print(ApprovalReturnMenu.approvalmenu);
          //                                      if (ApprovalReturnMenu.approvalmenu.isNotEmpty) {
          //                                       ApprovalReturnMenu.approvalmenu.removeWhere((element) => element == menu1[1]);
          //                                       ApprovalReturnMenu.approvalmenu.add(menu1[1]);
          //                                     }
          //                                   return RamayanaApprovalSubmenu();
          //                                  } else if (menu1[0] == ' approval') {
          //                                   ApprovalReturnMenu.approvalmenu.add(menu1[1]);
          //                                     print(ApprovalReturnMenu.approvalmenu);
          //                                      if (ApprovalReturnMenu.approvalmenu.isNotEmpty) {
          //                                       ApprovalReturnMenu.approvalmenu.removeWhere((element) => element == menu1[1]);
          //                                       ApprovalReturnMenu.approvalmenu.add(menu1[1]);
          //                                     }
          //                                   return RamayanaApprovalSubmenu();
          //                                  } else if (menu1[0] == ' void') {
          //                                    return Blank();
          //                                 } else if (menu1[0] == 'void') {
          //                                    return Blank();
          //                                 } else return Ramayana();
          //                                   }));
          //                               },
          //                               child:  
          //                              getIcon()
          //                               ),
               
                
          //                           SizedBox(
          //                           height: 10,
          //                           ),
                
          //                           Text('${getNameLog()}',
          //                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          //                           )
          //                            ],
          //     );
          //     }).toList(), 
            
          //   ),
        //   )

        // Container(
        //   margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
        //   child: Wrap(
        //     spacing: 10.0,
        //     runSpacing: 7.0,
        //     alignment: WrapAlignment.spaceAround,
        //     runAlignment: WrapAlignment.spaceEvenly,
        //     //adel ini gausah di masukin ke model bisa gaa? langsung aja dia pake api nya nembak langsung
        //     children: HakAkses.hakakses.map((e) {
        //       // ${e.nsadssaame_menu}
        //       print(e);
        //       print(e.routes);
        //       var routes = '${e.routes}';
        //       getIcon() {
        //         var icon = '${e.routes}';
        //         if(icon == 'Blank') {
        //           return Icon(Icons.document_scanner_rounded,
        //                   size: 35,
        //                   color: Colors.white,
        //                 );
        //         } else if (icon == "RamayanaIDCash") {
        //            return Icon(Icons.credit_score_rounded,
        //                   size: 35,
        //                   color: Colors.white,
        //                 );
        //         } else if (icon == "RamayanaHistoryApprove") {
        //            return Icon(Icons.edit_document,
        //                   size: 35,
        //                   color: Colors.white,
        //                 ); 
        //         } else {
        //           return  Icon(Icons.menu,
        //                   size: 35,
        //                   color: Colors.white,
        //                 );
        //         }
        //       }
              
        //       return 
        //        Column(
        //           children: [
        //             MaterialButton(
        //               color: Color.fromARGB(255, 255, 17, 17),
        //                                   minWidth:  MediaQuery.of(context).size.width/6,
        //                                   height:  MediaQuery.of(context).size.height/13,
        //                                   shape: RoundedRectangleBorder(
        //                                   borderRadius: BorderRadius.circular(50)
                                          
        //                                   ),
        //                                   child: 
                                          
        //                                   getIcon(),
                                        
        //                                   onPressed: ()async {
        //                                     print(e.routes);
        //                                     print('haiiioooo');
        //                                     if(e.routes == 'Blank'){
        //                                     Navigator.push(context, MaterialPageRoute(builder: (context){
        //                                       return Blank(); 
        //                                     }));
        //                                     }else if(e.routes == 'RamayanaIDCash'){
        //                                     Navigator.push(context, MaterialPageRoute(builder: (context){
        //                                       return RamayanaIDCash(); }));
        //                                     }else if(e.routes == 'RamayanaHistoryApprove'){
        //                                     Navigator.push(context, MaterialPageRoute(builder: (context){
        //                                       return RamayanaApprovalSubmenu(); }));
        //                                     }else{
        // //dimmmmmmana ya del fi
        // //beart yang ramayana_id_cash_riwayat sama ramayanaidcash_pin.dart?
        // //semua pak yg ada id cash itu menu idcash semua

        // //hmm okee kalo kaya gini berarti adel perlu bikin halaman untuk menampung modul sub ini, ada ?
        // //adaa, ramayanaidcash, ok sekarang, sekarang ini kalo ada modul yang punya sub modul, lariin ke 1 
        // // halaman nanti kita panggil api nyadisitu okaauu nambah api lagi ya?, gauasah pake api ini aja
        // //sekarang adel buat buat dulu file ramayana_sub atau apa, atau rubah rrrrename yang ramaynaidcash biar
        // //bisa di pake modul lain nya nanti nya emm oke pak
        //                                     }
        //                                      AndroidDeviceInfo info = await deviceInfo.androidInfo;
        //                                      var formData = FormData.fromMap({
        //                                 'progname': 'RALS_TOOLS ',
        //                                 'versi': '2.12 v.2',
        //                                 'date_run': '${DateTime.now()}',
        //                                 'info1': '${e.name_menu}',
        //                                 ' info2': '${_udid} ',
        //                                 'userid': '${userData.getUsernameID()}',
        //                                 ' toko': '${userData.getUserToko()}',
        //                                 ' devicename': '${info.device}',
        //                                 'TOKEN': 'R4M4Y4N4'
        //                               });
        //                             var tipeurl = '${prod}';
        //                     var response = await dio.post(
        //                         '${tipeurl}v1/activity/createmylog',
        //                         data: formData);   
        //                         print('berhasil $_udid');   
        //                                   }
                                         
        //             ),
        
        //                             SizedBox(
        //                               height: 10,
        //                               ),
                  
        //                               Text('${e.name_menu}',
        //                               style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        //                               )
                    
        //           ]
        //        );
                                      
        //     }).toList(),
        //     ),
        // )
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
        