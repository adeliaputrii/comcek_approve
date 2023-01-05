// import 'dart:convert';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:myactivity_project/sample.dart';

// import 'models/model_apv.dart';


// class RamayanaApprove extends StatefulWidget {

//   @override
//   State<StatefulWidget> createState() {
//     return RamayanaApproveState();
//   }
// }

// class RamayanaApproveState extends State<RamayanaApprove> {

// fetchProduk({
//     required String m1
//   }) async {
//     ApproveModel.approvelist.clear();
//     final responseku = await http.post(
//       Uri.parse('https://android-api.ramayana.co.id:8304/v1/activity/tbl_commcheck'),
//         body: {
//           'm1' : m1
//         });

//     var data = jsonDecode(responseku.body);
   
//     if (data['status'] == 200) {
//       print("API Success");
//       print(data);
//       int count = data['data'].length;
//       for (int i = 0; i < count; i++) {
//         ApproveModel.approvelist.add(ApproveModel.fromjson(data['data'][i]));
//       }
//       print('check length ${ApproveModel.approvelist.length}');
//       print(data['data'].toString());

//     } else {
//       print('NO DATA');
//     }
//   // var result;
//   //   print('jogja hebat');
//   //    if (result == fetchProduk(m1: '084')) {
//   //     print('jogja');
//   //    }
//   //    return result;
//   }

//    void initState() {
//     super.initState();
//     fetchProduk(m1: '082');
//   }

//   List<Item> _items = [];
//   int _sortColumnIndex = 0;
//   bool _sortAscending = true;

//   int _rowSelectedCount = 0;

//  @override
//     void initState1() {
//       setState(() {
//         _items = _generateItems();
//       });
//     }
  
//     List<Item> _generateItems() {
//       return List.generate(15, (int index) {
//         return Item(
//           id: index + 1,
//           sku: '264762746',
//           toko: 'RB17',
//           m1: '5336',
//           hb: '150.000',
//           hj: '150.000',
//           hjBaru: '150.000',
//           datecr: '20/11/2022',
//           timecr: '12.25',
//           usercr: 'Jaka',
//           isapv: '-',
//           dateapv: '-',
//           userapv: '-',
//           isSelected: false,
//         );
//       });
//     }



//   int get selectedItems => _rowSelectedCount;
//   int get selectedItemsAll => _items.length - _rowSelectedCount;
//   void approve1() {
//     AlertDialog popup = AlertDialog(
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(20),
//       ),

//       // shadowColor: Colors.black,
//       titlePadding: EdgeInsets.all(0),
//       title: Container(
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(20),
//               topRight: Radius.circular(20),
//             ),
//           ),
//           height: 190,
//           width: 2000,
//           child: Image.asset(
//             'assets/omaigat.png',
//           )),
//       content: Container(
//         height: 100,
//         child: Column(
//           children: [
//             Text(
//               'Jumlah pengajuan yang disetujui : ${selectedItems}',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 15,
//               ),
//             ),
//             Text(
//               'Jumlah pengajuan yang ditolak : ${selectedItemsAll}',
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 15,
//               ),
//             ),
//             SizedBox(
//               height: 30,
//             ),
//             Text(
//               'Apakah Anda yakin ingin menyetujui pengajuan ini?',
//               style: TextStyle(
//                   color: Colors.black,
//                   fontSize: 15,
//                   fontWeight: FontWeight.bold),
//             ),
//           ],
//         ),
//       ),
//       actions: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceAround,
//           children: [
//             MaterialButton(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               height: 40,
//               color: Color.fromARGB(255, 255, 17, 17),
//               onPressed: () {
//                 Navigator.pop(context);
//               },
//               child: Text(
//                 'Cancel',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15),
//               ),
//             ),
//             MaterialButton(
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10)),
//               height: 40,
//               color: Colors.green,
//               onPressed: () {},
//               child: Text(
//                 'Approve',
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 15),
//               ),
//             ),
//           ],
//         )
//       ],
//       actionsAlignment: MainAxisAlignment.start,
//       actionsPadding: EdgeInsets.only(bottom: 20),
//     );
//     showCupertinoModalPopup(context: context, builder: (context) => popup);
//   }

//   List<DataColumn> _createColumns() {
//     return [
//       DataColumn(
//         label: const Text('No', style: TextStyle(color: Colors.white, fontSize: 17),),
//         numeric: false, // Deliberately set to false to avoid right alignment.
//       ),
//       DataColumn(
//         label: const Text(
//           'SKU',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),
//       DataColumn(
//         label: const Text(
//           'Toko',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),
//       DataColumn(
//         label: const Text(
//           'M1',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),
//       DataColumn(
//         label: const Text(
//           'Harga Beli',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),
//       DataColumn(
//         label: const Text(
//           'Harga Jual',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),
//       DataColumn(
//         label: const Text(
//           'Harga Jual Baru',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),

//       DataColumn(
//         label: const Text(
//           'Date Create',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),
//       DataColumn(
//         label: const Text(
//           'Time Create',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),
//       DataColumn(
//         label: const Text(
//           'User Create',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),
//       DataColumn(
//         label: const Text(
//           'Is Approve',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),
//       DataColumn(
//         label: const Text(
//           'Date Approve',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),
//       DataColumn(
//         label: const Text(
//           'User Approve',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//         ),
//         numeric: false, // Del
//       ),
//     ];
//   }

//   DataRow _createRow(Item item) {
//     return DataRow(
//       // index: item.id, // for DataRow.byIndex
//       key: ValueKey(item.id),
//       // selected: item.isSelected,
//       onSelectChanged: (bool? isSelected) {
//         if (isSelected != null) {
//           item.isSelected = isSelected;
//           _rowSelectedCount += isSelected ? 1 : -1;
//           setState(() {});
//         }
//       },
//       color: MaterialStateColor.resolveWith((Set<MaterialState> states) =>
//           states.contains(MaterialState.selected)
//               ? Color.fromARGB(255, 255, 217, 217)
//               : Color.fromARGB(100, 215, 217, 219)),
//       cells: [
//         DataCell(
//           Text(item.id.toString()),
//         ),
//         DataCell(
//           Text(item.sku),
//         ),
//         DataCell(Text(item.toko)),
//         DataCell(
//           Text(item.m1),
//         ),
//         DataCell(
//           Text(item.hb),
//         ),
//         DataCell(
//           Text(item.hj),
//         ),
//         DataCell(
//           Text(item.hjBaru),
//         ),
//         DataCell(
//           Text(item.datecr),
//         ),
//         DataCell(
//           Text(item.timecr),
//         ),
//         DataCell(
//           Text(item.usercr),
//         ),
//         DataCell(
//           Text(item.isapv),
//         ),
//         DataCell(
//           Text(item.dateapv),
//         ),
//         DataCell(
//           Text(item.userapv),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Approve', style: TextStyle(fontSize: 23)),
//         backgroundColor: Color.fromARGB(255, 255, 17, 17),
//         elevation: 7.20,
//         toolbarHeight: 90,
//       ),
//       body: Stack(
//         children: [
//           Container(
//             margin: EdgeInsets.fromLTRB(10, 30, 10, 300),
//             child: ListView(scrollDirection: Axis.horizontal, children: [
//               SizedBox(
//                 width: 1500,
//                 child: SingleChildScrollView(
//                   child: DataTable(
//                     sortColumnIndex: _sortColumnIndex,
//                     sortAscending: _sortAscending,
//                     columnSpacing: 0,
//                     dividerThickness: 5,
//                     onSelectAll: (bool? isSelected) {
//                       if (isSelected != null) {
//                         _items.forEach((item) {
//                           item.isSelected = isSelected;
//                         });
//                         _rowSelectedCount = isSelected ? _items.length : 0;

//                         setState(() {});
//                       }
//                     },
//                     dataRowColor: MaterialStateColor.resolveWith(
//                         (Set<MaterialState> states) =>
//                             states.contains(MaterialState.selected)
//                                 ? Colors.blue
//                                 : Color.fromARGB(100, 215, 217, 219)),
//                     dataRowHeight: 80,
//                     dataTextStyle: const TextStyle(
//                         fontStyle: FontStyle.italic, color: Colors.black),
//                     headingRowColor: MaterialStateColor.resolveWith(
//                         (states) => Color.fromARGB(255, 255, 17, 17)),
//                     headingRowHeight: 80,
//                     headingTextStyle: const TextStyle(
//                         fontWeight: FontWeight.bold, color: Colors.black),
//                     horizontalMargin: 10,
//                     showBottomBorder: true,
//                     showCheckboxColumn: true,
//                     columns: _createColumns(),
                    
//                     rows: _items.map((item) => _createRow(item))
//                   .toList(),
//                   ),
//                 ),
//               )
//             ]),
//           ),
//           Container(
//               margin: EdgeInsets.fromLTRB(179, 600, 179, 100),
//               child: MaterialButton(
//                   padding: EdgeInsets.symmetric(horizontal: 40),
//                   height: 40,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: Text(
//                     'Send',
//                     style: TextStyle(color: Colors.white, fontSize: 18),
//                   ),
//                   color: Color.fromARGB(255, 255, 17, 17),
//                   onPressed: () {
//                     approve1();
//                   }))
//         ],
//       ),
//     );
//   }
// }
