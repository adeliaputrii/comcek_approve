import 'package:flutter/material.dart';

class RamayanaApproveUpdate extends StatefulWidget {
  const RamayanaApproveUpdate({super.key});

  @override
  State<RamayanaApproveUpdate> createState() => _RamayanaApproveUpdateState();
}

class _RamayanaApproveUpdateState extends State<RamayanaApproveUpdate> {

  bool _checkBoxVal = false;

 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Approve', style: TextStyle(fontSize: 23)),
        backgroundColor: Color.fromARGB(255, 255, 17, 17),
        elevation: 5  ,
        toolbarHeight: 90,
        ),

      body: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 30, 10, 0),
            height: 80,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 244, 244),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 1, 
                  color: Colors.red
                ),
            ),
            child: 
            Container(
              margin: EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Jumlah SKU', 
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Checkbox(
                    activeColor: Colors.red,
                    onChanged: (value) {
                      _checkBoxVal = value!;
                      setState(() {});
                    },
                    value: _checkBoxVal,)
                ],
              ),
            ),
          ),
           Container(
            margin: EdgeInsets.fromLTRB(10, 150, 10, 0),
            height: 200,
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 255, 244, 244),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                  width: 1, 
                  color: Colors.red
                ),
            ),
            child: 
            Container(
              margin: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text('Jumlah SKU', 
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Checkbox(
                    activeColor: Colors.red,
                    onChanged: (value) {
                      _checkBoxVal = value!;
                      setState(() {});
                    },
                    value: _checkBoxVal,)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}