        import 'package:flutter/material.dart';
        
        
        class Androidlarge1Widget extends StatefulWidget {
        @override
        _Androidlarge1WidgetState createState() => _Androidlarge1WidgetState();
        }
        
        class _Androidlarge1WidgetState extends State<Androidlarge1Widget> {
        @override
        Widget build(BuildContext context) {
        // Figma Flutter Generator Androidlarge1Widget - FRAME
        
        return Container(
      width: 360,
      height: 800,
      decoration: BoxDecoration(
          color : Color.fromRGBO(250, 250, 250, 1),
  ),
      child: Stack(
        children: <Widget>[
          Positioned(
        top: 0,
        left: 0,
        child: Image.asset(
        'assets/images/rectangle7.png',
      )
      ),Positioned(
        top: 18,
        left: 57,
        child: Text('Profile', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(250, 250, 250, 1),
        fontFamily: 'Inter',
        fontSize: 18,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),
      // Positioned(
      //   top: 66,
      //   left: 1,
      //   child: null
      // ),
      Positioned(
        top: 264,
        left: 28,
        child: Container(
        width: 292,
        height: 170,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(8),
            topRight: Radius.circular(8),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
          ),
      image : DecorationImage(
          image: AssetImage('assets/images/Rectangle8.png'),
          fit: BoxFit.fitWidth
      ),
  )
      )
      ),Positioned(
        top: 85,
        left: 28,
        child: Image.asset(
        'assets/images/rectangle.png',
        
      )
      ),Positioned(
        top: 541,
        left: 13,
        child: Divider(
        color: Color.fromRGBO(0, 0, 0, 1),
        thickness: 1
      )
      
      ),Positioned(
        top: 474,
        left: 13,
        child: Text('Fullname', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Inter',
        fontSize: 12,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),Positioned(
        top: 626,
        left: 13,
        child: Divider(
        color: Color.fromRGBO(0, 0, 0, 1),
        thickness: 1
      )
      
      ),Positioned(
        top: 558,
        left: 13,
        child: Text('Email', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Inter',
        fontSize: 12,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),Positioned(
        top: 706,
        left: 13,
        child: Divider(
        color: Color.fromRGBO(0, 0, 0, 1),
        thickness: 1
      )
      
      ),Positioned(
        top: 641,
        left: 13,
        child: Text('Subdivisi', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(0, 0, 0, 1),
        fontFamily: 'Inter',
        fontSize: 12,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),Positioned(
        top: 734,
        left: 12,
        child: Container(
        width: 335,
        height: 34,
        decoration: BoxDecoration(
          borderRadius : BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
            bottomLeft: Radius.circular(4),
            bottomRight: Radius.circular(4),
          ),
      color : Color.fromRGBO(247, 25, 25, 1),
  )
      )
      ),Positioned(
        top: 740,
        left: 137,
        child: Text('UPDATE', textAlign: TextAlign.left, style: TextStyle(
        color: Color.fromRGBO(250, 250, 250, 1),
        fontFamily: 'Inter',
        fontSize: 18,
        letterSpacing: 0 /*percentages not used in flutter. defaulting to zero*/,
        fontWeight: FontWeight.normal,
        height: 1
      ),)
      ),
        ]
      )
    );
        }
        }
        