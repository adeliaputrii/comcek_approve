import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:myactivity_project/models/model_idcash.dart';
import 'package:myactivity_project/models/model_idcash_bulan.dart';
import 'package:myactivity_project/ramayana_id_cash_riwayat.dart';
import 'package:myactivity_project/ramayana_idcash.dart';
import 'package:myactivity_project/ramayana_idcash_riwayatBulan.dart';
import 'package:myactivity_project/settingsralstools.dart';


class RamayanaRiwayatIDCash2 extends StatefulWidget {
  const RamayanaRiwayatIDCash2({super.key});

  @override
  State<RamayanaRiwayatIDCash2> createState() => _RamayanaRiwayatIDCash2State();
}

class _RamayanaRiwayatIDCash2State extends State<RamayanaRiwayatIDCash2> {

   fetchDataBulan({
    required String nokartu,
    required String tahun
   }) async {
     
    final Map<String, ApprovalIdcashCustomerBulan> profileMap = new Map();
      ApprovalIdcashCustomerBulan.  approvalidcashbulan.clear();
    final responseku = await http.post(
      Uri.parse('${tipeurl}v1/membercards/tbl_trxsaldokaryawanMM'),
      body: {
        'nokartu' : '${ApprovalIdcash.approvalidcash[0]}',
        // 'nokartu' : '1100180309385576',
        'tahun' : '${ApprovalIdcash.approvalidcash[1]}'
        
        }
      );
    var data = jsonDecode(responseku.body);
   
    if (data['status'] == 200 ) {
      print("API Success oooo");
      print(data);
      int count = data['data'].length;
      for (int i = 0; i < count; i++) {
          ApprovalIdcashCustomerBulan.  approvalidcashbulan.add(  ApprovalIdcashCustomerBulan.fromjson(data['data'][i]));
      } 
      // ApprovalIdcashCustomerBulan.approvalidcashbulan.forEach((element) {
      //   profileMap[element.month] = element;
      //    ApprovalIdcashCustomerBulan.approvalidcashbulan = profileMap.values.toList();
      //  });
      print('check length ${  ApprovalIdcashCustomerBulan. approvalidcashbulan.length}');
      print(data['data'].toString());
      if(ApprovalIdcashCustomerBulan.approvalidcashbulan.length == 0) {
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
                'NO DATA',
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
      }

    } 
     else {
      print('NO DATA');
      
    }
   
   setState(() {});
  }

  
   @override
   void initState() {
    super.initState();
    fetchDataBulan(nokartu: '${ApprovalIdcash.approvalidcash[0]}', tahun: '${ApprovalIdcash.approvalidcash[1]}');
    // fetchDataBulan(nokartu: '1100180309385576', tahun: '${ApprovalIdcash.approvalidcash[1]}');
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            ApprovalIdcash.approvalidcash.removeLast();
            print(ApprovalIdcash.approvalidcash);
            print(ApprovalIdcash.approvalidcash);
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
              return RamayanaRiwayatIDCash();
            }), (route) => false);
          },
          icon: Icon(Icons.arrow_back),
          ),
        title: 
        Container(
          margin: EdgeInsets.only(left: 70, right: 70),
          child: Text('Riwayat Transaksi', style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),)),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        elevation: 0,
        toolbarHeight: 80,
        ),

        body: Stack(
          fit: StackFit.loose,
          children: [
            Container(
              color: Color.fromARGB(255, 255, 0, 0),
            ),
           
            Container(
              margin: EdgeInsets.only(top: 30, left: 5, right: 5, bottom: 10),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
              ),
             
            ),
            Container(
              margin: EdgeInsets.fromLTRB(0, 60, 0, 0),
              child: 
              Column(
                children: [
                  Center(child: Text('${ApprovalIdcash.approvalidcash[1]}', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic))),
               Container(
                margin: EdgeInsets.only(top: 15, left: 50, right: 50),
                 color: Color.fromARGB(255, 197, 197, 197),
                height: 1,
               )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 105, bottom: 30),
              
              child: 
               ListView(
                children:  ApprovalIdcashCustomerBulan.approvalidcashbulan.map((e) {
                
                kondisiSelisih() {
                    var ex = '${e.nilai}';
                    List<String> resultSelisih = ex.split('');
                    print(resultSelisih);
                    if(resultSelisih.length <= 4 && resultSelisih.length > 2) {
                      resultSelisih.insert(resultSelisih.length - 3 , '.');
                      print(resultSelisih);
                    }//doneee 1000
                    else if (resultSelisih.length <= 5 && resultSelisih.length > 4) {
                       resultSelisih.insert(resultSelisih.length - 3 , '.');
                      print(resultSelisih);
                    } else if (resultSelisih.length <= 6 && resultSelisih.length > 5) {
                       resultSelisih.insert(resultSelisih.length - 3 , '.');
                      print(resultSelisih);
                    }  else if (resultSelisih.length <= 7 && resultSelisih.length > 6) {
                       resultSelisih.insert(resultSelisih.length - 3 , '.');
                       resultSelisih.insert(resultSelisih.length - 7 , '.');
                      print(resultSelisih);
                    }
                     else if (resultSelisih.length <= 8 && resultSelisih.length > 7) {
                       resultSelisih.insert(resultSelisih.length - 3 , '.');
                       resultSelisih.insert(resultSelisih.length - 7 , '.');
                      print(resultSelisih);
                    }
                     else if (resultSelisih.length <= 9 && resultSelisih.length > 8) {
                       resultSelisih.insert(resultSelisih.length - 3 , '.');
                       resultSelisih.insert(resultSelisih.length - 7 , '.');
                      print(resultSelisih);
                    }
                     else if (resultSelisih.length <= 10 && resultSelisih.length > 9) 
                     {
                       resultSelisih.insert(resultSelisih.length - 3 , '.');
                       resultSelisih.insert(resultSelisih.length - 7 , '.');
                       resultSelisih.insert(resultSelisih.length - 11 , '.');
                      print(resultSelisih);
                    }
                     else if (resultSelisih.length <= 11 && resultSelisih.length > 10) {
                       resultSelisih.insert(resultSelisih.length - 3 , '.');
                       resultSelisih.insert(resultSelisih.length - 7 , '.');
                       resultSelisih.insert(resultSelisih.length - 11 , '.');
                      print(resultSelisih);
                    }
                     else if (resultSelisih.length <= 12 && resultSelisih.length > 11) {
                       resultSelisih.insert(resultSelisih.length - 3 , '.');
                       resultSelisih.insert(resultSelisih.length - 7 , '.');
                       resultSelisih.insert(resultSelisih.length - 11 , '.');
                      print(resultSelisih);
                    } else {
                      return e.nilai;
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
                  print(kondisiSelisih());

                kondisiBulan() {
                  var bulan = e.month;
                  if(e.month == '1') {
                    return 'Januari';
                  } else if (e.month == '2'){
                    return 'Februari';
                  } else if (e.month == '3') {
                    return 'Maret';
                  } else if (e.month == '4') {
                    return 'April';
                  }  else if (e.month == '5') {
                    return 'Mei';
                  } else if (e.month == '6') {
                    return 'Juni';
                  } else if (e.month == '7') {
                    return 'Juli';
                  } else if (e.month == '8') {
                    return 'Agustus';
                  } else if (e.month == '9') {
                    return 'September';
                  } else if (e.month == '10') {
                    return 'Oktober';
                  } else if (e.month == '11') {
                    return 'November';
                  } else if (e.month == '12') {
                    return 'Desember';
                  } else {
                   return e.month;
                  }
                }
                  
               return
                 
                     Container(
                        padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
                        height: 90,
                       child: MaterialButton(
                        onPressed: () {
                         ApprovalIdcash.approvalidcash.add(e.month);
                         print(ApprovalIdcash.approvalidcash);
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return RamayanaRiwayatIDCashBulan();
                          }));
                        },
                                       color: Color.fromARGB(255, 234, 234, 234),
                                       shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                                         ),
                                        child: ListTile(
                                         leading: CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 255, 17, 17),
                        child: Icon(Icons.attach_money_outlined, color: Colors.white, size: 25,),
                                        ),
                                        title: Text('${kondisiBulan()}', style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),),
                                        trailing: Text('Rp.${kondisiSelisih()}',  style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
                                        ),
                                      ),
                     );
              
                  },).toList(),
                
              ), 
            )
             
          ]
          ),

    );
  }
 
}