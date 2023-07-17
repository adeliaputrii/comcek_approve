import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myactivity_project/models/model_approval_return.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:dio/dio.dart';
import 'package:myactivity_project/models/model_tabel_approve.dart';
import 'package:myactivity_project/ramayana_approval_submenu.dart';
import 'package:myactivity_project/ramayana_comcheck_cek.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/service/API_service/API_service.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/settingsralstools.dart';
class RamayanaApprovalReturn extends StatefulWidget {
  const RamayanaApprovalReturn({super.key});

  @override
  State<RamayanaApprovalReturn> createState() => _RamayanaApprovalReturnState();

}



class _RamayanaApprovalReturnState extends State<RamayanaApprovalReturn> {


  TextEditingController _dateController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool? tanda;

   var selected;
    final List<String> data = [
    'Fasihon',
    'Bazar',
  ];

   fetchDataApproval({
    required String tanggal,
    required String tipe,
    
    //disini
  }) async {
      print('tipe123xxx');
  print(tipe);
    print(tanggal);
  print('tipe123');
    
     
    ApprovalReturnModel.approvalreturn.clear();
    final responseku = await http.post(
      Uri.parse('${tipeurl}v1/returnvoid/tbl_my_transaksi_rtn'),
      body: {
        
          'tanggal' : tanggal,
          'tipe': tipe,
          'store_code': '${userData.getUserToko()}',
        }
      );
 

    
    var data = jsonDecode(responseku.body);
    
    if (data['status'] == 200 ) {
      print("API Success oooo");
      print(data);
      int count = data['data'].length;
      final Map<String, ApprovalReturnModel> profileMap = new Map();
      for (int i = 0; i < count; i++) {
        ApprovalReturnModel.approvalreturn.add(ApprovalReturnModel.fromjson(data['data'][i]));
       

      } 
        ApprovalReturnModel.approvalreturn.forEach((element) {
        profileMap[element.no_trx] = element;
        ApprovalReturnModel.approvalreturn = profileMap.values.toList();
        print(ApprovalReturnModel.approvalreturn);
       });
      print('check length ${ApprovalReturnModel.approvalreturn.length}');
     
      print(data['data'].toString());
      
      if(ApprovalReturnModel.approvalreturn.length == 0) {
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

  UserData userData = UserData();
  
  DateTime selectedDate = DateTime.now();
  String? _setDate;
  DateTime  currentTime = DateTime.now();
  String formattedDate =  DateFormat('yyyy-MM-dd').format(DateTime.now());
  bool check1 = false;
  
  String oke = '';
  bool _visible = false;

DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String _udid = 'Unknown';
    var dio = Dio();

List<Widget> bodyElements = [];
int num = 0;

 List selectedData = [];
  List selectedData2 = [];

  



// visible() {
//   if(dateController.text == null || selected == '') {
//     _visible = true;
//   } if (_dateController.text == )
//    else {
//     _visible = false;
//   }
//   return _visible;
// }
  
  // void table(){
  //   Container container = Container(
  //                   margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
  //                   width: 10000,
  //                  decoration: BoxDecoration(
  //                     color: Colors.white,
  //                     borderRadius: BorderRadius.circular(10),
  //                     boxShadow: [
  //                       (
  //                        BoxShadow(
  //                       color: Color.fromARGB(255, 182, 182, 182),
  //                       blurRadius: 6,
  //                       offset: Offset(2, 5), // Shadow position
  //                     ))
  //                     ]
  //                   ),
  //                   height: 600,
  //                   child:  SingleChildScrollView(
  //                     scrollDirection: Axis.horizontal,
  //                     child: SingleChildScrollView(
  //                       scrollDirection: Axis.vertical,
  //                     child:
  //                     DataTable(
  //                       columnSpacing: 50.0,
  //                       columns: [
  //                          DataColumn(label: Text('', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))),
  //                         DataColumn(label: Text('POS', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))),
  //                         DataColumn(label: Text('ID USER', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))),
  //                         DataColumn(label: Text('NAMA USER',style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))),
  //                         DataColumn(label: Text('NOMINAL RETURN',style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))),
  //                       ],
  //                       rows: List.generate(ApprovalReturnModel.approvalreturn.length, (index) {

  //                         pos() {
  //                           var y;
  //                           print(ApprovalReturnModel.approvalreturn[0].date_cr);
  //                           if(_dateController.text != null) {
  //                              y = ApprovalReturnModel.approvalreturn[index].status;
  //                              print(y);
  //                           } else {
  //                              y = '';
  //                              print(y);
  //                           }
  //                           return y;
  //                         }

  //                         id_user() {
  //                           var x;
  //                           if(_dateController.text != null) {
  //                              x = ApprovalReturnModel.approvalreturn[index].toko;
  //                           } else {
  //                              x = '';
  //                           }
  //                           return x;
  //                         }

  //                         nama_user() {
  //                           var z;
  //                           if(_dateController.text != null) {
  //                              z = ApprovalReturnModel.approvalreturn[index].no_trx;
  //                           } else {
  //                              z = '';
  //                           }
  //                           return z;
  //                         }

  //                         nominal_return() {
  //                           var w;
  //                           if(_dateController.text != null) {
  //                              w = ApprovalReturnModel.approvalreturn[index].tanggal;
  //                           } else {
  //                              w = '';
  //                           }
  //                           return w;
  //                         }


  //                         final y = ApprovalReturnModel.approvalreturn[index].status;

  //                         final x = userData.getUsernameID();

  //                         final z = userData.getFullname();

  //                         final w = ApprovalReturnModel.approvalreturn[index].tanggal;

  //                          bool tampungan = false;
  //                           // ApprovalReturnModel.approvalreturn.map((e) {
  //                           //   tampungan = e.isSelected;
  //                           // });
  //                         return DataRow(cells: [
  //                           DataCell(  Checkbox(
  //                              // tileColor: Colors.greenAccent,
  //                            activeColor: Colors.red,
                             
  //                              value: tampungan,
  //                                onChanged: (value) {
  //                               setState(() {
  //                                 ApprovalReturnModel.approvalreturn[index].isSelected = value!;
                                  
  //                               });
  //                               }
  //                              ),),
  //                          DataCell(Container(width: 80, child: Text(y!=null?y:'INI NULL'))),
  //                           DataCell(Container(child: Text(x!=null?x:'INI NULL'))),
  //                           DataCell(Container(child: Text(z!=null?z:'INI NULL'))),
  //                           DataCell(Container(child: Text(w!=null?w:'INI NULL')))
  //                         ]);
  //                       }),
  //                     ),
  //                   ),
  //                   )

  //                 );
  //                 //  showCupertinoModalPopup(context: context, builder: (context) => container);
  // }
var inputDate;

   _selectDate(BuildContext context) async {
  final DateTime? picked = await showDatePicker(
      context: context,
      builder: (BuildContext context, Widget ?child) {
      return Theme(
        data: ThemeData(
          primarySwatch: Colors.grey,
          splashColor: Colors.black,
          textTheme: TextTheme(
            subtitle1: TextStyle(color: Colors.black),
            button: TextStyle(color: Colors.black),
          ),
          accentColor: Colors.black,
          colorScheme: ColorScheme.light(
              primary: Color.fromARGB(255, 255, 17, 17),
              primaryVariant: Colors.black,
              secondaryVariant: Colors.black,
              onSecondary: Colors.black,
              onPrimary: Colors.white,
              surface: Colors.black,
              onSurface: Colors.black,
              secondary: Colors.black),
              dialogBackgroundColor: Colors.white,
        ),
        child: child ??Text(""),
      );
    },
      
      initialDate: selectedDate,
      initialDatePickerMode: DatePickerMode.day,
      firstDate: DateTime(2015),
      lastDate: DateTime(2101));
      
  if (picked != null)
    setState(() {
      
      selectedDate = picked;
      _dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
     
    });
}



  @override
   void initState() {
    super.initState();
    _dateController.text = formattedDate;
    // formattedDate = DateFormat.yMMMEd().format(currentTime);
    fetchDataApproval(tanggal: _dateController.text, tipe: '' );
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
    return Scaffold(
      appBar: AppBar(
       
        title: 
        Text('Approval Return', style: TextStyle(fontSize: 23, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),),
        backgroundColor: Color.fromARGB(255, 255, 14, 14),
        elevation: 0,
        toolbarHeight: 80,
        ),

        body: Stack(
          children: [
            
            Container(
              color:  Color.fromARGB(255, 255, 14, 14),
              height: 70,
            ),
            Container(
              margin: EdgeInsets.only(bottom: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        (
                         BoxShadow(
                        color: Color.fromARGB(255, 182, 182, 182),
                        blurRadius: 6,
                        offset: Offset(2, 5), // Shadow position
                      ))
                      ]
                    ),
                    height: 155,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(left: 30),
                                  width: 100,
                                  // color: Colors.green,
                                  child: Text(
                                    'Tanggal',
                                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
                                  ),
                                ),
                                Container(
                                  width: 20,
                                  // color: Colors.green,
                                  child: Text(
                                    ':',
                                    style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
                                  ),
                                ),
                                 Container(
                                  width: 150,
                                  // color: Colors.green,
                                  child: InkWell(
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                  child: Container(
                                    width: 8,
                                    height: 20,
                                    margin: EdgeInsets.only(top: 15),
                                    
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: '${DateTime.now()}'
                                      ),
                                      style: TextStyle(fontSize: 18),
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _dateController,
                                      onSaved: (String? val) {
                                        _setDate = val;
                                      },
                                      
                                    ),
                                  ),
                                ),
                                ),
                                
                              ],
                            ),
                         
                         Container(
                              margin: EdgeInsets.only(right: 10),
                              height: 35,
                              decoration: BoxDecoration(
                              color: Color.fromARGB(255, 255, 17, 17),
                              borderRadius: BorderRadius.circular(20)
                              ),
                              width: 100,
                              child: Center(child: Text('${userData.getUserToko()}', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),)
//                               Checkbox( //only check box
//   value: check1, //unchecked
//   onChanged: (bool? value){
//       //value returned when checkbox is clicked
//       setState(() {
//           check1 = value;
//       });
//   }
// ),
                            ),
                         )
                             ],
                        ),
                         Row(
                          children: [
                           Container(
                              margin: EdgeInsets.only(left: 30),
                              width: 100,
                              // color: Colors.green,
                              child: Text(
                                'Toko',
                                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                             Container(
                              width: 20,
                              // color: Colors.green,
                              child: Text(
                                ':',
                                style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700),
                              ),
                            ),
                            Container(
                              width: 150,
                              // color: Colors.green,
                              child:  DropdownButton(
                                            value: selected,
                                            hint: Text('Select Toko',
                                            style: TextStyle(
                                              color: Color.fromARGB(255, 175, 175, 175),
                                              fontSize: 18, 
                                            ),
                                            ),
                                            onChanged: (value) {
                                              print(value);
                                              setState(() {
                                                selected = value;
                                              });
                                            },
                                            items: data
                                            .map(
                                              (e) => DropdownMenuItem(
                                                value: e,
                                                child: 
                                                Text(e, style: TextStyle(fontSize: 17,color: Colors.black),),
                                              ),
                                              )
                                              .toList()
                                            ),
                            )
                          ],
                        ),
                        Container(
                margin: EdgeInsets.fromLTRB(150, 0, 150, 0),
                child: MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    height: 30,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: 
                    Text(
                      'Search',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color.fromARGB(255, 255, 17, 17),
                  onPressed: () async {
                    fetchDataApproval(tanggal: _dateController.text, tipe: selected);
                      setState(() {
                // visible();
                // _visible = true;
            selected == 'Fasihon' || selected == 'Bazar' ? _visible = true : _visible = false;
            print(_dateController.text);
            print(selected);
          });
                    }))    
                      ],
                    ),
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    width: 10000,
                   decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        (
                         BoxShadow(
                        color: Color.fromARGB(255, 182, 182, 182),
                        blurRadius: 6,
                        offset: Offset(2, 5), // Shadow position
                      ))
                      ]
                    ),
                    height: 600,
                    child:   AnimatedOpacity(
                      opacity: _visible ? 1.0 : 0.0,
                      duration: const Duration(milliseconds: 500),
                      child: Container(
                        height: 600,
                         child: 
                         
                         SingleChildScrollView(
                           scrollDirection: Axis.horizontal,
                           child: SingleChildScrollView(
                             scrollDirection: Axis.vertical,
                           child:
                           DataTable(
                            showCheckboxColumn: true,
                            sortAscending: true,
                             columnSpacing: 40.0,
                             columns: [
                                DataColumn(label: Text('', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))),
                               DataColumn(label: Text('POS', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))),
                               DataColumn(label: Text('ID USER', style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))),
                               DataColumn(label: Text('NAMA USER',style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))),
                               DataColumn(label: Text('NOMINAL RETURN',style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.w700))),
                             ],
                             rows:
                             
                             ApprovalReturnModel.approvalreturn.map((e) 
                             
                             => 
                             
                             DataRow(
                                  
                              cells: [
                                 DataCell(Container(width: 20, child: 
                                 Checkbox(
                                  value: e.isSelected,
                                  onChanged: (value) {
                                      setState(() {
                                      e.isSelected = value!;
                                      
                                      });
                                      if (e.isSelected == value) {
                                        tanda = true;
                                      }
                                   
                                 },)
                                
                                 )),
                                  DataCell(
                                    Container(
                                      width: 50, child: Text('${e.nocp}'))),
                                 DataCell(Container(child: Text(e.id_kasir))),
                                 DataCell(Container(child: Text(e.nama_kasir))),
                                 DataCell(Container(child: Text('${e.amaount}'))),
                                 
                             ],
                             
                             
                          )
                             ).toList()
                          
                           ),
                         ),
                         ),
                       ),
                    )
                  ),
                  
                   Container(
                // margin: EdgeInsets.fromLTRB(179, 770, 179, 0),
                child: MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 120),
                    height: 45,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      'Menyetujui',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    color: Color.fromARGB(255, 255, 17, 17),
                    onPressed: () async { 
                      
                      await popupSucces();
                           
                    }))    
                ],
              ),
            )
          ],
        ),
    );
  }
  popupSucces() async{
  
   if (tanda == true) {
    print('setuju');
     APIApprovalReturnService api = APIApprovalReturnService();
                    List<ApprovalReturnModel> modelyangsudahdiapproval = ApprovalReturnModel.approvalreturn.where((tiapitem) => tiapitem.isSelected).toList();
                    
                    await api.ApprovalReturn(
                                  // status: '1',
                                  approve_return: modelyangsudahdiapproval
                                );

   
 fetchDataApproval(tanggal: _dateController.text, tipe: selected);
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
                'Data Berhasil di Approve',
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
     AndroidDeviceInfo info = await deviceInfo.androidInfo;
                        var formData = FormData.fromMap({
                              'progname': 'RALS_TOOLS ',
                              'versi': '${versi}',
                              'date_run': '${DateTime.now()}',
                              'info1': 'Approve Data - Menu Approval Return',
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
   
 else  {


   print('tidak setuju');
 fetchDataApproval(tanggal: _dateController.text, tipe: selected);
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
                'Tidak ada data yang harus disetujui',
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
}