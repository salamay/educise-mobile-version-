import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
class TimeOutPage extends StatefulWidget {
  String body;
  TimeOutPage({this.body});

  @override
  _TimeOutPageState createState() => _TimeOutPageState();
}
class _TimeOutPageState extends State<TimeOutPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("e3ebff"),
      body:Center(
        child: Text(
          widget.body,
          style: GoogleFonts.lato(
            color: Colors.black54,
            fontSize: 24
          ),
        ),
      ) ,
    );
  }
}
