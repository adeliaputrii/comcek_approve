import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:form_field_validator/form_field_validator.dart';  


class Blank extends StatefulWidget {
    static const routeName = '/blank';
  const Blank({super.key});

  @override
  State<Blank> createState() => _BlankState();
}

class _BlankState extends State<Blank> with RouteAware {

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  TextEditingController myController = TextEditingController();

  String _scanBarcode = '';
  bool _visible = false;

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

  Future<String> _getLogikaVoid() async {
    // user id
    UserData userData = UserData();
    await userData.getPref();
    String userId = userData.getUsernameID();
    String? randomAngka = myController.text;
    print('grgr 123');
    print(userId);
    
    late int numberStepOne;
    late int numberStepTwo;

    late String result;

    if (randomAngka != null && userId != null) {
    numberStepOne = stepOne(input: randomAngka);
    numberStepTwo = stepTwo(input: numberStepOne);
    result = stepThree(
      angkaKedua: numberStepTwo.toString(), angkaPertama: userId);
    print('Hasil : ${result}');
  }
  return result;
}

  int stepOne({required String input}) {
  int current = 1;
  for (int i = 0; i < input.length; i++) {
    print('Check number :${input[i]} at index $i');
    if (input[i] == '0') {
      print('catch 1');
      print('current = $current * ${i + 1}');
      current = current * (i + 1);
      print('coba current if');
      print(current);
    } else {
      print('catch 2');
      print('current = $current * ${int.parse(input[i])}');
      current = current * int.parse(input[i]);
      print('coba current else');
      print(current);
    }
    print('current val is $current');
  }
  return current;
}

int stepTwo({required int input}) {
  print('coba hasil input');
  print(input);
  return (input * 121) - 100;
}

String stepThree({required String angkaPertama, required String angkaKedua}) {
  int prefixNumber = 0;
  int postNumber = 0;
  if (angkaPertama.length >= 3) {
    prefixNumber = int.parse(angkaPertama.substring(0, 3)) + 13;
    postNumber = int.parse(angkaPertama.substring(3, angkaPertama.length)) + 18;
  }
   else if (angkaPertama.length > 0) {
    prefixNumber = 
      int.parse(angkaPertama.substring(0, angkaPertama.length)) + 13;
  } 
  else {}
  return '${prefixNumber}X${angkaKedua}B${postNumber}';
}
  
  String data = '';

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
    return Scaffold(
      appBar: AppBar(
         leading: 
         IconButton(onPressed: () {
           Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DefaultBottomBarController(child: Ramayana()),), (Route<dynamic> route) => false);
         },
        icon: Icon(Icons.arrow_back, size: 30,),),
        title: Text('Void', style: TextStyle(fontSize: 23)),
        backgroundColor: Color.fromARGB(255, 255, 17, 17),
        elevation: 7.20  ,
        toolbarHeight: 90,
        ),

      body: 
      
      ListView(
        children: [
          Stack(
              children: <Widget>[

                Container(
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  color: Color.fromARGB(255, 253, 249, 249)
                ),

                Container(
                  width: 500,
                  height: 170,
                  color: Color.fromARGB(255, 255, 17, 17),
                ),
                
                Container(
                margin: EdgeInsets.fromLTRB(30, 30,30, 0),
                child:
                  Text(
                  'Form Void', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23, color: Colors.white),
                   ),
                  ),

                Container(
                  margin: EdgeInsets.fromLTRB(10, 100, 10, 0),  
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 255, 255, 255),
                    boxShadow: [BoxShadow( 
                    blurRadius: 5
                    )]
                    ),
              ),
                  
                SizedBox(
                height: 30,
                width: 30,
                ),
                        
                Container(
                  margin: EdgeInsets.fromLTRB(30, 130, 30, 0),
                  child:

                    Form(
                      key: _formKey,
                        child: 

                        TextFormField(
                          controller: myController,
                          style: TextStyle(fontSize: 20, color: Colors.black),
                          validator: (value) {
                          if(value!.isEmpty){
                          return "Required";
                         }
                        },
                          keyboardType: TextInputType.number,
                          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                          decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                            color: Colors.black, 
                            width: 5.0),
                            borderRadius: BorderRadius.circular(25)
                           ),
                          errorBorder: OutlineInputBorder( 
                            borderSide: BorderSide(color: Color.fromARGB(255, 255, 17, 17),), borderRadius: BorderRadius.circular(25)),
                          errorStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 14, fontWeight: FontWeight.w400),
                          labelStyle: TextStyle(
                           color: Colors.black87
                            ),
                          prefixIcon: Icon(
                           Icons.keyboard,
                           color: Color.fromARGB(255, 255, 17, 17),
                           size: 30,
                          ),
                          hintStyle: TextStyle(
                           color:  Colors.black,
                           fontSize: 20
                           ),
                          enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25),
                          borderSide: new BorderSide(color: Colors.black),
                          )
                          )      
                        )
                    )
                  ),

                  Container(
                    margin: EdgeInsets.fromLTRB(160, 230, 160, 0),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(255, 255, 17, 17),
                      borderRadius: BorderRadius.circular(30)
                      ),
                      height: 40,
                      child: 
                        Container(
                          margin: EdgeInsets.only(right: 7),
                          width: 150,
                          child: 
                          TextButton(
                            child: 
                             Text(
                            'GENERATE', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),
                             ),
                            onPressed: () async {
                               if (_formKey.currentState!.validate()) {
                                data = await _getLogikaVoid(); 
                                setState(() {   
                               _visible = true;
                                });
                               }
                              },
                            ),
                          )
                          ),
                   
                  Container(
                   margin: EdgeInsets.fromLTRB(10, 350, 10, 0),
                   child: AnimatedOpacity(
                   opacity: _visible ? 1.0 : 0.0,
                   duration: const Duration(milliseconds: 500),
                   child: Container(
                       margin: EdgeInsets.fromLTRB(10, 0,10, 0),
                        child: 
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Container(
                                margin: EdgeInsets.fromLTRB(10, 0,10, 0),
                                   child: 
                                    Center(
                                      child: 
                                      BarCodeImage(
                                        backgroundColor: Colors.white,
                                        params: Code128BarCodeParams(
                                        "${data}",
                                        lineWidth: 1.5,                // width for a single black/white bar (default: 2.0)
                                        barHeight: 100,               // height for the entire widget (default: 100.0)
                                        withText: false,                // Render with text label or not (default: false)
                                       ),
                                      padding: EdgeInsets.only(bottom: 7),
                                      onError: (error) {               // Error handler
                                        print('error = $error');
                                      },
                                  ),
                                 )
                              ),
                           
                  Container(
                    margin: EdgeInsets.fromLTRB(100,30, 100, 0),
                    child: 
                    PrettyQr(
                      image: AssetImage('assets/ramayana(C).png'),
                      size: 200,
                      data: '$data',
                      errorCorrectLevel: QrErrorCorrectLevel.M,
                      typeNumber: 7,
                      roundEdges: false,
                    ),
                    )
                 ],
                ),
                )
                ),
              )
            ]
            ),
        ],
      ),
    );
  }
    );
  }
}





