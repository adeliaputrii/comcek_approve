import 'dart:convert';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:myactivity_project/justtest.dart';
import 'package:myactivity_project/models/model_apv.dart';
import 'package:myactivity_project/models/model_tabel_approve.dart';
import 'package:myactivity_project/models/models_act.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:myactivity_project/ramayana_activity.dart';
import 'package:myactivity_project/ramayana_comcheck_cek.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/service/API_service/API_service_table.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class RamayanaHistory12 extends StatefulWidget {
  const RamayanaHistory12({super.key});

  @override
  State<RamayanaHistory12> createState() => _RamayanaHistory12State();
}

class _RamayanaHistory12State extends State<RamayanaHistory12> {
 TextEditingController dateInput = TextEditingController();
 TextEditingController sku = TextEditingController();
 TextEditingController m1 = TextEditingController();

  var dio = Dio();
  var selected1;
    final List<String> data1 = [
    'MD1',
    'MD2',
    'MD3',
    'MD4'
  ];

  var selected2;
    final List<String> data2 = [
    'RB17',
    'R136',
    'S204',
    'S445'
  ];

  UserData userData = UserData();

  fetchProduk({
    required String m1
  }) async {
  
    
    ApproveModel1.approvelist1.clear();
    final responseku = await http.post(
      Uri.parse('https://android-api.ramayana.co.id:8304/v1/activity/tbl_commcheck'),
        body: {
          'm1' : m1
        });

    var data = jsonDecode(responseku.body);
   
    if (data['status'] == 200 ) {
      print("API Success");
      print(data);
      int count = data['data'].length;
      for (int i = 0; i < count; i++) {
        ApproveModel1.approvelist1.add(ApproveModel1.fromjson(data['data'][i]));

      } 
      print('check length ${ApproveModel1.approvelist1.length}');
      print(data['data'].toString());

    } 
     else {
      print('NO DATA');
    }
    
    
     setState(() {});
  }
  var map1 = <String, String>{};
  var map2 = <String, String>{};

   void initState() {
    super.initState();
    fetchProduk(m1: '081');
    dateInput.text = "";
   
    
    
  }  
 
  
 
  bool click = true;
  bool click2 = true;
  int isapv = 0;
  int _rowSelectedCount = 0;
  List selectedData = [];
  List selectedData2 = [];

  int get selectedItems => _rowSelectedCount;
  int get selectedItemsAll => ApproveModel1.approvelist1.length - _rowSelectedCount;

   void approve1() {
    if (selectedItems == 0) {
      AlertDialog popup1 = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // shadowColor: Colors.black,
      titlePadding: EdgeInsets.all(0),
      title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 170,
          width: 2000,
          child: Image.asset(
            'assets/omaigat.png',
          )),
      content: Container(
        margin: EdgeInsets.only(bottom: 10),
        height: 30,
        child:
            Center(
              child: Text(
                'Anda Tidak Menyetujui Apapun',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          
      ),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popup1);
    }  else {
    AlertDialog popup = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),

      // shadowColor: Colors.black,
      titlePadding: EdgeInsets.all(0),
      title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          height: 190,
          width: 2000,
          child: Image.asset(
            'assets/omaigat.png',
          )),
      content: Container(
        height: 100,
        child: Column(
          children: [
            Text(
              'Jumlah pengajuan yang disetujui : ${selectedItems}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            Text(
              'Jumlah pengajuan yang ditolak : ${selectedItemsAll}',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Text(
              'Apakah Anda yakin ingin menyetujui pengajuan ini?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 40,
              color: Color.fromARGB(255, 255, 17, 17),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'Cancel',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              height: 40,
              color: Colors.green,
              onPressed: ()  async{
                
                var formData = FormData.fromMap({
                              'is_approv': isapv,
                              'user_approv' : 'adel',
                              'sku': selectedData,
                              'm1' : selectedData2
                            });

                            var response = await dio.post(
                                'https://android-api.ramayana.co.id:8304/v1/activity/updateApproveCommcheck',
                                data: formData);

                            print(
                                // 'Berhasil, ${}, ${password.text},${password.text}, ${passwordReEnter.text}'
                                'Berhasil, ${selectedData}, ${selectedData2} '
                                );
                            Duration(seconds: 10);

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RamayanaCompetitorCek(),
                                ),
                                (Route<dynamic> route) => false);
              },
              child: Text(
                'Approve',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
            ),
          ],
        )
      ],
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popup);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
                      return RamayanaCompetitorCek();
                    }));
          },
          icon: Icon(IconlyLight.arrowLeft, color: Color.fromARGB(255, 255, 255, 255), size: 25,),
        ),
        title: 
        Container(
          margin: EdgeInsets.only(left: 120),
         child: Text('Approve', style: TextStyle(fontSize: 23, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),),
            
            
        ),
        backgroundColor: Color.fromARGB(255, 255, 14, 14),
        elevation: 5,
        toolbarHeight: 80,
        ),
      body: 
      Stack(
        children: [
          Container(
            color: Color.fromARGB(255, 244, 244, 244),
          ),
           Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 130,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 232, 15, 15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 3,
                  blurRadius: 3,
                )
              ],
            )
        ),

        Container(
          margin: EdgeInsets.only(left: 10, top: 20),
            child: Text('List Approve',
              style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w700)
            ),
        ),

        Container(
          margin: EdgeInsets.only(right: 0, top: 70, left: 10),
            child: 
            ListTile(
              trailing: Text('${userData.getFullname()} ${userData.getUsernameID()}',
               style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500)
              )
            )
        ),
          Container(
          margin: EdgeInsets.fromLTRB(0, 125, 0, 0),
          height: 60,
          decoration: 
          BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 15)
            ],
          ),
          child: 
          Container(
            margin: EdgeInsets.only(left: 50, right: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment:CrossAxisAlignment.center,
              children: <Widget>[
                DropdownButton(
                    value: selected2,
                    hint: Text('TOKO',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 17, 17),
                      fontSize: 17, fontWeight: FontWeight.w500
                    ),
                    ),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        selected2 = value;
                      });
                    },
                    items: data2
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: 
                        Text(e, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 255, 17, 17)),),
                      ),
                      )
                      .toList()
                    ),
                DropdownButton(
                    value: selected1,
                    hint: Text('MD',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 17, 17),
                      fontSize: 17, fontWeight: FontWeight.w500
                    ),
                    ),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        selected1 = value;
                      });
                    },
                    items: data1
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: 
                        Text(e, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 255, 17, 17)),),
                      ),
                      )
                      .toList()
                    ),
                 
              ],
            ),
          ),
        ),

        
       
        Container(
            margin: EdgeInsets.only(top: 190, bottom: 120),
            decoration: BoxDecoration(
            color: Color.fromARGB(255, 244, 244, 244),
           
          ),
            child: 
            ListView(
              children: ApproveModel1.approvelist1.map((e) {
            
                
                var hb = '${e.hbeli}';
                var hbD = double.parse(hb);
                var hj = '${e.hjual}';
                var hjD = double.parse(hj);
                var hjB = '${e.hjualBaru}';
                var hjBd = double.parse(hjB);
                var selisih = hjD - hjBd;
                var selisihStr = selisih.toString();
                bool yesornay = hbD > hjBd;
               
                kondisiHb() {
                List<String> resultHb = hb.split('');
                  if (resultHb.length >7) {
                  resultHb.insert((resultHb.length - 7), '.');
                } 
                else if (resultHb.length > 10) {
                  resultHb.insert((resultHb.length - 7), '.');
                  resultHb.insert((resultHb.length - 10), '.');
                }
                var resultHbDone = resultHb.join('');
                return resultHbDone;
                }

                kondisiHj() {
                List<String> resultHj = hj.split('');
                  if (resultHj.length > 7) {
                  resultHj.insert((resultHj.length - 7), '.');
                }  else if (resultHj.length > 10) {
                  resultHj.insert((resultHj.length - 7), '.');
                  resultHj.insert((resultHj.length - 10), '.');
                }
                var resultHjDone = resultHj.join('');
                return resultHjDone;
                }

                kondisiHjb() {
                List<String> resultHjb = hjB.split('');
                  if (resultHjb.length >7) {
                  resultHjb.insert((resultHjb.length - 7), '.');
                }  else if (resultHjb.length > 10) {
                  resultHjb.insert((resultHjb.length - 7), '.');
                  resultHjb.insert((resultHjb.length - 10), '.');
                }
                var resultHjbDone = resultHjb.join('');
                return resultHjbDone;
                }
               
                
             
                return 
          
        Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            crossFadeState:
                e.isSelectedCont ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 800),
            firstChild: 
           Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 127,
            decoration: BoxDecoration(
              border: Border.all(
                          width: 1, 
                          color: Colors.red
                        ),
            
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
              
            child: 
            Container(
              margin: EdgeInsets.only(left: 10, right: 5, top: 0),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      Container(
                        margin: EdgeInsets.only(top: 5, ),
                        child: 
                             CheckboxListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 Text('Nama Barang', 
                         style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 17,  fontWeight: FontWeight.bold),
                        ),
                                 Container(
                              height: 26,
                              width: 50,
                              decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)
                              ),
                               child: 
                               Center(
                                 child: Text('${e.m1}', 
                                     style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold,),
                                    ),
                               ),
                             ),
                                ]
                              ),
                              tileColor: Colors.greenAccent,
                              controlAffinity: ListTileControlAffinity.trailing,
                              activeColor: Colors.red,
                              dense: true,

                              value: e.isSelected,

                              onChanged: (bool? value) {
                                //itemChange(newValue!, index);
                                setState(() {
                                  e.isSelected = value!;
                                  if(selectedData.indexOf('00${e.sku}') < 0) {
                                  selectedData.add('00${e.sku}');
                                  selectedData2.add(e.m1);
                                     _rowSelectedCount += value ? 1 : -1;
                                  } else {
                                    selectedData.removeWhere((element) => element== '00${e.sku}');
                                   selectedData2.removeLast();
                                     _rowSelectedCount += value ? 1 : -1;
                                  }
                                  print(selectedData);
                                  print(selectedData2);
                                });
                              }
                              ),
                        // ],
                        // ),
                      ),

                      // CheckboxListTile(
                            
                      //         tileColor: Colors.greenAccent,
                      //         controlAffinity: ListTileControlAffinity.trailing,
                      //         activeColor: Colors.pink[300],
                      //         dense: true,

                      //         value: e.isSelected,

                      //         onChanged: (bool? value) {
                      //           //itemChange(newValue!, index);
                      //           setState(() {
                      //             e.isSelected = value!;
                      //             if(e.isSelected) {
                      //               selectedItem = '00${e.sku}';
                      //               selectedItem2 = '00${e.m1}';
                      //               selectedValue =  e.isSelected;
                      //                _rowSelectedCount += value ? 1 : -1;
                      //             }
                      //             else{
                      //               selectedItem = '';
                      //               selectedItem2 = '';
                      //               selectedValue = e.isSelected;
                      //                _rowSelectedCount += value ? 1 : -1;
                      //             }
                      //             print(selectedItem);
                      //             print(selectedItem2);
                      //             print(selectedValue);
                      //           });
                      //         }
                      //         ),
                   
                  Container(
                    margin: EdgeInsets.only(left: 15,),
                    child: 
                   Row(
                      children: [
                         Text('${kondisiHb()}', 
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                          width: 20,
                        ),
                       Text('${kondisiHjb()}', 
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                          width: 20,
                        ),
                         Text('MarBaru', 
                      style: TextStyle(color: Colors.black,fontSize: 15),
                      ),
                      SizedBox(
                          width: 10,
                        ),
                         Padding(
                        padding: const EdgeInsets.only(left:5),
                        child: double.parse(e.hbeli) >  double.parse(e.hjualBaru)
                            ? Text(
                                "${selisihStr}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                ) 
                            )
                            : Text(
                                "${selisihStr}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                ) 
                            ),
                    ),
                      ],
                    ),
                  ),
                  Center(
                    child: 
                    
                    IconButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: 38,
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                         e.isSelectedCont = !e.isSelectedCont;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
            secondChild: 
             Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 305,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  width: 1, 
                  color: Colors.red
                ),
            ),
            child: 
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 0),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      Container(
                        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                         Text('Nama Barang', 
                         style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 17,  fontWeight: FontWeight.bold),
                        ),
                         Container(
                              height: 26,
                              width: 50,
                              decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20)
                              ),
                               child: 
                               Center(
                                 child: Text('${e.m1}', 
                                     style: TextStyle(color: Colors.white, fontSize: 16,fontWeight: FontWeight.bold,),
                                    ),
                               ),
                             ),
                        ],
                        ),
                      ),
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 10),
                    child: 
                    Row(
                      children: [
                         Text('${kondisiHb()}', 
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                          width: 20,
                        ),
                       Text('${kondisiHjb()}', 
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                          width: 20,
                        ),
                         Text('MarBaru', 
                      style: TextStyle(color: Colors.black,fontSize: 15),
                      ),
                      SizedBox(
                          width: 10,
                        ),
                         Padding(
                        padding: const EdgeInsets.only(left:5),
                        child:  double.parse(e.hbeli) >  double.parse(e.hjualBaru)
                            ? Text(
                                "${selisih}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                ) 
                            )
                            : Text(
                                "${selisih}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                ) 
                            ),
                    ),
                      ],
                    ),
                  ),
                 
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                               decoration:  BoxDecoration(
                              border: Border.all(
                              width: 1, 
                              color: Colors.red
                            ),
                            color: Colors.white,
                              ),
                              height: 35,
                              width: 130,
                              child: 
                               
                               Container(
                                margin: EdgeInsets.only(left: 23, top: 15),
                                 child: TextField(
                                             controller: dateInput,
                                              decoration: InputDecoration(
                                    border: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.red, width: 5.0),
                                      ),
                                    hintText: 'Start Date',
                                    labelStyle: TextStyle(color: Colors.red),
                                    hintStyle:
                                        TextStyle(color: Colors.black, fontSize: 15,),
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.red,),),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Colors.red),)),
                                             readOnly: true,
                                             onTap: () async {
                                               DateTime? pickedDate = await showDatePicker(
                                                   context: context,
                                                   initialDate: DateTime.now(),
                                                   firstDate: DateTime(1950),
                                                   lastDate: DateTime(2100));
                                
                                               if (pickedDate != null) {
                                                 print(
                                                     pickedDate); 
                                                 String formattedDate =
                                                     DateFormat('yyyy-MM-dd').format(pickedDate);
                                                 print(
                                                     formattedDate); 
                                                 setState(() {
                                                   dateInput.text =
                                                       formattedDate;
                                                 });
                                               } else {}
                                             },
                                           ),
                               )
                            ),
                        
                        SizedBox(width: 10),
                        Text('s/d'),
                        SizedBox(width: 10),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                           decoration:  BoxDecoration(
                          border: Border.all(
                          width: 1, 
                          color: Colors.red
                        ),
                        color: Colors.white,
                          ),
                          height: 35,
                          width: 130,
                           child: Container(
                            margin: EdgeInsets.only(left: 23, top: 15),
                             child: TextField(
                                         controller: dateInput,
                                          decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.red, width: 5.0),
                                  ),
                                hintText: 'End Date',
                                labelStyle: TextStyle(color: Colors.red),
                                hintStyle:
                                    TextStyle(color: Colors.black, fontSize: 15,),
                                enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.red,),),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        new BorderSide(color: Colors.red),)),
                                         readOnly: true,
                                         onTap: () async {
                                           DateTime? pickedDate = await showDatePicker(
                                               context: context,
                                               initialDate: DateTime.now(),
                                               firstDate: DateTime(1950),
                                               lastDate: DateTime(2100));
                            
                                           if (pickedDate != null) {
                                             print(
                                                 pickedDate); 
                                             String formattedDate =
                                                 DateFormat('yyyy-MM-dd').format(pickedDate);
                                             print(
                                                 formattedDate); 
                                             setState(() {
                                               dateInput.text =
                                                   formattedDate;
                                             });
                                           } else {}
                                         },
                                       ),
                           )
                        ),
                          ],
                        ),
                        Checkbox(
                        activeColor: Colors.red,
                                 value: e.isSelected,

                              onChanged: (bool? value) {
                                //itemChange(newValue!, index);
                                setState(() {
                                  e.isSelected = value!;
                                 if(selectedData.indexOf('00${e.sku}') < 0) {
                                  selectedData.add('00${e.sku}');
                                  selectedData2.add(e.m1);
                                     _rowSelectedCount += value ? 1 : -1;
                                  } else {
                                    selectedData.removeWhere((element) => element == '00${e.sku}');
                                    selectedData2.removeLast();
                                     _rowSelectedCount += value ? 1 : -1;
                                  }
                                  print(selectedData);
                                  print(selectedData2);
                                });
                              }
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Column(
                      children: [
                         Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                'SKU',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                ': ${e.sku}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                'HB',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Text(
                                ': ${kondisiHb()}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                'HJ',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              width: 120,
                              child: Text(
                                ': ${kondisiHj()}',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              width: 120,
                              child: Text(
                                'Margin Lama',
                                style: TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                     ],
                         ),
                      ],
                    ),
                  ),
                  Center(
                    child: 
                    IconButton(
                      icon: Icon(
                        Icons.arrow_drop_up,
                      ),
                      iconSize: 38,
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                         e.isSelectedCont = !e.isSelectedCont;
                        });
                      },
                      
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
         
            
                   
        ],
      );
       
              }).toList(),
              
            )
            ),
              Container(
              margin: EdgeInsets.fromLTRB(179, 770, 179, 50),
              child: MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 40),
                  height: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    'Send',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  color: Color.fromARGB(255, 255, 17, 17),
                  onPressed: () {
                    approve1();
                  }))    
             
        ])
        
    );
  }
  
   DropdownMenuItem<String> buildMenuItem(String item) =>
  DropdownMenuItem(
    value: item,
    child: Text(
      item, 
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color.fromARGB(255, 255, 17, 17)),
    ),
  );
}
