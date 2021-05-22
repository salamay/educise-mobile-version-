import 'dart:convert';

import 'package:animations/animations.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:educise/API/Post.dart';
import 'package:educise/Screens/SigningIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui' as ui;

import 'package:hexcolor/hexcolor.dart';

import 'Register.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}


class _SignInState extends State<SignIn> {
  final _key=GlobalKey<FormState>();
  String _staffid=null;
  String _password=null;
  String _schoolid=null;
  showFailed(int statusCode,String message){
    AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'Error',
        desc:"Finished with response code ${statusCode} \n ${message}",
        btnOkOnPress: () {},
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }
  @override
  Widget build(BuildContext context) {
    double WIDTH = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          width:MediaQuery.of(context).size.width ,

          child: Stack(
            children: [
               CustomPaint(
                size: Size(WIDTH*0.6,(WIDTH*3.0).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter2(),
              ),
               CustomPaint(
                size: Size(WIDTH*0.4,(WIDTH*3.4).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                painter: RPSCustomPainter(),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height*0.09 ,
                left: MediaQuery.of(context).size.width*0.4,
                child: SizedBox(
                  height: 300,
                  width: 300,
                  child: Image.asset("asset/undraw_professor_8lrt-removebg-preview.png")
                )
              ),
              Positioned(
                top: MediaQuery.of(context).size.height*0.3,
                left:MediaQuery.of(context).size.width*0.4 ,
                child: Container(
                  child: Text(
                    "Sign In",
                    style: GoogleFonts.lato(
                        color: HexColor("8B5FBF"),
                        fontSize: 30
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: MediaQuery.of(context).size.height*0.4,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width*0.9 ,
                    child: Form(
                      key: _key,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center ,
                        children: [
                          TextFormField(
                            inputFormatters: [new  WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),],
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                  color: Colors.green
                              ),
                              icon: Icon(
                                Icons.tag,
                                size: 18,
                                color: HexColor("8B5FBF"),
                              ),
                              hintText: "Enter school id",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    width: 1.0,
                                    color: HexColor("E3EBFF"),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                            ),
                            onChanged: (val){
                              setState(() {
                                _schoolid=val;
                              });
                            },
                            validator: (val)=> val.isEmpty?"please provide a valid password":null,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                          TextFormField(
                            inputFormatters: [new  WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),],
                            decoration: InputDecoration(
                                errorStyle: TextStyle(
                                    color: Colors.green
                                ),
                                icon: Icon(
                                  Icons.people,
                                  color: HexColor("8B5FBF"),
                                  size: 18,
                                ),
                                hintText: "Staff id",
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      width: 1.0,
                                      color:HexColor("E3EBFF"),
                                    ),
                                    borderRadius: BorderRadius.all(Radius.circular(20))
                                )
                            ),
                            onChanged: (val){
                              setState(() {
                                _staffid=val;
                              });
                            },
                            validator: (val)=>val.isEmpty?"Please enter a valid staff id":null,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.05,),
                          TextFormField(
                            inputFormatters: [new  WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),],
                            decoration: InputDecoration(
                              errorStyle: TextStyle(
                                color: Colors.green
                              ),
                              icon: Icon(
                                Icons.lock,
                                size: 18,
                                color: HexColor("8B5FBF"),
                              ),
                              hintText: "password",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      width: 1.0,
                                      color: HexColor("E3EBFF"),
                                  ),
                                  borderRadius: BorderRadius.all(Radius.circular(20))
                              ),
                            ),
                            obscureText: true,
                            onChanged: (val){
                              setState(() {
                                _password=val;
                              });
                            },
                            validator: (val)=> val.length<6?"please provide a valid password":null,
                          ),
                          SizedBox(height: MediaQuery.of(context).size.height*0.09,),

                          FlatButton(
                  hoverColor: Colors.white70,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(
                          color: Colors.white
                      )
                  ),
                  color: HexColor("48A986"),
                  onPressed: ()async{
                    if(_key.currentState.validate()){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SigningIn(staffid: _staffid,schoolid: _schoolid,password: _password,)));
                    }
                  },

                  child: Text(
                    "Sign in",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.normal
                    ),
                  ),
                ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text("Not a member "),
                              SizedBox(width: 3,),
                              RaisedButton(
                                elevation:30,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(20)),
                                    side: BorderSide(
                                        color: HexColor("E3EBFF"),
                                    )
                                ),
                                color: Colors.white,
                                onPressed:(){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Register()));
                                  },
                                child: Text(
                                  "Register",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.normal
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  )
              )
            ],
          ),
        ),
      ),
    );
  }
}
class RPSCustomPainter extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color = HexColor("48a9a6")
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path_0 = Path();
    path_0.moveTo(0,size.height*0.0025000);
    path_0.lineTo(size.width*0.3266667,0);
    path_0.quadraticBezierTo(size.width*0.6700000,size.height*0.1035000,size.width*0.6733333,size.height*0.1980000);
    path_0.cubicTo(size.width*0.6650000,size.height*0.2955000,size.width*0.3400000,size.height*0.3055000,size.width*0.3400000,size.height*0.3980000);
    path_0.cubicTo(size.width*0.3366667,size.height*0.4960000,size.width*0.6633333,size.height*0.5045000,size.width*0.6600000,size.height*0.6000000);
    path_0.cubicTo(size.width*0.6683333,size.height*0.6955000,size.width*0.3350000,size.height*0.7040000,size.width*0.3266667,size.height*0.8020000);
    path_0.quadraticBezierTo(size.width*0.3300000,size.height*0.8957600,size.width*0.6733333,size.height*0.9970000);
    path_0.lineTo(size.width*0.0066667,size.height*0.9960000);
    path_0.lineTo(0,size.height*0.0025000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
class RPSCustomPainter2 extends CustomPainter{

  @override
  void paint(Canvas canvas, Size size) {



    Paint paint_0 = new Paint()
      ..color =HexColor("e3ebff")
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;


    Path path_0 = Path();
    path_0.moveTo(0,0);
    path_0.quadraticBezierTo(size.width*0.5578125,0,size.width*0.7437500,0);
    path_0.cubicTo(size.width*0.6815625,size.height*0.0515000,size.width*0.5009500,size.height*0.1045000,size.width*0.4950000,size.height*0.2060000);
    path_0.cubicTo(size.width*0.5025000,size.height*0.2970000,size.width*0.7425000,size.height*0.3040000,size.width*0.7500000,size.height*0.4000000);
    path_0.cubicTo(size.width*0.7425000,size.height*0.4980000,size.width*0.4962500,size.height*0.5015000,size.width*0.4950000,size.height*0.6020000);
    path_0.cubicTo(size.width*0.5025000,size.height*0.6995000,size.width*0.7425000,size.height*0.7045000,size.width*0.7500000,size.height*0.8020000);
    path_0.quadraticBezierTo(size.width*0.7437500,size.height*0.8990000,size.width*0.5000000,size.height);
    path_0.lineTo(0,size.height*0.9960000);
    path_0.lineTo(0,0);
    path_0.close();

    canvas.drawPath(path_0, paint_0);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }

}
