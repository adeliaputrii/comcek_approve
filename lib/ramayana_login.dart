import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:motion_toast/resources/arrays.dart';
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
  String _user_name = '';
  String _password = '';
  static UserData userData = UserData();

 
  void _displayCenterMotionToast() {
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

  loginPressed() async {
    if (_user_name.isNotEmpty && _password.isNotEmpty) {
      // SharedPreferences pref = await SharedPreferences.getInstance();
      // pref.setString("username", "$user_name");
      http.Response response = await AuthServices.login(_user_name, _password);
      Map responseMap = jsonDecode(response.body);
      if (responseMap['status'] == 200) {
        
         await userData.setUser(data: responseMap);
         SharedPreferences pref =await SharedPreferences.getInstance();
         pref.setString("username", "${userData.getUsernameID()}");
      //   Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
      //   return DefaultBottomBarController(child: Ramayana());
      //  }));
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DefaultBottomBarController(child: Ramayana()) ), ModalRoute.withName('/'),); 
         Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => DefaultBottomBarController(child: Ramayana()),), (Route<dynamic> route) => false);
        //  Navigator.
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (BuildContext context) => DefaultBottomBarController(child: Ramayana(),))
            // );
      } 
      else {
      _displayCenterMotionToast();
      
      }
    }
  }

    
//     final controller_username = TextEditingController();
//     final controller_password = TextEditingController();
//     var dio = Dio();


//    UserData userData = UserData();
 
// //  Future<String> _getUsername() async {
// //   UserData userData = UserData();
// //    await userData.getPref();
// //   String username = userData.getUsernameID();

// //   return username;
// //  }
  
// //  Future<String> _getPassword() async {
// //   UserData userData = UserData();
// //    await userData.getPref();
// //   String password = userData.getUserPassword();

// //   return password;
// //  }

// //  String user = '';
// //   String pass = '';

//   Future<void> fetchUser() async {
//     print('onta');
//     APIUserService apiUserService = APIUserService();
//     // ignore: unnecessary_null_comparison
//     if (controller_username.text == null ||
//         controller_username.text == '' ||
//         controller_password.text == null ||
//         controller_password.text == '') {
//       showWarning();
//       return;
//     }
//     var result = await apiUserService.loginUser(
//         user_name: controller_username.text, password: controller_password.text);
// print('jogja hebat');
//     switch (result) { 
//       case 0:
//         if (userData.getAdminStatus()) {
//           print('kamalud');
//       print('saipul jamil');
//           Navigator.of(context).pushAndRemoveUntil(
//               MaterialPageRoute(builder: (context) => Profilee()),
//               (Route<dynamic> route) => false);
//               print('masuk ke sini profile');
//         } else {
//           print('steven willi');
//           Navigator.of(context).pushAndRemoveUntil(
//               //Client
//               MaterialPageRoute(builder: (context) => DefaultBottomBarController(child: Ramayana())),
//               (Route<dynamic> route) => false);
//               print('masuk ke sini ramayana');
//         }

//         break;
//    case 1:
//    controller_username.clear();
//    controller_password.clear();
   
//    setState(() { 
//    });
//    //Invalid Account

//    break;
//    case 3:
//    //network error

//    break;
//    default:
//    break;
//   }
//   }


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
          ListView(
            children: [
          Container(
            margin: EdgeInsets.fromLTRB(20, 100, 20, 0),
            height: 450,
            
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white70
            ),
             child: Form(
                  key: _formKey,
            child: 
            
            Column(
              children: <Widget>[

                Container(
            margin: EdgeInsets.only(top: 40),
            height: 130,
            
            child:Image.asset(
                  "assets/ram.png",
                  height: 200,
            )
          ),
          SizedBox(height: 50,),

                    Container(
                      margin: EdgeInsets.only(left: 10, right: 20),
                      child:
                          TextFormField(
                            cursorColor: Colors.black,
                              // controller: controller_username,
                        onChanged: (value) {
                      _user_name = value;
                    },
                   validator: RequiredValidator(errorText: "Please Enter"),
                      // validator: (value) {
                      //     if (value != '${userData.getUsernameID()}') {
                      //       return 'Enter valid username';
                    
                      //     }
                      //   },
                      // validator: MultiValidator([
                        // validator: (value) {
                        //   if (value != '${userData.getUsernameID()}') {
                        //     return 'Enter valid username';
                    
                        //   }
                        // },
                        

                      
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

                Container(
            margin: EdgeInsets.only(left: 10, right: 20),
            child: 
                 TextFormField(
                    onChanged: (value) {
                      _password = value;
                    },
                    //  controller: controller_password,
                      style: TextStyle(fontSize: 20, color: Colors.black),
                      validator: RequiredValidator(errorText: "Please Enter"),
                      // validator: (value) {
                      //     if (value != '${userData.getUserPassword()}') {
                      //       return 'Enter valid password';
                      //     }
                      //   },
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
            ),
            
             )
            ),
            
          Column(
            children: <Widget>[
              
                 SizedBox(height: 10),

                
                      MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 200),
                  height: 40,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    'Sign In',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17
                    ),
                  ),
                  color: Colors.red, 
                       onPressed: () async {
                       
                        if (_formKey.currentState!.validate()) {
                          await loginPressed();
                          print('huhu'); 
                        
                        }
                        
                       }
                ),
               
              
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Pasword ?',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(50, 0, 50, 0),
                  child: 
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: <Widget>[
                    Text('Belum Punya Akun?',
                    style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.w400),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return RamayanaSignup();
                        }));
                      },
                       child: Text(
                        'Daftar',
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 255, 17, 17)),
                       )
                       )
                  ],
                ),
                )
          ],)
              ],
          ),

        ],
      ),
    );
  }
}