// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:flutter_web_data_table/web_data_table.dart';
// import 'package:myactivity_project/ramayana_comcheck_cek.dart';
// import 'package:myactivity_project/sample.dart';

// class RamayanaRiwayatApprove extends StatefulWidget {
//   const RamayanaRiwayatApprove({super.key, required DateTime initialDate});

//   @override
//   State<RamayanaRiwayatApprove> createState() => _RamayanaRiwayatApproveState();
// }

// class _RamayanaRiwayatApproveState extends State<RamayanaRiwayatApprove> {


//    List<Item> _items = [];
//     int _sortColumnIndex = 0;
//     bool _sortAscending = true;
//     bool _visible = false;

//     @override
//     void initState() {
//       super.initState();
//       setState(() {
//         _items = _generateItems();
//       });
//     }

    

//     List<Item> _generateItems() {
//       return List.generate(18, (int index) {
//         return Item(
//           id: index + 1,
//           sku: 0460545,
//           hb: '150.000',
//           hj: '160.000',
//           hjBaru: '120.000',
//           isSelected: false,
//         );
//       });
//     }

//      List<DataColumn> _createColumns() {
//       return [
//         DataColumn(
//           label: const Text('No.',
//           style: TextStyle(color: Colors.white, fontSize: 17),
//           ),
//           numeric: false, // Deliberately set to false to avoid right alignment.
//         ),
//          DataColumn(
//           label: const Text('SKU',
//           style: TextStyle(color: Colors.white, fontSize: 17),),
//         ),
//         DataColumn(
//           label: const Text('HB',
//           style: TextStyle(color: Colors.white, fontSize: 17),),
//         ),
//         DataColumn(
//           label: const Text('HJ',
//           style: TextStyle(color: Colors.white, fontSize: 17),),
//         ),
//         DataColumn(
//           label: const Text('HJ Baru',
//           style: TextStyle(color: Colors.white, fontSize: 17),),
//         )
//       ];
//     }

//     DataRow _createRow(Item item) {
//       return DataRow(
//         // index: item.id, // for DataRow.byIndex
//         key: ValueKey(item.id),
//         selected: item.isSelected,
//         onSelectChanged: (bool? isSelected) {
//           if (isSelected != null) {
//             item.isSelected = isSelected;
//             setState(() {
//             });
//           }
//         },
//         color: MaterialStateColor.resolveWith((Set<MaterialState> states) => states.contains(MaterialState.selected)
//             ? Color.fromARGB(255, 255, 217, 217)
//             : Color.fromARGB(100, 215, 217, 219)
//         ),
//         cells: [
//           DataCell(
//             Text(item.id.toString()),
//           ),
//           DataCell(
//             Text(item.sku.toString()),
//           ),
//           DataCell(
//             Text(item.hb.toString()),
//           ),
//           DataCell(
//             Text(item.hj.toString())
//           ),
//           DataCell(
//             Text(item.hjBaru.toString()),
//           ),
//         ],
//       );
//     }
  
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading:  IconButton
//           (icon: Icon(Icons.arrow_back), onPressed: () {Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => RamayanaCompetitorCek(),), (Route<dynamic> route) => false);},),
//         title: Text('Riwayat Approve', style: TextStyle(fontSize: 23)),
//         backgroundColor: Color.fromARGB(255, 255, 17, 17),
//         toolbarHeight: 90,
//         ),

//            body: Stack(
//         children: <Widget>[
//           Container(
//             color: Colors.white,
//           ),
//           Container(
//             margin: EdgeInsets.fromLTRB(20, 30, 20, 0),
//             // color: Colors.green,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                   Container(
//                     height: 80,
//                     width: 120,
//                     child: MaterialButton(
//                       elevation: 7,
//                       color: Color.fromARGB(255, 255, 17, 17),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20) 
//                         ),
//                       onPressed: () {}, 
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                         Text('Periode', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
//                         Text('xxx',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
//                       ],)
//                     ),
//                   ),

//                   Container(
//                     height: 80,
//                     width: 120,
//                     child: MaterialButton(
//                       elevation: 7,
//                       color: Color.fromARGB(255, 255, 17, 17),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20) 
//                         ),
//                       onPressed: () {}, 
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                         Text('Toko', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
//                         Text('R31',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
//                       ],)
//                     ),
//                   ),

//                   Container(
//                     height: 80,
//                     width: 120,
//                     child: MaterialButton(
//                       elevation: 7,
//                       color: Color.fromARGB(255, 255, 17, 17),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20) 
//                         ),
//                       onPressed: () {}, 
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                         Text('MD', style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),),
//                         Text('001',style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold))
//                       ],)
//                     ),
//                   )
//           ]),
//           ),

//          Container(
//           margin: EdgeInsets.only(top: 170, left: 10, right: 10),
//           height: 500,
//            child: SizedBox(
//             width: MediaQuery.of(context).size.width,
//             child: SingleChildScrollView(
//               child: DataTable(
                
//                 sortColumnIndex: _sortColumnIndex,
//                 sortAscending: _sortAscending,
//                 columnSpacing: 3,
//                 dividerThickness: 5,
//                 onSelectAll: (bool? isSelected) {
//                   if (isSelected != null) {
//                     _items.forEach((item) {
//                       item.isSelected = isSelected;
//                     });
           
//                     setState(() {
//                     });
//                   }
//                 },
//                 dataRowColor: MaterialStateColor.resolveWith((Set<MaterialState> states) => states.contains(MaterialState.selected)
//                     ? Colors.green
//                     : Color.fromARGB(100, 215, 217, 219)
//                 ),
//                 dataRowHeight: 80,
//                 dataTextStyle: const TextStyle(fontStyle: FontStyle.italic, color: Colors.black),
//                 headingRowColor: MaterialStateColor.resolveWith((states) => Color.fromARGB(255, 255, 17, 17)),
//                 headingRowHeight: 80,
//                 headingTextStyle: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
//                 horizontalMargin: 10,
//                 showBottomBorder: true,
//                 showCheckboxColumn: true,
                
//                 columns: _createColumns(),
//                 rows: _items.map((item) => _createRow(item))
//                     .toList(),
//               ),
//             )
//                  ),
//          ),
            
//             Container(
//               margin: EdgeInsets.fromLTRB(10, 700,10, 0),
//               child: AnimatedOpacity(
//                      opacity: _visible ? 1.0 : 0.0,
//                      duration: const Duration(milliseconds: 500),
//                      child: Container(
//                          margin: EdgeInsets.fromLTRB(10, 0,10, 0),
                            
//                   )
//                   ),
//             ),
          
//         ]
//       )
//     );
//   }
// }