                // AlertDialog popup = AlertDialog(
                             
                //              shape: RoundedRectangleBorder(
                //               borderRadius: BorderRadius.circular(20),
                //             ),
                //               shadowColor: Colors.black,
                //               titlePadding: EdgeInsets.all(0),
                //               title: 
                              
                //               Column(
                //                 children: [
                //                   Container(
                //                     decoration: BoxDecoration(
                //                       borderRadius: BorderRadius.only(
                //                         topLeft: Radius.circular(20),
                //                         topRight: Radius.circular(20),
                                        
                //                       ),
                                      
                //                     color:Color.fromARGB(255, 254, 234, 233)
                //                     ),
                //                     height: 190,
                //                     width: 2000,
                //                     child: 
                //                           Image.asset(
                //                           'assets/adel.png',
                //                           // width: 20,
                //                           // height: 1,
                //                         )
                                        
                                      
                                     
                //                   ),
                //                     Container(
                //                       margin: EdgeInsets.only(top: 0),
                //                       color: Colors.black,
                //                       height: 1,
                //                      width: 2000,
                                    
                //                     ),
                //                 ],
                //               ),
                //               content: 
                //               Form(
                //                 key: _formKey2,
                //                 child: Container(
                                 
                //                     height: 230,
                //                   width: 500,
                //                   child: Column(
                //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     children: [
                                     
                //                       Column(
                //                         crossAxisAlignment: CrossAxisAlignment.start,
                //                         children: [
                //                           Text(
                //                             'Password:',
                //                             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                //                           ),
                //                         SizedBox(
                //                           height: 10,
                //                          ),
                //                       TextFormField(
                //                          controller: password,
                //                                       style: TextStyle(fontSize: 20, color: Colors.black),
                //                                        validator:(value){
                //                                         if(value!.isEmpty){
                //                                           return "Required";
                //                                         }
                //                                         if(value.length != 6){
                //                                           return "Password length must be 6 characters";
                //                                         }
                                                      
                //                                         if(!value.contains(RegExp(r'[0-9]'))){
                //                                           return "Password must contain a number";
                //                                             }

                //                                         if(
                                                          
                //                                           value == username.text){
                //                                           return "Password can't same with username";
                //                                             }
                //                                           },
                                                     
                //                                       obscureText: true,
                //                                       keyboardType: TextInputType.number,
                //                                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //                                       decoration: InputDecoration(
                //                                         border: OutlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                         color: Colors.black, 
                //                                           width: 5.0),
                //                                          borderRadius: BorderRadius.circular(60)
                //                                           ),
                                                          
                //                                         errorBorder: OutlineInputBorder( borderSide: BorderSide(color: Color.fromARGB(255, 255, 17, 17),), borderRadius: BorderRadius.circular(60)),
                //                                         errorStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 14, fontWeight: FontWeight.w400),
                //                  labelStyle: TextStyle(
                //                 color: Colors.black87
                //                                         ),
                //                                         prefixIcon: Icon(
                //                                           IconlyBroken.lock,
                //                                           color: Color.fromARGB(255, 255, 17, 17),
                //                                         ),
                //                                         //  hintText: 'Password', 
                //                                         hintStyle: TextStyle(
                //                                           color:  Colors.black,
                //                                           fontSize: 20
                //                                         ),
                //                                         enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(60)),
                //                                        focusedBorder: OutlineInputBorder(
                //                                       borderSide: new BorderSide(color: Colors.black),
                //                                           borderRadius: BorderRadius.circular(60)
                //                                            )
                //                                       )      
                //                       ),
                //                        ],
                //                       ),
                                   
                //                        Column(
                //                         crossAxisAlignment: CrossAxisAlignment.start,
                //                          children: [
                //                            Text(
                //                             'Re-Enter Password:',
                //                             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
                //                       ),
                //                          SizedBox(
                //                           height: 10,
                //                          ),
                //                       TextFormField(
                //                          controller: passwordReEnter,
                //                                       style: TextStyle(fontSize: 20, color: Colors.black),
                //                                        validator: (value) {
                //                                        if(value!.isEmpty){
                //                                           return "Required";
                //                                         }
                                                      
                //                                         if(!value.contains(RegExp(r'[0-9]'))){
                //                                           return "Password must contain a number";
                //                                             }

                //                                         if(value != password.text){
                //                                           return "Please Re-Enter password correctly";
                //                                             }
                                                          
                //                                        },
                //                                       obscureText: true,
                //                                       keyboardType: TextInputType.number,
                //                                       inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                //                                       decoration: InputDecoration(
                //                                         border: OutlineInputBorder(
                //                                           borderSide: BorderSide(
                //                                         color: Colors.black, 
                //                                           width: 5.0),
                //                                           borderRadius: BorderRadius.circular(60)
                //                                           ),
                                                          
                //                                         errorBorder: OutlineInputBorder( borderSide: BorderSide(color: Color.fromARGB(255, 255, 17, 17),), borderRadius: BorderRadius.circular(60)),
                //                                         errorStyle: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontSize: 14, fontWeight: FontWeight.w400),
                //                                         labelStyle: TextStyle(
                //                                         color: Colors.black87
                //                                         ),
                //                                         prefixIcon: Icon(
                //                                           IconlyBroken.lock,
                //                                           color: Color.fromARGB(255, 255, 17, 17),
                //                                         ),
                                                        
                //                                         hintStyle: TextStyle(
                //                                           color:  Colors.black,
                //                                           fontSize: 20
                //                                         ),
                //                                         enabledBorder: OutlineInputBorder(borderSide: new BorderSide(color: Colors.black),borderRadius: BorderRadius.circular(60)),
                //                                        focusedBorder: OutlineInputBorder(
                //                                         borderRadius: BorderRadius.circular(60),
                //                                      borderSide: new BorderSide(color: Colors.black),
                //                                            )
                //                                       )      
                //                       )
                                     
                //                       ],
                //                        ),
                //                     ],
                //                   ),
                //                 ),
                //               ),
                //               //terdapat 2 button.
                //               //jika ya maka jalankan _deleteKontak() dan tutup dialog
                //               //jika tidak maka tutup dialog
                //               actions: [ 
                //                //button buat reset
                //                 Container(
                //                   margin: EdgeInsets.only(left: 20),
                //                   child: Column(
                //                     crossAxisAlignment: CrossAxisAlignment.start,
                //                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //                     children: [
                //                       Container(
                //                         margin: EdgeInsets.only(left: 80, right: 80),
                //                         child: MaterialButton(
                //                           height: 40,
                //                           padding: EdgeInsets.symmetric(horizontal: 80),
                //                           shape: RoundedRectangleBorder(
                //                               borderRadius: BorderRadius.circular(40),
                //                             ),
                //                           color: Color.fromARGB(255, 255, 17, 17),
                //                           child: Text('Submit',
                //                               style: TextStyle(
                //                               color:  Colors.white, fontWeight: FontWeight.w500, fontSize: 17)),
                //                           onPressed: () async {
                //                               if (_formKey2.currentState!.validate()) {
                //                               _displayCenterMotionToastSuccess();
                //                              var formData = FormData.fromMap({
                //                             'user_name': username.text,
                //                             'password': password.text,
                //                            // 're-enter': passwordReEnter.text,
                //                          });
                //                           var response = await dio.post('https://android-api.ramayana.co.id:8304/api/v1/auth/reset.password',
                //                             data: formData
                //                           );
                //                           print('Berhasil, ${username.text}, ${password.text},${password.text}, ${passwordReEnter.text}');
                //                           Duration(seconds: 10);
                //                               Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RamayanaLogin(),), (Route<dynamic> route) => false);
                //                               }
                                             
                                          
                //                              }
                                            
                                          
                //                         ),
                //                       ),
                //                       SizedBox(
                //                         height: 10,
                //                       ),
                                   
                //                                               Text('Note : ',
                //                                                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                //                     ),
                //                      Text( 'Password baru tidak boleh sama dengan username',
                //                                                style: TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
                //                     ),    
                //                    ],
                //                   ),
                //                 ),  
                //               ],
                //               actionsAlignment: MainAxisAlignment.start,
                //               actionsPadding: EdgeInsets.only(bottom: 30),
                              
                //             );
                //             showDialog(
                //                 context: context, builder: (context) => popup);