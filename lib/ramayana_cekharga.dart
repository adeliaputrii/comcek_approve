import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class RamayanaCekHarga extends StatefulWidget {
  const RamayanaCekHarga({super.key});

  @override
  State<RamayanaCekHarga> createState() => _RamayanaCekHargaState();
}

class _RamayanaCekHargaState extends State<RamayanaCekHarga> {
   TextEditingController _dateController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController barcodeScan = TextEditingController();
  String _scanBarcode = 'Scan SKU';

  @override
  void initState() {
    super.initState();
    _dateController.text = formattedDate;
  }

  DateTime selectedDate = DateTime.now();
  String? _setDate;
  bool _visible = false;
  String formattedDate =  DateFormat('yyyy-MM-dd').format(DateTime.now());

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

   Future<void> startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
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
      _scanBarcode = barcodeScanRes;
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
      _scanBarcode = barcodeScanRes;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      
        title: Text('Cek Promo', style: TextStyle(fontSize: 23)),
        backgroundColor: Color.fromARGB(255, 255, 17, 17),
        elevation: 6  ,
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
            height: 240,
            child: 
            Container(
              // margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              // color: Colors.yellow,
              child: 
              Column(
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
                          icon: Icon(Icons.qr_code_scanner_outlined,
                        size: 50,
                        color: Color.fromARGB(255, 179, 42, 33),
                          ),
                          onPressed: () {
                            scanBarcodeNormal();
                          },
                        ),
                      ),
                      Container(
                        // color: Colors.green,
                        margin: EdgeInsets.only(top: 20, right: 20),
                        width: 300,
                        height: 50,
                        child: TextFormField(
                          controller: barcodeScan..text = '${_scanBarcode}',
                                cursorColor: Color.fromARGB(255, 255, 17, 17),
                                keyboardType: TextInputType.number,
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                style: TextStyle(fontSize: 20, color: Colors.black),
                                decoration: InputDecoration(
                                    labelStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17)),
                                    
                                    hintText: 'No. SKU',
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 20),
                                    enabledBorder: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Color.fromARGB(255, 255, 17, 17)),
                                        borderRadius: BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide:
                                            new BorderSide(color: Color.fromARGB(255, 255, 17, 17)),
                                        borderRadius: BorderRadius.circular(10))),
                              ),
                      )
                    ],
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Container(
                           margin: EdgeInsets.only(left: 20),
                        width: 100,
                        height: 50,
                        // color: Colors.yellow,
                          child: Center(child: Text('Periode  :   ', style: TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.w500))),
                        ),
                     
                         Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Container(
                              margin: EdgeInsets.only(right: 5),
                              // color: Colors.red,
                              height: 40,
                              width: 132,
                              child:  TextFormField(
                                onTap: () async  {
                                  _selectDate(context);
                         
                                },
                                  controller: _dateController,
                                  onSaved: (String? val) {
                                              _setDate = val;
                                            },
                                        cursorColor: Color.fromARGB(255, 255, 17, 17),
                                        keyboardType: TextInputType.number,
                                        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                        style: TextStyle(fontSize: 20, color: Colors.black),
                                        decoration: InputDecoration(
                                          
                                            labelStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17)),
                                            hintText: '${DateTime.now()}',
                                            hintStyle: TextStyle(
                                                color: Colors.black, fontSize: 15),
                                            enabledBorder: OutlineInputBorder(
                                                borderSide:
                                                    new BorderSide(color: Color.fromARGB(255, 255, 17, 17)),
                                                borderRadius: BorderRadius.circular(5)),
                                            focusedBorder: OutlineInputBorder(
                                                borderSide:
                                                    new BorderSide(color: Color.fromARGB(255, 255, 17, 17)),
                                                borderRadius: BorderRadius.circular(5))),
                                      ),),
                           ],
                         ),
                      
                        Container(
                           margin: EdgeInsets.only(right: 5),
                          // color: Colors.amber,
                          child: Text('s/d', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.w500)),
                        ),
                         Container(
                           margin: EdgeInsets.only(right: 20),
                          // color: Colors.blue,
                        height: 40,
                        width: 132,
                        child:  TextFormField(
                           onTap: () async  {
                              _selectDate(context);

                            },
                            controller: dateController,
                                  cursorColor: Color.fromARGB(255, 255, 17, 17),
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                  decoration: InputDecoration(
                                    hintText: '${DateTime.now()}',
                                      labelStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17)),
                                      hintStyle: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: Color.fromARGB(255, 255, 17, 17)),
                                          borderRadius: BorderRadius.circular(5)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide:
                                              new BorderSide(color: Color.fromARGB(255, 255, 17, 17)),
                                          borderRadius: BorderRadius.circular(5))),
                                ),),
                    ],),
                  
                  MaterialButton(
                    color: Color.fromARGB(255, 255, 17, 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {
                      setState(() {   
                               _visible = true;
                                });
                     

                    },
                    child: Text('Process', style: TextStyle(
                           color: Colors.white, fontSize: 18),),
                    )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 300),
            decoration: BoxDecoration(
              color: Colors.white,
               boxShadow: [(BoxShadow(
                // spreadRadius: 5,
                blurRadius: 10,
                color: Color.fromARGB(255, 120, 120, 120)
              ))],
            ),
          child:
          
          AnimatedOpacity(
            opacity: _visible ? 1.0 : 0.0,
                   duration: const Duration(milliseconds: 500),
            child: Container(
              margin: EdgeInsets.only(top: 30),
              child: ListView(
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
                            offset: Offset(2, 4)
                    )
                  ],
                                    ),
                             child: 
                            
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 10),
                                        child: Text('Description', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                    
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      style:
                                              TextStyle(fontSize: 18, color: Colors.black),
                                     decoration: InputDecoration(
                                        
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(255, 228, 228, 228)),),
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)), ),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)),)),
                                      // controller: nama..text = kondisiNama(),
                                      readOnly: true,
                                    ),
                                  )
                                  ],
                                  ),
                                
                             
                            ),
            
                             Container(
                              height: 80,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                               decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 228, 228, 228),
                                    borderRadius: BorderRadius.circular(10),
                                     boxShadow: <BoxShadow>[
                    BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4)
                    )
                  ],
                                    ),
                             child: 
                            
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 10),
                                        child: Text('Harga', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                    
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      style:
                                              TextStyle(fontSize: 18, color: Colors.black),
                                     decoration: InputDecoration(
                                        
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(255, 228, 228, 228)),),
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)), ),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)),)),
                                      // controller: nama..text = kondisiNama(),
                                      readOnly: true,
                                    ),
                                  )
                                  ],
                                  ),
                                
                             
                            ),
                             Container(
                              height: 80,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                               decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 228, 228, 228),
                                    borderRadius: BorderRadius.circular(10),
                                     boxShadow: <BoxShadow>[
                    BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4)
                    )
                  ],
                                    ),
                             child: 
                            
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 10),
                                        child: Text('Last Receive', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                    
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      style:
                                              TextStyle(fontSize: 18, color: Colors.black),
                                     decoration: InputDecoration(
                                        
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(255, 228, 228, 228)),),
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)), ),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)),)),
                                      // controller: nama..text = kondisiNama(),
                                      readOnly: true,
                                    ),
                                  )
                                  ],
                                  ),
                                
                             
                            ),
                             Container(
                              height: 80,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                               decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 228, 228, 228),
                                    borderRadius: BorderRadius.circular(10),
                                     boxShadow: <BoxShadow>[
                    BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4)
                    )
                  ],
                                    ),
                             child: 
                            
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 10),
                                        child: Text('Promotion 1', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                    
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      style:
                                              TextStyle(fontSize: 18, color: Colors.black),
                                     decoration: InputDecoration(
                                        
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(255, 228, 228, 228)),),
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)), ),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)),)),
                                      // controller: nama..text = kondisiNama(),
                                      readOnly: true,
                                    ),
                                  )
                                  ],
                                  ),
                                
                             
                            ),
                             Container(
                              height: 80,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                               decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 228, 228, 228),
                                    borderRadius: BorderRadius.circular(10),
                                     boxShadow: <BoxShadow>[
                    BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4)
                    )
                  ],
                                    ),
                             child: 
                            
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 10),
                                        child: Text('Promotion 2', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                    
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      style:
                                              TextStyle(fontSize: 18, color: Colors.black),
                                     decoration: InputDecoration(
                                        
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(255, 228, 228, 228)),),
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)), ),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)),)),
                                      // controller: nama..text = kondisiNama(),
                                      readOnly: true,
                                    ),
                                  )
                                  ],
                                  ),
                                
                             
                            ),
                             Container(
                              height: 80,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                               decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 228, 228, 228),
                                    borderRadius: BorderRadius.circular(10),
                                     boxShadow: <BoxShadow>[
                    BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4)
                    )
                  ],
                                    ),
                             child: 
                            
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 10),
                                        child: Text('Promotion 3', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                    
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      style:
                                              TextStyle(fontSize: 18, color: Colors.black),
                                     decoration: InputDecoration(
                                        
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(255, 228, 228, 228)),),
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)), ),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)),)),
                                      // controller: nama..text = kondisiNama(),
                                      readOnly: true,
                                    ),
                                  )
                                  ],
                                  ),
                                
                             
                            ),
                             Container(
                              height: 80,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                               decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 228, 228, 228),
                                    borderRadius: BorderRadius.circular(10),
                                     boxShadow: <BoxShadow>[
                    BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4)
                    )
                  ],
                                    ),
                             child: 
                            
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 10),
                                        child: Text('Sales', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                    
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      style:
                                              TextStyle(fontSize: 18, color: Colors.black),
                                     decoration: InputDecoration(
                                        
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(255, 228, 228, 228)),),
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)), ),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)),)),
                                      // controller: nama..text = kondisiNama(),
                                      readOnly: true,
                                    ),
                                  )
                                  ],
                                  ),
                                
                             
                            ),
                             Container(
                              height: 80,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                               decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 228, 228, 228),
                                    borderRadius: BorderRadius.circular(10),
                                     boxShadow: <BoxShadow>[
                    BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4)
                    )
                  ],
                                    ),
                             child: 
                            
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 10),
                                        child: Text('Saldo Akhir', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                    
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      style:
                                              TextStyle(fontSize: 18, color: Colors.black),
                                     decoration: InputDecoration(
                                        
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(255, 228, 228, 228)),),
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)), ),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)),)),
                                      // controller: nama..text = kondisiNama(),
                                      readOnly: true,
                                    ),
                                  )
                                  ],
                                  ),
                                
                             
                            ),
                             Container(
                              height: 80,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 0),
                               decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 228, 228, 228),
                                    borderRadius: BorderRadius.circular(10),
                                     boxShadow: <BoxShadow>[
                    BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4)
                    )
                  ],
                                    ),
                             child: 
                            
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 10),
                                        child: Text('Tanggal Mulai', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                    
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      style:
                                              TextStyle(fontSize: 18, color: Colors.black),
                                     decoration: InputDecoration(
                                        
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(255, 228, 228, 228)),),
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)), ),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)),)),
                                      // controller: nama..text = kondisiNama(),
                                      readOnly: true,
                                    ),
                                  )
                                  ],
                                  ),
                                
                             
                            ),
                             Container(
                              height: 80,
                              width: 100000,
                              margin: EdgeInsets.fromLTRB(20, 15, 20, 20),
                               decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 228, 228, 228),
                                    borderRadius: BorderRadius.circular(10),
                                     boxShadow: <BoxShadow>[
                    BoxShadow(
                            color: Colors.black54,
                            blurRadius: 3,
                            offset: Offset(2, 4)
                    )
                  ],
                                    ),
                             child: 
                            
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Container(
                                        margin: EdgeInsets.only(left: 20, top: 10),
                                        child: Text('Tanggal Akhir', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                                    
                                  Container(
                                    margin: EdgeInsets.only(left: 20),
                                    child: TextFormField(
                                      style:
                                              TextStyle(fontSize: 18, color: Colors.black),
                                     decoration: InputDecoration(
                                        
                                                  border: UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Color.fromARGB(255, 228, 228, 228)),),
                                                  enabledBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)), ),
                                                  focusedBorder: UnderlineInputBorder(
                                                      borderSide:
                                                          new BorderSide(color: Color.fromARGB(255, 228, 228, 228)),)),
                                      // controller: nama..text = kondisiNama(),
                                      readOnly: true,
                                    ),
                                  )
                                  ],
                                  ),
                                
                             
                            ),
                ],
              ),
            ),
          ),
          )
        ],
      ),
    );
  }
}