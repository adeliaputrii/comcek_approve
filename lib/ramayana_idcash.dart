import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myactivity_project/keyboard.dart';
import 'package:myactivity_project/ramayana_device_info.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_id_cash_riwayat.dart';
import 'package:myactivity_project/ramayana_idcash_pin.dart';
import 'package:myactivity_project/ramayana_idcashbarcode.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class RamayanaIDCash extends StatefulWidget {
  const RamayanaIDCash({super.key});

  @override
  State<RamayanaIDCash> createState() => _RamayanaIDCashState();
}

class _RamayanaIDCashState extends State<RamayanaIDCash> {
  TextEditingController nama = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController hp = TextEditingController();

 UserData userData = UserData();
 
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
              return DefaultBottomBarController(child: Ramayana());
            }), (route) => false);
          },
          icon: Icon(Icons.arrow_back),
          ),
        title: 
       Text('ID CASH', style: TextStyle(fontSize: 23, color: Colors.white, fontWeight: FontWeight.bold),),
        backgroundColor:Color.fromARGB(255, 255, 17, 17),
        elevation: 5,
        toolbarHeight: 90,
        ),

        body: 
        Stack(
          fit: StackFit.loose,
          children: <Widget>[
            Container(
              // height: MediaQuery.of(context).size.height/1.14,
            decoration: BoxDecoration(
                color:  Color.fromARGB(255, 255, 0, 0),
                
          )
          ),

          Container(
            width: 100000,
            height: 300,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 0, 0),
              // borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SizedBox(
                height: 1,
              ),
              
              Column(
                children: [
                   Text('Saldo', style: TextStyle(color: Colors.white, fontSize: 18, fontStyle: FontStyle.italic),),
                  Text('Rp. 1.000.000', style: TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),),
                ],
              ),
             
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Column(
                  
                    children: [
                      MaterialButton(
                                minWidth:  MediaQuery.of(context).size.width/7,
                                height:  MediaQuery.of(context).size.height/15,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return RamayanaPin();
                                  }));
                                },
                               child:  Icon(Icons.payment_outlined,
                                size: 35,
                                color: Colors.red,
                                ),
                                
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                        Text('No. Kartu ID CASH', style: TextStyle(color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),),
                    ],
                  ),
                    Column(
                  
                    children: [
                      MaterialButton(
                                minWidth:  MediaQuery.of(context).size.width/7,
                                height:  MediaQuery.of(context).size.height/15,
                                shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)
                                ),
                                color: Colors.white,
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return RamayanaRiwayatIDCash();
                                  }));
                                },
                                child:  Icon(Icons.bar_chart,
                                size: 35,
                                color: Colors.red,
                                ),
                                
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                        Text('Riwayat Transaksi', style: TextStyle(color: Colors.white, fontSize: 16, fontStyle: FontStyle.italic, fontWeight: FontWeight.w500),)
                    ],
                  ),
                ],
              )
            ],
          ),
          ),
          Container(
            // height: MediaQuery.of(context).size.height/1.81,
            margin: EdgeInsets.fromLTRB(5, 320, 5, 0),
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
                  height: 80,
                  width: 100000,
                  margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
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
                            child: Text('Nama', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                        
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: TextFormField(
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
                          controller: nama..text = '${userData.getFullname()}',
                          readOnly: true,
                        ),
                      )
                      ],
                      ),
                    
                 
                ),
                 
             
         
               
                Container(
                  height: 80,
                  width: 100000,
                  margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
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
                            child: Text('Email', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                        
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: TextFormField(
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
                          controller: email..text = '${userData.getEmail()}',
                          readOnly: true,
                        ),
                      )
                      ],
                      ),
                    
                 
                ),

                 Container(
                  height: 80,
                  width: 100000,
                  margin: EdgeInsets.fromLTRB(20, 25, 20, 0),
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
                            child: Text('No. HP', style: TextStyle(fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),)),
                        
                      Container(
                        margin: EdgeInsets.only(left: 20),
                        child: TextFormField(
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
                          controller: hp..text = '08XXXXXXXXXX',
                          readOnly: true,
                        ),
                      )
                      ],
                      ),
                    
                 
                ),
           ],
            ),
          ),
          ]),
          
    );
  }
}