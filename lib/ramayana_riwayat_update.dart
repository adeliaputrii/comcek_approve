import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:myactivity_project/models/model_tabel_approve.dart';
import 'package:myactivity_project/ramayana_comcheck_cek.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:http/http.dart' as http;

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
    
    
  }  
 
  
 
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
              color: Color.fromARGB(255, 255, 14, 14),
          )
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
               color: Colors.white,
               boxShadow: [BoxShadow(
                blurRadius: 3,
                color: Color.fromARGB(255, 235, 229, 229)
               )]
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 150),
            decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(70)
            )
            ),
             child: 
            Container(
              margin: EdgeInsets.only(top: 20, left: 20),
              child: ListView(
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
                              // Container(
                              //   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                              //    decoration:  BoxDecoration(
                              //   border: Border.all(
                              //   width: 1, 
                              //   color: Colors.red
                              // ),
                              // color: Colors.white,
                              //   ),
                              //   height: 35,
                              //   width: 130,
                              //   child: 
                                 
                              //    Container(
                              //     margin: EdgeInsets.only(left: 23, top: 15),
                              //      child: TextField(
                              //                  controller: dateInput,
                              //                   decoration: InputDecoration(
                              //         border: UnderlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Colors.red, width: 5.0),
                              //           ),
                              //         hintText: 'Start Date',
                              //         labelStyle: TextStyle(color: Colors.red),
                              //         hintStyle:
                              //             TextStyle(color: Colors.black, fontSize: 15,),
                              //         enabledBorder: UnderlineInputBorder(
                              //             borderSide:
                              //                 new BorderSide(color: Colors.red,),),
                              //         focusedBorder: UnderlineInputBorder(
                              //             borderSide:
                              //                 new BorderSide(color: Colors.red),)),
                              //                  readOnly: true,
                              //                  onTap: () async {
                              //                    DateTime? pickedDate = await showDatePicker(
                              //                        context: context,
                              //                        initialDate: DateTime.now(),
                              //                        firstDate: DateTime(1950),
                              //                        lastDate: DateTime(2100));
                                  
                              //                    if (pickedDate != null) {
                              //                      print(
                              //                          pickedDate); 
                              //                      String formattedDate =
                              //                          DateFormat('yyyy-MM-dd').format(pickedDate);
                              //                      print(
                              //                          formattedDate); 
                              //                      setState(() {
                              //                        dateInput.text =
                              //                            formattedDate;
                              //                      });
                              //                    } else {}
                              //                  },
                              //                ),
                              //    )
                              // ),
                          
                          SizedBox(width: 10),
                          // Text('s/d'),
                          // SizedBox(width: 10),
                          // Container(
                          //   margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          //    decoration:  BoxDecoration(
                          //   border: Border.all(
                          //   width: 1, 
                          //   color: Colors.red
                          // ),
                          // color: Colors.white,
                          //   ),
                          //   height: 35,
                          //   width: 130,
                          //    child: Container(
                          //     margin: EdgeInsets.only(left: 23, top: 15),
                          //      child: TextField(
                          //                  controller: dateInput,
                          //                   decoration: InputDecoration(
                          //         border: UnderlineInputBorder(
                          //             borderSide: BorderSide(
                          //                 color: Colors.red, width: 5.0),
                          //           ),
                          //         hintText: 'End Date',
                          //         labelStyle: TextStyle(color: Colors.red),
                          //         hintStyle:
                          //             TextStyle(color: Colors.black, fontSize: 15,),
                          //         enabledBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 new BorderSide(color: Colors.red,),),
                          //         focusedBorder: UnderlineInputBorder(
                          //             borderSide:
                          //                 new BorderSide(color: Colors.red),)),
                          //                  readOnly: true,
                          //                  onTap: () async {
                          //                    DateTime? pickedDate = await showDatePicker(
                          //                        context: context,
                          //                        initialDate: DateTime.now(),
                          //                        firstDate: DateTime(1950),
                          //                        lastDate: DateTime(2100));
                              
                          //                    if (pickedDate != null) {
                          //                      print(
                          //                          pickedDate); 
                          //                      String formattedDate =
                          //                          DateFormat('yyyy-MM-dd').format(pickedDate);
                          //                      print(
                          //                          formattedDate); 
                          //                      setState(() {
                          //                        dateInput.text =
                          //                            formattedDate;
                          //                      });
                          //                    } else {}
                          //                  },
                          //                ),
                          //    )
                          // ),
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
                
              ),
            )
          )
        ]),
    );
  }
}