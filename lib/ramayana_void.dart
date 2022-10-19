import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:myactivity_project/ramayana_print.dart';
import 'package:myactivity_project/ramayana_print_%20harga.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';


class Void extends StatefulWidget {
  const Void({super.key});

  @override
  State<Void> createState() => _VoidState();
}

class _VoidState extends State<Void> {

  TextEditingController myController = TextEditingController();

  String _scanBarcode = '';

  @override
  void initState() {
    super.initState();
  }

  

  Future<void> startBarcodeScanStream2() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
        .listen((barcode) => print(barcode));
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcode() async {
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

  // TextEditingController _editingController =
  //     TextEditingController(text: '');
  // String data = ''; 
  
  @override
  Widget build(BuildContext context) {
    //  int _total = 0;

    // for (var i = 0; i < data.length; i++) {
    //   _total += dataPrint[i]['total_price'] as int;
    // }
    return Scaffold(
      appBar: AppBar(
        title: Text('Void', style: TextStyle(fontSize: 23)),
        backgroundColor: Color.fromARGB(255, 255, 17, 17),
        elevation: 7.20  ,
          toolbarHeight: 90,
          actions: <Widget>[
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Harga();
              }));
            }, 
            icon: Icon(Icons.print, size: 30,),
            )
          ],
        ),
      body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: Color.fromARGB(255, 253, 249, 249)
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              width: 500,
              height: 50,
              color: Color.fromARGB(255, 239, 237, 237),
             
            ),
             Container(
                    margin: EdgeInsets.fromLTRB(30, 30,30, 0),
              child:
              Text(
                    'Form Void', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23, color: Colors.black),
                    ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 90, 30, 0),
                child: ListView(
                  children: <Widget>[
                     Text('Code',
                  style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.w500, fontSize: 17),
                  ),
                  TextFormField(
                    cursorColor: Colors.black,
                    
                    decoration:
                      InputDecoration(contentPadding: EdgeInsets.all(10),
                       labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            )
                      ),
                //  controller: _editingController,
               
               controller: myController..text = '$_scanBarcode\n',
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    ),
                  ],
                ),
              ),
              Container(
                color: Color.fromARGB(255, 255, 17, 17),
                margin: EdgeInsets.only(top:180),
                height: 60,
                child: Container(
                 margin: EdgeInsets.only(right: 7),
                    width: 500,
                    child: 
                    TextButton(
                     
                      child: 
                       Text(
                      'GENERATE', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),
                       ),
                      onPressed: () {
                  setState(() {
                    _scanBarcode = myController.text;
                    // data = _editingController.text;
                  });
                },
                      ),
                  
                  
              )
              ),
              Container(
                color: Color.fromARGB(255, 239, 237, 237),
                width: 500,
                height: 50,
                    margin: EdgeInsets.fromLTRB(10, 260,10, 0),
              child:
              Container(
                child: 
                TextButton(
                     onPressed: () => scanBarcode(), 
                      child: 
                       Text(
                      'Scan Barcode', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24, color: Colors.black),
                       ),
                      ),
              ),
              ),
              Container(
                 margin: EdgeInsets.fromLTRB(30, 350,30, 0),
                child: ListView(
                  children: <Widget>[
                 Container(
            margin: EdgeInsets.fromLTRB(100,0, 100, 0),
            child: 
            PrettyQr(
          image: AssetImage('assets/ramayana.jpg'),
          size: 215,
          data: '$_scanBarcode',
          errorCorrectLevel: QrErrorCorrectLevel.M,
          typeNumber: 7,
          roundEdges: false,
        ),
           
      //            Column(
      //   children: <Widget>[
      //     Expanded(
      //       child: ListView.builder(
      //         itemCount: data.length,
      //         itemBuilder: (c, i) {
      //           return ListTile(
      //             title: Text(dataPrint[i]['title']),
      //             subtitle: Text('Rp ${dataPrint[i]['price']} x ${dataPrint[i]['qty']}'),
      //             trailing: Text('Rp ${dataPrint[i]['total_price']}'),
      //           );
      //         },
      //       ),
      //     ),
      //     Container(
      //       color: Colors.grey[200],
      //       padding: EdgeInsets.all(20),
      //       child: Row(
      //         children: <Widget>[
      //           Column(
      //             children: <Widget>[
      //               Text(
      //                 'Total :',
      //                 style: TextStyle(fontWeight: FontWeight.bold),
      //               ),
      //               Text(
      //                 'Rp $_total :',
      //                 style: TextStyle(fontWeight: FontWeight.bold),
      //               )
      //             ],
      //           ),
      //           SizedBox(width: 20),
      //           Expanded(
      //             child: FlatButton(
      //               color: Theme.of(context).primaryColor,
      //               textColor: Colors.white,
      //               child: Text('Print'),
      //               onPressed: () {
      //                 Navigator.push(context,
      //                     MaterialPageRoute(builder: (_) => Print(dataPrint)));
      //               },
      //             ),
      //           )
      //         ],
      //       ),
      //     )
      //   ],
      // ),
                 )
                  ],
                ),
              )
        ]
        ),
    );
  }
}