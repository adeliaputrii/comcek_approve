import 'dart:convert';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:expandable_bottom_bar/expandable_bottom_bar.dart';
import 'package:flutter/services.dart';
import 'package:flutter_udid/flutter_udid.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:myactivity_project/models/model_searchtoko.dart';
import 'package:myactivity_project/models/model_toko.dart';
import 'package:myactivity_project/models/models_approval_return_list.dart';
import 'package:myactivity_project/ramayana_cekharga.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:myactivity_project/settingsralstools.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RamayanaCariToko extends StatefulWidget {
  const RamayanaCariToko({super.key});

  @override
  State<RamayanaCariToko> createState() => _RamayanaCariTokoState();
}

class _RamayanaCariTokoState extends State<RamayanaCariToko> {
  TextEditingController controller = TextEditingController();
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  bool isLoading = false;
  bool api = false;
  List<SearchToko> _foundtoko = [];
  String _keyword = "";
  String _udid = 'Unknown';
  UserData userData = UserData();

  @override
  void initState() {
    super.initState();
    api;
    fetchHarga(toko: '${userData.getUserToko()}');
    deleteToko();

    // _foundtoko = SearchToko.searchtoko;
  }

  Future<void> initPlatformState() async {
    String udid;
    try {
      udid = await FlutterUdid.consistentUdid;
    } on PlatformException {
      udid = 'Failed to get UDID.';
    }

    if (!mounted) return;

    setState(() {
      _udid = udid;
    });
  }

  Future<void> deleteToko() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.remove('toko');
  }

  List<SearchToko> _getFilteredList() {
    if (_keyword.isEmpty) {
      return SearchToko.searchtoko;
    }
    return SearchToko.searchtoko
        .where((user) =>
            user.store_code.toLowerCase().contains(_keyword.toLowerCase()))
        .toList();
  }

  fetchHarga({
    required String toko,
  }) async {
    SearchToko.searchtoko.clear();
    final responseku = await http.post(
        Uri.parse('${tipeurl}v1/activity/tbl_liststore'),
        body: {'toko': toko});

    var data = jsonDecode(responseku.body);

    if (data['pesan'] == 'RHO') {
      setState(() {
        api = false;
        print(api);
      });
      print("API Success");
      print(data);
      int count = data['data'].length;
      for (int i = 0; i < count; i++) {
        SearchToko.searchtoko.add(SearchToko.fromjson(data['data'][i]));
      }
      print('check length ${SearchToko.searchtoko.length}');
      print(data['data'].toString());
      if (SearchToko.searchtoko.length == 0) {
        AlertDialog popup1 = AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),

          // shadowColor: Colors.black,
          titlePadding: EdgeInsets.all(0),
          title: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              height: 170,
              width: 2000,
              child: Image.asset(
                'assets/omaigat.png',
              )),
          content: Container(
            margin: EdgeInsets.only(bottom: 10),
            height: 30,
            child: Center(
              child: Text(
                'Tidak ada data yang membutuhkan persetujuan',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          actionsAlignment: MainAxisAlignment.start,
          actionsPadding: EdgeInsets.only(bottom: 20),
        );
        showCupertinoModalPopup(context: context, builder: (context) => popup1);
      }
    } else if (data['pesan'] == 'Bukan RHO') {
      setState(() {
        api = true;
        print(api);
      });
      final Map<String, ModelToko> profileMap = new Map();
      if (ModelToko.menutoko.isEmpty) {
        setState(() {
          ModelToko.menutoko.add(data['data']);
        });
      } else {
        print('satu aja');
      }

      print('check length ${SearchToko.searchtoko.length}');
      print(data['data'].toString());
    } else {
      print('NO DATA');
    }

    setState(() {});
  }
  // List<SearchToko> searchtoko = SearchToko.searchtoko;
  // void searchlisttoko(String query) {
  //   List<SearchToko> result = [];
  //   if (query.isEmpty) {
  //     result = SearchToko.searchtoko;
  //   } else {
  //     result = SearchToko.searchtoko.where((toko) =>
  //       toko.store_code.toLowerCase().contains(query.toLowerCase())).toList();
  //     print(result);
  //     setState(() {

  //     });

  //   }

  // final suggestion = SearchToko.searchtoko.where((element) {
  //   final toko = element.store_code.toLowerCase();
  //   final input = query.toLowerCase();
  //   // print(toko.contains(input));
  //   return toko.contains(input);

  // }).toList();
  // setState(() {
  //   searchtoko = suggestion;
  // });
  // }

  @override
  Widget build(BuildContext context) {
    final filteredList = _getFilteredList();
    return WillPopScope(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        DefaultBottomBarController(child: Ramayana()),
                  ),
                  (Route<dynamic> route) => false);
            },
          ),
          title: Text('Cari Toko', style: TextStyle(fontSize: 23)),
          backgroundColor: Color.fromARGB(255, 255, 17, 17),
          elevation: 6,
          toolbarHeight: 100,
        ),
        body: Stack(children: [
          Container(
            color: Colors.white,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
            decoration: BoxDecoration(
                color: Color.fromARGB(255, 232, 231, 229),
                borderRadius: BorderRadius.circular(40)),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 30),
                  height: 50,
                  width: 300,
                  // color: Colors.red,
                  child: TextFormField(
                    controller: controller,
                    onChanged: (text) {
                      setState(() {
                        _keyword = text;
                        print(_keyword);
                      });
                    },
                    cursorColor: Colors.black,
                    decoration: InputDecoration(
                      hintText: 'Masukkan Kode Toko',
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 110,
                  // color: Colors.green,
                  child: Row(
                    children: [
                      IconButton(
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await Future.delayed(const Duration(seconds: 3));
                            await fetchHarga(toko: '${userData.getUserToko()}');
                            setState(() {
                              isLoading = false;
                            });
                          },
                          icon: Icon(Icons.search)),
                      IconButton(onPressed: () {}, icon: Icon(Icons.cancel))
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.fromLTRB(20, 100, 20, 0),
            // color: Colors.red,
            child: api
                ? ListView(
                    children: ModelToko.menutoko.map(
                    (e) {
                      return Column(
                        children: [
                          ListTile(
                              leading: Text(
                                '${e}',
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w500),
                              ),
                              onTap: () async {
                                SharedPreferences pref =
                                    await SharedPreferences.getInstance();
                                pref.setString('toko', '${e}');
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  print(e);

                                  return RamayanaCekHarga();
                                }));
                              }),
                        ],
                      );
                    },
                  ).toList())
                :
                // ListView(
                //   children: SearchToko.searchtoko.map((e) {
                //     return Column(
                //       children: [
                //         ListTile(
                //           leading:
                //           Text('${e.ka_toko}', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),),
                //           // title:Text('${filteredList[index].store_name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),) ,
                //           // subtitle: Text('${filteredList[index].address}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),) ,
                //         onTap: () async {
                //           SharedPreferences pref = await SharedPreferences.getInstance();
                //             pref.setString('toko', '${filteredList[index].store_code}');
                //           Navigator.push(context, MaterialPageRoute(builder: (context){
                //           //  print(filteredList[index].store_code);

                //             return RamayanaCekHarga();

                //           }));

                //              }           ),
                //       ],
                //     );
                //   }).toList()
                // )
                ListView.builder(
                    itemCount: filteredList.length,
                    itemBuilder: (context, index) {
                      final namaToko = filteredList[index];
                      return Container(
                          margin: EdgeInsets.all(25),
                          height: 70,
                          // color: Colors.cyan,
                          child: Column(
                            children: [
                              ListTile(
                                  leading: Text(
                                    '${filteredList[index].store_code}',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  // title:Text('${filteredList[index].store_name}', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),) ,
                                  // subtitle: Text('${filteredList[index].address}', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),) ,
                                  onTap: () async {
                                    SharedPreferences pref =
                                        await SharedPreferences.getInstance();
                                    pref.setString('toko',
                                        '${filteredList[index].store_code}');
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      print(filteredList[index].store_code);

                                      return RamayanaCekHarga();
                                    }));
                                  }),
                            ],
                          ));
                    }),
          ),
        ]),
      ),
      onWillPop: () async {
        if (true) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return DefaultBottomBarController(child: Ramayana());
          }), (route) => false);
          return true;
        }
      },
    );
  }
}
