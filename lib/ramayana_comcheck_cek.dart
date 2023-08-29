import 'dart:collection';
import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:myactivity_project/env.dart';
import 'package:myactivity_project/models/model_hakakses.dart';
import 'package:myactivity_project/models/model_tabel_approve.dart';
import 'package:myactivity_project/ramayana_approve_update.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_profile.dart';
import 'package:myactivity_project/ramayana_riwayat_update.dart';
import 'package:myactivity_project/ramayanavoid.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/settingsralstools.dart';
import 'package:flutter/services.dart';

class RamayanaCompetitorCek extends StatefulWidget {
  const RamayanaCompetitorCek({super.key});

  @override
  State<RamayanaCompetitorCek> createState() => _RamayanaCompetitorCekState();
}

class _RamayanaCompetitorCekState extends State<RamayanaCompetitorCek> {

  UserData userData = UserData();
  Dio dio = Dio();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _udid = 'Unknown';
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

  @override
  Widget build(BuildContext context) {
    List<String> result = LinkedHashSet<String>.from(HakAkses.hakaksesSubmenuComcek).toList();
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 255, 17, 17),
          elevation: 0  ,
          toolbarHeight: 1,
      ),

      body: 
      ListView(
        children: [
          Stack(
            children: <Widget>[
             
              Container(
                  margin: EdgeInsets.only(top: 250),
                      height: 150,
                      color: Color.fromARGB(255, 255, 17, 17),
                    ),
              Container(
                color:  Color.fromARGB(255, 111, 60, 60)
              ), 

               

              Container(
                height: 250,
                decoration: BoxDecoration(
                color:  Color.fromARGB(255, 255, 17, 17),
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(150),
                  // topRight: Radius.circular(70)
                )
                ),
              ), 

               
                    
             Container(
              margin: EdgeInsets.fromLTRB(20, 80, 20, 0),
              height: 50,
              
              child: 
               Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                    
                       Text('',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),

                        Text('Competitor Checking',
                        style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold, color: Colors.white),
                        ),

                        Text('',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                        ),

                        ]
                        )
                        ),
              

              Container(
                margin: EdgeInsets.only(top: 250),
                height: 250,
                decoration: BoxDecoration(
                color:  Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(150),
                )
                ),
              ),
              
              Container(
                margin: EdgeInsets.fromLTRB(30, 450, 30, 0),
                // color: Colors.green,
                child: Column(
                  children: result.map((e) {

                  
                  getName() {
                    if (e == 'comchek.approvedcomchek') {
                      return 'Approve';
                    } else if (e == 'comchek.historycomchek') {
                      return 'Riwayat Approve';
                    } else {
                      return 'Menu Approve';
                    }
                  }

                   getIcon() {
                            var icon = '${e}';
                            if(icon == 'comchek.approvedcomchek') {
                              return Visibility(
                                        child: 
                                        Icon(
                            IconlyLight.tickSquare,
                            size: 30,
                            color: Colors.black,
                           ),
                                        visible: true, 
                              );
                            }
                            else if (icon == 'comchek.historycomchek') {
                              return Visibility(
                                        child: 
                                        Icon(
                            IconlyLight.message,
                            size: 30,
                            color: Colors.black,
                           ),
                                        visible: true, 
                              );
                            }
                   }

                  return
                    
                    Container(
                      margin: EdgeInsets.only(bottom: 50),
                      child: MaterialButton(
                        height: 100,
                        color: Color.fromARGB(255, 228, 222, 222),
                        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                        ),
                        onPressed: () async {
                          if(e == 'comchek.approvedcomchek'){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                                          return RamayanaHistoryApprove();
                                                        }));
                          } else if(e == 'comchek.historycomchek'){
                                                        Navigator.push(context, MaterialPageRoute(builder: (context){
                                                          return RamayanaRiwayatUpdate();
                                                        }));

                                                         AndroidDeviceInfo info = await deviceInfo.androidInfo;
                                                         
                                                         var formData = FormData.fromMap({
                                                    'progname': 'RALS_TOOLS ',
                                                    'versi': '${versi}',
                                                    'date_run': '${DateTime.now()}',
                                                    'info1': '${getName()}',
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
                          }
                        
                        },
                        child: Row(
                          children: [
                    
                          SizedBox(
                            width: 20,
                          ),
                    
                         
                           Container(child: getIcon()),
                           
                    
                           SizedBox(
                            width: 20,
                          ),
                    
                           Text('${getName()}',
                           style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                           )
                          ],
                        ),
                      ),
                    );

                    // SizedBox(
                    //   height: 50,
                    // ),

                    // MaterialButton(
                    //   height: 100,
                    //   color: Color.fromARGB(255, 228, 222, 222),
                    //   shape: RoundedRectangleBorder(
                    //   borderRadius: BorderRadius.circular(30),
                    //   ),
                    //   onPressed: () {
                    //      Navigator.push(context, MaterialPageRoute(builder: (context){
                    //       return RamayanaRiwayatUpdate(); 
                    //     }));
                    //     // Navigator.push(context, MaterialPageRoute(builder: (context){
                    //     //   return RamayanaRiwayat(initialDate: DateTime.now(),);
                    //     // }));
                    //   },
                    //   child: Row(
                    //     children: [

                    //     SizedBox(
                    //       width: 20,
                    //     ),

                    //      Icon(
                    //       IconlyLight.message,
                    //       size: 30,
                    //      ),

                    //      SizedBox(
                    //       width: 20,
                    //     ),

                    //      Text('Riwayat Approve',
                    //      style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
                    //      )
                    //     ],
                    //   ),
                    // ),
                    
                    // SizedBox(
                    //   height: 120,
                    // ),
                     }).toList()
                ),
                    
                   
                    
                 
              ),
               Center(
                 child: Container(
                  margin: EdgeInsets.only(top: 800,bottom: 50),
                        child: MaterialButton(
                          height: 70,
                          minWidth: 70,
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) => 
                            DefaultBottomBarController(child: Ramayana()),), 
                            (Route<dynamic> route) => false);},
                          color: Color.fromARGB(255, 255, 17, 17),
                          shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(50),
                          ),
                          child: Icon(Icons.home,
                            color: Colors.white,
                            size: 30,),
                        ),
                      ),
               ),

            
              
              
            ],
          ),
        ],
      ),
     
     
    );
  }
}


