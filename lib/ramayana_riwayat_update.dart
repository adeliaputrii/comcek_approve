import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:myactivity_project/models/model_tabel_approve.dart';
import 'package:myactivity_project/ramayana_comcheck_cek.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class RamayanaRiwayatUpdate extends StatefulWidget {
  const RamayanaRiwayatUpdate({super.key});

  @override
  State<RamayanaRiwayatUpdate> createState() => _RamayanaRiwayatUpdateState();
}

class _RamayanaRiwayatUpdateState extends State<RamayanaRiwayatUpdate> {

   UserData userData = UserData();

  fetchProduk({
    required String m1
  }) async {
  
  var prod = 'https://';
  var dev = 'https://dev-';
  var tipeurl = '${prod}';
    ApproveModel1.approvelist1.clear();
    final responseku = await http.post(
      Uri.parse('${tipeurl}android-api.ramayana.co.id:8304/v1/activity/tbl_commcheck'),
      // Uri.parse('https://android-api.ramayana.co.id:8304/v1/activity/tbl_commcheck'),
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
    fetchProduk(m1: '082');
    
    
  }  
 
  
 bool checkedAll = false;
  bool click = true;
  bool click2 = true;
  int isapv = 0;
  int _rowSelectedCount = 0;
  List selectedData = [];
  List selectedData2 = [];

  int get selectedItems => _rowSelectedCount;
  int get selectedItemsAll => ApproveModel1.approvelist1.length - _rowSelectedCount;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: 
        Container(
          margin: EdgeInsets.only(left: 90, right: 115),
          child: Text('Riwayat Approve', style: TextStyle(fontSize: 23, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),)),
        backgroundColor: Color.fromARGB(255, 255, 14, 14),
        elevation: 0,
        toolbarHeight: 80,
        ),

      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Container(
            height: 250,
            decoration: BoxDecoration(
                color:  Color.fromARGB(255, 255, 14, 14),
               
                
          )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(30, 20, 30, 0),
            height: 50,
            
            decoration: BoxDecoration(
              
              borderRadius: BorderRadius.circular(70),
               color: Colors.white,
               
               boxShadow: [BoxShadow(
                blurRadius: 3,
                
                offset: Offset(2, 2),
                color: Color.fromARGB(255, 194, 191, 191)
               )]
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Bulan', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),),
                 Text('Tahun', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold))
              ],
            ),
          ),
          
          Container(
            margin: EdgeInsets.only(top: 110, right: 10, left: 10, bottom: 10),
            decoration: BoxDecoration(
            color:  Color.fromARGB(255, 255, 250, 250),
            borderRadius: BorderRadius.circular(15),
             boxShadow: [BoxShadow(
                  blurRadius: 5,
                  color: Color.fromARGB(255, 105, 102, 102)
                )]
            ),
             child: 
          
                Container(
                  margin: EdgeInsets.only(left: 15, top: 15),
                  child:  ListView(
              children: ApproveModel1.approvelist1.map((e) {
            
                
                var hb = '${e.hbeli}';
                var iniSku = e.sku;
                var iniSkuStr = iniSku.toString();
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
                // print(resultHb);
                final hapus = resultHb.remove('.');
                  if (resultHb.length > 6 && resultHb.length <= 9) {
                  resultHb.remove(hapus);
                  resultHb.remove('0');
                  resultHb.insert(resultHb.length - 2, ',');
                  resultHb.insert((resultHb.length - 6), '.');
                  
                } 
                else if (resultHb.length >= 10 && resultHb.length <= 12) {
                  resultHb.remove(hapus);
                  resultHb.remove('0');
                  resultHb.insert(resultHb.length - 2, ',');
                  resultHb.insert((resultHb.length - 6), '.');
                  resultHb.insert((resultHb.length - 10), '.');
                }
                else if (resultHb.length >= 13) {
                  resultHb.remove(hapus);
                  resultHb.remove('0');
                  resultHb.insert(resultHb.length - 2, ',');
                  resultHb.insert((resultHb.length - 6), '.');
                  resultHb.insert((resultHb.length - 10), '.');
                  resultHb.insert((resultHb.length - 14), '.');
                }
               
                var resultHbDone = resultHb.join('');
                return resultHbDone;
                }

                kondisiHj() {
               List<String> resultHj = hj.split('');
                // print(resultHb);
                final hapus = resultHj.remove('.');
                  if (resultHj.length > 6 && resultHj.length <= 9) {
                  resultHj.remove(hapus);
                  resultHj.remove('0');
                  resultHj.insert(resultHj.length - 2, ',');
                  resultHj.insert((resultHj.length - 6), '.');
                  
                } 
                else if (resultHj.length >= 10 && resultHj.length <= 12) {
                  resultHj.remove(hapus);
                  resultHj.remove('0');
                  resultHj.insert(resultHj.length - 2, ',');
                  resultHj.insert((resultHj.length - 6), '.');
                  resultHj.insert((resultHj.length - 10), '.');
                }
                else if (resultHj.length >= 13) {
                  resultHj.remove(hapus);
                  resultHj.remove('0');
                  resultHj.insert(resultHj.length - 2, ',');
                  resultHj.insert((resultHj.length - 6), '.');
                  resultHj.insert((resultHj.length - 10), '.');
                  resultHj.insert((resultHj.length - 14), '.');
                }
                var resultHjDone = resultHj.join('');
                return resultHjDone;
                }

                kondisiHjb() {
                 List<String> resultHjb = hjB.split('');
                // print(resultHb);
                final hapus = resultHjb.remove('.');
                  if (resultHjb.length > 6 && resultHjb.length <= 9) {
                  resultHjb.remove(hapus);
                  resultHjb.remove('0');
                  resultHjb.insert(resultHjb.length - 2, ',');
                  resultHjb.insert((resultHjb.length - 6), '.');
                  
                } 
                else if (resultHjb.length >= 10 && resultHjb.length <= 12) {
                  resultHjb.remove(hapus);
                  resultHjb.remove('0');
                  resultHjb.insert(resultHjb.length - 2, ',');
                  resultHjb.insert((resultHjb.length - 6), '.');
                  resultHjb.insert((resultHjb.length - 10), '.');
                }
                else if (resultHjb.length >= 13) {
                  resultHjb.remove(hapus);
                  resultHjb.remove('0');
                  resultHjb.insert(resultHjb.length - 2, ',');
                  resultHjb.insert((resultHjb.length - 6), '.');
                  resultHjb.insert((resultHjb.length - 10), '.');
                  resultHjb.insert((resultHjb.length - 14), '.');
                }
                var resultHjbDone = resultHjb.join('');
                return resultHjbDone;
                }
               
                kondisiSelisih() {
                  final sel = '4050.0';
              List<String> resultSelisih = selisihStr.split('');
              final hapus = resultSelisih.remove('.');
              final strip = resultSelisih.remove('-');
              if (resultSelisih.length < 5 ) {
                  resultSelisih.remove(hapus);
                  resultSelisih.remove(strip);
                  resultSelisih.insert(resultSelisih.length - 1, ',');
                  resultSelisih;
                }
               else if (resultSelisih.length >= 5 && resultSelisih.length < 8) {
                  resultSelisih.remove(hapus);
                  resultSelisih.insert(resultSelisih.length - 1, ',');
                  resultSelisih.insert((resultSelisih.length - 5), '.');
                } 
                 else if (resultSelisih.length >= 8  && resultSelisih.length < 12) {
                  resultSelisih.remove(hapus);
                  resultSelisih.insert(resultSelisih.length - 1, ',');
                  resultSelisih.insert((resultSelisih.length - 5), '.');
                  resultSelisih.insert((resultSelisih.length - 9), '.');
                }
                 else if (resultSelisih.length >= 11) {
                  resultSelisih.remove(hapus);
                  resultSelisih.insert(resultSelisih.length - 1, ',');
                  resultSelisih.insert((resultSelisih.length - 5), '.');
                  resultSelisih.insert((resultSelisih.length - 9), '.');
                  resultSelisih.insert((resultSelisih.length - 13), '.');
                }
                var resultSelisihDone = resultSelisih.join('');
                return resultSelisihDone;
                }

                kondisiSku() {
                  List<String> resultSku = iniSkuStr.split('');
                  final nol = List.filled(8 - resultSku.length, 0);
                  final List<String> strs = nol.map((e) => e.toString()).toList();
                  var resultSkuAdd = strs + resultSku;
                  var resultSkuDone = resultSkuAdd.join('');
                  return resultSkuDone;
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
            margin: EdgeInsets.fromLTRB(4, 15, 15, 0),
            height: 70,
            decoration: BoxDecoration(
              boxShadow: [  BoxShadow(
                        color: Colors.red,
                        
                        offset: const Offset(-4, 0),
                      ),
                    
                    ],
                     border: Border.all(
                          width: 0.3, 
                          color: Colors.red
                        ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
              
            child: 
            MaterialButton(
              padding: EdgeInsets.only(top: 10, left: 10, right: 10),
              onPressed: () {
                 setState(() {
                         e.isSelectedCont = !e.isSelectedCont;
                        });
              },
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 Text('Nama Barang', 
                         style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 17,  fontWeight: FontWeight.bold),
                        ),
                                 Row(
                                   children: [
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
                                ]
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
                    margin: EdgeInsets.only(top: 5),
                    child: 
                   Row(
                      children: [
                         Text('${kondisiHj()}', 
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
                         Padding(
                        padding: const EdgeInsets.only(left:5),
                        child: double.parse(e.hbeli) >  double.parse(e.hjualBaru)
                            ? Text(
                                "${kondisiSelisih()}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                ) 
                            )
                            : Text(
                                "${kondisiSelisih()}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                ) 
                            ),
                    ),
                        
                      SizedBox(
                          width: 20,
                        ),
                         Text('MarBaru', 
                      style: TextStyle(color: Colors.black,fontSize: 15),
                      ),
                      ],
                    ),
                  ),
                  // Center(
                  //   child: 
                    
                  //   IconButton(
                  //     icon: Icon(
                  //       Icons.arrow_drop_down,
                  //     ),
                  //     iconSize: 38,
                  //     color: Colors.black,
                  //     onPressed: () {
                  //       setState(() {
                  //        e.isSelectedCont = !e.isSelectedCont;
                  //       });
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
            secondChild: 
             Container(
            margin: EdgeInsets.fromLTRB(5, 15, 15, 0),
            height: 240,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
                boxShadow: [
                      BoxShadow(
                        color: Colors.red,
                        
                        offset: const Offset(-5, 0),
                      ),
                    
                    ],
                     border: Border.all(
                          width: 1, 
                          color: Colors.red
                        ),
            ),
            child: 
            MaterialButton(
              onPressed: () {
                 setState(() {
                         e.isSelectedCont = !e.isSelectedCont;
                        });
              },
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                      Container(
                        margin: EdgeInsets.only(top: 10),
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
                    margin: EdgeInsets.only(top: 10),
                    child: 
                    Row(
                      children: [
                         Text('${kondisiHj()}', 
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
                        Padding(
                        padding: const EdgeInsets.only(left:5),
                        child:  double.parse(e.hbeli) >  double.parse(e.hjualBaru)
                            ? Text(
                                "${kondisiSelisih()}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 15,
                                ) 
                            )
                            : Text(
                                "${kondisiSelisih()}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                ) 
                            ),
                    ),
                      SizedBox(
                          width: 20,
                        ),
                         Text('MarBaru', 
                      style: TextStyle(color: Colors.black,fontSize: 15),
                      ),
                         
                      ],
                    ),
                  ),
                 
                  Container(
                    margin: EdgeInsets.only( top: 10),
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
                              Center(child: Text('Start Date'))
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
                           child: Center(child: Text('Start Date'))
                        ),
                          ],
                        ),

                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
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
                                ': ${kondisiSku()}',
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
            
          ),
         
        ]),
    );
  }
}