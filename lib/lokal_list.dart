//     import 'package:uki_flutter/lokal_activity.dart';
// import 'package:uki_flutter/lokal_list.dart';
// import 'package:flutter/material.dart';
//     import 'package:uki_flutter/database/database.dart';
//     import 'package:uki_flutter/model/model.dart';


//    class ListKontakPage extends StatefulWidget {
//         const ListKontakPage({ Key? key }) : super(key: key);
    
//         @override
//         _ListKontakPageState createState() => _ListKontakPageState();
//     }
    
//     class _ListKontakPageState extends State<ListKontakPage> {
//         List<Kontak> listKontak = [];
//         DbHelper db = DbHelper();
    
//         @override
//         void initState() {
//         //menjalankan fungsi getallkontak saat pertama kali dimuat
//         _getAllKontak();
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
//             body: ListView.builder(
//                 itemCount: listKontak.length,
//                 itemBuilder: (context, index) {
//                     Kontak kontak = listKontak[index];
//                     return Padding(
//                     padding: const EdgeInsets.only(
//                         top: 20
//                     ),
//                     child: ListTile(
//                         leading: Icon(
//                         Icons.person, 
//                         size: 50,
//                         ),
//                         title: Text(
//                         '${kontak.name}'
//                         ),
//                         subtitle: Column(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                             Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 8, 
//                             ),
//                             child: Text("NIK: ${kontak.nik}"),
//                             ), 
//                             Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 8,
//                             ),
//                             child: Text("Subdivisi: ${kontak.mobileNo}"),
//                             ),
//                             Padding(
//                             padding: const EdgeInsets.only(
//                                 top: 8,
//                             ),
//                             child: Text("Date Visit: ${kontak.company}"),
//                             )
//                         ],
//                         ),
//                         trailing: 
//                         FittedBox(
//                         fit: BoxFit.fill,
//                         child: Row(
//                             children: [
//                             // button edit 
//                             IconButton(
//                                 onPressed: () {
//                                 _openFormEdit(kontak);
//                                 },
//                                 icon: Icon(Icons.edit)
//                             ),
//                             // button hapus
//                             IconButton(
//                                 icon: Icon(Icons.delete),
//                                 onPressed: (){
//                                 //membuat dialog konfirmasi hapus
//                                 AlertDialog hapus = AlertDialog(
//                                     title: Text("Information"),
//                                     content: Container(
//                                     height: 100, 
//                                     child: Column(
//                                         children: [
//                                         Text(
//                                             "Yakin ingin Menghapus Data ${kontak.name}"
//                                         )
//                                         ],
//                                     ),
//                                     ),
//                                     //terdapat 2 button.
//                                     //jika ya maka jalankan _deleteKontak() dan tutup dialog
//                                     //jika tidak maka tutup dialog
//                                     actions: [
//                                     TextButton(
//                                         onPressed: (){
//                                         _deleteKontak(kontak, index);
//                                         Navigator.pop(context);
//                                         }, 
//                                         child: Text("Ya")
//                                     ), 
//                                     TextButton(
//                                         child: Text('Tidak'),
//                                         onPressed: () {
//                                         Navigator.pop(context);
//                                         },
//                                     ),
//                                     ],
//                                 );
//                                 showDialog(context: context, builder: (context) => hapus);
//                                 }, 
//                             )
//                             ],
//                         ),
//                         ),
//                     ),
//                     );
//                 }),
//                 //membuat button mengapung di bagian bawah kanan layar
//                 floatingActionButton: FloatingActionButton(
//                   backgroundColor: Color.fromARGB(255, 255, 17, 17),
//                     child: Icon(Icons.add), 
//                     onPressed: (){
//                     _openFormCreate();
//                     },
//                 ),
            
//         );
//         }
    
//         //mengambil semua data Kontak
//         Future<void> _getAllKontak() async {
//         //list menampung data dari database
//         var list = await db.getAllKontak();
    
//         //ada perubahanan state
//         setState(() {
//             //hapus data pada listKontak
//             listKontak.clear();
    
//             //lakukan perulangan pada variabel list
//             list!.forEach((kontak) {
            
//             //masukan data ke listKontak
//             listKontak.add(Kontak.fromMap(kontak));
//             });
//         });
//         }
    
//         //menghapus data Kontak
//         Future<void> _deleteKontak(Kontak kontak, int position) async {
//         await db.deleteKontak(kontak.id!);
//         setState(() {
//             listKontak.removeAt(position);
//         });
//         }
    
//         // membuka halaman tambah Kontak
//         Future<void> _openFormCreate() async {
//         var result = await Navigator.push(
//             context, MaterialPageRoute(builder: (context) => FormKontak()));
//         if (result == 'save') {
//             await _getAllKontak();
//         }
//         }
    
//         //membuka halaman edit Kontak
//         Future<void> _openFormEdit(Kontak kontak) async {
//         var result = await Navigator.push(context,
//             MaterialPageRoute(builder: (context) => FormKontak(kontak: kontak)));
//         if (result == 'update') {
//             await _getAllKontak();
//         }
//         }
//     }