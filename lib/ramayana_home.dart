import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myactivity_project/ramayana_comcheck_cek.dart';
import 'package:myactivity_project/service/service_api/auth.dart';
import 'package:path/path.dart' as Path;
import 'package:relative_scale/relative_scale.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:myactivity_project/ramayana_activity.dart';
import 'package:myactivity_project/ramayana_history.dart';
import 'package:myactivity_project/ramayana_login.dart';
import 'package:myactivity_project/ramayana_profile.dart';
import 'package:myactivity_project/ramayana_void.dart';
import 'package:myactivity_project/service/API_service/API_service.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:barcode_flutter/barcode_flutter.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
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
          appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 255, 17, 17),
           elevation: 0  ,
          toolbarHeight: 1,
        ),
       
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
          backgroundColor: Color.fromARGB(255, 255, 17, 17),
          foregroundColor: Colors.white,
          //Set onPressed event to swap state of bottom bar
          onPressed: () => DefaultBottomBarController.of(context).swap(),
        ),
      ),
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
                    margin: EdgeInsets.fromLTRB(10, 80, 10, 0),
                    height: 500,
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
                                onPressed: () {},
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
                                onPressed: () {},
                                child:  
                                Icon(IconlyBold.wallet,
                                size: 30,
                                color: Colors.white,
                                ),
                                ),

                                SizedBox(
                                height: 10,
                                ),

                                Text('Menu1',
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
                                onPressed: () {}, 
                                child:  Icon(IconlyBold.work,
                                size: 30,
                                color: Colors.white,
                                ),
                                ),

                                SizedBox(
                                height: 10,
                                ),

                                Text('Menu2',
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
                                  return RamayanaCompetitorCek();
                                }));
                              }, 
                                child: 
                                Icon(IconlyBold.editSquare,
                                size: 30,
                                color: Colors.white,
                                ),
                                ),

                                SizedBox(
                                height: 10,
                                ),

                                Text('COM Check',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),)
                         ],
                         ) 
                        ],
                        ),

                        SizedBox(
                          height: 90,
                        )
                      ],
                    ),
                  ),
              ],
            ),
      ),

      body: 
      ListView(
        children: [
          Stack(
           fit: StackFit.loose,
           children: <Widget>[

            Container(
              margin: EdgeInsets.only(top: 0),
              height: 180,
              width: 2000,
              color: Color.fromARGB(255, 255, 17, 17),
              ),
                      
            Container(
              margin: EdgeInsets.only(top: 5,left: 20, right: 20),
              child:
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
              margin: EdgeInsets.only(top: 100, left: 20, right: 20),       
                child:AnimatedTextKit(
                isRepeatingAnimation: true,
                animatedTexts: [

                TyperAnimatedText('Halo ${userData.getFullname()}',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                TyperAnimatedText('Welcome to Ramayana My Activity',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                TyperAnimatedText('Halo ${userData.getFullname()} ',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                TyperAnimatedText('Welcome to Ramayana My Activity',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                TyperAnimatedText('Halo ${userData.getFullname()}',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),
                TyperAnimatedText('Welcome to Ramayana My Activity',
                speed: Duration(milliseconds: 100),
                textStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)
                ),   
                ]
               ),
               ),

              Container(
              margin: EdgeInsets.fromLTRB(10, 195, 10, 0),
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
                       'assets/rama(C).png',
                        width: 180,
                       )
                      ],
                    ),   
                    ),
                    ],
                  ),
                ],
              )
              );
            });
          }
        }