import 'dart:convert';
import 'dart:io';
import 'package:bottom_bar_matu/bottom_bar_matu.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myactivity_project/service/service_api/auth.dart';
import 'package:path/path.dart' as Path;
import 'package:relative_scale/relative_scale.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:myactivity_project/ramayana_lokal_form.dart';
import 'package:myactivity_project/ramayana_lokal_list.dart';
import 'package:myactivity_project/ramayana_lokal_list.dart';
import 'package:myactivity_project/ramayana_lokal_form.dart';
import 'package:myactivity_project/ramayana_activity.dart';
import 'package:myactivity_project/ramayana_history.dart';
import 'package:myactivity_project/ramayana_login.dart';
import 'package:myactivity_project/ramayana_profile.dart';
import 'package:myactivity_project/ramayana_void.dart';
import 'package:myactivity_project/service/API_service/API_service.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:draggable_home/draggable_home.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:rounded_tabbar_widget/rounded_tabbar_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class Ramayana extends StatefulWidget {
  const Ramayana({super.key});

  @override
  State<Ramayana> createState() => _RamayanaState();
}

class _RamayanaState extends State<Ramayana> {

  static UserData userData = UserData();

    @override
   void initState() {
    super.initState();
    dapetinData();
   }

 Future<void> dapetinData() async {
  UserData userData = UserData();
  await userData.getPref();
  String username = userData.getUsernameID();
  }
  
  logoutPressed() async {
    
    SharedPreferences pref =await SharedPreferences.getInstance();
        pref.remove('username');
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
        return RamayanaLogin();
       }));
    
  }

 
 void sweatAlert(BuildContext context) {
  Alert(
    context: context,
    type: AlertType.warning,
    title: "Log Out",
    desc: "Are you sure you want to log out?",
    buttons: [
      DialogButton(
        color: Colors.green,
        onPressed: () { 
          Navigator.pop(context);
         },
        child: 
         Text( "Cancel",
              style: TextStyle(color: Colors.white, fontSize: 14),
             ),
            ),

        DialogButton(
        color: Color.fromARGB(255, 255, 17, 17),
        onPressed: () { 
          logoutPressed();
          Navigator.pop(context);
         },
        child: 
         Text( "Log Out",
              style: TextStyle(color: Colors.white, fontSize: 14),
             ),
            ),
          
    ],
  ).show();
  return;
}


  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(builder: (context, height, width, sy, sx) {
      return Scaffold(
          backgroundColor: Theme.of(context).canvasColor,
          extendBody: true,
          
        //   appBar: AppBar(
        //   title: Text('Dashboard My Activity', style: TextStyle(fontSize: 23),),
        //   backgroundColor: Color.fromARGB(255, 213, 213, 213),
        //   leading: Icon(Icons.power_settings_new_rounded, size: 30,),
        //   // elevation: 7.20  ,
        //   toolbarHeight: 150,
        //   actions: <Widget>[
        //     IconButton(
        //     icon: Icon(Icons.person, size: 30,
        //     color: Colors.white,),
        //     onPressed: () {
        //        Navigator.push(context, MaterialPageRoute(builder: (context){
        //                 return Profilee(); 
        //               }));
        //     }
        //       ),
        //       IconButton(
        //     icon: Icon(Icons.power_settings_new_rounded, size: 30,) ,
        //     onPressed: () {
        //       Navigator.push(context, MaterialPageRoute(builder: (context){
        //         return RamayanaLogin();
        //       }));
              
        //     },
        //       ),
      
        //   ],
        // ),
       
      // Lets use docked FAB for handling state of sheet
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: GestureDetector(
        onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
        onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
        child: FloatingActionButton.extended(
          label: AnimatedBuilder(
            animation: DefaultBottomBarController.of(context).state,
            builder: (context, child) => Row(
              children: [
                Text(
                  DefaultBottomBarController.of(context).isOpen
                      ? "Pull"
                      : "Pull",
                ),
                const SizedBox(width: 4.0),
                AnimatedBuilder(
                  animation: DefaultBottomBarController.of(context).state,
                  builder: (context, child) => Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.diagonal3Values(
                      1,
                      DefaultBottomBarController.of(context).state.value * 2 -
                          1,
                      1,
                    ),
                    child: child,
                  ),
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: Icon(
                      Icons.chevron_right,
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),
          elevation: 2,
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          //
          //Set onPressed event to swap state of bottom bar
          onPressed: () => DefaultBottomBarController.of(context).swap(),
        ),
      ),
      //
      // Actual expandable bottom bar
      bottomNavigationBar: 
      BottomExpandableAppBar(
        horizontalMargin: 16,
        shape: AutomaticNotchedShape(
            RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),    
        expandedBackColor: Color.fromARGB(255, 255, 245, 245),
        expandedBody: 
            ListView(
              children: [
                Container(
                  margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
                  width: 2000,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      
                      SizedBox(
                        height: 50,
                      ),
                      Image.asset('assets/Logo-Ramayana.png',
                      height: 50,
                      width: 2000,
                      ),
                     
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    
                    height: 230,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color.fromARGB(255, 255, 255, 255),
                      boxShadow: [BoxShadow( 
                              blurRadius: 5
                      )]
                    ),
                  
                        child: 
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.center,

                          children: [

                             Text('My Activity Fitur',
                      style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.bold, fontSize: 25, fontStyle: FontStyle.italic),
                      ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                           Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                             children: [
                                               MaterialButton(
                            minWidth:  MediaQuery.of(context).size.width/6,
                            height:  MediaQuery.of(context).size.height/13,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            ),
                             color: Color.fromARGB(255, 255, 17, 17),
                            onPressed: () {
                               Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Activity();
                              }));
                            }, 
                            child:  
                            Icon(IconlyBold.paperPlus,
                            size: 30,
                            color: Colors.white,
                            ),
                            
                             ),
                             SizedBox(
                              height: 10,
                             ),

                             Text('Add Activity',
                             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                             )
                                             ],
                                           ),
                               Column(
                                 children: [
                                   MaterialButton(
                            minWidth:  MediaQuery.of(context).size.width/6,
                            height:  MediaQuery.of(context).size.height/13,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            ),
                             color: Color.fromARGB(255, 255, 17, 17),
                            onPressed: () {
                                   Navigator.push(context, MaterialPageRoute(builder: (context){
                                    return RamayanaHistory();
                              }));
                            }, 
                            child:  Icon(IconlyBold.document,
                            size: 30,
                            color: Colors.white,
                            ),
                            
                                               ),

                                                SizedBox(
                              height: 10,
                             ),

                             Text('List Activity',
                             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                 ],
                               ),
                                           Column(
                                             children: [
                                               MaterialButton(
                            minWidth:  MediaQuery.of(context).size.width/6,
                            height:  MediaQuery.of(context).size.height/13,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)
                            ),
                             color: Color.fromARGB(255, 255, 17, 17),
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(builder: (context){
                                return Blank();
                              }));
                            }, 
                            child: 
                             Icon(IconlyBold.scan,
                            size: 30,
                            color: Colors.white,
                            ),
                            
                                               ),
                                               SizedBox(
                              height: 10,
                             ),

                             Text('Void',
                             style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                                             ],
                                           )
                                           
                                      
                                           
                            ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),

        // Stack(children: <Widget>[
        // Container(
        //             margin: EdgeInsets.fromLTRB(30, 30,30, 0),
        //       child:
        //       Text(
        //             'Form Void', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 23, color: Colors.white),
        //             ),
        //       ),

        //       Container(
        //         margin: EdgeInsets.fromLTRB(10, 100, 10, 0),
                
        //         height: 200,
        //         decoration: BoxDecoration(
        //           borderRadius: BorderRadius.circular(20),
        //           color: Color.fromARGB(255, 255, 255, 255),
        //           boxShadow: [BoxShadow( 
        //                   blurRadius: 5
        //           )]
        //         ),
        //       ),
        //       Container(
        //         margin: EdgeInsets.fromLTRB(30, 100, 30, 0),
        //         child: ListView(
        //           children: <Widget>[

              
        //        SizedBox(
        //             height: 30,
        //             width: 30,
        //             ),

        //           TextFormField(
        //           cursorColor: Colors.black,
        //               controller: myControllerRandomAngka,
        //              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        //               keyboardType: TextInputType.number,
        //               style: TextStyle(fontSize: 20, color: Colors.black),
        //               decoration: InputDecoration( 
        //               errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: Color.fromARGB(255, 255, 17, 17),)),
        //                 errorStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
        //               labelStyle: TextStyle(
        //               color: Colors.black
        //                 ),

        //                 prefixIcon: Icon(
        //                   Icons.keyboard,
        //                   color: Color.fromARGB(255, 255, 17, 17),
        //                   size: 30,
        //                 ),
        //                 hintText: 'Enter Code', 
        //                 hintStyle: TextStyle(
        //                   color:  Colors.black,
        //                   fontSize: 20
        //                 ),
        //                    enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black), borderRadius:  BorderRadius.circular(25)),
        //                    focusedBorder: OutlineInputBorder(
        //                       borderSide: new BorderSide(color: Colors.black),
        //                       borderRadius:  BorderRadius.circular(25)
        //                    )
        //               ),
        //             ),
        //           SizedBox(
        //             height: 20,
        //             width: 20,
        //             ),
        //           Container(
                
        //         margin: EdgeInsets.only(top:10, left: 120, right: 120),
        //         decoration: BoxDecoration(
        //           color: Color.fromARGB(255, 255, 17, 17),
        //           borderRadius: BorderRadius.circular(30)
        //         ),
        //         height: 40,
        //         child: Container(
        //          margin: EdgeInsets.only(right: 7),
        //             width: 50,
        //             child: 
        //             TextButton(
                     
        //               child: 
        //                Text(
        //               'GENERATE', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20, color: Colors.white),
        //                ),
        //                onPressed: () async {
        //           data = await _getLogikaVoid();
                 
        //           setState(() {
        //             _visible = true;
        //           });
        //         },
               
        //               ),
                  
                  
        //       )
        //       ),
        //           ],
        //         ),
        //       ),


              
              
        //       AnimatedOpacity(
                
        //         opacity: _visible ? 1.0 : 0.0,
        //         duration: const Duration(milliseconds: 500),
                
               
        //       child: Container(
                
        //          margin: EdgeInsets.fromLTRB(10, 250,10, 0),
        //         child: ListView(
        //           children: <Widget>[
        //             Container(
        //           // color: Colors.green,
        //     margin: EdgeInsets.fromLTRB(10,100, 10, 0),
        //     child: 
        //           Center(
        //             child: BarCodeImage(
        //                      backgroundColor: Colors.white,
        //             params: Code128BarCodeParams(
        //               "$data",
        //               lineWidth: 1.5,                // width for a single black/white bar (default: 2.0)
        //               barHeight: 100,               // height for the entire widget (default: 100.0)
        //               withText: true,                // Render with text label or not (default: false)
        //             ),
        //             padding: EdgeInsets.only(bottom: 7),
        //             onError: (error) {               // Error handler
        //               print('error = $error');
                      
        //             },
        //             ),
        //           )
        //                 ),
        //          Container(
        //           // color: Colors.green,
        //     margin: EdgeInsets.fromLTRB(120,40, 120, 0),
        //     child: 
        //     PrettyQr(
             
        //   image: AssetImage('assets/ramayana.jpg'),
        //   elementColor: Colors.white,
        //   size: 190,
        //   data: '$data',
        //   errorCorrectLevel: QrErrorCorrectLevel.M,
        //   typeNumber: 7,
        //   roundEdges: false,
        // ),
      
           
        //          )
                
        //           ],
        //         ),
        //       )
        //       )
        //       ],),
        // bottomAppBarBody: 
        
        // selectedIndex: _index,
        // BottomBarBubble(
        //   onSelect: (index) {
        // void onAddButtonTapped(int index) {
        // controller.jumpToPage(index);

        // }
        // },
        //   color: Color.fromARGB(255, 255, 17, 17),
        //   items: [
        //     BottomBarItem(
        //       iconData: Icons.home
              
        //     ),
        //     BottomBarItem(
        //       iconData: Icons.person,
        //     )
        //  ]
        
        // ),
        
      ),
      
      

    
  
          body: 
      Stack(
      
            fit: StackFit.loose,
            children: <Widget>[
             
           
          //  ListView(
          //   children: <Widget>[
            
                Container(
                        margin: EdgeInsets.only(top: 0),
                        height: 230,
                        width: 2000,
                        child: 
                        Image.asset('assets/y.jpeg',
                        width: 2000,
                         fit: BoxFit.cover
                        ),
      
                      ),
                    
                  Container(
                    margin: EdgeInsets.only(top: 40, left: 20, right: 20),
                    child:
                //     ListTile(
                //       leading: FittedBox(
                //   fit: BoxFit.fill,
                //   child: Row(
                //     children: [
                     
                //       // button hapus
                //       IconButton(
                //         icon: Icon(Icons.power_settings_new_rounded),
                //         color: Colors.white,
                //         iconSize: 28,
                //         onPressed: () {
                //           //membuat dialog konfirmasi hapus
                //           AlertDialog hapus = AlertDialog(
                //             title: Text("Information"),
                //             content: Container(
                //               height: 30,
                //               child: Column(
                //                 children: [
                //                   Text(
                //                       "Are you sure you want to log out?")
                //                 ],
                //               ),
                //             ),
                //             //terdapat 2 button.
                //             //jika ya maka jalankan _deleteKontak() dan tutup dialog
                //             //jika tidak maka tutup dialog
                //             actions: [
                //               TextButton(
                //                   onPressed: () {
                //                     logoutPressed();
                //                     Navigator.pop(context);
                //                   },
                //                   child: Text("Log Out",
                //                     style: TextStyle(
                //                     color:  Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.w500, fontSize: 17)
                //                   )
                //                     ),
                                  
                //               TextButton(
                //                 child: Text('Cancel',
                //                     style: TextStyle(
                //                     color:  Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.w500, fontSize: 17)),
                //                 onPressed: () {
                //                   Navigator.pop(context);
                //                 },
                //               ),
                //             ],
                //           );
                //           showDialog(
                //               context: context, builder: (context) => hapus);
                //         },
                //       )
                //     ],
                //   ),
                // ),

                // title: Text('Dashboard My Activity',
                //     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                //     ),

                //   trailing: 
                //   IconButton(onPressed: () {
                //      Navigator.push(context, MaterialPageRoute(builder: (context){
                //       return Profilee();
                //     }
                //     ));
                //   },
                //     icon: Icon(Icons.person,
                //     color: Colors.white,
                //     size: 30,
                //     ),
                //     ),
                //     ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                     IconButton(
                        icon: Icon(Icons.power_settings_new_rounded),
                        color: Colors.white,
                        iconSize: 28,
                        onPressed: () {
                          sweatAlert(context);
                        }
                     ),
                //   FittedBox(
                //   fit: BoxFit.fill,
                //   child: Row(
                //     children: [
                     
                //       // button hapus
                //       IconButton(
                //         icon: Icon(Icons.power_settings_new_rounded),
                //         color: Colors.white,
                //         iconSize: 28,
                //         onPressed: () {
                //           //membuat dialog konfirmasi hapus
                //           AlertDialog hapus = AlertDialog(
                //             title: Text("Log Out?"),
                //             content: Container(
                //               height: 30,
                //               child: Column(
                //                 children: [
                //                   Text(
                //                       "Are you sure you want to log out?")
                //                 ],
                //               ),
                //             ),
                //             //terdapat 2 button.
                //             //jika ya maka jalankan _deleteKontak() dan tutup dialog
                //             //jika tidak maka tutup dialog
                //             actions: [
                //               TextButton(
                //                   onPressed: () {
                                    
                //                     Navigator.pop(context);
                //                   },
                //                   child: Text("Cancel",
                //                     style: TextStyle(
                //                     color:  Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.w500, fontSize: 17)
                //                   )
                //                     ),
                                  
                //               TextButton(
                //                 child: Text('Log Out',
                //                     style: TextStyle(
                //                     color:  Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.w500, fontSize: 17)),
                //                 onPressed: () {
                //                   logoutPressed();
                //                   Navigator.pop(context);
                //                 },
                //               ),
                //             ],
                //           );
                //           showDialog(
                //               context: context, builder: (context) => hapus);
                //         },
                //       )
                //     ],
                //   ),
                // ),

                Text('Dashboard My Activity',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                  IconButton(onPressed: () {
                     Navigator.push(context, MaterialPageRoute(builder: (context){
                      return Profilee();
                    }
                    ));
                  },
                    icon: Icon(Icons.person,
                    color: Colors.white,
                    size: 30,
                    ),
                    ),
                    
                 
                    ]
                    )
                    ),
                  
                  Container(
                    margin: EdgeInsets.only(top: 150, left: 20, right: 20),
                    
                  
      child:AnimatedTextKit(
        isRepeatingAnimation: true,
          animatedTexts: [
            TyperAnimatedText('Halo ${userData.getFullname()} ${userData.getUsernameID()}',
                    speed: Duration(milliseconds: 100),
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                    ),
            TyperAnimatedText('Welcome to Ramayana My Activity'
                    ,speed: Duration(milliseconds: 100),
                    
                     textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
            ),
             TyperAnimatedText('Halo ${userData.getFullname()} ${userData.getUsernameID()}',
                    speed: Duration(milliseconds: 100),
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                    ),
                    TyperAnimatedText('Welcome to Ramayana My Activity'
                    ,speed: Duration(milliseconds: 100),
                    
                     textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
            ),
             TyperAnimatedText('Halo ${userData.getFullname()} ${userData.getUsernameID()}',
                    speed: Duration(milliseconds: 100),
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                    ),
                    TyperAnimatedText('Welcome to Ramayana My Activity'
                    ,speed: Duration(milliseconds: 100),
                    
                     textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
            ),
             TyperAnimatedText('Halo ${userData.getFullname()} ${userData.getUsernameID()}',
                    speed: Duration(milliseconds: 100),
                    textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                    ),
                   
          ]
        ),
                  ),

            Container(
            
                    margin: EdgeInsets.fromLTRB(10, 250, 10, 0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.white,
                      boxShadow: [BoxShadow(
                          color: Colors.black12,
                          spreadRadius: 3,
                          blurRadius: 3
                        ),]
                    ),
                    height: 270,   
               width: 2000,  
               
                    child:
            
                    
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                          Image.asset(
                            'assets/ram.png',
                            width: 200,
                          )
                   
                        ],
              ),
                      
              ),
            
             
          //  ],
          //  )
              ],
              
      
       
      )
      );
    });
  }
}