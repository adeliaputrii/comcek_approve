import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_profile.dart';
import 'package:myactivity_project/ramayana_signup.dart';
import 'package:dio/dio.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/service/API_service/API_service.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:form_field_validator/form_field_validator.dart';  

class RamayanaLogin extends StatefulWidget {
  @override
  _RamayanaLogin createState() => _RamayanaLogin();
}

class _RamayanaLogin extends State<RamayanaLogin> {

    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final controller_username = TextEditingController();
    final controller_password = TextEditingController();
    var dio = Dio();

  UserData userData = UserData();

  Future<void> fetchUser() async {
    print('onta');
    APIUserService apiUserService = APIUserService();
    // ignore: unnecessary_null_comparison
    if (controller_username.text == null ||
        controller_username.text == '' ||
        controller_password.text == null ||
        controller_password.text == '') {
      showWarning();
      return;
    }
    var result = await apiUserService.loginUser(
        user: controller_username.text, pass: controller_password.text);
print('jogja hebat');
    switch (result) { 
      case 0:
        if (userData.getAdminStatus()) {
          print('kamalud');
      print('saipul jamil');
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => Profilee()),
              (Route<dynamic> route) => false);
              print('masuk ke sini profile');
        } else {
          print('steven willi');
          Navigator.of(context).pushAndRemoveUntil(
              //Client
              MaterialPageRoute(builder: (context) => Ramayana()),
              (Route<dynamic> route) => false);
              print('masuk ke sini ramayana');
        }

        break;
   case 1:
   controller_username.clear();
   controller_password.clear();
   
   setState(() { 
   });
   //Invalid Account

   break;
   case 3:
   //network error

   break;
   default:
   break;
  }
  }


void showWarning(){
   //do something if username or password isn't filled correctly
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // height: 900,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 168, 3, 3),
            ),
          ),
          ListView(
            children: [
          
          Container(
            margin: EdgeInsets.fromLTRB(20, 120, 20, 0),
            height: 200,
            width: 400,
            
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "assets/ram.png",
                  height: 190,
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 60, 20, 0),
             child: Form(
                  key: _formKey,
            child: 
            
            Column(
              children: <Widget>[
                TextFormField(
                  cursorColor: Colors.white,
                      controller: controller_username,
                      validator: (value) {
                            if (value != 'jogjatim') {
                              return 'Enter valid username';
                            }
                            return null;
                          },
                      keyboardType: TextInputType.multiline,
                      style: TextStyle(fontSize: 20, color: Colors.white),
                      decoration: InputDecoration( 
                      errorBorder: UnderlineInputBorder(borderSide: new BorderSide(color: Colors.white)),
                        errorStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                      labelStyle: TextStyle(
                      color: Colors.white
                        ),

                        prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                        ),
                        hintText: 'Username', 
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                        enabledBorder: UnderlineInputBorder(borderSide: new BorderSide(color: Colors.white)),
                        focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                            )
                      ),
                    ),
                            
                          
                    
                  
                SizedBox(height: 30),
                 TextFormField(
                      controller: controller_password,
                      cursorColor: Colors.white,
                      style: TextStyle(fontSize: 20, color: Colors.white,),
                      validator: (value) {
                            if (value != 'jogjatim') {
                              return 'Enter valid password';
                            } 
                            return null;
                          },
                      obscureText: true,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                        errorBorder: UnderlineInputBorder(borderSide: new BorderSide(color: Colors.white)),
                        errorStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                             labelStyle: TextStyle(
                            color: Colors.white
                        ),
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.white,
                          size: 30,
                        ),
                         hintText: 'Password', 
                        hintStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                        ),
                        enabledBorder: UnderlineInputBorder(borderSide: new BorderSide(color: Colors.white)),
                       
                        focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.white),
                            )
                      ),
                    ),
                SizedBox(height: 40),
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
                 SizedBox(height: 10),
                MaterialButton(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
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
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.white,
                            content: Text(
                              'Validation Successful',
                              style: TextStyle(
                                  color: Colors.black,
                              ),
                            ),
                          ),
                      );
           await fetchUser();
           print('huhu'); 
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: Colors.white,
                            content: Text(
                              'Please check again',
                              style: TextStyle(
                                  color: Colors.black,
                              ),
                            ),
                          ),
                      );
                        }
                      }
                ),
                SizedBox(height: 10),
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
                        style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                       )
                       )
                  ],
                ),
                )
              ],
            ),
             )
            )
            
          
              ],
          ),

        ],
      ),
    );
  }
}