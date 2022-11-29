// import 'dart:convert';
// import 'dart:io';
// import 'package:bottom_bar_matu/bottom_bar_matu.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:myactivity_project/flashcreen.dart';
// import 'package:myactivity_project/service/service_api/auth.dart';
// import 'package:path/path.dart' as Path;
// import 'package:relative_scale/relative_scale.dart';
// import 'package:responsive_framework/responsive_framework.dart';
// import 'package:bouncing_widget/bouncing_widget.dart';
// import 'package:myactivity_project/form_data_local.dart';
// import 'package:myactivity_project/list_format.dart';
// import 'package:myactivity_project/lokal_activity.dart';
// import 'package:myactivity_project/lokal_list.dart';
// import 'package:myactivity_project/ramayana_activity.dart';
// import 'package:myactivity_project/ramayana_history.dart';
// import 'package:myactivity_project/ramayana_login.dart';
// import 'package:myactivity_project/ramayana_profile.dart';
// import 'package:myactivity_project/ramayana_void.dart';
// import 'package:myactivity_project/service/API_service/API_service.dart';
// import 'package:myactivity_project/service/SP_service/SP_service.dart';
// import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
// import 'package:tbib_splash_screen/splash_screen_view.dart';
// import 'package:draggable_home/draggable_home.dart';
// import 'package:http/http.dart' as http;
// import 'package:dio/dio.dart';
// import 'package:url_launcher/url_launcher.dart';
// import 'package:barcode_flutter/barcode_flutter.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:rounded_tabbar_widget/rounded_tabbar_widget.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class Home extends StatefulWidget {
//   const Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {

//   UserData userData = UserData();

//    void dapetinData() async {
//   print('qwe');
//   UserData userData = UserData();
//   await userData.getPref();
//   String username = userData.getUsernameID();
//   print('yuhu 123');
//   print(username);
//   }
//   logoutPressed() async {
//     SharedPreferences pref =await SharedPreferences.getInstance();
//       pref.remove('username');
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
//       return RamayanaLogin();
//     }));
//   }

//   @override
//   void initState() {
//     super.initState();
//       dapetinData();
    
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).canvasColor,
//       extendBody: true,
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//       floatingActionButton: GestureDetector(
//         onVerticalDragUpdate: DefaultBottomBarController.of(context).onDrag,
//         onVerticalDragEnd: DefaultBottomBarController.of(context).onDragEnd,
//         child: FloatingActionButton.extended(
//           label: AnimatedBuilder(
//             animation: DefaultBottomBarController.of(context).state,
//             builder: (context, child) => Row(
//               children: [
//                 Text(
//                   DefaultBottomBarController.of(context).isOpen
//                       ? "Pull"
//                       : "Pull",
//                 ),
//                 const SizedBox(width: 4.0),
//                 AnimatedBuilder(
//                   animation: DefaultBottomBarController.of(context).state,
//                   builder: (context, child) => Transform(
//                     alignment: Alignment.center,
//                     transform: Matrix4.diagonal3Values(
//                       1,
//                       DefaultBottomBarController.of(context).state.value * 2 -
//                           1,
//                       1,
//                     ),
//                     child: child,
//                   ),
//                   child: RotatedBox(
//                     quarterTurns: 1,
//                     child: Icon(
//                       Icons.chevron_right,
//                       size: 20,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           elevation: 2,
//           backgroundColor: Colors.deepOrange,
//           foregroundColor: Colors.white,
//           //
//           //Set onPressed event to swap state of bottom bar
//           onPressed: () => DefaultBottomBarController.of(context).swap(),
//         ),
//       ),
//       //
//       // Actual expandable bottom bar
//       bottomNavigationBar: 
//       BottomExpandableAppBar(
//         horizontalMargin: 16,
//         shape: AutomaticNotchedShape(
//             RoundedRectangleBorder(), StadiumBorder(side: BorderSide())),    
//         expandedBackColor: Color.fromARGB(255, 255, 245, 245),
//         expandedBody: 
//             ListView(
//               children: [
//                 Container(
//                   margin: EdgeInsets.fromLTRB(10, 50, 10, 0),
//                   width: 2000,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
                      
//                       SizedBox(
//                         height: 50,
//                       ),
//                       Image.asset('assets/Logo-Ramayana.png',
//                       height: 50,
//                       width: 2000,
//                       ),
                     
//                       SizedBox(
//                         height: 30,
//                       ),
//                       Container(
//                         margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    
//                     height: 230,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: Color.fromARGB(255, 255, 255, 255),
//                       boxShadow: [BoxShadow( 
//                               blurRadius: 5
//                       )]
//                     ),
                  
//                         child: 
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           crossAxisAlignment: CrossAxisAlignment.center,

//                           children: [

//                              Text('My Activity Fitur',
//                       style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.bold, fontSize: 25, fontStyle: FontStyle.italic),
//                       ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: <Widget>[

//                                            Column(
//                                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                             crossAxisAlignment: CrossAxisAlignment.center,
//                                              children: [
//                                                MaterialButton(
//                             minWidth:  MediaQuery.of(context).size.width/6,
//                             height:  MediaQuery.of(context).size.height/13,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50)
//                             ),
//                              color: Color.fromARGB(255, 255, 17, 17),
//                             onPressed: () {
//                                Navigator.push(context, MaterialPageRoute(builder: (context){
//                                 return Activity();
//                               }));
//                             }, 
//                             child:  
//                             Icon(IconlyBold.paperPlus,
//                             size: 30,
//                             color: Colors.white,
//                             ),
                            
//                              ),
//                              SizedBox(
//                               height: 10,
//                              ),

//                              Text('Add Activity',
//                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
//                              )
//                                              ],
//                                            ),
//                                Column(
//                                  children: [
//                                    MaterialButton(
//                             minWidth:  MediaQuery.of(context).size.width/6,
//                             height:  MediaQuery.of(context).size.height/13,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50)
//                             ),
//                              color: Color.fromARGB(255, 255, 17, 17),
//                             onPressed: () {
//                                    Navigator.push(context, MaterialPageRoute(builder: (context){
//                                     return RamayanaHistory();
//                               }));
//                             }, 
//                             child:  Icon(IconlyBold.document,
//                             size: 30,
//                             color: Colors.white,
//                             ),
                            
//                                                ),

//                                                 SizedBox(
//                               height: 10,
//                              ),

//                              Text('List Activity',
//                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
//                                  ],
//                                ),
//                                            Column(
//                                              children: [
//                                                MaterialButton(
//                             minWidth:  MediaQuery.of(context).size.width/6,
//                             height:  MediaQuery.of(context).size.height/13,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50)
//                             ),
//                              color: Color.fromARGB(255, 255, 17, 17),
//                             onPressed: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context){
//                                 return Blank();
//                               }));
//                             }, 
//                             child: 
//                              Icon(IconlyBold.scan,
//                             size: 30,
//                             color: Colors.white,
//                             ),
                            
//                                                ),
//                                                SizedBox(
//                               height: 10,
//                              ),

//                              Text('Void',
//                              style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
//                                              ],
//                                            )
                                           
                                      
                                           
//                             ],
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//     ),

//     body: Stack(
//       fit: StackFit.loose,
//       children: <Widget>[
        
          
             
           
//           //  ListView(
//           //   children: <Widget>[
            
//                 Container(
//                         margin: EdgeInsets.only(top: 0),
//                         height: 230,
//                         width: 2000,
//                         child: 
//                         Image.asset('assets/y.jpeg',
//                         width: 2000,
//                          fit: BoxFit.cover
//                         ),
      
//                       ),
                    
//                   Container(
//                     margin: EdgeInsets.only(top: 40, left: 20, right: 20),
//                     child:Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: <Widget>[
                    
//                    IconButton(onPressed: () async {
//                      logoutPressed();
//                     //  SharedPreferences pref =await SharedPreferences.getInstance();
//                     //       pref.setString("username", "${userData.getUsernameID()}}");
//                     //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
//                     //         return RamayanaLogin() ;
//                     //        }));
//                     //       print('sharedP');
//                    },
//                     icon: Icon(Icons.power_settings_new_outlined,
//                     color: Colors.white,
//                     size: 30,
//                     ),
//                     ),
//                     Text('Dashboard My Activity',
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
//                     ),
//                   IconButton(onPressed: () {
//                      Navigator.push(context, MaterialPageRoute(builder: (context){
//                       return Profilee();
//                     }
//                     ));
//                   },
//                     icon: Icon(Icons.person,
//                     color: Colors.white,
//                     size: 30,
//                     ),
//                     ),
                   
//                     ]
//                     )
//                     ),
                  
//                   Container(
//                     margin: EdgeInsets.only(top: 150, left: 20, right: 20),
                    
                  
//       child:AnimatedTextKit(
//         isRepeatingAnimation: true,
//           animatedTexts: [
//             TyperAnimatedText('Halo ${userData.getFullname()} ${userData.getUsernameID()}',
//                     speed: Duration(milliseconds: 100),
//                     textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
//                     ),
//             TyperAnimatedText('Welcome to Ramayana My Activity'
//                     ,speed: Duration(milliseconds: 100),
                    
//                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
//             ),
//              TyperAnimatedText('Halo ${userData.getFullname()} ${userData.getUsernameID()}',
//                     speed: Duration(milliseconds: 100),
//                     textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
//                     ),
//                     TyperAnimatedText('Welcome to Ramayana My Activity'
//                     ,speed: Duration(milliseconds: 100),
                    
//                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
//             ),
//              TyperAnimatedText('Halo ${userData.getFullname()} ${userData.getUsernameID()}',
//                     speed: Duration(milliseconds: 100),
//                     textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
//                     ),
//                     TyperAnimatedText('Welcome to Ramayana My Activity'
//                     ,speed: Duration(milliseconds: 100),
                    
//                      textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
//             ),
//              TyperAnimatedText('Halo ${userData.getFullname()} ${userData.getUsernameID()}',
//                     speed: Duration(milliseconds: 100),
//                     textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
//                     ),
                   
//           ]
//         ),
//                   ),

//             Container(
            
//                     margin: EdgeInsets.fromLTRB(10, 250, 10, 0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(5),
//                       color: Colors.white,
//                       boxShadow: [BoxShadow(
//                           color: Colors.black12,
//                           spreadRadius: 3,
//                           blurRadius: 3
//                         ),]
//                     ),
//                     height: 270,   
//                width: 2000,  
               
//                     child:
            
                    
//               Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                           Image.asset(
//                             'assets/ram.png',
//                             width: 200,
//                           )
                   
//                         ],
//               ),
                      
//               ),
//       ]),
//     );
//   }
// }