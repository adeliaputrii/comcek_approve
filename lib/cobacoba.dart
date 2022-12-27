import 'dart:convert';
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

class RamayanaHistory120 extends StatefulWidget {
  const RamayanaHistory120({super.key});

  @override
  State<RamayanaHistory120> createState() => _RamayanaHistory120State();
}

class _RamayanaHistory120State extends State<RamayanaHistory120> {
  TextEditingController dateInput = TextEditingController();
  TextEditingController sku = TextEditingController();
  TextEditingController m1 = TextEditingController();

  var dio = Dio();
  var selected1;
  final List<String> data1 = ['MD1', 'MD2', 'MD3', 'MD4'];

  var selected2;
  final List<String> data2 = ['RB17', 'R136', 'S204', 'S445'];

  UserData userData = UserData();

  fetchProduk({required String m1}) async {
    ApproveModel1.approvelist1.clear();
    final responseku = await http.post(
        Uri.parse(
            'https://android-api.ramayana.co.id:8304/v1/activity/tbl_commcheck'),
        body: {'m1': m1});

    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success");
      print(data);
      int count = data['data'].length;
      for (int i = 0; i < count; i++) {
        ApproveModel1.approvelist1.add(ApproveModel1.fromjson(data['data'][i]));
      }
      print('check length ${ApproveModel1.approvelist1.length}');
      print(data['data'].toString());
    } else {
      print('NO DATA');
    }

    setState(() {});
  }

  void initState() {
    super.initState();
    fetchProduk(m1: '081');
    dateInput.text = "";
  }

  bool click = true;
  bool click2 = true;
  int _rowSelectedCount = 0;

  int get selectedItems => _rowSelectedCount;
  int get selectedItemsAll =>
      ApproveModel1.approvelist1.length - _rowSelectedCount;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return RamayanaCompetitorCek();
              }));
            },
            icon: Icon(
              IconlyLight.arrowLeft,
              color: Color.fromARGB(255, 255, 255, 255),
              size: 25,
            ),
          ),
          title: Container(
            margin: EdgeInsets.only(left: 120),
            child: Text(
              'Approve',
              style: TextStyle(
                  fontSize: 23,
                  color: Color.fromARGB(255, 255, 255, 255),
                  fontWeight: FontWeight.bold),
            ),
          ),
          backgroundColor: Color.fromARGB(255, 255, 14, 14),
          elevation: 5,
          toolbarHeight: 80,
        ),
        body: Stack(children: [
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
              )),

          Container(
            margin: EdgeInsets.only(left: 10, top: 20),
            child: Text('List Approve',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                    fontWeight: FontWeight.w700)),
          ),

          Container(
              margin: EdgeInsets.only(right: 0, top: 70, left: 10),
              child: ListTile(
                  trailing: Text(
                      '${userData.getFullname()} ${userData.getUsernameID()}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w500)))),
          Container(
            margin: EdgeInsets.fromLTRB(0, 125, 0, 0),
            height: 60,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                    color: Colors.black12, spreadRadius: 5, blurRadius: 15)
              ],
            ),
            child: Container(
              margin: EdgeInsets.only(left: 50, right: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  DropdownButton(
                      value: selected2,
                      hint: Text(
                        'TOKO',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 17, 17),
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
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
                              child: Text(
                                e,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 255, 17, 17)),
                              ),
                            ),
                          )
                          .toList()),
                  DropdownButton(
                      value: selected1,
                      hint: Text(
                        'MD',
                        style: TextStyle(
                            color: Color.fromARGB(255, 255, 17, 17),
                            fontSize: 17,
                            fontWeight: FontWeight.w500),
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
                              child: Text(
                                e,
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 255, 17, 17)),
                              ),
                            ),
                          )
                          .toList()),
                ],
              ),
            ),
          ),

          // Container(
          //     margin: EdgeInsets.only(top: 190, bottom: 120),
          //     decoration: BoxDecoration(
          //     color: Color.fromARGB(255, 244, 244, 244),

          //   ),
          //     child:

          //     ),
          Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: ApproveModel1.approvelist1.map((e) {
                return Container(
                    margin: EdgeInsets.only(top: 10, bottom: 120),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 244, 244, 244),
                    ),
                    child: ListView(
                      children: <Widget>[
                        
                      ],
                    ));
              }).toList())
        ]));
  }

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: Color.fromARGB(255, 255, 17, 17)),
        ),
      );
}
