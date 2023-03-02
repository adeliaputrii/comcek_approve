import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter/material.dart';
import 'package:myactivity_project/ramayana_idcash.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class RamayanaBarcode extends StatefulWidget {
  const RamayanaBarcode({super.key});

  @override
  State<RamayanaBarcode> createState() => _RamayanaBarcodeState();
}

class _RamayanaBarcodeState extends State<RamayanaBarcode> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
              return RamayanaIDCash();
            }), (route) => false);
          },
          icon: Icon(Icons.arrow_back),
          ),
        title: 
        Container(
          margin: EdgeInsets.only(left: 100, right: 115),
          child: Text('Kode ID Cash', style: TextStyle(fontSize: 25, color: Color.fromARGB(255, 255, 255, 255), fontWeight: FontWeight.bold),)),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        elevation: 0,
        toolbarHeight: 80,
        ),

        body: 
        Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Container(
              // height: MediaQuery.of(context).size.height/1.129,
              color: Color.fromARGB(255, 227, 222, 222),
            ),
             Container(
              color: Color.fromARGB(255, 255, 0, 0),
              height: 200,
            ),
            Container(
              //  height: MediaQuery.of(context).size.height/1.129,
              //  color: Colors.green,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ClipPath(
                  clipper: CustomTicket(), 
                  child: Container(
                        margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                        height: MediaQuery.of(context).size.height / 1.555,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                         child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                  Container(
                    margin: EdgeInsets.only(left: 100, right: 100, top: 10),
                    width: 10000,
                    height: MediaQuery.of(context).size.height / 12,
                    decoration: BoxDecoration(
                        
                    // color: Colors.green,
                         
                        ),
                        child:
                        Image.asset('assets/Logo-Ramayana.png')
                  
                  ),
                   Container(
                    height: 2.5,
                    color: Color.fromARGB(255, 223, 223, 223),
                   ),
                       Container(
                        height: MediaQuery.of(context).size.height / 2.8,
                      //  color: Colors.amber,
                         child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                           children: [
                             Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                      margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                      child: Text('Max Pembayaran',  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize:20))),
                              
                                       Container (
                                      margin: EdgeInsets.fromLTRB(0, 20, 20, 0),
                                      child: Text('Rp. 1.000.000,00',  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 20, fontStyle: FontStyle.italic))),
                                      ],
                                       ),
                           
                                     
                                   Container(
                            margin: EdgeInsets.fromLTRB(10,30, 10, 0),
                            child: 
                            PrettyQr(
                              image: AssetImage('assets/ramayana(C).png'),
                              size: 230,
                              data: 'ID CASH TESTING',
                              errorCorrectLevel: QrErrorCorrectLevel.M,
                              typeNumber: 7,
                              roundEdges: false,
                            ),
                            ),
                          ],
                         ),
                       ),
                          Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height / 10,
                                color: Colors.deepOrange,
                                          margin: EdgeInsets.fromLTRB(10, 0,10, 0),
                                             child: 
                                             
                                                BarCodeImage(
                                                  backgroundColor: Colors.white,
                                                  params: Code128BarCodeParams(
                                                  "ID CASH TESTING",
                                                  lineWidth: 1.5,                // width for a single black/white bar (default: 2.0)
                                                  barHeight: 10,
                                                  // barHeight: 30.0,               // height for the entire widget (default: 100.0)
                                                  withText: false,                // Render with text label or not (default: false)
                                                 ),
                                                padding: EdgeInsets.only(bottom: 7),
                                                onError: (error) {               // Error handler
                                                  print('error = $error');
                                                },
                                            )
                                           
                                        ),
                                        Container(
                                          height: MediaQuery.of(context).size.height / 15,
                                          // color: Colors.blue,
                                          child: 
                                          Row(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                'Copyright EDP',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 17,
                                    fontWeight: FontWeight.w400),
                              ),
                                           
                                         Icon(
                                Icons.copyright,
                                color: Colors.black,
                                size: 18,
                              ),
                              Text(
                                '2022',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              )
                               ],
                                          ),
                                        ),
                            ],
                          ),
                         
                          ],
                         ),
                   
                  )
                ),
                 Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 20),
                child: MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 200),
                    height: MediaQuery.of(context).size.height/20,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'OK',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                    color: Color.fromARGB(255, 255, 17, 17),
                    onPressed: () async {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                return RamayanaIDCash();
              }), (route) => false);
                          
                    }))    ,
                   
                ],
              ),
            )
          ]),
    );
  }
}

class CustomTicket extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    //Radius
    path.addRRect(
      RRect.fromRectAndRadius(
        Rect.fromLTWH(0, 0, size.width, size.height),
        const Radius.circular(0),
      ),
    );
    
    // Left Round In
    // path.addOval(
    //   Rect.fromCircle(
    //     center: Offset(1, (size.height/ 11) * 1.8), // Position Roun In Left
    //     radius: 16, // Size
    //   ),
    // );
    path.addOval(
      Rect.fromCircle(
        center: Offset(5, (size.height / 2.6) * 1.8), // Position Roun In Left
        radius: 16, // Size
      ),
    );

    // Right Round In
    // path.addOval(
    //   Rect.fromCircle(
    //     center: Offset(size.width - 1, (size.height / 11) * 1.8), // Position Roun In Right
    //     radius: 16, // Size
    //   ),
    // );
     path.addOval(
      Rect.fromCircle(
        center: Offset(size.width - 5, (size.height / 2.6) * 1.8), // Position Roun In Right
        radius: 16, // Size
      ),
    );
    
    // Horizontal Line Dash
    const dashWidth = 10;
    const dashSpace = 7;
    final dashCount = size.width ~/ (dashWidth + dashSpace);

    for (var i = 0; i < dashCount; i++) {
      path.addRect(
        Rect.fromLTWH(
          i * (dashWidth + dashSpace).toDouble() + 22,
          (size.height / 2.6) * 1.8,
          dashWidth.toDouble(),
          1.5,
        ),
      );
      
    }

    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(CustomClipper oldClipper) {
    return true;
  }
}