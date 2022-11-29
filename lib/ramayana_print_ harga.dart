// import 'package:flutter/material.dart';
// import 'package:myactivity_project/ramayana_print.dart';

// class Harga extends StatefulWidget {
//   const Harga({super.key});

//   @override
//   State<Harga> createState() => _HargaState();
// }

// class _HargaState extends State<Harga> {

//    final List<Map<String, dynamic>> dataPrint = [
//     {
//       'title': 'Produk 1',
//       'price': 10000,
//       'qty': 2,
//       'total_price': 20000,
//     },
//     {
//       'title': 'Produk 2',
//       'price': 20000,
//       'qty': 2,
//       'total_price': 40000,
//     },
//     {
//       'title': 'Produk 3',
//       'price': 12000,
//       'qty': 1,
//       'total_price': 12000,
//     },
//   ];

//   @override

//   Widget build(BuildContext context) {
//      int _total = 0;

//     for (var i = 0; i < dataPrint.length; i++) {
//       _total += dataPrint[i]['total_price'] as int;
//     }
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Print Harga', style: TextStyle(fontSize: 23)),
//         backgroundColor: Color.fromARGB(255, 255, 17, 17),
//         elevation: 7.20  ,
//           toolbarHeight: 90,
          
//         ),

//         body: 
//         Column(
//         children: <Widget>[
//           Expanded(
//             child: ListView.builder(
//               itemCount: dataPrint.length,
//               itemBuilder: (c, i) {
//                 return ListTile(
//                   title: Text(dataPrint[i]['title']),
//                   subtitle: Text('Rp ${dataPrint[i]['price']} x ${dataPrint[i]['qty']}'),
//                   trailing: Text('Rp ${dataPrint[i]['total_price']}'),
//                 );
//               },
//             ),
//           ),
//           Container(
//             color: Colors.grey[200],
//             padding: EdgeInsets.all(20),
//             child: Row(
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     Text(
//                       'Total :',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     ),
//                     Text(
//                       'Rp $_total :',
//                       style: TextStyle(fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//                 SizedBox(width: 20),
//                 Expanded(
//                   child: MaterialButton(
//                     color: Color.fromARGB(255, 255, 17, 17),
//                     textColor: Colors.white,
//                     child: Text('Print'),
//                     onPressed: () {
//                       Navigator.push(context,
//                           MaterialPageRoute(builder: (_) => Print(dataPrint)));
//                     },
//                   ),
//                 )
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }