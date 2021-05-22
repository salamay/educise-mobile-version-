import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:educise/API/Post.dart';
import 'package:educise/Screens/Home.dart';
import 'package:educise/Screens/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';

class SigningIn extends StatefulWidget {
  String staffid;
  String schoolid;
  String password;
  SigningIn({this.staffid,this.schoolid,this.password});
  @override
  _SigningInState createState() => _SigningInState();
}

class _SigningInState extends State<SigningIn> {
  @override
  void initState() {
    startAuth();
  }
  showFailed(int statusCode,String message){
    AwesomeDialog(
      dismissOnTouchOutside: false,
        dismissOnBackKeyPress: false,
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.RIGHSLIDE,
        headerAnimationLoop: false,
        title: 'Error',
        desc:"Finished with response code ${statusCode} \n ${message}",
        btnOkOnPress: () {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => SignIn(),));
        },
        btnOkIcon: Icons.cancel,
        btnOkColor: Colors.red)
      ..show();
  }
  startAuth()async{
      Map<String, dynamic> body = {
        "staffid": widget.staffid + "," + widget.schoolid,
        "password": widget.password,
      };
      final response = await PostRequest().sendData(context,"http://192.168.43.36:8080/authenticate", body,null);
if(response.statusCode!=null){
  if (response.statusCode == 200) {
    Map <String, dynamic> responseBody = jsonDecode(response.body);
    print(responseBody['jwt']);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Home(token: responseBody['jwt'],)));
  } else {
    showFailed(response.statusCode, response.body);
  }
}else{

}

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SpinKitFoldingCube(
        color: HexColor("48A986"),
        size: 40,
      ),
    );
  }
}

