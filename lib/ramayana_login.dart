import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:myactivity_project/ramayana_forgotpass.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_profile.dart';
import 'package:myactivity_project/ramayana_signup.dart';
import 'package:dio/dio.dart';
import 'package:myactivity_project/ramayana_void.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/service/API_service/API_service.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:myactivity_project/service/service_api/auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:form_field_validator/form_field_validator.dart';  
import 'package:shared_preferences/shared_preferences.dart';
import 'package:motion_toast/motion_toast.dart';


class RamayanaLogin extends StatefulWidget {
  const RamayanaLogin({super.key});

  @override
  _RamayanaLogin createState() => _RamayanaLogin();
}

class _RamayanaLogin extends State<RamayanaLogin> {
   
GlobalKey<FormState> _formKey = GlobalKey<FormState>();
GlobalKey<FormState> _formKey2 = GlobalKey<FormState>();
  String _user_name = '';
  String _password = '';
   UserData userData = UserData();
  TextEditingController username = TextEditingController();
  TextEditingController pass = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController passwordReEnter = TextEditingController();
  
  void _displayCenterMotionToast() async {
    MotionToast(
      toastDuration: Duration(seconds: 4),
      icon: Icons.error,
      primaryColor: Colors.red,
      title: const Text(
        'Username/Password not found!',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17
        ),
      ),
      width: 350,
      backgroundType: BackgroundType.lighter,
      height: 100,
      description: const Text(
        'Please Check Again',
        style: TextStyle(
          fontSize: 15
        ),
      ),
      //description: "Center displayed motion toast",
      position: MotionToastPosition.center,
    ).show(context);
  }

   void _displayCenterMotionToastSuccess() {
    MotionToast(
      toastDuration: Duration(seconds: 10),
      icon: IconlyBold.tickSquare,
      primaryColor: Colors.green,
      title: const Text(
        "Success",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17
        ),
      ),
      width: 350,
      backgroundType: BackgroundType.lighter,
      height: 100,
      description: const Text(
        'You can login with a new password',
        style: TextStyle(
          fontSize: 15
        ),
      ),
      //description: "Center displayed motion toast",
      position: MotionToastPosition.top,
    ).show(context);
  }

  loginPressed() async {
    if (username.text.isNotEmpty && pass.text.isNotEmpty) {
      http.Response response = await AuthServices.login(username.text, pass.text);
      Map responseMap = jsonDecode(response.body);      
      if (responseMap['userpass'] == "0") {
         await userData.setUser(data: responseMap);
         SharedPreferences pref =await SharedPreferences.getInstance();
         pref.setString("username", "${userData.getUsernameID()}");
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DefaultBottomBarController(child: Ramayana()),), (Route<dynamic> route) => false);
        }
      else if (responseMap['userpass'] == "1") {
         AlertDialog popup = AlertDialog(
                             
                             shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                              shadowColor: Colors.black,
                              titlePadding: EdgeInsets.all(0),
                              title: 
                              
                              Column(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20),
                                        
                                      ),
                                      
                                    color:Color.fromARGB(255, 254, 234, 233)
                                    ),
                                    height: 190,
                                    width: 2000,
                                    child: 
                                          Image.asset(
                                          'assets/adel.png',
                                          // width: 20,
                                          // height: 1,
                                        )
                                        
                                      
                                     
                                  ),
                                    Container(
                                      margin: EdgeInsets.only(top: 0),
                                      color: Colors.black,
                                      height: 1,
                                     width: 2000,
                                    
                                    ),
                                ],
                              ),
                              content: 
                              Form(
                                key: _formKey2,
                                child: Container(
                                 
                                    height: 230,
                                  width: 500,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                     
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Password:',
                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                          ),
                                        SizedBox(
                                          height: 10,
                                         ),
                                      TextFormField(
                                         controller: password,
                                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                                       validator:(value){
                                                        if(value!.isEmpty){
                                                          return "Required";
                                                        }
                                                        if(value.length != 6){
                                                          return "Password length must be 6 characters";
                                                        }
                                                      
                                                        if(!value.contains(RegExp(r'[0-9]'))){
                                                          return "Password must contain a number";
                                                            }

                                                        if(
                                                          
                                                          value == username.text){
                                                          return "Password can't same with username";
                                                            }
                                                          },
                                                     
                                                      obscureText: true,
                                                      keyboardType: TextInputType.number,
                                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                        color: Colors.black, 
                                                          width: 5.0),
                                                         borderRadius: BorderRadius.circular(60)
                                                          ),
                                                          
                                                        errorBorder: OutlineInputBorder( borderSide: BorderSide(color: Color.fromARGB(255, 255, 17, 17),), borderRadius: BorderRadius.circular(60)),
                                                        errorStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 14, fontWeight: FontWeight.w400),
                                                          labelStyle: TextStyle(
                                                          color: Colors.black87
                                                        ),
                                                        prefixIcon: Icon(
                                                          IconlyBroken.lock,
                                                          color: Color.fromARGB(255, 255, 17, 17),
                                                        ),
                                                        //  hintText: 'Password', 
                                                        hintStyle: TextStyle(
                                                          color:  Colors.black,
                                                          fontSize: 20
                                                        ),
                                                        enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(60)),
                                                       focusedBorder: OutlineInputBorder(
                                                      borderSide: new BorderSide(color: Colors.black),
                                                          borderRadius: BorderRadius.circular(60)
                                                           )
                                                      )      
                                      ),
                                       ],
                                      ),
                                   
                                       Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                         children: [
                                           Text(
                                            'Re-Enter Password:',
                                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                                      ),
                                         SizedBox(
                                          height: 10,
                                         ),
                                      TextFormField(
                                         controller: passwordReEnter,
                                                      style: TextStyle(fontSize: 20, color: Colors.black),
                                                       validator: (value) {
                                                       if(value!.isEmpty){
                                                          return "Required";
                                                        }
                                                      
                                                        if(!value.contains(RegExp(r'[0-9]'))){
                                                          return "Password must contain a number";
                                                            }

                                                        if(value != password.text){
                                                          return "Please Re-Enter password correctly";
                                                            }
                                                          
                                                       },
                                                      obscureText: true,
                                                      keyboardType: TextInputType.number,
                                                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(
                                                          borderSide: BorderSide(
                                                        color: Colors.black, 
                                                          width: 5.0),
                                                          borderRadius: BorderRadius.circular(60)
                                                          ),
                                                          
                                                        errorBorder: OutlineInputBorder( borderSide: BorderSide(color: Color.fromARGB(255, 255, 17, 17),), borderRadius: BorderRadius.circular(60)),
                                                        errorStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 14, fontWeight: FontWeight.w400),
                                                        labelStyle: TextStyle(
                                                        color: Colors.black87
                                                        ),
                                                        prefixIcon: Icon(
                                                          IconlyBroken.lock,
                                                          color: Color.fromARGB(255, 255, 17, 17),
                                                        ),
                                                        
                                                        hintStyle: TextStyle(
                                                          color:  Colors.black,
                                                          fontSize: 20
                                                        ),
                                                        enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(60)),
                                                       focusedBorder: OutlineInputBorder(
                                                        borderRadius: BorderRadius.circular(60),
                                                     borderSide: new BorderSide(color: Colors.black),
                                                           )
                                                      )      
                                      )
                                     
                                      ],
                                       ),
                                    ],
                                  ),
                                ),
                              ),
                              //terdapat 2 button.
                              //jika ya maka jalankan _deleteKontak() dan tutup dialog
                              //jika tidak maka tutup dialog
                              actions: [ 
                               //button buat reset
                                Container(
                                  margin: EdgeInsets.only(left: 20),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(left: 80, right: 80),
                                        child: MaterialButton(
                                          height: 40,
                                          padding: EdgeInsets.symmetric(horizontal: 80),
                                          shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(40),
                                            ),
                                          color: Color.fromARGB(255, 255, 17, 17),
                                          child: Text('Submit',
                                              style: TextStyle(
                                              color:  Colors.white, fontWeight: FontWeight.w500, fontSize: 17)),
                                          onPressed: () async {
                                              if (_formKey2.currentState!.validate()) {
                                              _displayCenterMotionToastSuccess();
                                             var formData = FormData.fromMap({
                                            'user_name': username.text,
                                            'password': password.text,
                                           // 're-enter': passwordReEnter.text,
                                         });
                                          var response = await dio.post('https://android-api.ramayana.co.id:8304/api/v1/auth/reset.password',
                                            data: formData
                                          );
                                          print('Berhasil, ${username.text}, ${password.text},${password.text}, ${passwordReEnter.text}');
                                          Duration(seconds: 10);
                                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RamayanaLogin(),), (Route<dynamic> route) => false);
                                              }
                                             }
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                   
                                                              Text('Note : ',
                                                               style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                    ),
                                     Text( 'Password baru tidak boleh sama dengan username',
                                                               style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                                    ),    
                                   ],
                                  ),
                                ),  
                              ],
                              actionsAlignment: MainAxisAlignment.start,
                              actionsPadding: EdgeInsets.only(bottom: 30),
                              
                            );
                            showDialog(
                                context: context, builder: (context) => popup);
      } else  {
        _displayCenterMotionToast();
      }
    }
  }
   var dio = Dio();
void showWarning(){
   //do something if username or password isn't filled correctly
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: 2000,
            height: 2000,
            // color: Colors.green,
            child: Image.asset(
                  "assets/rmy.jpeg",
                  // height: 200,
                   fit: BoxFit.cover,
                   
            )
          ),
          Form(
            key: _formKey,
            child: ListView(
              children: [
            Container(
              margin: EdgeInsets.fromLTRB(20, 100, 20, 0),
              height: 450,
              
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white70
              ),
               child: Column(
                 children: <Widget>[
          
                   Container(
               margin: EdgeInsets.only(top: 40),
               height: 130,
               
               child:Image.asset(
                     "assets/ramay.png",
                     height: 180,
               )
            ),
            SizedBox(height: 50,),
          
                       Container(
                         margin: EdgeInsets.only(left: 10, right: 20),
                         child:
                             TextFormField(
                               cursorColor: Colors.black,
                                 controller: username,
                      //      onChanged: (value) {
                      //    _user_name = value;
                      //  },
                       validator: RequiredValidator(errorText: 'Please Enter'),
                //     validator: (value) {
                //      if(value!.isEmpty){
                //      return "Required";
                //    }
                //  },
                        //  validator: (value) {
                        //      if (value != '${userData.getUsernameID()}') {
                        //        return 'Enter valid username';
                       
                        //      }
                         //   },
                         // validator: MultiValidator([
                         //   validator: (value) {
                         //     if (value != '${userData.getUsernameID()}') {
                         //       return 'Enter valid username';
                       
                         //     }
                         //   },
                           
          
                         
                         keyboardType: TextInputType.multiline,
                         style: TextStyle(fontSize: 20, color: Colors.black),
                         decoration: InputDecoration(  
                         border: OutlineInputBorder(
                         borderSide: BorderSide(
                         color: Colors.black, 
                             width: 5.0),
                             borderRadius: BorderRadius.circular(25),
                             ),
                           errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: Color.fromARGB(255, 255, 17, 17),)),
                           errorStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 14, fontWeight: FontWeight.w400),
                          labelStyle: TextStyle(
                           color: Colors.black
                           ),
          
                           prefixIcon: Icon(
                             Icons.person,
                             color: Color.fromARGB(255, 255, 17, 17),
                             size: 30,
                           ),
                           hintText: 'Username', 
                           hintStyle: TextStyle(
                             color:  Colors.black,
                             fontSize: 20
                           ),
                              enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black), borderRadius:  BorderRadius.circular(25)),
                              focusedBorder: OutlineInputBorder(
                                 borderSide: new BorderSide(color: Colors.black),
                                 borderRadius:  BorderRadius.circular(25)
                              )
                         ),
                       ),       
                     ),    
                       
                   SizedBox(height: 30),
          
                        //  popupin()async{
                   Container(
               margin: EdgeInsets.only(left: 10, right: 20),
               child: 
                    TextFormField(
                        controller: pass,
                         style: TextStyle(fontSize: 20, color: Colors.black),
                               validator: (value) {
                    
                       if(value!.isEmpty){
                     return "Please Enter";
                   } },
                        obscureText: true,
                         keyboardType: TextInputType.multiline,
                         decoration: InputDecoration(
                           border: OutlineInputBorder(
                             borderSide: BorderSide(
                           color: Colors.black, 
                             width: 5.0),
                             borderRadius: BorderRadius.circular(25),
                             ),
                             
                           errorBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(25), borderSide: BorderSide(color: Color.fromARGB(255, 255, 17, 17),)),
                           errorStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 14, fontWeight: FontWeight.w400),
                                labelStyle: TextStyle(
                               color: Colors.black87
                           ),
                           prefixIcon: Icon(
                             Icons.lock,
                             color: Color.fromARGB(255, 255, 17, 17),
                           ),
                            hintText: 'Password', 
                           hintStyle: TextStyle(
                             color:  Colors.black,
                             fontSize: 20
                           ),
                           enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black), borderRadius:  BorderRadius.circular(25)),
                          focusedBorder: OutlineInputBorder(
                                 borderSide: new BorderSide(color: Colors.black),
                                 borderRadius:  BorderRadius.circular(25)
                              )
                         )      
                         ),
                       ),
                  
                 ],
               )
              ),
              
            Column(
              children: <Widget>[
              
                   SizedBox(height: 20),
          
                    FittedBox(
                    fit: BoxFit.fill,
                    child: Row(
                      children: [
                       
                        // button login
                       MaterialButton(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    height: 40,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18
                      ),
                    ),
                    color: Colors.red, 
                         onPressed: () async {
                           if (_formKey.currentState!.validate()) {
                            await loginPressed();
                            print('huhu'); 
                           } 
                         
                          //  }
                           
                          // else {
                          //    await loginPressed();
                          //   print('huhu'); 
     
                          // }
    
                         
                         }
                        )
                      ],
                    ),
                  ),
                
                //   TextButton(
                //   onPressed: () {
                //     Navigator.push(context, MaterialPageRoute(builder: (context){
                //       return ForgotPass();
                //     }));
                //   },
                //   child: Text(
                //     'Forgot Pasword ?',
                //     style: TextStyle(
                //       fontSize: 17,
                //       color: Colors.white,
                //     ),
                //   ),
                // ),
                  SizedBox(
                    height: 70,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: <Widget>[
                      Text('Version 2.2.1 Copyright EDP',
                      style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                      Icon(Icons.copyright,
                        color: Colors.white,
                        size: 18,
                        ),
                       Text(
                          '2022',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Colors.white),
                         )
                         
                    ],
                  )
            ],)
                ],
            ),
          ),

        ],
      ),
    );
  }
}