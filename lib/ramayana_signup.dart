import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_login.dart';
// import 'package:form_field_validator/form_field_validator.dart';  

class RamayanaSignup extends StatefulWidget {
  @override
  _RamayanaSignup createState() => _RamayanaSignup();
}

class _RamayanaSignup extends State<RamayanaSignup> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final controller_username = TextEditingController();
  final controller_email = TextEditingController();
  final controller_nomor = TextEditingController();

  Future sendEmail() async{
    final url = Uri.parse("https://api.emailjs.com/api/v1.0/email/send");
    const serviceId = "service_cfnvq19";
    const templateId = "template_1537ydx";
    const userId = "HgM5nYzs8tKFD0136";
    final response = await http.post(url,
    headers: {'Content-Type': 'application/json', 'origin': 'http://localhost'},
    body: json.encode({
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'name': controller_username.text,
        'email': controller_email.text,
        'nomor': controller_nomor.text,
      }
    })
    );
    return response.statusCode;
  }

  var dio = Dio();
  late Size ukuranlayar;
  var akses = 'usr';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: 1000,
            height: 2000,
            color: Colors.green,
            child: Image.asset(
             "assets/rmy.jpeg",
              fit: BoxFit.cover,   
            )
          ),

          ListView(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(20, 120, 20, 0),
                height: 200,
                width: 400,
                child:
                 Column(
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
                margin: EdgeInsets.fromLTRB(20, 50, 20, 0),
                child:
                Form(
                  key: _formKey,
                  child: 
                    Column(
                      children: <Widget>[

                      TextFormField(
                      cursorColor: Colors.white,
                      controller: controller_username,
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
                      cursorColor: Colors.white,
                      controller: controller_email,
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
                        hintText: 'Email', 
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
                          controller: controller_nomor,
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                          errorBorder: UnderlineInputBorder(borderSide: new BorderSide(color: Colors.white)),
                          errorStyle: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w400),
                          labelStyle: TextStyle(
                          color: Colors.white
                        ) ,
                          prefixIcon: Icon(
                          Icons.person,
                          color: Colors.white,
                          size: 30,
                          ),
                          hintText: 'No.Handphone', 
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

                          MaterialButton(
                          padding: EdgeInsets.symmetric(horizontal: 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Text(
                          'Sign Up',
                          style: TextStyle(
                          fontSize: 17,
                          color: Colors.white,
                          ),
                        ),
                          color: Colors.red,
                          onPressed: () async {
                            sendEmail();
                            if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.white,
                                content: Text(
                                  'Coba Cek Email Anda',
                                  style: TextStyle(
                                  color: Colors.black,
                                ),
                             ),
                            ),
                          );
                        DateTime now = new DateTime.now();
                        print('Berhasil, ${controller_username.text}, ${controller_email.text}, ${controller_nomor.text}');
                        Navigator.push(context,
                          MaterialPageRoute(
                          builder: (context) {
                          return RamayanaLogin();
                          } ));
                      };
                      }
                    ),
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
