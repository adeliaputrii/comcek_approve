// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:myactivity_project/database/db.dart';
// import 'package:url_launcher/url_launcher.dart'; 
// import 'package:flutter/services.dart';
// import 'package:dio/dio.dart';
// import 'package:myactivity_project/db.dart';
// import 'package:myactivity_project/list_format.dart';
// import 'package:myactivity_project/models/models_form.dart';
// import 'package:myactivity_project/ramayana_home.dart';
// import 'package:form_field_validator/form_field_validator.dart';
// import 'package:image_picker/image_picker.dart';

// class FormAct extends StatefulWidget {
//   final Activityy? activityy;

//   FormAct({this.activityy});

//   @override
//   _FormActState createState() => _FormActState();
// }

// class _FormActState extends State<FormAct> {
//   DbHelper db = DbHelper();

//    GlobalKey<FormState> _formKey = GlobalKey<FormState>();
//   TextEditingController? id_act;
//   TextEditingController? nik;
//   TextEditingController? fullname;
//   TextEditingController? subdivisi;
//   TextEditingController? location;
//   TextEditingController? status;
//   TextEditingController? description;
//   TextEditingController? target;
//   TextEditingController? dateVisit;
//   TextEditingController? stkNumbers;

//   @override
//   void initState() {
//     nik = TextEditingController(
//         text: widget.activityy == null ? '' : widget.activityy!.nik);

//     fullname = TextEditingController(
//         text: widget.activityy == null ? '' : widget.activityy!.fullname);

//     subdivisi = TextEditingController(
//         text: widget.activityy == null ? '' : widget.activityy!.subdivisi);

//     location = TextEditingController(
//         text: widget.activityy == null ? '' : widget.activityy!.location);

//     status = TextEditingController(
//         text: widget.activityy == null ? '' : widget.activityy!.status);

//     description = TextEditingController(
//         text: widget.activityy == null ? '' : widget.activityy!.description);

//     target = TextEditingController(
//         text: widget.activityy == null ? '' : widget.activityy!.target);

//     dateVisit = TextEditingController(
//         text: widget.activityy == null ? '' : widget.activityy!.dateVisit);

//     stkNumbers = TextEditingController(
//         text: widget.activityy == null ? '' : widget.activityy!.stkNumbers);

//     super.initState();
//   }

//    XFile? image;

//   final ImagePicker picker = ImagePicker();

//   //we can upload image from camera or from gallery based on parameter
//   Future getImage(ImageSource media) async {
//     var img = await picker.pickImage(source: media);

//     setState(() {
//       image = image;
//     });
//   }


//   //show popup dialog
//   void myAlertCamera() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             title: Text('Please choose media to select'),
//             content: Container(
//               height: MediaQuery.of(context).size.height / 18,
//               child: 
//                   MaterialButton(
//                     color: Color.fromARGB(255, 255, 17, 17),
//                     //if user click this button. user can upload image from camera
//                     onPressed: () {
//                       Navigator.pop(context);
//                       getImage(ImageSource.camera);
//                     },
//                     child: Row(
//                       children: [
//                         Icon(Icons.camera, color: Colors.white),
//                         Text('From Camera', style: TextStyle(color: Colors.white)),
//                       ],
//                     ),
//                   ),
               
//             ),
//           );
//         });
//   }

//   void myAlertGallery() {
//     showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             title: Text('Please choose media to select'),
//             content: Container(

//               height: MediaQuery.of(context).size.height / 20,
//               child: 
//                   MaterialButton(
//                     color: Color.fromARGB(255, 255, 17, 17),
//                     //if user click this button, user can upload image from gallery
//                     onPressed: () {
//                       Navigator.pop(context);
//                       getImage(ImageSource.gallery);
//                     },
//                     child: Row(
//                       children: [
//                         Icon(Icons.image, color: Colors.white),
//                         Text('From Gallery', style: TextStyle(color: Colors.white),),
//                       ],
//                     ),
//                   ),
                 
                
              
//             ),
//           );
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      appBar: AppBar(
//         title: Text('Add Activity', style: TextStyle(fontSize: 23)),
//         backgroundColor: Color.fromARGB(255, 255, 17, 17),
//         elevation: 7.20  ,
//           toolbarHeight: 90,
//           actions: <Widget>[
//             IconButton(onPressed: () {
//               Navigator.push(context, MaterialPageRoute(builder: ((context) {
//                 return ListActivityPage();
//               })));
//             }, 
//             icon: Icon(Icons.list,
//             size: 35,
//             )
//             )
//           ],
//         ),  
//       body: Stack(
//         children: <Widget>[
//           Container(
//               margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
//               color: Color.fromARGB(255, 253, 249, 249)
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
//               width: 500,
//               height: 50,
//               color: Color.fromARGB(255, 239, 237, 237),
             
//             ),
//           Container(
//                     margin: EdgeInsets.fromLTRB(30, 30,30, 0),
//               child:
//               Text(
//                     'Form Activity', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 23, color: Colors.black),
//                     ),
//               ),
//        Container(
//                 margin: EdgeInsets.fromLTRB(30, 100, 30, 0),
//                 child: 
//                 Form(
//                   key: _formKey,
//                   child: 
//       ListView(
//         // padding: EdgeInsets.all(2.0),
//         children: [
//            Text('NIK',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
//                   ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 1,
//             ),
//             child:  TextFormField(
//                   controller: nik,
//                    keyboardType: TextInputType.number,
//                     validator: 
//                       RequiredValidator(errorText: "Please Enter"),
//                     cursorColor: Colors.black,
//                           style: TextStyle(
//                             fontSize: 17
//                           ),
//                           decoration: InputDecoration(
//                             labelStyle: TextStyle(color: Colors.black),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: new BorderSide(color: Colors.black),
//                             )
//                           )
//             )
//           ),
//           SizedBox(
//                     height: 20,
//                     width: 20,
//                     ),

//            Text('Fullname',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
//                   ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 20,
//             ),
//             child: TextFormField(
//                   controller: fullname,
//                    keyboardType: TextInputType.multiline,
//                     validator: 
//                       RequiredValidator(errorText: "Please Enter"),
//                     cursorColor: Colors.black,
//                           style: TextStyle(
//                             fontSize: 17
//                           ),
//                           decoration: InputDecoration(
//                             labelStyle: TextStyle(color: Colors.black),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: new BorderSide(color: Colors.black),
//                             )
//                           )
//             )
//           ),
//           SizedBox(
//                     height: 20,
//                     width: 20,
//                     ),

//            Text('Subdivisi',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
//                   ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 20,
//             ),
//             child: TextFormField(
//                   controller: subdivisi,
//                    keyboardType: TextInputType.multiline,
//                     validator: 
//                       RequiredValidator(errorText: "Please Enter"),
//                     cursorColor: Colors.black,
//                           style: TextStyle(
//                             fontSize: 17
//                           ),
//                           decoration: InputDecoration(
//                             labelStyle: TextStyle(color: Colors.black),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: new BorderSide(color: Colors.black),
//                             )
//                           )
//             )
//           ),
//           SizedBox(
//                     height: 20,
//                     width: 20,
//                     ),

//            Text('Date Visit',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
//                   ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 20,
//             ),
//             child: TextFormField(
//                   controller: dateVisit,
//                    keyboardType: TextInputType.multiline,
//                     validator: 
//                       RequiredValidator(errorText: "Please Enter"),
//                     cursorColor: Colors.black,
//                           style: TextStyle(
//                             fontSize: 17
//                           ),
//                           decoration: InputDecoration(
//                             labelStyle: TextStyle(color: Colors.black),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: new BorderSide(color: Colors.black),
//                             )
//                           )
//             )
//           ),
//           SizedBox(
//                     height: 20,
//                     width: 20,
//                     ),

//            Text('Location',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
//                   ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 20,
//             ),
//             child: TextFormField(
//                   controller: location,
//                    keyboardType: TextInputType.multiline,
//                     validator: 
//                       RequiredValidator(errorText: "Please Enter"),
//                     cursorColor: Colors.black,
//                           style: TextStyle(
//                             fontSize: 17
//                           ),
//                            decoration: InputDecoration(
//                              border: OutlineInputBorder(),
//                     labelText: 'Search Location',
//                     prefixIcon: Icon(Icons.search, 
//                     color: Colors.black,),
                    
                    
//                             labelStyle: TextStyle(color: Colors.black),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: new BorderSide(color: Colors.black),
//                             )
//                           )
//             )
//           ),
//           SizedBox(
//                     height: 20,
//                     width: 20,
//                     ),

//            Text('Status',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
//                   ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 20,
//             ),
//             child: TextFormField(
//                   controller: status,
//                    keyboardType: TextInputType.multiline,
//                     validator: 
//                       RequiredValidator(errorText: "Please Enter"),
//                     cursorColor: Colors.black,
//                           style: TextStyle(
//                             fontSize: 17
//                           ),
//                           decoration: InputDecoration(
//                             labelStyle: TextStyle(color: Colors.black),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: new BorderSide(color: Colors.black),
//                             )
//                           )
//             )
//           ),
//           SizedBox(
//                     height: 20,
//                     width: 20,
//                     ),

//            Text('Description',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
//                   ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 20,
//             ),
//             child:TextFormField(
//                   controller: description,
//                    keyboardType: TextInputType.multiline,
//                     validator: 
//                       RequiredValidator(errorText: "Please Enter"),
//                     cursorColor: Colors.black,
//                           style: TextStyle(
//                             fontSize: 17
//                           ),
//                           decoration: InputDecoration(
//                             labelStyle: TextStyle(color: Colors.black),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: new BorderSide(color: Colors.black),
//                             )
//                           )
//             )
//           ),
//           SizedBox(
//                     height: 20,
//                     width: 20,
//                     ),

//            Text('Target',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
//                   ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 20,
//             ),
//             child: TextFormField(
//                   controller: target,
//                    keyboardType: TextInputType.multiline,
//                     validator: 
//                       RequiredValidator(errorText: "Please Enter"),
//                     cursorColor: Colors.black,
//                           style: TextStyle(
//                             fontSize: 17
//                           ),
//                           decoration: InputDecoration(
//                             labelStyle: TextStyle(color: Colors.black),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: new BorderSide(color: Colors.black),
//                             )
//                           )
//             )
//           ),
//           SizedBox(
//                     height: 20,
//                     width: 20,
//                     ),

//            Text('STK Numbers',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
//                   ),
//           Padding(
//             padding: const EdgeInsets.only(
//               top: 20,
//             ),
//             child: TextFormField(
//                   controller: stkNumbers,
//                    keyboardType: TextInputType.number,
//                     validator: 
//                       RequiredValidator(errorText: "Please Enter"),
//                     cursorColor: Colors.black,
//                           style: TextStyle(
//                             fontSize: 17
//                           ),
//                           decoration: InputDecoration(
//                             labelStyle: TextStyle(color: Colors.black),
//                             focusedBorder: UnderlineInputBorder(
//                               borderSide: new BorderSide(color: Colors.black),
//                             )
//                           )
//             )
//           ),

//            SizedBox(
//                     height: 20,
//                     width: 20,
//                     ),
                  
//                  Text(
//                   'Upload Foto',
//                   style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 17, fontWeight: FontWeight.w500),
//                  ),

//                  Container(

//                  margin: EdgeInsets.only(top: 20),
//                   child: Row(
//                     children: <Widget>[
//                       Container(
//                         decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 191, 183, 183),
//                         borderRadius: BorderRadius.circular(5)
//                         ),
//                       child: IconButton(onPressed: () {
//                         myAlertCamera();
//                       }, 
//                       icon: Icon(Icons.camera_alt),
//                       ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 15),
//                     decoration: BoxDecoration(
//                         color: Color.fromARGB(255, 191, 183, 183),
//                         borderRadius: BorderRadius.circular(5)
//                         ),
//                      child:  IconButton(onPressed: () {
//                         myAlertGallery();
//                       }, 
//                       icon: Icon(Icons.photo,),
//                       )
//                   )
//                     ],
//                   ),
//                  ),

//           Padding(
//             padding: const EdgeInsets.only(top: 20, bottom: 20),
//             child: MaterialButton(
//               color: Color.fromARGB(255, 255, 17, 17),
//               height: 45,
//               child: (widget.activityy == null)
//                   ? Text(
//                       'Add',
//                       style: TextStyle(color: Colors.white),
//                     )
//                   : Text(
//                       'Update',
//                       style: TextStyle(color: Colors.white),
//                     ),
//               onPressed: () {
//                  if (_formKey.currentState!.validate()) {
//                       ScaffoldMessenger.of(context).showSnackBar(
//                           SnackBar(
//                             backgroundColor: Colors.white,
//                             content: Text(
//                               'Validation Successful',
//                               style: TextStyle(
//                                   color: Colors.black,
//                               ),
//                             ),
//                           ),
//                       );
//                 upsertActivityy();
//                  }
//               }
//             ),
//           )
//         ],
//       ),
//                 )
//        )
//       ],
//       )
//     );
//   }

//   Future<void> upsertActivityy() async {
//     if (widget.activityy != null) {
//       //update
//       await db.updateActivityy(Activityy.fromMap({
//         'id_act': widget.activityy!.id_act,
//         'nik': nik!.text,
//         'fullname': fullname!.text,
//         'subdivisi': subdivisi!.text,
//         'location': location!.text,
//         'status': status!.text,
//         'description': description!.text,
//         'target': target!.text,
//         'dateVisit': dateVisit!.text,
//         'stkNumbers': stkNumbers!.text,
//       }));
//       Navigator.pop(context, 'update');
//     } else {
//       //insert
//       await db.saveActivityy(Activityy(
//         nik: nik!.text,
//         fullname: fullname!.text,
//         subdivisi: subdivisi!.text,
//         location: location!.text,
//         status: status!.text,
//         description: description!.text,
//         target: target!.text,
//         dateVisit: dateVisit!.text,
//         stkNumbers: stkNumbers!.text,
//       ));
//       Navigator.pop(context, 'save');
//     }
//   }
// }
