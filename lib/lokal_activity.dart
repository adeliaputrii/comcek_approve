//     import 'package:flutter/material.dart';
//     import 'package:uki_flutter/database/database.dart';
// import 'package:uki_flutter/lokal_list.dart';
//     import 'package:uki_flutter/model/model.dart';
    
    
//     class FormKontak extends StatefulWidget {
//         final Kontak? kontak;
    
//         FormKontak({this.kontak});
    
//         @override
//         _FormKontakState createState() => _FormKontakState();
//     }
    
//     class _FormKontakState extends State<FormKontak> {
//         DbHelper db = DbHelper();
    
//         TextEditingController? name;
//         TextEditingController? lastName;
//         TextEditingController? mobileNo;
//         TextEditingController? nik;
//         TextEditingController? company;
    
//         @override
//         void initState() {
//         name = TextEditingController(
//             text: widget.kontak == null ? '' : widget.kontak!.name);
    
//         mobileNo = TextEditingController(
//             text: widget.kontak == null ? '' : widget.kontak!.mobileNo);
    
//         nik = TextEditingController(
//             text: widget.kontak == null ? '' : widget.kontak!.nik);
    
//         company = TextEditingController(
//             text: widget.kontak == null ? '' : widget.kontak!.company);
            
//         super.initState();
//         }
    
//         @override
//         Widget build(BuildContext context) {
//         return Scaffold(
//             appBar: AppBar(
//         title: Text('Add Activity', style: TextStyle(fontSize: 23)),
//         backgroundColor: Color.fromARGB(255, 255, 17, 17),
//         elevation: 7.20  ,
//           toolbarHeight: 90,
//         ),   
//             body: ListView(
//             padding: EdgeInsets.all(16.0),
//             children: [
//                 Padding(
//                 padding: const EdgeInsets.only(
//                     top: 20,
//                 ),
//                 child: TextField(
//                     controller: nik,
//                     decoration: InputDecoration(
//                         labelText: 'NIK',
//                         border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         )),
//                 ),
//                 ),
//                  Padding(
//                 padding: const EdgeInsets.only(
//                     top: 20,
//                 ),
//                 child: TextField(
//                     controller: name,
//                     decoration: InputDecoration(
//                         labelText: 'Nama',
//                         border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         )),
//                 ),
//                 ),
//                 Padding(
//                 padding: const EdgeInsets.only(
//                     top: 20,
//                 ),
//                 child: TextField(
//                     controller: mobileNo,
//                     decoration: InputDecoration(
//                         labelText: 'Subdivisi',
//                         border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         )),
//                 ),
//                 ),
               
//                 Padding(
//                 padding: const EdgeInsets.only(
//                     top: 20,
//                 ),
//                 child: TextField(
//                     controller: company,
//                     decoration: InputDecoration(
//                         labelText: 'Date Visit',
//                         border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(8),
//                         )),
//                 ),
//                 ),
//                 Padding(
//                 padding: const EdgeInsets.only(
//                     top: 20
//                 ),
//                 child: MaterialButton(
//                     color: Color.fromARGB(255, 255, 17, 17),
//                     child: (widget.kontak == null)
//                         ? Text(
//                             'Add',
//                             style: TextStyle(color: Colors.white),
//                         )
//                         : Text(
//                             'Update',
//                             style: TextStyle(color: Colors.white),
//                         ),
//                     onPressed: () {
//                        Navigator.push(context, MaterialPageRoute(builder: (context){
//                         return ListKontakPage();
//                       }));
//                     upsertKontak();
//                     },
//                 ),
//                 )
//             ],
//             ),
//         );
//         }
    
//         Future<void> upsertKontak() async {
//         if (widget.kontak != null) {
//             //update
//             await db.updateKontak(Kontak.fromMap({
//             'id' : widget.kontak!.id,
//             'name' : name!.text,
//             'mobileNo' : mobileNo!.text,
//             'nik' : nik!.text,
//             'company' : company!.text
//             }));
//             Navigator.pop(context, 'update');
//         } else {
//             //insert
//             await db.saveKontak(Kontak(
//             name: name!.text,
//             mobileNo: mobileNo!.text,
//             nik: nik!.text,
//             company: company!.text,
//             ));
//             Navigator.push(context, MaterialPageRoute(builder: (context){
//                         return ListKontakPage();
//                       }));
//         }
//         }
//     }