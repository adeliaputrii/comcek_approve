import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:myactivity_project/ramayana_comcheck_cek.dart';
import 'package:month_picker_dialog_2/month_picker_dialog_2.dart';
import 'package:myactivity_project/ramayana_riwayat_apv.dart';

class RamayanaRiwayat extends StatefulWidget {

  final DateTime initialDate;

  const RamayanaRiwayat({Key? key, required this.initialDate}) : super(key: key);

  @override
  State<RamayanaRiwayat> createState() => _RamayanaRiwayatState();
}

class _RamayanaRiwayatState extends State<RamayanaRiwayat> {

  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate = widget.initialDate;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en'),
        Locale('zh'),
        Locale('fr'),
        Locale('es'),
        Locale('de'),
        Locale('ru'),
        Locale('ja'),
        Locale('ar'),
        Locale('fa'),
        Locale("es"),
      ],
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
            height: 5000,
             color: Color.fromARGB(255, 255, 17, 17),
            ),
            Container(
               margin: EdgeInsets.fromLTRB(20, 90, 20, 0),
               child: 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                
                   Text('',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),

                    Text('Riwayat Approve',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
                    ),

                    Text('',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),

                    ]
                    )
              
            ),

              Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(40),
               color: Colors.white
               ),
               margin: EdgeInsets.only(top: 200, bottom: 50),
               height: 620,
               child: Column(
                children: <Widget>[
                  Container(
                  margin: EdgeInsets.only(top: 50, left: 70, right: 70),
              decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              ),
              
              ),
              height: 200,
              width: 2000,
              child: 
               Image.asset(
               'assets/jamtanggal.png',
                )
              ),

              Container(
                margin: EdgeInsets.only(top: 80, left: 30, right:30),
                height:150,
                 decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(40),
               color: Color.fromARGB(255, 228, 222, 222),
               ),
                 child: 
                 MaterialButton(
                  minWidth: 2000,
                 onPressed: () {
                                  showMonthPicker(
                                context: context,
                                firstDate: DateTime(DateTime.now().year - 100),
                                lastDate: DateTime(DateTime.now().year + 100),
                                initialDate: selectedDate ?? widget.initialDate,
                                locale: Locale("en"),
                                //show only even months
                                selectableMonthPredicate: (DateTime val) => mounted,
                                headerColor: Color.fromARGB(255, 255, 17, 17),
                                headerTextColor: Colors.white,
                                selectedMonthBackgroundColor: Color.fromARGB(255, 171, 3, 3),
                                selectedMonthTextColor: Colors.white,
                                unselectedMonthTextColor: Colors.blueGrey,
                                confirmText: Text('This one!',style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 17, 17)), ),
                                cancelText: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 17, 17)), ),
                                yearFirst: true,
                                roundedCornersRadius: 20,
                              ).then((date) {
                                if (date != null) {
                                  setState(() {
                                    selectedDate = date;
                                  });
                                }
                              });
                            },
                   child: 
                   Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: [
                     Text( 'Tahun/Bulan', 
                    style: TextStyle(color: Color.fromARGB(255, 95, 5, 5), fontSize: 28, fontWeight: FontWeight.bold,),
                     ),
                     SizedBox(
                      height: 10,
                     ),
                    Text('${selectedDate?.year}/${selectedDate?.month}', 
                     style: TextStyle(color: Color.fromARGB(255, 95, 5, 5), fontSize: 20, fontWeight: FontWeight.bold,),
                     )
                   ],
                   ),
                 ),
               ),
              
                ],
               ),
              ),
                

            Container(
              margin: EdgeInsets.only(top: 870, bottom: 50, left: 40, right: 40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                      height: 50,
                      color: Colors.white,
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RamayanaCompetitorCek(),), (Route<dynamic> route) => false);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Icon(IconlyBroken.arrowLeftCircle,
                          color: Colors.red,
                          size: 25,
                          ),
                          Text('Back',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          
                        ]),
                      ),
            
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                      height: 50,
                      color: Colors.white,
                      onPressed: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context) {
                        //   return RamayanaRiwayatApprove(initialDate: DateTime.now());
                        // }));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text('Next',
                          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Icon(IconlyBroken.arrowRightCircle,
                          color: Colors.red,
                          size: 25,
                          )
                        ]),
                      ),
                ],
              ),
            ),

             

           


            // Container(
            //   margin: EdgeInsets.fromLTRB(0, 150, 0, 50),
            //   decoration: BoxDecoration(
            //     borderRadius: BorderRadius.circular(20),
            //     color: Color.fromARGB(255, 236, 234, 234),
            //     boxShadow: [(BoxShadow(
            //       blurRadius: 4,
            //       spreadRadius: 1,
            //       color: Colors.grey
            //     ))]
            //     ),
            //   height: 750,
            //   ),
            //    Container(
            //     margin: EdgeInsets.fromLTRB(10, 300, 10, 0),
            //      child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceAround,
            //       children: <Widget>[
            //         Column(
            //           children: [
            //             TextButton
            //             (
            //               child:
            //              Text( 'Tahun', 
            //             style: TextStyle(color: Color.fromARGB(255, 95, 5, 5), fontSize: 28, fontWeight: FontWeight.bold,),
            //              ),
            //             onPressed: () {
            //               showMonthPicker(
            //             context: context,
            //             firstDate: DateTime(DateTime.now().year - 100),
            //             lastDate: DateTime(DateTime.now().year + 100),
            //             initialDate: selectedDate ?? widget.initialDate,
            //             locale: Locale("en"),
            //             //show only even months
            //             selectableMonthPredicate: (DateTime val) => mounted,
            //             headerColor: Color.fromARGB(255, 255, 17, 17),
            //             headerTextColor: Colors.white,
            //             selectedMonthBackgroundColor: Color.fromARGB(255, 171, 3, 3),
            //             selectedMonthTextColor: Colors.white,
            //             unselectedMonthTextColor: Colors.blueGrey,
            //             confirmText: Text('This one!',style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 17, 17)), ),
            //             cancelText: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 17, 17)), ),
            //             yearFirst: true,
            //             roundedCornersRadius: 20,
            //           ).then((date) {
            //             if (date != null) {
            //               setState(() {
            //                 selectedDate = date;
            //               });
            //             }
            //           });
            //         },
            //             ),

            //             Text('${selectedDate?.year}', 
            //             style: TextStyle(color: Color.fromARGB(255, 95, 5, 5), fontSize: 20, fontWeight: FontWeight.bold,),
            //             )
            //           ],
            //         ),
                    
            //         Column(
            //           children: [

            //             TextButton(
            //               child: Text('Bulan',
            //                style: TextStyle(color: Color.fromARGB(255, 95, 5, 5), fontSize: 28, fontWeight: FontWeight.bold)
            //               ),
            //               onPressed: () {
            //                 showMonthPicker(
            //             context: context,
            //             firstDate: DateTime(DateTime.now().year - 100),
            //             lastDate: DateTime(DateTime.now().year + 100),
            //             initialDate: selectedDate ?? widget.initialDate,
            //             locale: Locale("en"),
            //             //show only even months
            //             selectableMonthPredicate: (DateTime val) => mounted,
            //             headerColor: Color.fromARGB(255, 255, 17, 17),
            //             headerTextColor: Colors.white,
            //             selectedMonthBackgroundColor: Color.fromARGB(255, 171, 3, 3),
            //             selectedMonthTextColor: Colors.white,
            //             unselectedMonthTextColor: Colors.blueGrey,
            //             confirmText: Text('This one!',style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 17, 17)), ),
            //             cancelText: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 17, 17)), ),
            //             yearFirst: true,
            //             roundedCornersRadius: 20,
            //           ).then((date) {
            //             if (date != null) {
            //               setState(() {
            //                 selectedDate = date;
            //               });
            //             }
            //           });
            //           },
            //             ),
            //             Text('${selectedDate?.month}', 
            //             style: TextStyle(color: Color.fromARGB(255, 95, 5, 5), fontSize: 20, fontWeight: FontWeight.bold,),
            //             )
            //           ],
            //         )
            //       ],
            //                  ),
            //    ),
          ]),
      )
    );
  }
}