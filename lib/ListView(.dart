  //  ListView(

  //       children: [
  //         //satu
  //         SizedBox(
  //           height: 40,
  //         ),
  //          Center(
  //            child: Text('My Activity Fitur',
  //                           style: TextStyle(color: Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.bold, fontSize: 25, fontStyle: FontStyle.italic),
  //                           ),
  //          ),
  //                         SizedBox(
  //           height: 40,
  //         ),
  //         split.length < 3 ?
  //         Row(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //                 children: split.map((e) {
  //                   print(e);
  //                   print('spilt: ${split}');
  //                   print('spilt length: ${split.length}');
  //                   print('yuhuuu');

  //                    var namaAkses = '${e}';

  //                   getNameLog() {
  //                     var namaAkses = '${e}';
  //                     if (namaAkses == 'checkedkartu') {
  //                       return 'ID CASH';
  //                     } else if (namaAkses == 'checkedapproval') {
  //                       return 'Approval Return';
  //                     } else if (namaAkses == 'checkedvoidreturn') {
  //                       return 'VOID';
  //                     } else e;
  //                     return namaAkses;
  //                   }

  //                    getIcon() {
  //                     var namaAkses = '${e}';
  //                     if (namaAkses == 'checkedkartu') {
  //                       return  
  //                       Icon(Icons.credit_score_rounded,
  //                         size: 35,
  //                         color: Colors.white,
  //                         );
  //                     } else if (namaAkses == 'checkedapproval') {
  //                       return 
  //                       Icon(Icons.edit_document,
  //                         size: 35,
  //                         color: Colors.white,
  //                         );
  //                     } else if (namaAkses == 'checkedvoidreturn') {
  //                       return 
  //                        Icon(Icons.document_scanner_rounded,
  //                         size: 35,
  //                         color: Colors.white,
  //                         );
  //                     } else return 
  //                      Icon(Icons.menu,
  //                         size: 35,
  //                         color: Colors.white,
  //                         );
  //                   }

                

  //                   return 
  //           Column(
  //             children: [
  //               MaterialButton(
  //                                     minWidth:  MediaQuery.of(context).size.width/6,
  //                                     height:  MediaQuery.of(context).size.height/13,
  //                                     shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(50)
  //                                     ),
  //                                     color: Color.fromARGB(255, 255, 17, 17),
  //                                     onPressed: ()async {
  //                                        AndroidDeviceInfo info = await deviceInfo.androidInfo;
  //                                        var formData = FormData.fromMap({
  //                                   'progname': 'RALS_TOOLS ',
  //                                   'versi': '2.12 v.2',
  //                                   'date_run': '${DateTime.now()}',
  //                                   'info1': '${getNameLog()}',
  //                                   ' info2': '${_udid} ',
  //                                   'userid': '${userData.getUsernameID()}',
  //                                   ' toko': '${userData.getUserToko()}',
  //                                   ' devicename': '${info.device}',
  //                                   'TOKEN': 'R4M4Y4N4'
  //                                 });
  //                                 
  //                                 
  //                                 var tipeurl = '${prod}';
  //                                 var response = await dio.post(
  //                                     '${tipeurl}v1/activity/createmylog',
  //                                     data: formData);   
  //                                     print('berhasil $_udid');   
  //                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
  //                                          var namaAkses = '${e}';
  //                                       if (namaAkses == 'checkedkartu') {
  //                                         return RamayanaIDCash();
  //                                       } else if (namaAkses == 'checkedapproval') {
  //                                         return RamayanaApprovalSubmenu();
  //                                        } else if (namaAkses == 'checkedvoidreturn') {
  //                                          return Blank();
  //                                       } else return Ramayana();
  //                                         }));
  //                                     },
  //                                     child:  
  //                                    getIcon()
  //                                     ),
             
      
  //                                 SizedBox(
  //                                 height: 10,
  //                                 ),
      
  //                                 Text('${getNameLog()}',
  //                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                                 )
  //                                  ],
  //           );
           
  //                 }).toList(),
                  
  //               ) : Column(
  //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //         //dua
  //                 children: split.map((e) {
  //                   print(e);
  //                   print('spilt: ${split}');
  //                   print('spilt length: ${split.length}');
  //                   print('yuhuuu');

  //                    var namaAkses = '${e}';

  //                   getNameLog() {
  //                     var namaAkses = '${e}';
  //                     if (namaAkses == 'checkedkartu') {
  //                       return 'ID CASH';
  //                     } else if (namaAkses == 'checkedapproval') {
  //                       return 'Approval Return';
  //                     } else if (namaAkses == 'checkedvoidreturn') {
  //                       return 'VOID';
  //                     } else e;
  //                     return namaAkses;
  //                   }

  //                    getIcon() {
  //                     var namaAkses = '${e}';
  //                     if (namaAkses == 'checkedkartu') {
  //                       return  
  //                       Icon(Icons.credit_score_rounded,
  //                         size: 35,
  //                         color: Colors.white,
  //                         );
  //                     } else if (namaAkses == 'checkedapproval') {
  //                       return 
  //                       Icon(Icons.edit_document,
  //                         size: 35,
  //                         color: Colors.white,
  //                         );
  //                     } else if (namaAkses == 'checkedvoidreturn') {
  //                       return 
  //                        Icon(Icons.document_scanner_rounded,
  //                         size: 35,
  //                         color: Colors.white,
  //                         );
  //                     } else return 
  //                      Icon(Icons.menu,
  //                         size: 35,
  //                         color: Colors.white,
  //                         );
  //                   }

                

  //                   return 
  //           Column(
  //             children: [
  //               MaterialButton(
  //                                     minWidth:  MediaQuery.of(context).size.width/6,
  //                                     height:  MediaQuery.of(context).size.height/13,
  //                                     shape: RoundedRectangleBorder(
  //                                     borderRadius: BorderRadius.circular(50)
  //                                     ),
  //                                     color: Color.fromARGB(255, 255, 17, 17),
  //                                     onPressed: ()async {
  //                                        AndroidDeviceInfo info = await deviceInfo.androidInfo;
  //                                        var formData = FormData.fromMap({
  //                                   'progname': 'RALS_TOOLS ',
  //                                   'versi': '2.12 v.2',
  //                                   'date_run': '${DateTime.now()}',
  //                                   'info1': '${getNameLog()}',
  //                                   ' info2': '${_udid} ',
  //                                   'userid': '${userData.getUsernameID()}',
  //                                   ' toko': '${userData.getUserToko()}',
  //                                   ' devicename': '${info.device}',
  //                                   'TOKEN': 'R4M4Y4N4'
  //                                 });
  //                                 
  //                                  
  //                                 var response = await dio.post(
  //                                     '${tipeurl}v1/activity/createmylog',
  //                                     data: formData);   
  //                                     print('berhasil $_udid');   
  //                                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
  //                                          var namaAkses = '${e}';
  //                                       if (namaAkses == 'checkedkartu') {
  //                                         return RamayanaIDCash();
  //                                       } else if (namaAkses == 'checkedapproval') {
  //                                         return RamayanaApprovalSubmenu();
  //                                        } else if (namaAkses == 'checkedvoidreturn') {
  //                                          return Blank();
  //                                       } else return Ramayana();
  //                                         }));
  //                                     },
  //                                     child:  
  //                                    getIcon()
  //                                     ),
             
      
  //                                 SizedBox(
  //                                 height: 10,
  //                                 ),
      
  //                                 Text('wakwaw',
  //                                 style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
  //                                 )
  //                                  ],
  //           );
           
  //                 }).toList(),
                  
  //               )
  //       ],
        
  //     )