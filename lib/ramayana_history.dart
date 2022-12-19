import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:myactivity_project/models/models_act.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:myactivity_project/ramayana_activity.dart';
import 'package:myactivity_project/ramayana_home.dart';
import 'package:myactivity_project/service/SP_service/SP_service.dart';
import 'package:url_launcher/url_launcher.dart';

class RamayanaHistory extends StatefulWidget {
  const RamayanaHistory({super.key});

  @override
  State<RamayanaHistory> createState() => _RamayanaHistoryState();
}

class _RamayanaHistoryState extends State<RamayanaHistory> {

  UserData userData = UserData();

  void fetchProduk() async {
    AktivitasModel.aktivitaslist.clear();
    final responseku = await http.post(
      Uri.parse('http://ramayana.joeloecs.com/mobileapi/fetch_data_act.php'),
        body: {
          "id_act": 'nothing',
        });

    var data = jsonDecode(responseku.body);
    if (data[0]['result'] == '1') {
      int count = data[1].length;
      for (int i = 0; i < count; i++) {
        AktivitasModel.aktivitaslist.add(AktivitasModel.fromjson(data[1][i]));
      }

      print('check length ${AktivitasModel.aktivitaslist.length}');
      print(data[1].toString());

    } else {
      print('NO DATA');
    }

    setState(() {});
  }

  void deleteProduk(id_act) async {
    AktivitasModel.aktivitaslist.clear();
    final responseku = await http.post(
      Uri.parse('http://ramayana.joeloecs.com/mobileapi/deleted_data_act.php'),
        body: {
          "id_act": id_act,
        });

    var data = jsonDecode(responseku.body);
    if (['value'] == 1) {
      setState(() {
        fetchProduk();
      });
    print('check length ${AktivitasModel.aktivitaslist.length}');
    } else {
      print('NO DATA');
    }
    setState(() {});
  }

  void initState() {
    super.initState();
    fetchProduk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: TextField(
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide.none,
            ),
            isCollapsed: true,
            labelText: 'Search',
            prefixIcon: Icon(Icons.search),
            // suffixText: 'Search'
          ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 17, 17),
        elevation: 7.20,
        toolbarHeight: 90,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.filter_1),
            onPressed: () {},
          ),
        ],
      ),

      body: Stack(
        children: <Widget>[

        Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 150,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 232, 15, 15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 3,
                  blurRadius: 3,
                )
              ],
            )
        ),

        Container(
          margin: EdgeInsets.only(left: 10, top: 20),
            child: Text('List Activity',
              style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.w700)
            ),
        ),

        Container(
          margin: EdgeInsets.only(right: 0, top: 70, left: 10),
            child: 
            ListTile(
              trailing: Text('${userData.getFullname()} ${userData.getUsernameID()}',
               style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.w500)
              )
            )
        ),

        Container(
          margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
          height: 70,
          decoration: 
          BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 15)
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment:CrossAxisAlignment.center,
            children: <Widget>[
              Text('ALL',
                  style: TextStyle(
                      color: Color.fromARGB(221, 101, 89, 89),
                      fontSize: 17,
                      fontWeight: FontWeight.w700)),
              Text('TRASH',
                  style: TextStyle(
                      color: Color.fromARGB(221, 101, 89, 89),
                      fontSize: 17,
                      fontWeight: FontWeight.w700))
            ],
          ),
        ),

        Container(
            margin: EdgeInsets.only(top: 180),
            decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 3, blurRadius: 5)
            ],
          ),
            child: ListView(
              children: AktivitasModel.aktivitaslist.map((e) {
                print('nama user ${e.fullname}');
                return ListTile(
                  leading: Text('${e.id_act}'),
                  title: Text('${e.fullname}'),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      deleteProduk(e.id_act);
                      fetchProduk();
                      setState(() {
                      });
                    },
                  ),
                  subtitle: Text('${e.subdivisi}'),
                  tileColor: Colors.green[100],
                );
              }).toList(),
            ))
      ]),
      
      floatingActionButton: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 255, 17, 17),
          child: Icon(Icons.add),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Activity();
            }));
          }),
    );
  }
}
