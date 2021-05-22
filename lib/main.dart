import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Screens/IntroScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SplashScreen(),
  ));
}
class SplashScreen extends StatefulWidget  {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  AnimationController controller;
  Animation <double> animation;
  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
  }

  @override
  void initState() {
    controller=AnimationController(vsync: this,duration: Duration(seconds: 2));
    animation=Tween<double>(begin: 1.0,end: 0.6).animate(controller);
    controller.forward();
    Future.delayed(Duration(seconds: 5),(){
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context)=>IntroScreen()
      ));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("8B5FBF"),
      body: Container(
        child: Center(
          child: ScaleTransition(
            scale: animation,
            child: Text(
              "EDUCISE",
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Horizon",
                fontSize: 60
              ),
            ),
          ),
        ),
      )
    );
  }
}
