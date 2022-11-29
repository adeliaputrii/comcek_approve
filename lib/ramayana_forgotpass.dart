import 'package:flutter/material.dart';

class ForgotPass extends StatefulWidget {
  const ForgotPass({super.key});

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 255, 17, 17),
          elevation: 0  ,
          toolbarHeight: 1,
      ),

      body: Stack(
        children: <Widget>[
          Container(
            // height: 350,
            color:  Color.fromARGB(255, 255, 17, 17),
          ),
          Container(
            height: 250,
            width: 250,
            margin: EdgeInsets.only(top: 50, left: 115, right: 115),
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child: Image.asset('assets/forgot.png',
             
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 400),
            decoration: BoxDecoration(
              color: Colors.white,
             borderRadius: BorderRadius.only(
              topLeft: Radius.circular(100)
             )
            ),
            
          ),
          Container(
            margin: EdgeInsets.fromLTRB(125, 330, 125, 0),
            child:
                Text('Forgot Password?',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
                ),
          ),
          //  Container(
          //    margin: EdgeInsets.fromLTRB(30, 530, 0, 0),
          //   child:
          //    Text('Please enter your ID',
          //    style: TextStyle(fontSize: 18,color: Colors.black),
          //    )
          //    ),

              Container(
             margin: EdgeInsets.fromLTRB(30, 550, 50, 0),
            child:
             TextFormField(
             cursorColor: Colors.black,
                     
                         style: TextStyle(fontSize: 18, color: Colors.black),
                         decoration: InputDecoration(  
                         border: UnderlineInputBorder(
                         borderSide: BorderSide(
                         color: Colors.black, 
                         )
                             ),
                          labelStyle: TextStyle(
                           color: Colors.black
                           ),
                           icon: Icon(Icons.person,
                           size: 30,
                           color: Colors.black,
                           ),
                           hintText: 'Enter Your ID',
                           hintStyle: TextStyle(
                             color:  Colors.black,
                             fontSize: 18
                           ),
                              enabledBorder: UnderlineInputBorder(borderSide: new BorderSide(color: Colors.black),),
                              focusedBorder: UnderlineInputBorder(
                                 borderSide: new BorderSide(color: Colors.black),
                              )
                         ),
                       ),
             ),

             Container(
              margin: EdgeInsets.fromLTRB(160, 700, 160, 50),
               child: MaterialButton(
                shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 50),
                onPressed: () {},
                color: Color.fromARGB(255, 255, 17, 17),
                child: Text('Submit',
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                ),
                ),
             )
        ],
      ),
    );
  }
}