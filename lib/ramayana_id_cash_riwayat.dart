import 'package:flutter/material.dart';
import 'package:myactivity_project/ramayana_idcash.dart';

class RamayanaRiwayatIDCash extends StatefulWidget {
  const RamayanaRiwayatIDCash({super.key});

  @override
  State<RamayanaRiwayatIDCash> createState() => _RamayanaRiwayatIDCashState();
}

class _RamayanaRiwayatIDCashState extends State<RamayanaRiwayatIDCash> {

  var selected2;
    final List<String> data2 = [
    'RB17',
    'R136',
    'S204',
    'S445'
  ];
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

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20)
                  ),
                  height: 140,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                        // height: 50,
                        // color: Colors.green,
                        child: 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.calendar_month_sharp, size: 40, color: Colors.red,),
                              
                            
                            Container(
                              margin: EdgeInsets.only(left: 10,),
                              child: Text('Select Month', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),)),
                              ],
                            ),
                             Container(
                              margin: EdgeInsets.only(left: 20),
                               child: DropdownButton(
                                             value: selected2,
                                             hint: Text('TOKO',
                                             style: TextStyle(
                                               color: Color.fromARGB(255, 255, 17, 17),
                                               fontSize: 17, fontWeight: FontWeight.w500
                                             ),
                                             ),
                                             onChanged: (value) {
                                               print(value);
                                               setState(() {
                                                 selected2 = value;
                                               });
                                             },
                                             items: data2
                                             .map(
                                               (e) => DropdownMenuItem(
                                                 value: e,
                                                 child: 
                                                 Text(e, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 255, 17, 17)),),
                                               ),
                                               )
                                               .toList()
                                             ),
                             ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 1,
                        color: Colors.red,
                      ),
                     Container(
                       margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                       child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.calendar_month_sharp, size: 40, color: Colors.red,),
                                
                              
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                child: Text('Select Year', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),)),
                                ],
                              ),
                               Container(
                                margin: EdgeInsets.only(left: 20),
                                 child: DropdownButton(
                                               value: selected2,
                                               hint: Text('TOKO',
                                               style: TextStyle(
                                                 color: Color.fromARGB(255, 255, 17, 17),
                                                 fontSize: 17, fontWeight: FontWeight.w500
                                               ),
                                               ),
                                               onChanged: (value) {
                                                 print(value);
                                                 setState(() {
                                                   selected2 = value;
                                                 });
                                               },
                                               items: data2
                                               .map(
                                                 (e) => DropdownMenuItem(
                                                   value: e,
                                                   child: 
                                                   Text(e, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 255, 17, 17)),),
                                                 ),
                                                 )
                                                 .toList()
                                               ),
                               ),
                            ],
                          ),
                     ),
                    ]),
                ),
               
                Container(
                  margin: EdgeInsets.fromLTRB(180, 20, 180, 0),
                  child: MaterialButton(
                    height: 40,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                              onPressed: () {
                  
                              },
                              child: Text('Search', style: TextStyle(color: Color.fromARGB(255, 255, 0, 0), fontSize: 18, fontWeight: FontWeight.bold),),
                              color: Colors.white
                              ),
                ),
              ],
            ),
            
              
            Container(
              margin: EdgeInsets.only(top: 250),
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30)
              )
              ),
              child: ListView(
                children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(30, 30, 0, 0),
                    child: Text('Transaction', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),)
                    )
                ],
              ),
            )
          ]
          ),

    );
  }
 
}