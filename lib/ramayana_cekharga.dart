import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RamayanaCekHarga extends StatefulWidget {
  const RamayanaCekHarga({super.key});

  @override
  State<RamayanaCekHarga> createState() => _RamayanaCekHargaState();
}

class _RamayanaCekHargaState extends State<RamayanaCekHarga> {
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
            color: Color.fromARGB(255, 255, 17, 17),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 40, 20, 0),
             decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20)
            ),
            height: 170,
            child: 
            Container(
              margin: EdgeInsets.fromLTRB(20, 20, 20, 20),
              // color: Colors.yellow,
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(Icons.qr_code_scanner_outlined,
                      size: 50,
                      color: Color.fromARGB(255, 179, 42, 33),
                        ),
                        onPressed: () {},
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: 300,
                        height: 50,
                        child: TextFormField(
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
                  MaterialButton(
                    color: Color.fromARGB(255, 255, 17, 17),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () {},
                    child: Text('Process', style: TextStyle(
                                        color: Colors.white, fontSize: 18),),
                    )
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 250),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(70)
              )
            ),
          ),
          
        ],
      ),
    );
  }
}