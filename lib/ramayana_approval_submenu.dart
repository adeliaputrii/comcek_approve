import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:myactivity_project/ramayana_approval.dart';
import 'package:myactivity_project/ramayana_approve_update.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_riwayat_update.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';

class RamayanaApprovalSubmenu extends StatefulWidget {
  const RamayanaApprovalSubmenu({super.key});

  @override
  State<RamayanaApprovalSubmenu> createState() => _RamayanaApprovalSubmenuState();
}

class _RamayanaApprovalSubmenuState extends State<RamayanaApprovalSubmenu> {

  UserData userData = UserData();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 255, 17, 17),
          elevation: 0  ,
          toolbarHeight: 1,
      ),

      body: 
      Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 190,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 17, 17),
             
                 boxShadow: [
              BoxShadow(color: Color.fromARGB(255, 190, 190, 190), spreadRadius: 5, blurRadius: 15)
            ],
              
            )
        ),

        Container(
          margin: EdgeInsets.only(left: 20, top: 40),
            child: Text('Menu Approval Return',
              style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w700)
            ),
        ),

        Container(
          margin: EdgeInsets.only(right: 0, top: 120, left: 10),
            child: 
            ListTile(
              trailing: Text('${userData.getFullname()} | ${userData.getUserToko()}',
               style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500)
              )
            )
        ),

      

          

        
          Container(
            margin: EdgeInsets.fromLTRB(30, 200, 30, 10),
            // color: Colors.green,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
               
              children: <Widget>[
                
                SizedBox(
                  height: 50,
                ),
                
                MaterialButton(
                  minWidth: 450,
                  height: 230,
                  color: Color.fromARGB(255, 239, 235, 235),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    // await fetchData();
                    // print('HARUS BISA YA ELAH');
                  Navigator.push(context, MaterialPageRoute(builder: (context){
                    return RamayanaApprovalReturn();
                  }));
                  },
                  child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.done_outline_outlined, 
                      size: 100,
                      color: Color.fromARGB(255, 255, 17, 17),
                      ),
                    
                    SizedBox(
                      height: 20,
                    ),
                   Text('Approval Return',
                   style: TextStyle(fontSize: 20, color: Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.bold),
                   )
                   ],
                  ),
                ),

                SizedBox(
                  height: 50,
                ),

               MaterialButton(
                  minWidth: 450,
                  height: 230,
                  color: Color.fromARGB(255, 239, 235, 235),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                  ),
                  onPressed: () {
                    // await fetchData();
                    // print('HARUS BISA YA ELAH');
                  // Navigator.push(context, MaterialPageRoute(builder: (context){
                  //   return RamayanaApprovalReturn();
                  // }));
                  },
                  child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(Icons.history, 
                      size: 100,
                      color: Color.fromARGB(255, 255, 17, 17),
                      ),
                    
                    SizedBox(
                      height: 20,
                    ),
                   Text('Riwayat Approval Return',
                   style: TextStyle(fontSize: 18, color: Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.bold),
                   )
                   ],
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                
             Container(
              margin: EdgeInsets.fromLTRB(0, 10, 0, 30),
               child: MaterialButton(
                
                     height: 65,
                   color: Color.fromARGB(255, 255, 17, 17),
                    shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                    ),
                    onPressed: () {
                      
                    Navigator.pushAndRemoveUntil(
                          context, MaterialPageRoute(builder: (context) => 
                          DefaultBottomBarController(child: Ramayana()),), 
                          (Route<dynamic> route) => false);},
                    
                    child: Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                         Icon(Icons.home, color: Colors.white, size: 30,),
                      
                      
                    Text('Home',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.w700))
                     ],
                    ),
                  ),
             ),
                
                // Container(
                //   child: MaterialButton(
                //     height: 70,
                //     minWidth: 70,
                //     onPressed: () {
                //       Navigator.pushAndRemoveUntil(
                //       context, MaterialPageRoute(builder: (context) => 
                //       DefaultBottomBarController(child: Ramayana()),), 
                //       (Route<dynamic> route) => false);},
                //     color: Color.fromARGB(255, 255, 17, 17),
                //     shape:RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(50),
                //     ),
                //     child: Icon(Icons.home,
                //       color: Colors.white,
                //       size: 30,),
                //   ),
                // ),
                
              ],
            ),
          ),

        
          
          
        ],
      ),
    );
  }
}