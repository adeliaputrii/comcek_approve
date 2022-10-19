import 'package:path/path.dart';
import 'package:relative_scale/relative_scale.dart';
import 'package:flutter/material.dart';
import 'package:myactivity_project/form_data_local.dart';
import 'package:myactivity_project/list_format.dart';
import 'package:myactivity_project/lokal_activity.dart';
import 'package:myactivity_project/lokal_list.dart';
import 'package:myactivity_project/ramayana_activity.dart';
import 'package:myactivity_project/ramayana_history.dart';
import 'package:myactivity_project/ramayana_login.dart';
import 'package:myactivity_project/ramayana_profile.dart';
import 'package:myactivity_project/ramayana_void.dart';
import 'package:myactivity_project/shopping.dart';

class Ramayana extends StatefulWidget {
  const Ramayana({super.key});

  @override
  State<Ramayana> createState() => _RamayanaState();
}

class _RamayanaState extends State<Ramayana> {

  bool _visible = false;

  @override
  Widget build(BuildContext context) {
    return RelativeBuilder(
      builder: (context, height, width, sy, sx) {
    return Scaffold(
      appBar: AppBar(
          title: Text('Dashboard', style: TextStyle(fontSize: 23),),
          backgroundColor: Color.fromARGB(255, 255, 17, 17),
          leading: Icon(Icons.home, size: 30,),
          elevation: 7.20  ,
          toolbarHeight: 90,
          actions: <Widget>[
            IconButton(
            icon: Icon(Icons.person, size: 30,
            color: Colors.white,),
            onPressed: () {
               Navigator.push(context, MaterialPageRoute(builder: (context){
                        return Profilee();
                      }));
            }
              ),
              IconButton(
            icon: Icon(Icons.power_settings_new_rounded, size: 30,) ,
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return RamayanaLogin();
              }));
              
            },
              ),
      
          ],
        ),
        body: Stack(
          
          children: <Widget>[
            Container(
              color: Colors.white,
            ),
              
            Container(
              height: 90,
              color: Color.fromARGB(255, 255, 17, 17),
            ),
            ListView(
              children: <Widget>[
              
              
            Container(
              margin: EdgeInsets.fromLTRB(10, 120, 10, 0),
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
              // width: 500,  
             
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

              
              AnimatedOpacity(
                opacity: _visible ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 500),
                child: Container(
                  margin: EdgeInsets.fromLTRB(20,200, 20, 0),
                  height: 95,
                 
                  
                  
                  decoration: BoxDecoration( 
                    borderRadius: BorderRadius.circular(5),
                     color: Color.fromARGB(255, 255, 17, 17),
                    // boxShadow: [BoxShadow(
                    //   color: Colors.black12,
                    //   spreadRadius: 7,
                    //   blurRadius: 7
                    // ),
                    // ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment:CrossAxisAlignment.center,
                      children: <Widget>[
                        Column( 
                    
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                          onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Activity();
                        }));
                          }, 
                          icon: Icon(
                            Icons.add_circle_rounded,
                            color: Colors.white,
                            size: 40,
                            ),
                          
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('ADD ACTIVITY', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),)
                        ],
                    ),
                    Column( 
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                          onPressed: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context){
                          return RamayanaHistory();
                        }));
                          }, 
                          icon: Icon(
                            Icons.file_copy,
                            color: Colors.white,
                            size: 40,                           
                            ),
                            
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('LIST ACTIVITY', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),)
                        ],
                    ), 
                    Column( 
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                          onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context){
                          return Void();
                        }));
                          }, 
                          icon: Icon(
                            Icons.backup_table,
                            color: Colors.white,
                            size: 40,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('VOID', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),)
                        ],
                    ),
              
                    Column( 
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            IconButton(
                          onPressed: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context){
                          return FormAct();
                        }));
                          }, 
                          icon: Icon(
                            Icons.dataset,
                            color: Colors.white,
                            size: 40,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Data Lokal', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),)
                        ],
                    )
                      ],
                      
                    ),
                    
                ),
              ),

              Container(
                 margin: EdgeInsets.fromLTRB(200, 30, 200, 20),
                height: 83,
                width: 83,
                // child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   children: <Widget>[

                 child: 
              Container(
               
                width: MediaQuery.of(context).size.width/6,
                height: MediaQuery.of(context).size.height/6,
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(70),
                  color: Color.fromARGB(255, 255, 17, 17),
                   ),
               
                child: 
              
                IconButton(
                  onPressed: () {
                     setState(() {
                      _visible = !_visible;
                    });
                  },
                  icon: Icon(Icons.menu_rounded,
                  color: Colors.white70,
                  size: 40,
                  ),
                )
              )
              // ],
              //   ),
              )
                
              

              ],
             ),
                Container(
                margin: EdgeInsets.fromLTRB(10, 40, 10, 100),
                height: 70,
                
                decoration: BoxDecoration( 
                  borderRadius: BorderRadius.circular(5),
                   color: Colors.white,
                  boxShadow: [BoxShadow(
                    color: Colors.black12,
                    spreadRadius: 7,
                    blurRadius: 7
                  ),
                  ]
                  ),
                  width: 500,
                  child: Container(
                    margin: EdgeInsets.fromLTRB(15, 24, 0, 0),
                    child: 
                  Text(
                    'Welcome, Adhelia Putri Wardhana in My Activity', style: TextStyle(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic, fontSize: 17, color: Colors.black),
                    ),
              ),
              ), 
          ]
        )
    );
      }
    );
  
  }
}