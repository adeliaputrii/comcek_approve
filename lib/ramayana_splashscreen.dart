import 'package:flutter/material.dart';
import 'package:myactivity_project/ramayana_login.dart';
import 'package:tbib_splash_screen/splash_screen_view.dart';

class SplashScreenRamayana extends StatefulWidget {
  const SplashScreenRamayana({super.key});

  @override
  State<SplashScreenRamayana> createState() => _SplashScreenRamayanaState();
}

class _SplashScreenRamayanaState extends State<SplashScreenRamayana> {
  bool isLoaded = false;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 10)).then((value) => setState(() {
          isLoaded = true;
        }));
  }
  @override
  Widget build(BuildContext context) {
    return SplashScreenView(
      navigateWhere: isLoaded,
      navigateRoute: RamayanaLogin(), backgroundColor: Colors.white,
      linearGradient: const LinearGradient(
          colors: [
            Colors.white,
            Colors.white,

          ],
          begin: FractionalOffset(0.0, 0.0),
          end: FractionalOffset(1.0, 0.0),
          stops: [0.0, 1.0],
          tileMode: TileMode.clamp),
          logoSize: 150,
          
      text: FadeAnimatedText(
        "",
        textStyle: const TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ), 
       
      ),
      imageSrc: "assets/ram.png",
    );
  }
}