import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:myactivity_project/models/model_anakan_modul.dart';
import 'package:myactivity_project/settingsralstools.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Anakan extends StatefulWidget {
  const Anakan({super.key});

  @override
  State<Anakan> createState() => _AnakanState();
}

class _AnakanState extends State<Anakan> {
  String? _hakAkses;
  Dio dio = Dio();

  @override
  void initState() {
    super.initState();
    _loadhakAkses();
    
  }

    _loadhakAkses() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    print('hakAksesooo ${prefs.getString('hakAkses')}');
    setState(() {
      _hakAkses = (prefs.getString('hakAkses') ?? '');
      print('hak akses : ${_hakAkses}');
      fetchAnakan(akses_menu: '${_hakAkses}');
    });
    return _hakAkses;
  }

  fetchAnakan({
    required String akses_menu}) async {
    print('oke');
    try {
      ModulAnakan.modulanakan.clear();
      final responseku = await http.post(
          Uri.parse('${tipeurl}v1/activity/tbl_mastermenu'),
          body: {
            'akses_menu': akses_menu
            });

      var data = jsonDecode(responseku.body);

      if (data['status'] == 200) {
        print("API Success");
        print(data);
    
        int count = data['data'].length;
        final Map<String, ModulAnakan> profileMap = new Map();
        for (int i = 0; i < count; i++) {
          ModulAnakan.modulanakan.add(ModulAnakan.fromjson(data['data'][i]));
        }
        ModulAnakan.modulanakan.forEach((element) {
          profileMap[element.name_menu] = element;
          ModulAnakan.modulanakan = profileMap.values.toList();
        });
        print('check length ${ModulAnakan.modulanakan.length}');
        print(data['data'].toString());
        if (ModulAnakan.modulanakan.length == 0) {
          print('NO DATA');
        } else {
          print('NO DATA');
        }
      }
    } on Exception {
      print('EROR');
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Anakan Menu'),
      ),
      body: Stack(
        children: ModulAnakan.modulanakan.map((e) {

        return
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                MaterialButton(
                  color: Color.fromARGB(255, 189, 106, 85),
                  shape: CircleBorder(
                
                  ),
                  height: 90,
                
                  onPressed: () async {
                  },
                  child: Icon(Icons.account_balance_rounded),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                Text('${e.name_menu}', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),)
              ],
            ),
          );
        }).toList()
      ),
    );
  }
}