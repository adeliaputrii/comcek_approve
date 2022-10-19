import 'dart:ffi';

import 'package:flutter/material.dart';

import 'db.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key,}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  late String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String itemTitle = '';
  String itemNik = '';
  List items = [];

  insertShoppingItems() async {
    await insertItemsToDb(itemTitle, itemNik, 0);
    getItemsFromDb();
  }

  getItemsFromDb() async {
    List shoppingItems = await retreiveItemsFromDb();
    setState(() {
      items = shoppingItems;
    });
  }

  @override
  Widget build(BuildContext context) {
    getItemsFromDb();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar:  AppBar(
        title: Text('Ramayana Data Lokal', style: TextStyle(fontSize: 23)),
        backgroundColor: Color.fromARGB(255, 255, 17, 17),
        elevation: 7.20  ,
          toolbarHeight: 90,
        ),   
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              // text field
              title: TextFormField(
              cursorHeight: 35,
              cursorColor: Colors.black,
                onChanged: (String mytitle) {
                  setState(() {
                    itemTitle = mytitle;
                  });
                },
                decoration:
                    
                    InputDecoration(
                      hintText: 'Masukkan Data',
                    focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            )
                            ),
                    
                style: TextStyle(fontSize: 17, height: 2),
              ),
              // add button
              trailing: MaterialButton(
                color: Color.fromARGB(255, 255, 17, 17),
                height: 40,
                onPressed: () {
                  // insert into the database
                  insertShoppingItems();
                },
                child: const Text('ADD', style: TextStyle(fontSize: 17, color: Colors.white)),
              ),
            ),

             ListTile(
              // text field
              title: TextFormField(
              cursorHeight: 35,
              cursorColor: Colors.black,
                onChanged: (String mynik) {
                  setState(() {
                    itemNik = mynik;
                  });
                },
                decoration:
                    
                    InputDecoration(
                      hintText: 'Masukkan Data',
                    focusedBorder: UnderlineInputBorder(
                              borderSide: new BorderSide(color: Colors.black),
                            )
                            ),
                    
                style: TextStyle(fontSize: 17, height: 2),
              ),
              // add button
              trailing: MaterialButton(
                color: Color.fromARGB(255, 255, 17, 17),
                height: 40,
                onPressed: () {
                  // insert into the database
                  insertShoppingItems();
                },
                child: const Text('ADD', style: TextStyle(fontSize: 17, color: Colors.white)),
              ),
            ),
            // Data
            DataTable(
              columns: [
                DataColumn(
                  label: Text("Select", style: TextStyle(fontSize: 18),),
                  numeric: false,
                ),
                DataColumn(
                  label: Text("Nama", style: TextStyle(fontSize: 18)),
                  numeric: false,
                ),
                DataColumn(
                  label: Text("NIK", style: TextStyle(fontSize: 18)),
                  numeric: false,
                ),
                DataColumn(
                  label: Text("Delete", style: TextStyle(fontSize: 18)),
                  numeric: false,
                )
              ],
              rows: items
                  .map<DataRow>((item) => DataRow(cells: [
                        DataCell(
                            Checkbox(
                                value: item['BOUGHT'] == 1 ? true : false,
                                onChanged: (newValue) {}),
                            onTap: () {}),
                        DataCell(
                            Text(
                              item['TITLE'],
                              style: TextStyle(
                                fontSize: 17,
                                decoration: item['BOUGHT'] == 1
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            onTap: () {}),
                            DataCell(
                            Text(
                              item['NIK'],
                              style: TextStyle(
                                fontSize: 17,
                                decoration: item['BOUGHT'] == 1
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                              ),
                            ),
                            onTap: () {}),
                        DataCell(
                            Icon(Icons.delete,
                                color: Color(0xffDB4437), size: 25),
                            onTap: () async {}),
                      ]))
                  .toList(),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}