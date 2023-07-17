import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:myactivity_project/models/model_cekpromo.dart';
import 'package:myactivity_project/models/model_searchtoko.dart';
import 'package:myactivity_project/models/models_approval_return_list.dart';
import 'package:myactivity_project/ramayana_caritoko.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/settingsralstools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RamayanaCekHarga extends StatefulWidget {
  const RamayanaCekHarga({super.key});

  @override
  State<RamayanaCekHarga> createState() => _RamayanaCekHargaState();
}

class _RamayanaCekHargaState extends State<RamayanaCekHarga> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _dateControllerr = TextEditingController();
  TextEditingController dateController = TextEditingController();
  // TextEditingController dateControllerxxx = TextEditingController();
  TextEditingController barcodeScan = TextEditingController();
  String? _toko;
  String? _barcode;
  String _udid = 'Unknown';
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _dateControllerr.text = _formattedDate;
    dateController.text = formattedDate;
    _loadToko();
    print(_barcode);
    initPlatformState();
    // fetchHarga(para1: '2', apara2: 'cekprice~08161389~R71');
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

  _loadToko() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('tokoooo ${prefs.getString('toko')}');
    setState(() {
      _toko = (prefs.getString('toko') ?? '');
      _barcode = (prefs.getString('barcode') ?? '');
    });
    return _toko;
  }

  DateTime selectedDate = DateTime.now();
  DateTime _selectedDate = DateTime.now();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  String? _setDate;
  String? setDate;
  bool _saving = false;
  bool isLoading = false;
  bool _visible = false;
  String _formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
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
            child: child ??
                Text(
                  "",
                  style: TextStyle(fontSize: 15, color: Colors.amber),
                ),
          );
        },
        initialDate: _selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));

    if (picked != null)
      setState(() {
        _selectedDate = picked;
        _dateControllerr.text = DateFormat('yyyy-MM-dd').format(_selectedDate);
      });
  }

  selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        builder: (BuildContext context, Widget? child) {
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
            child: child ?? Text(""),
          );
        },
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));

    if (picked != null)
      setState(() {
        selectedDate = picked;
        dateController.text = DateFormat('yyyy-MM-dd').format(selectedDate);
      });
  }

  Future<String> namaToko() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var getToko = prefs.getString('toko') ?? '';
    print('TOKO : ${getToko}');
    return getToko;
  }

  var _scanBarcode = '';

  UserData userData = UserData();
  fetchHarga({required String para1, required String apara2}) async {
    print('oke');
    try {
      CekHarga.cekharga.clear();
      final responseku = await http.post(
          Uri.parse('${tipeurl}v1/scansku/tbl_store'),
          body: {'para1': para1, 'apara2': apara2});

      var data = jsonDecode(responseku.body);

      if (data['status'] == 200) {
        print("API Success");
        print(data);
        AndroidDeviceInfo info = await deviceInfo.androidInfo;
        var formData = FormData.fromMap({
          'progname': 'RALS_TOOLS ',
          'versi': '${versi}',
          'date_run': '${DateTime.now()}',
          'info1': 'Cek Harga',
          ' info2': '${_udid} ',
          'userid': '${userData.getUsernameID()}',
          ' toko': '${userData.getUserToko()}',
          ' devicename': '${info.device}',
          'TOKEN': 'R4M4Y4N4'
        });

        var response =
            await dio.post('${tipeurl}v1/activity/createmylog', data: formData);
        print('berhasil $_udid');
        int count = data['data'].length;
        final Map<String, CekHarga> profileMap = new Map();
        for (int i = 0; i < count; i++) {
          CekHarga.cekharga.add(CekHarga.fromjson(data['data'][i]));
        }
        CekHarga.cekharga.forEach((element) {
          profileMap[element.site] = element;
          CekHarga.cekharga = profileMap.values.toList();
        });
        print('check length ${CekHarga.cekharga.length}');
        print(data['data'].toString());
        if (CekHarga.cekharga.length == 0) {
          print('NO DATA');
        } else {
          print('NO DATA');
        }
      }
    } on Exception {
      return _displaypopup();
    }

    setState(() {});
  }

  Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  void _displaypopup() async {
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
        child: Center(
          child: Text(
            'SKU TIDAK DITEMUKAN',
            style: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      actionsAlignment: MainAxisAlignment.start,
      actionsPadding: EdgeInsets.only(bottom: 20),
    );
    showCupertinoModalPopup(context: context, builder: (context) => popup1);
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      barcodeScan..text = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      barcodeScan..text = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () async {
            SharedPreferences pref = await SharedPreferences.getInstance();
            pref.remove('toko');
            pref.remove('barcode');
            Navigator.pushAndRemoveUntil(context,
                MaterialPageRoute(builder: (context) {
              return RamayanaCariToko();
            }), (route) => false);
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text('Cek Harga', style: TextStyle(fontSize: 23)),
        backgroundColor: Color.fromARGB(255, 255, 17, 17),
        elevation: 6,
        toolbarHeight: 90,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 17, 17),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color.fromARGB(255, 109, 109, 109).withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 5,
                  offset: Offset(4, 4), // changes position of shadow
                ),
              ],
            ),
            height: 150,
            child: Container(
              // margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              // color: Colors.yellow,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        width: 100,
                        height: 50,
                        // color: Colors.yellow,
                        child: IconButton(
                          icon: Icon(
                            Icons.qr_code_scanner_outlined,
                            size: 50,
                            color: Colors.black,
                          ),
                          onPressed: () {
                            scanBarcodeNormal();
                          },
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Container(
                          // color: Colors.green,
                          margin: EdgeInsets.only(top: 20, right: 20),
                          width: 300,
                          height: 50,
                          child: TextFormField(
                            validator:
                                RequiredValidator(errorText: 'Please Enter'),
                            controller: barcodeScan,
                            cursorColor: Color.fromARGB(255, 255, 17, 17),
                            keyboardType: TextInputType.number,
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly
                            ],
                            style: TextStyle(fontSize: 20, color: Colors.black),
                            decoration: InputDecoration(
                                labelStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 17, 17)),
                                hintText: 'No. SKU',
                                hintStyle: TextStyle(
                                    color: Colors.black, fontSize: 20),
                                border: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.black, width: 5.0),
                                    borderRadius: BorderRadius.circular(60)),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 17, 17)),
                                    borderRadius: BorderRadius.circular(10)),
                                errorBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 17, 17)),
                                    borderRadius: BorderRadius.circular(10)),
                                errorStyle: TextStyle(
                                    color: Color.fromARGB(255, 255, 17, 17),
                                    fontSize: 10,
                                    fontWeight: FontWeight.w400),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: new BorderSide(
                                        color:
                                            Color.fromARGB(255, 255, 17, 17)),
                                    borderRadius: BorderRadius.circular(10))),
                          ),
                        ),
                      )
                    ],
                  ),
                  MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    height: 35,
                    color: Color.fromARGB(255, 255, 17, 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        print('cekprice~${barcodeScan.text}~${_toko}');
                        print('cekprice~${_barcode}~${_toko}');
                        print('toko : ${_toko}');
                        print('barcode : ${_barcode}');
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('barcode', '${barcodeScan.text}');
                        setState(() {
                          isLoading = true;
                          _visible = true;
                        });
                        await Future.delayed(const Duration(seconds: 3));
                        await fetchHarga(
                            para1: '${_toko}', apara2: '${barcodeScan.text}');

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    child: Text(
                      'PROCESS',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 200),
            decoration: BoxDecoration(
              color: Colors.white,

              // color: Colors.green,
              boxShadow: [
                (BoxShadow(
                    // spreadRadius: 5,
                    blurRadius: 7,
                    color: Color.fromARGB(255, 120, 120, 120)))
              ],

              //  borderRadius: BorderRadius.only(
              //   topLeft: Radius.circular(50),
              //   // topRight: Radius.circular(50)
              //  )
            ),
            child: Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: EdgeInsets.only(top: 20),
                        child: Text(
                          'Cek Harga',
                          style: TextStyle(
                              fontSize: 15, fontWeight: FontWeight.w600),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 5),
                        child: Text(
                          'Store  : ${_toko}',
                          style: TextStyle(
                              fontSize: 15, fontStyle: FontStyle.italic),
                        ))
                  ]),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 250),
            // decoration: BoxDecoration(
            //   // color: Colors.green,
            //    boxShadow: [(BoxShadow(
            //     // spreadRadius: 5,
            //     blurRadius: 10,
            //     // color: Color.fromARGB(255, 120, 120, 120)
            //   ))],
            // ),
            child: isLoading
                ? SpinKitThreeBounce(
                    color: Color.fromARGB(255, 255, 17, 17),
                    size: 50.0,
                  )
                : AnimatedOpacity(
                    opacity: _visible ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      margin: EdgeInsets.only(top: 30),
                      color: Colors.white,
                      child: ListView(
                          children: CekHarga.cekharga.map((e) {
                        // var deskripsi = "${e.jawab1}";
                        // print(deskripsi);
                        // List split = deskripsi.split(';');
                        // print(split);
                        return Column(
                          children: [
                            Container(
                              height: 80,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(left: 20, top: 0),
                                      child: Text(
                                        'Bazar',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, bottom: 10),
                                      child: Text(
                                        'Bazar',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              height: 70,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text(
                                        'MD',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, bottom: 10),
                                      child: Text(
                                        '${e.md}',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              height: 70,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text(
                                        'No. SKU',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, bottom: 10),
                                      child: Text(
                                        '${e.sku_code}',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              height: 70,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text(
                                        'Nama Barang',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, bottom: 10),
                                      child: Text(
                                        '${e.sku_desc_l}',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      )),
                                ],
                              ),
                            ),
                            Container(
                              height: 70,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, top: 10),
                                      child: Text(
                                        'Harga',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      )),
                                  Container(
                                      margin:
                                          EdgeInsets.only(left: 20, bottom: 10),
                                      child: Text(
                                        '${e.hargajual}',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.black),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        );
                      }).toList()),
                    ),
                  ),
          )
        ],
      ),
    );
  }
}
