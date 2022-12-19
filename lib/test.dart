import 'package:flutter/material.dart';

class Chomcheck extends StatefulWidget {
  const Chomcheck({super.key});

  @override
  State<Chomcheck> createState() => _ChomcheckState();
}

class _ChomcheckState extends State<Chomcheck> {
  bool _checkBoxVal = false;
  bool click = true;
  bool click2 = true;
  bool value = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedCrossFade(
            crossFadeState:
                click ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 800),
            firstChild: 
           Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 180,
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
              margin: EdgeInsets.only(left: 10, right: 10, top: 0),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('MD', 
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20, decoration: TextDecoration.underline),
                          ),
                        SizedBox(
                          width: 30,
                        ),
                       Text('SKU', 
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20, decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                          width: 30,
                        ),
                       Text('Nama Barang', 
                     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20, decoration: TextDecoration.underline),
                      ),
                      ],
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
                  Container(
                    margin: EdgeInsets.only(left: 15),
                    child: Text('Selisih Harga',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 20),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                           decoration:  BoxDecoration(
                          border: Border.all(
                          width: 1, 
                          color: Colors.red
                        ),
                        color: Colors.white,
                          ),
                          height: 35,
                          width: 130,
                          child: 
                          Center(child: Text('Start Date', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black),)),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                           decoration:  BoxDecoration(
                          border: Border.all(
                          width: 1, 
                          color: Colors.red
                        ),
                        color: Colors.white,
                          ),
                          height: 35,
                          width: 130,
                          child: 
                          Center(child: Text('End Date', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black),)),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: 38,
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          click = !click;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
            secondChild: 
             Container(
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            height: 300,
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
              margin: EdgeInsets.only(left: 10, right: 10, top: 0),
              child: 
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('MD', 
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20, decoration: TextDecoration.underline),
                          ),
                        SizedBox(
                          width: 30,
                        ),
                       Text('SKU', 
                      style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20, decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                          width: 30,
                        ),
                       Text('Nama Barang', 
                     style: TextStyle(color: Colors.black, fontWeight: FontWeight.w500, fontSize: 20, decoration: TextDecoration.underline),
                      ),
                      ],
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
                  Container(
                    margin: EdgeInsets.only(left: 15, top: 10),
                    child: Text('Selisih Harga',
                    style: TextStyle(color: Colors.black, fontWeight: FontWeight.w400, fontSize: 18),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 20),
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                           decoration:  BoxDecoration(
                          border: Border.all(
                          width: 1, 
                          color: Colors.red
                        ),
                        color: Colors.white,
                          ),
                          height: 35,
                          width: 130,
                          child: 
                          Center(child: Text('Start Date', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black),)),
                        ),
                        SizedBox(height: 10),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                           decoration:  BoxDecoration(
                          border: Border.all(
                          width: 1, 
                          color: Colors.red
                        ),
                        color: Colors.white,
                          ),
                          height: 35,
                          width: 130,
                          child: 
                          Center(child: Text('End Date', style: TextStyle(fontWeight: FontWeight.w500, fontSize: 17, color: Colors.black),)),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(20, 20, 0, 0),
                    child: Column(
                      children: [
                        Text(
                          'HB             :',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'HJ             :',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'HJ BARU  :',
                         style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_drop_down,
                      ),
                      iconSize: 38,
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          click = !click;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          ),
          SizedBox(height: 10),
          AnimatedCrossFade(
            crossFadeState:
                click2 ? CrossFadeState.showFirst : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 800),
            firstChild: Container(
              height: 150,
              width: 500,
              color: Colors.amber,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_drop_down,
                ),
                iconSize: 50,
                color: Colors.lightGreen,
                onPressed: () {
                  setState(() {
                    click2 = !click2;
                  });
                },
              ),
            ),
            secondChild: Container(
              height: 150,
              width: 500,
              color: Colors.lightBlue,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_drop_down,
                ),
                iconSize: 50,
                color: Colors.lightGreen,
                onPressed: () {
                  setState(() {
                    click2 = !click2;
                  });
                },
              ),
            ),
          ),
         
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        setState(() {
          click = !click;
        });
      }),
    );
  }
}