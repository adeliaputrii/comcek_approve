
import 'package:flutter/services.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:http/http.dart' as http;
import 'package:myactivity_project/ramayana_history.dart';
import 'package:url_launcher/url_launcher.dart';  
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {


 
 GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final controller_nik = TextEditingController();
  final controller_fullname = TextEditingController();
  final controller_subdivisi = TextEditingController();
  final controller_date_visit = TextEditingController();
  final controller_location = TextEditingController();
  final controller_status = TextEditingController();
  final controller_description = TextEditingController();
  final controller_target = TextEditingController();
  final controller_stk_numbers = TextEditingController();
  final controller_data_gambar = TextEditingController();
  bool obscure=true;

  var dio = Dio();
  late Size ukuranLayar;
  var akses = 'usr';


  var selected;
  final List<String> data = [
    'Lajang',
    'Menikah',
    'Janda',
    'Duda'
  ];

   XFile? image;

  final ImagePicker picker = ImagePicker();

  //we can upload image from camera or from gallery based on parameter
  Future getImage(ImageSource media) async {
    var img = await picker.pickImage(source: media);

    setState(() {
      image = image;
    });
  }


  //show popup dialog
  void myAlertCamera() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(
              height: MediaQuery.of(context).size.height / 20,
              child: 
                  MaterialButton(
                    color: Color.fromARGB(255, 255, 17, 17),
                    //if user click this button. user can upload image from camera
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.camera);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.camera, color: Colors.white),
                        Text('From Camera', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
               
            ),
          );
        });
  }

  void myAlertGallery() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            title: Text('Please choose media to select'),
            content: Container(

              height: MediaQuery.of(context).size.height / 20,
              child: 
                  MaterialButton(
                    color: Color.fromARGB(255, 255, 17, 17),
                    //if user click this button, user can upload image from gallery
                    onPressed: () {
                      Navigator.pop(context);
                      getImage(ImageSource.gallery);
                    },
                    child: Row(
                      children: [
                        Icon(Icons.image, color: Colors.white),
                        Text('From Gallery', style: TextStyle(color: Colors.white),),
                      ],
                    ),
                  ),
                 
                
              
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        title: Text('Add Activity', style: TextStyle(fontSize: 23)),
        backgroundColor: Color.fromARGB(255, 255, 17, 17),
        elevation: 7.20  ,
          toolbarHeight: 90,
          
        ),   
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
              color: Color.fromARGB(255, 253, 249, 249)
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
              width: 500,
              height: 50,
              color: Color.fromARGB(255, 239, 237, 237),
             
            ),
             Container(
                    margin: EdgeInsets.fromLTRB(30, 30,30, 0),
              child:
              Text(
                    'Form Activity', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23, color: Colors.black),
                    ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(30, 100, 30, 0),
                child: 
                Form(
                  key: _formKey,
                  child: 
                ListView(

                children: <Widget>[
                  Text('NIK',
                  style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    controller: controller_nik,
                   keyboardType: TextInputType.number,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    validator: 
                      RequiredValidator(errorText: "Please Enter"),
                    cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 17
                          ),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            )
                          )
                    
                  ),
                 
                  SizedBox(
                    height: 20,
                    width: 20,
                    ),
                   Text('Full Name',
                  style: TextStyle(color: Color.fromARGB(255, 255, 17, 17),fontSize: 17, fontWeight: FontWeight.w500 ),
                  ),
                 TextFormField(
                    controller: controller_fullname,
                    validator: RequiredValidator(errorText: "Please Enter"),
                    cursorColor: Colors.black,
                          style: TextStyle(fontSize: 17),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            )
                          )
                    
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    ),
                     Text('Sub Divisi',
                  style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    controller: controller_subdivisi,
                    validator: RequiredValidator(errorText: "Please Enter"),
                    cursorColor: Colors.black,
                          style: TextStyle(fontSize: 17),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            )
                          )
                    
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    ),
                     Text('Date Visit',

                  style: TextStyle(color: Color.fromARGB(255, 255, 17, 17),fontSize: 17, fontWeight: FontWeight.w500 ),
                  ),
                  TextFormField(
                    controller: controller_date_visit,
                    validator: RequiredValidator(errorText: "Please Enter"),
                    cursorColor: Colors.black,
                          style: TextStyle(fontSize: 17),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            )
                          )
                    
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    ),
                     Text('Location',
                  style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
                  ),
                   SizedBox(
                    height: 20,
                    width: 20,
                    ),
                    TextFormField(
                    controller: controller_location,
                    validator: RequiredValidator(errorText: "Please Enter"),
                    cursorColor: Colors.black,
                          style: TextStyle(),
                          decoration: InputDecoration(
                             border: OutlineInputBorder(),
                    labelText: 'Search Location',
                    prefixIcon: Icon(Icons.search, 
                    color: Colors.black,),
                    
                    
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            )
                          )
                  ),
                   
                  
                  SizedBox(
                    height: 20,
                    width: 20
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                      
                  // Text('Status',
                  // style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), ),
                  // ),
                  // Flexible(child: 
                  // TextField(
                  //   controller: controller_status,
                  // ),
                  // ),
                    
                Container(
                  child: DropdownButton(
                    value: selected,
                    hint: Text('Status',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 17, 17),
                      
                      fontSize: 17, fontWeight: FontWeight.w500
                    ),
                    ),
                    onChanged: (value) {
                      print(value);
                      setState(() {
                        selected = value;
                      });
                    },
                    items: data
                    .map(
                      (e) => DropdownMenuItem(
                        
                        value: e,
                        child: Text(e, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500, color: Color.fromARGB(255, 255, 17, 17)),),
                      ),
                      )
                      .toList()
                    ),
                 
                ),
                ]
                ),
                  
                
                SizedBox(
                    height: 20,
                    width: 20,
                    ),
                  Text('Description',
                  style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    controller: controller_description,
                    validator: RequiredValidator(errorText: "Please Enter"),
                    cursorColor: Colors.black,
                          style: TextStyle(
                            fontSize: 15
                          ),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            )
                          )
                    
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    ),
                  Text('Target',
                  style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    controller: controller_target,
                    validator: RequiredValidator(errorText: "Please Enter"),
                    cursorColor: Colors.black,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            )
                          )
                    
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    ),
                    Text('STK NUMBERS',
                    
                  style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 15, fontWeight: FontWeight.w500),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                     inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    controller: controller_stk_numbers,
                    validator: RequiredValidator(errorText: "Please Enter"),
                    cursorColor: Colors.black,
                          style: TextStyle(fontSize: 15),
                          decoration: InputDecoration(
                            labelStyle: TextStyle(color: Colors.black),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            )
                          )
                    
                  ),
                  SizedBox(
                    height: 20,
                    width: 20,
                    ),
                  
                 Text(
                  'Upload Foto',
                  style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
                 ),

                 Container(

                 margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                        color: Color.fromARGB(255, 191, 183, 183),
                        borderRadius: BorderRadius.circular(5)
                        ),
                      child: IconButton(onPressed: () {
                        myAlertCamera();
                      }, 
                      icon: Icon(Icons.camera_alt),
                      ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 191, 183, 183),
                        borderRadius: BorderRadius.circular(5)
                        ),
                     child:  IconButton(onPressed: () {
                        myAlertGallery();
                      }, 
                      icon: Icon(Icons.photo,),
                      )
                  )
                    ],
                  ),
                 ),
                 Container(
                  
                 margin: EdgeInsets.only(top: 20, bottom: 20),
                  decoration: BoxDecoration( 
                   color: Color.fromARGB(255, 255, 17, 17),
                 //  borderRadius: BorderRadius.circular(20)
                  
                  ),
                
                  child: 

                  TextButton(child: 
                  Text('Submit',style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500, color: Colors.white),
                  
                  ),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return RamayanaHistory();
                    }));
                    DateTime now = new DateTime.now();
                    var formData = FormData.fromMap({
                      'nik': controller_nik.text,
                      'fullname': controller_fullname.text,
                      'subdivisi': controller_subdivisi.text,
                      'date_visit ': controller_date_visit.text,
                      'location': controller_location.text,
                      'status': controller_status.text,
                      'description': controller_description.text,
                      'target': controller_target.text,
                      'stk_numbers': controller_stk_numbers.text
                      // 'data_gambar': await MultipartFile.fromFile(
                      //   _image?.path,
                      //   filename: 'data_gambar${now.toString()}.png'
                      // ),
                    });
                    var response = await dio.post('http://ramayana.joeloecs.com/mobileapi/tambah_act.php',
                      data: formData
                    );
                    print('Berhasil, ${controller_nik.text}, ${controller_fullname.text}, ${controller_subdivisi.text}, ${controller_date_visit.text}, ${controller_location.text}, ${controller_status.text}, ${controller_description.text}, ${controller_target.text}, ${controller_stk_numbers.text}, ');
                  }
                  }
                  ),

                 )
                     
                  
                ],
              ),
                )
              )
          ]
          ),
    );
  }


DropdownMenuItem<String> buildMenuItem(String item) =>
  DropdownMenuItem(
    value: item,
    child: Text(
      item, 
      style: TextStyle(fontWeight: FontWeight.w500, fontSize: 13, color: Color.fromARGB(255, 255, 17, 17)),
    ),
  );


}