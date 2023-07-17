import 'dart:convert';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myactivity_project/keyboard.dart';
import 'package:myactivity_project/models/model_idacash_cust.dart';
import 'package:myactivity_project/models/model_idcash.dart';
import 'package:myactivity_project/models/models_approval_return_list.dart';
import 'package:myactivity_project/ramayana_device_info.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_id_cash_riwayat.dart';
import 'package:myactivity_project/ramayana_idcash_new_pin.dart';
import 'package:myactivity_project/ramayana_idcash_pin.dart';
import 'package:myactivity_project/ramayana_idcash_new_pin.dart';
import 'package:myactivity_project/ramayana_idcashbarcode.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:myactivity_project/settingsralstools.dart';

class RamayanaIDCash extends StatefulWidget {
  const RamayanaIDCash({super.key});

  @override
  State<RamayanaIDCash> createState() => _RamayanaIDCashState();
}

class _RamayanaIDCashState extends State<RamayanaIDCash> {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _udid = 'Unknown';
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController hp = TextEditingController();

  UserData userData = UserData();
  var dio = Dio();

  @override
  void didPushNext() {
    ScreenBrightness().resetScreenBrightness();
  }

  @override
  void didPop() {
    ScreenBrightness().resetScreenBrightness();
  }

  fetchDataCustomer({required String id_user}) async {
    print('${userData.getUsername7()}');
    print(tipeurl);
    ApprovalIdcashCustomer.approvalidcashcust.clear();
    final responseku = await http.post(
      
        Uri.parse('${tipeurl}v1/membercards/tbl_customer'),
        body: {'id_user': '${userData.getUsername7()}'});

    var data = jsonDecode(responseku.body);

    if (data['status'] == 200) {
      print("API Success oooo");
      print(data);
      int count = data['data'].length;
      final Map<String, ApprovalIdcashCustomer> profileMap = new Map();
      for (int i = 0; i < count; i++) {
        ApprovalIdcashCustomer.approvalidcashcust
            .add(ApprovalIdcashCustomer.fromjson(data['data'][i]));
      }
      ApprovalIdcashCustomer.approvalidcashcust.forEach((element) {
        profileMap[element.nokartu] = element;
        ApprovalIdcashCustomer.approvalidcashcust = profileMap.values.toList();
        print(ApprovalIdcashCustomer.approvalidcashcust);
      });
      print('check length ${ApprovalIdcashCustomer.approvalidcashcust.length}');
      print(data['data'].toString());
    } else {
      print('NO DATA');
    }

    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
    didPushNext();
    didPop();
    fetchDataCustomer(id_user: '${userData.getUsername7()}');
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
    String string = ApprovalReturnMenu.idcashmenu.toString();
    print('string ${string}');
    List splitted = string.split(",");
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ApprovalIdcash.approvalidcash.clear();
            print(ApprovalIdcash.approvalidcash);
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return DefaultBottomBarController(child: Ramayana());
            }), (route) => false);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'ID CASH',
          style: TextStyle(
              fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color.fromARGB(255, 255, 17, 17),
        elevation: 5,
        toolbarHeight: 90,
      ),
      body: Stack(fit: StackFit.loose, children: <Widget>[
        Container(
            // height: MediaQuery.of(context).size.height/1.14,
            decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 0, 0),
        )),
        Container(
          width: 100000,
          height: 300,
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 0, 0),
            // borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 1,
              ),

              Column(
                children: [
                  Text(
                    'Saldo',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontStyle: FontStyle.italic),
                  ),
                  Column(
                    children: ApprovalIdcashCustomer.approvalidcashcust.map(
                      (e) {
                        kondisiSelisih() {
                          var ex = '${e.saldo_pemakaian}';
                          List<String> resultSelisih = ex.split('');
                          print(resultSelisih);
                          if (resultSelisih.length <= 4 &&
                              resultSelisih.length > 2) {
                            resultSelisih.insert(resultSelisih.length - 3, '.');
                            print(resultSelisih);
                          } //doneee 1000
                          else if (resultSelisih.length <= 5 &&
                              resultSelisih.length > 4) {
                            resultSelisih.insert(resultSelisih.length - 3, '.');
                            print(resultSelisih);
                          } else if (resultSelisih.length <= 6 &&
                              resultSelisih.length > 5) {
                            resultSelisih.insert(resultSelisih.length - 3, '.');
                            print(resultSelisih);
                          } else if (resultSelisih.length <= 7 &&
                              resultSelisih.length > 6) {
                            resultSelisih.insert(resultSelisih.length - 3, '.');
                            resultSelisih.insert(resultSelisih.length - 7, '.');
                            print(resultSelisih);
                          } else if (resultSelisih.length <= 8 &&
                              resultSelisih.length > 7) {
                            resultSelisih.insert(resultSelisih.length - 3, '.');
                            resultSelisih.insert(resultSelisih.length - 7, '.');
                            print(resultSelisih);
                          } else if (resultSelisih.length <= 9 &&
                              resultSelisih.length > 8) {
                            resultSelisih.insert(resultSelisih.length - 3, '.');
                            resultSelisih.insert(resultSelisih.length - 7, '.');
                            print(resultSelisih);
                          } else if (resultSelisih.length <= 10 &&
                              resultSelisih.length > 9) {
                            resultSelisih.insert(resultSelisih.length - 3, '.');
                            resultSelisih.insert(resultSelisih.length - 7, '.');
                            resultSelisih.insert(
                                resultSelisih.length - 11, '.');
                            print(resultSelisih);
                          } else if (resultSelisih.length <= 11 &&
                              resultSelisih.length > 10) {
                            resultSelisih.insert(resultSelisih.length - 3, '.');
                            resultSelisih.insert(resultSelisih.length - 7, '.');
                            resultSelisih.insert(
                                resultSelisih.length - 11, '.');
                            print(resultSelisih);
                          } else if (resultSelisih.length <= 12 &&
                              resultSelisih.length > 11) {
                            resultSelisih.insert(resultSelisih.length - 3, '.');
                            resultSelisih.insert(resultSelisih.length - 7, '.');
                            resultSelisih.insert(
                                resultSelisih.length - 11, '.');
                            print(resultSelisih);
                          } else {
                            return e.saldo;
                          }
                          var resultSelisihDone = resultSelisih.join('');
                          return resultSelisihDone;
                          // if(resultSelisih.length <= 6 && resultSelisih.length > 5)
                          // {
                          //   print('true');
                          // } else {
                          //   print('false');
                          // }
                        }

                        return Text(
                          'Rp. ${kondisiSelisih()}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 40,
                              fontWeight: FontWeight.bold),
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),

              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: splitted.map((map) {
              //       getNameMenu() {
              //         var menu = '${map}';
              //         print(map);
              //         if (menu == "[ nokartu"){
              //           return 'No.Kartu ID CASH';
              //         }  else if (menu == "[ nokartu]]") {
              //           return 'No.Kartu ID CASH';
              //         } else if (menu == " transaksi]") {
              //           return 'Riwayat Transaksi';
              //         } else if (menu == " transaksi]]") {
              //           return 'Riwayat Transaksi';
              //         } else if (menu == "[ transaksi]]") {
              //           return 'Riwayat Transaksi';
              //         }  else {
              //           return map;
              //         }
              //       }

              //       getIconMenu() {
              //         var menu = '${map}';
              //         if (menu == "[ nokartu"){
              //           return Icon(Icons.payment_outlined,
              //               size: 35,
              //               color: Color.fromARGB(255, 255, 17, 17),
              //               );
              //         } else if (menu == "[ nokartu]]") {
              //         return Icon(Icons.payment_outlined,
              //                size: 35,
              //               color: Color.fromARGB(255, 255, 17, 17),
              //               );
              //         } else if (menu == " transaksi]") {
              //         return Icon(Icons.bar_chart,
              //                size: 35,
              //               color: Color.fromARGB(255, 255, 17, 17),
              //               );
              //         } else if (menu == " transaksi]]") {
              //         return Icon(Icons.bar_chart,
              //                size: 35,
              //               color: Color.fromARGB(255, 255, 17, 17),
              //               );
              //         } else if (menu == "[ transaksi]]") {
              //         return Icon(Icons.bar_chart,
              //                size: 35,
              //               color: Color.fromARGB(255, 255, 17, 17),
              //               );
              //         } else {
              //            Icon(Icons.menu,
              //               size: 35,
              //               color: Colors.white,
              //               );
              //         }
              //       }
              //       return
              //     Column(

              //       children: ApprovalIdcashCustomer.approvalidcashcust.map((e) {
              //             return
              //         Column(
              //           children: [
              //             MaterialButton(
              //                       minWidth:  MediaQuery.of(context).size.width/7,
              //                       height:  MediaQuery.of(context).size.height/15,
              //                       shape: RoundedRectangleBorder(
              //                       borderRadius: BorderRadius.circular(50)
              //                       ),
              //                       color: Colors.white,
              //                       onPressed: () {
              //                         Navigator.push(context, MaterialPageRoute(builder: (context){
              //                            var namaAkses = '${map}';
              //                            if (namaAkses == "[ nokartu") {
              //                             return RamayanaPin();
              //                            } else if (namaAkses == '[ nokartu]]') {
              //                              return RamayanaPin();
              //                            } else if (namaAkses == ' transaksi]') {
              //                              ApprovalIdcash.approvalidcash.add(e.nokartu);
              //                              print(ApprovalIdcash.approvalidcash);
              //                             return RamayanaRiwayatIDCash();
              //                            } else if (namaAkses == ' transaksi]]') {
              //                              ApprovalIdcash.approvalidcash.add(e.nokartu);
              //                              print(ApprovalIdcash.approvalidcash);
              //                             return RamayanaRiwayatIDCash();
              //                            } else if (namaAkses == '[ transaksi]]') {
              //                              ApprovalIdcash.approvalidcash.add(e.nokartu);
              //                              print(ApprovalIdcash.approvalidcash);
              //                             return RamayanaRiwayatIDCash();
              //                            } else {
              //                            return RamayanaIDCash();
              //                            }

              //                       }));
              //                       },
              //                      child:  getIconMenu()

              //                       ),
              //                        SizedBox(
              //                     height: 10,
              //                   ),
              //           Text('${getNameMenu()}', style: TextStyle(color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),),
              //           ],
              //         );

              //       },).toList(),
              //     );
              //     }).toList()
              // )
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      MaterialButton(
                          minWidth: MediaQuery.of(context).size.width / 7,
                          height: MediaQuery.of(context).size.height / 15,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return RamayanaIdcashNewPin();
                            }));
                          },
                          child: Icon(
                            Icons.payment_outlined,
                            size: 35,
                            color: Color.fromARGB(255, 255, 17, 17),
                          )),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'No. Kartu ID CASH',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontStyle: FontStyle.italic,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Column(
                      children:
                          ApprovalIdcashCustomer.approvalidcashcust.map((e) {
                    return Column(
                      children: [
                        MaterialButton(
                            minWidth: MediaQuery.of(context).size.width / 7,
                            height: MediaQuery.of(context).size.height / 15,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            color: Colors.white,
                            onPressed: () async {
                              AndroidDeviceInfo info =
                                  await deviceInfo.androidInfo;
                              var formData = FormData.fromMap({
                                'progname': 'RALS_TOOLS ',
                                'versi': '${versi}',
                                'date_run': '${DateTime.now()}',
                                'info1': 'Riwayat ID CASH',
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
                              ApprovalIdcash.approvalidcash.add(e.nokartu);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return RamayanaRiwayatIDCash();
                              }));
                            },
                            child: Icon(
                              Icons.bar_chart,
                              size: 35,
                              color: Color.fromARGB(255, 255, 17, 17),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Riwayat Transaksi',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontStyle: FontStyle.italic,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    );
                  }).toList())
                ],
              )
            ],
          ),
        ),
        Container(
          // height: MediaQuery.of(context).size.height/1.81,
          margin: EdgeInsets.fromLTRB(5, 320, 5, 0),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30), topRight: Radius.circular(30))),

          child: ListView(
              children: ApprovalIdcashCustomer.approvalidcashcust.map(
            (e) {
              kondisiNama() {
                var nama = "${e.nama}";
                if (nama != "${e.nama}") {
                  return '-';
                } else {
                  return e.nama;
                }
              }

              kondisiEmail() {
                var email = "${e.email}";
                if (email != "${e.email}" || email == " ") {
                  print('true');
                  return '-';
                } else {
                  print('false');
                  return e.email;
                }
              }

              print(kondisiEmail());

              kondisiNohp() {
                var nohp = "${e.nohp}";
                if (nohp != "${e.nohp}" || nohp == " ") {
                  print('true');
                  return '-';
                } else {
                  print('false');
                  return e.nohp;
                }
              }

              print(kondisiNohp());
              return Column(
                children: [
                  Container(
                    height: 80,
                    width: 100000,
                    margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 228, 228, 228),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              'Nama',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: TextFormField(
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 228, 228, 228)),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color:
                                          Color.fromARGB(255, 228, 228, 228)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color:
                                          Color.fromARGB(255, 228, 228, 228)),
                                )),
                            controller: nama..text = kondisiNama(),
                            readOnly: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 100000,
                    margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 228, 228, 228),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              'Email',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: TextFormField(
                            style: TextStyle(fontSize: 18, color: Colors.black),
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 228, 228, 228)),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color:
                                          Color.fromARGB(255, 228, 228, 228)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color:
                                          Color.fromARGB(255, 228, 228, 228)),
                                )),
                            controller: email..text = kondisiEmail(),
                            readOnly: true,
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 80,
                    width: 100000,
                    margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 228, 228, 228),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4))
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(left: 20, top: 10),
                            child: Text(
                              'No. HP',
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            )),
                        Container(
                          margin: EdgeInsets.only(left: 20),
                          child: TextFormField(
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            decoration: InputDecoration(
                                border: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 228, 228, 228)),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color:
                                          Color.fromARGB(255, 228, 228, 228)),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: new BorderSide(
                                      color:
                                          Color.fromARGB(255, 228, 228, 228)),
                                )),
                            controller: hp..text = kondisiNohp(),
                            readOnly: true,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              );
            },
          ).toList()),
        ),
      ]),
    );
  }
}
