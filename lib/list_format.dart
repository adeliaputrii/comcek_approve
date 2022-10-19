import 'package:flutter/material.dart';
import 'package:myactivity_project/form_data_local.dart';

import 'package:myactivity_project/database/db.dart';
import 'package:myactivity_project/models/models_form.dart';
import 'package:myactivity_project/ramayana_home.dart';

class ListActivityPage extends StatefulWidget {
  const ListActivityPage({Key? key}) : super(key: key);

  @override
  _ListActivityPageState createState() => _ListActivityPageState();
}

class _ListActivityPageState extends State<ListActivityPage> {
  List<Activityy> listActivity = [];
  DbHelper db = DbHelper();

  @override
  void initState() {
    //menjalankan fungsi getallkontak saat pertama kali dimuat
    _getAllActivity();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  AppBar(
        title: Text('Ramayana List', style: TextStyle(fontSize: 23)),
        leading: IconButton(
          icon: Icon(Icons.home, 
          size: 30,
          ),
          onPressed: (() {
            Navigator.push(context, MaterialPageRoute(builder: (context){
              return Ramayana();
            }));
          }
        ),
        ),
        backgroundColor: Color.fromARGB(255, 255, 17, 17),
        elevation: 7.20  ,
          toolbarHeight: 90,
        ),
        
      body: Stack(
        
        children: <Widget>[
        
          Container(
          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
            height: 150,
            // width: 500,
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
            margin: EdgeInsets.only(left: 230, top: 90),
            child: Text('Adhelia Putri Wardhana',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500)
            )
        ),

        Container(
          margin: EdgeInsets.fromLTRB(0, 120, 0, 0),
          height: 70,

          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 5)
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
        margin: EdgeInsets.only(top: 190 ),
         decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.black12, spreadRadius: 5, blurRadius: 5)
            ],
          ),
        child: 
      
      ListView.builder(
          itemCount: listActivity.length,
          itemBuilder: (context, index) {
            Activityy activityy = listActivity[index];
            return Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ListTile(
                leading: Icon(
                  Icons.person,
                  color:Color.fromARGB(255, 255, 17, 17),
                  size: 50,
                ),
                title: Text('${activityy.fullname}', 
                      style: TextStyle(
                      color: Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.w500, fontSize: 20)),
                subtitle: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                                      
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("NIK: ${activityy.nik}", 
                      style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Subdivisi: ${activityy.subdivisi}",
                      style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Date Visit: ${activityy.dateVisit}",
                      style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Lokasi: ${activityy.location}",
                      style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Status: ${activityy.status}",
                      style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Deskripsi: ${activityy.description}",
                      style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("Target: ${activityy.target}",
                      style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                    ),
                    
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text("STK Numbers: ${activityy.stkNumbers}",
                      style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w500, fontSize: 15)),
                    ),
                  ],
                ),
                trailing: FittedBox(
                  fit: BoxFit.fill,
                  child: Row(
                    children: [
                      // button edit
                      IconButton(
                          onPressed: () {
                            _openFormEdit(activityy);
                          },
                          icon: Icon(Icons.edit),
                          color: Color.fromARGB(255, 255, 17, 17),
                          ),
                      // button hapus
                      IconButton(
                        icon: Icon(Icons.delete),
                        color: Color.fromARGB(255, 255, 17, 17),
                        onPressed: () {
                          //membuat dialog konfirmasi hapus
                          AlertDialog hapus = AlertDialog(
                            title: Text("Information"),
                            content: Container(
                              height: 30,
                              child: Column(
                                children: [
                                  Text(
                                      "Apakah Anda yakin ingin Menghapus Data ${activityy.fullname}?")
                                ],
                              ),
                            ),
                            //terdapat 2 button.
                            //jika ya maka jalankan _deleteKontak() dan tutup dialog
                            //jika tidak maka tutup dialog
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    _deleteActivity(activityy, index);
                                    Navigator.pop(context);
                                  },
                                  child: Text("Ya",
                                    style: TextStyle(
                                    color:  Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.w500, fontSize: 17)
                                  )
                                    ),
                                  
                              TextButton(
                                child: Text('Tidak',
                                    style: TextStyle(
                                    color:  Color.fromARGB(255, 255, 17, 17), fontWeight: FontWeight.w500, fontSize: 17)),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                              ),
                            ],
                          );
                          showDialog(
                              context: context, builder: (context) => hapus);
                        },
                      )
                    ],
                  ),
                ),
              ),
            );
          }),
      )
      
      ],),
      
      //membuat button mengapung di bagian bawah kanan layar
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color.fromARGB(255, 255, 17, 17),
        child: Icon(Icons.add),
        onPressed: () {
          _openFormCreate();
        },
      ),
    );
  }

  //mengambil semua data Kontak
  Future<void> _getAllActivity() async {
    //list menampung data dari database
    var list = await db.getAllFormat();

    //ada perubahanan state
    setState(() {
      //hapus data pada listKontak
      listActivity.clear();

      //lakukan perulangan pada variabel list
      list!.forEach((activityy) {
        //masukan data ke listKontak
        listActivity.add(Activityy.fromMap(activityy));
      });
    });
  }

  //menghapus data Kontak
  Future<void> _deleteActivity(Activityy activityy, int position) async {
    await db.deleteActivityy(activityy.id_act!);
    setState(() {
      listActivity.removeAt(position);
    });
  }

  // membuka halaman tambah Kontak
  Future<void> _openFormCreate() async {
    var result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => FormAct()));
    if (result == 'save') {
      await _getAllActivity();
    }
  }

  //membuka halaman edit Kontak
  Future<void> _openFormEdit(Activityy activityy) async {
    var result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => FormAct(activityy: activityy)));
    if (result == 'update') {
      await _getAllActivity();
    }
  }
}
