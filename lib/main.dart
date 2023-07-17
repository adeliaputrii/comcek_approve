import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:myactivity_project/ramayana_cekharga.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_idcash_new_pin.dart';
import 'package:myactivity_project/ramayana_reset.dart';
import 'package:myactivity_project/ramayanaidcash.dart';
import 'package:myactivity_project/ramayana_splashscreen.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/ramayana_login.dart';
import 'package:myactivity_project/ramayana_profile.dart';
import 'package:myactivity_project/ramayanavoid.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  print(formattedDate);
  UserData userData = UserData();
  await userData.getPref();
  String userId = userData.getUsernameID();
  print('grgr 123');
  print(userId);
  var username = prefs.getString("username");
  print(" username : ${username}");
  var waktuLogin = prefs.getString("waktuLogin");
  print("waktu login : ${waktuLogin}");
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then(
    (value) => runApp(MaterialApp(
        builder: (context, child) => ResponsiveWrapper.builder(
              child,
              maxWidth: 1200,
              minWidth: 480,
              defaultScale: true,
              breakpoints: [
                ResponsiveBreakpoint.autoScale(600, name: PHONE),
                ResponsiveBreakpoint.autoScale(800, name: TABLET),
                ResponsiveBreakpoint.autoScale(1200, name: DESKTOP),
              ],
            ),
        title: 'rals-tools',
        debugShowCheckedModeBanner: false,
        home:
            //RamayanaNewPin()
            waktuLogin == formattedDate
                ? DefaultBottomBarController(child: Ramayana())
                : SplashScreenRamayana()
        // username == null ? SplashScreenRamayana() : DefaultBottomBarController(child: Ramayana()),
        // DefaultBottomBarController(child: Ramayana())
        // RamayanaReset()
        // Blank()
        // RamayanaCekHarga()
        // SplashScreenRamayana()

        )),
  );
}

//    void main() => runApp(const MyApp());
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       debugShowCheckedModeBanner: false,
//       home: BarcodeScannerDemo(),
//     );
//   }
// }
// class BarcodeScannerDemo extends StatefulWidget {
//   const BarcodeScannerDemo({Key? key}) : super(key: key);
//   @override
//   _BarcodeScannerDemoState createState() => _BarcodeScannerDemoState();
// }
// class _BarcodeScannerDemoState extends State<BarcodeScannerDemo> {
//   String _scanBarcode = 'Unknown';
//   /// For Continuous scan
//   Future<void> startBarcodeScanStream() async {
//     FlutterBarcodeScanner.getBarcodeStreamReceiver(
//             '#ff6666', 'Cancel', true, ScanMode.BARCODE)!
//         .listen((barcode) => print(barcode));
//   }
//   Future<void> barcodeScan() async {
//     String barcodeScanRes;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
//           '#ff6666', 'Cancel', true, ScanMode.QR);
//       print(barcodeScanRes);
//     } on PlatformException {
//       barcodeScanRes = 'Failed to get platform version.';
//     }
//     if (!mounted) return;
//     setState(() {
//       _scanBarcode = barcodeScanRes;
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Flutter Barcode Scanner Demo'),
//           centerTitle: true,
//           automaticallyImplyLeading: false,
//           backgroundColor: Colors.cyan,
//         ),
//         body: Builder(builder: (BuildContext context) {
//           return Container(
//               alignment: Alignment.center,
//               child: Flex(
//                   direction: Axis.vertical,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     const Image(
//                       image: AssetImage("assets/rama(C).png"),
//                       height: 150,
//                     ),
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     Text('Scan result : $_scanBarcode\n',
//                         style: const TextStyle(
//                             fontSize: 20, fontWeight: FontWeight.bold)),
//                     SizedBox(
//                       height: 45,
//                       child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.cyan,
//                           ),
//                           onPressed: () => barcodeScan(),
//                           child: const Text('Barcode Scan',
//                               style: TextStyle(
//                                   fontSize: 17, fontWeight: FontWeight.bold))),
//                     ),
//                   ]));
//         }));
//   }
// }