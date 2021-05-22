import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:clay_containers/constants.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:educise/API/Delete.dart';
import 'package:educise/API/Get.dart';
import 'package:educise/Model/StaffModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
class AllStaff extends StatefulWidget {
  String token;
  AllStaff({this.token});
  @override
  _AllStaffState createState() => _AllStaffState();
}

class _AllStaffState extends State<AllStaff> {
  showSuccess(){
    return  AwesomeDialog(
        context: context,
        animType: AnimType.LEFTSLIDE,
        headerAnimationLoop: false,
        dialogType: DialogType.SUCCES,
        title: 'Success',
        desc:"Success",
        btnOkOnPress: () {
          debugPrint('OnClcik');
        },
        btnOkIcon: Icons.check_circle,
        onDissmissCallback: () {
          debugPrint('Dialog Dissmiss from callback');
        })..show();
  }
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
      return Scaffold(
        backgroundColor: HexColor("e3ebff"),
        body: SafeArea(
          child: FutureBuilder(
            future: Get().getData(context,"http://192.168.43.36:8080/retrievestaff", widget.token),
            builder: (context, snapshot) {
              print(snapshot.data);
              if (snapshot.hasData) {
                var response = snapshot.data;
                print(response.body);
                List<dynamic> data = response.body != "Failed to process data"
                    ? jsonDecode(response.body)
                    : null;
                print(data);
                return data == null ? Container(
                    child: Center(
                      child: ClayText(
                        "No data",
                        color: Colors.black,
                        style: GoogleFonts.lato(
                            fontSize: 24
                        ),
                      ),
                    )
                ) : Column(
                  children: [
                    Expanded(
                      child: Container(
                        height: MediaQuery.of(context).size.height*0.25,
                        margin: EdgeInsets.all(10),
                        child: Image.asset("asset/undraw_swipe_re_vhc5-removebg-preview.png"),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Expanded(
                      child: Container(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                leading: ClayContainer(
                                  curveType: CurveType.convex,
                                  child: Text(
                                    data[index]["username"].toString(),
                                    style: GoogleFonts.lato(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black54
                                    ),
                                  ),
                                ),
                                title: Text(
                                    data[index]["role"].toString(),
                                  style:GoogleFonts.lato(
                                    fontSize: 18,
                                    color: Colors.black54
                                  ) ,
                                ),
                                subtitle: RaisedButton(
                                  elevation: 0.0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    side: BorderSide(
                                      color: Colors.white
                                    )
                                  ),
                                  color: Colors.blue,
                                  child: Text(
                                    "Delete",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold
                                    ),
                                  ),
                                  onPressed: () async {
                                    final response = await Delete().delete(context,
                                        "http://192.168.43.36:8080/deleteStaff/${data[index]["id"]}",
                                        widget.token);
                                    if (response.statusCode == 200) {
                                      data.removeAt(index);
                                      setState(() {

                                      });
                                      showSuccess();
                                    } else if(response.statusCode==403){
                                      showFailed(response.statusCode,"You are not authorized");
                                    }else {
                                      showFailed(response.statusCode, response.body);
                                    }
                                  },
                                ),
                                trailing: Text(
                                  data[index]["locked_status"].toString()=="1"?"Active":"locked",
                                  style: TextStyle(
                                    color: data[index]["locked_status"].toString()=="1"?Colors.green:Colors.red
                                  ),
                                ),
                              );
                            }
                        ),
                      ),
                    ),
                  ],
                );
              }
              else {
                return SpinKitFoldingCube(
                  size: 40,
                  color: HexColor("48A986"),
                );
              }
            },
          ),
        ),
      );
    }
  }

