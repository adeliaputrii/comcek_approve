import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:myactivity_project/justtest.dart';
import 'package:myactivity_project/models/model_apv.dart';
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

class RamayanaHistory1 extends StatefulWidget {
  const RamayanaHistory1({super.key});

  @override
  State<RamayanaHistory1> createState() => _RamayanaHistory1State();
}

class _RamayanaHistory1State extends State<RamayanaHistory1> {
 TextEditingController dateInput = TextEditingController();

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
    
    ApproveModel.approvelist.clear();
    final responseku = await http.post(
      Uri.parse('https://android-api.ramayana.co.id:8304/v1/activity/tbl_commcheck'),
        body: {
          'm1' : m1
        });

    var data = jsonDecode(responseku.body);
   
    if (data['status'] == 200) {
      print("API Success");
      print(data);
      int count = data['data'].length;
      for (int i = 0; i < count; i++) {
        ApproveModel.approvelist.add(ApproveModel.fromjson(data['data'][i]));
      }
      print('check length ${ApproveModel.approvelist.length}');
      print(data['data'].toString());

    } else {
      print('NO DATA');
    }
     setState(() {});
  }


   void initState() {
    super.initState();
    fetchProduk(m1: '082');
    dateInput.text = "";
  }  

  void approve1() {
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
                              'is_approv': '1',
                              'user_approv' : 'test_comcek_build',
                              'sku': '00414975',
                              'm1' : '081'
                            });

                            var response = await dio.post(
                                'https://android-api.ramayana.co.id:8304/v1/activity/updateApproveCommcheck',
                                data: formData);

                            print(
                                // 'Berhasil, ${}, ${password.text},${password.text}, ${passwordReEnter.text}'
                                'Berhasil, '
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
  bool _checkBoxVal = false;
  bool click = true;
  bool click2 = true;
  int _rowSelectedCount = 0;

  int get selectedItems => _rowSelectedCount;
  int get selectedItemsAll => ApproveModel.approvelist.length - _rowSelectedCount;

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
            margin: EdgeInsets.only(top: 200, bottom: 120),
            decoration: BoxDecoration(
            color: Color.fromARGB(255, 244, 244, 244),
           
          ),
            child: ListView(
              children: ApproveModel.approvelist.map((e) {
                print('nama user ${e.sku}');
                return 
          
        Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            crossFadeState:
                click ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 800),
            firstChild: 
           Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            height: 180,
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
              margin: EdgeInsets.only(left: 10, right: 10, top: 0),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${e.m1}', 
                             style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 18, decoration: TextDecoration.underline),
                            ),
                        SizedBox(
                            width: 30,
                          ),
                         Text('Nama Barang', 
                         style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 18, decoration: TextDecoration.underline),
                        ),
                        ],
                        ),
                      ),
                      Checkbox(
                        activeColor: Colors.red,
                        onChanged: (value) {
                          print(value);
                          _checkBoxVal = value!;
                          _rowSelectedCount += value ? 1 : -1;
                          setState(() {
                           
                          });
                        },
                        value: _checkBoxVal,)
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: 
                    Row(
                      children: [
                             Text('${e.hjual}', 
                         style: TextStyle(color: Colors.black, fontSize: 15),
                          ),
                        SizedBox(
                          width: 20,
                        ),
                         Text('${e.hjualBaru}', 
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                          width: 20,
                        ),
                       Text('${e.hbeli}', 
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                          width: 20,
                        ),
                         Text('MarL', 
                      style: TextStyle(color: Colors.black,  fontSize: 15),
                      ),
                      SizedBox(
                          width: 20,
                        ),
                        Text('SelHAr',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 20),
                    child: Row(
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
                          Center(child: Text('Start Date', style: TextStyle(fontSize: 15, color: Colors.black),)),
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
                          child: 
                          Center(child: Text('End Date', style: TextStyle( fontSize: 15, color: Colors.black),)),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: 38,
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          click = !click;
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
            height: 280,
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('${e.m1}', 
                             style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 17, decoration: TextDecoration.underline),
                            ),
                        SizedBox(
                            width: 30,
                          ),
                         Text('Nama Barang', 
                         style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 17, decoration: TextDecoration.underline),
                        ),
                        ],
                        ),
                      ),
                      Checkbox(
                        activeColor: Colors.red,
                        onChanged: (value) {
                          _checkBoxVal = value!;
                          _rowSelectedCount += value ? 1 : -1;
                          setState(() {
                           
                          });
                        },
                        value: _checkBoxVal,)
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: 
                    Row(
                      children: [
                             Text('${e.hjual}', 
                         style: TextStyle(color: Colors.black,  fontSize: 15),
                          ),
                        SizedBox(
                          width: 20,
                        ),
                         Text('${e.hjualBaru}', 
                      style: TextStyle(color: Colors.black,fontSize: 15),
                      ),
                      SizedBox(
                          width: 20,
                        ),
                       Text('${e.hbeli}', 
                      style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      SizedBox(
                          width: 20,
                        ),
                         Text('MarL', 
                      style: TextStyle(color: Colors.black,fontSize: 15),
                      ),
                      SizedBox(
                          width: 20,
                        ),
                        Text('SelHar',
                        style: TextStyle(color: Colors.black,fontSize: 15),
                        ),
                      ],
                    ),
                  ),
                 
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 20),
                    child: Row(
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
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          'HB             :  ${e.hbeli}',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'HJ             :  ${e.hjual}',
                           style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'HJ BARU  :  ${e.hjualBaru}',
                         style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_drop_up,
                      ),
                      iconSize: 38,
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          click = !click;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
          SizedBox(height: 10),
         
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
