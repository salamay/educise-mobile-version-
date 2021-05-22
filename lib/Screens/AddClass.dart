import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:educise/API/Post.dart';
import 'package:educise/Screens/ViewExistingClasses.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Widget/formDecoration.dart';
class AddClass extends StatefulWidget {
  String token;
  AddClass({this.token});
  @override
  _AddClassState createState() => _AddClassState();
}

class _AddClassState extends State<AddClass> {
  String _class;
  final _classkey=GlobalKey<FormState>();
  final TextEditingController classEditingController=TextEditingController();
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
  bool buttonPressed = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("e3ebff"),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width*0.9,
                    child: Image.asset("asset/undraw_back_to_school_inwc-removebg-preview.png",fit: BoxFit.contain,),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.25,
                    left: MediaQuery.of(context).size.width*0.3,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        elevation: 20,
                        child:Text(
                            "Add Class",
                            style:TextStyle(
                                color: HexColor("8b5fbf"),
                                fontSize: 30,
                                fontFamily: "Horizon"
                            )
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20,),
              Container(
                child: Row(
                  children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.red,
                    ),
                    SizedBox(width: 10,),
                    Text(
                      "Configure class by adding the classes available in your school",
                      style: GoogleFonts.lato(
                          color: Colors.black54,
                          fontSize: 14
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(10),
                child: Form(
                    key: _classkey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        TextFormField(
                          inputFormatters: [new  WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9[ ]")),],
                          controller: classEditingController,
                          decoration: inputDecoration.copyWith(hintText: "Class",icon: Icon(Icons.people,size: 24,)),
                          validator: (val)=>val.isEmpty ?"invalid class":null,
                        ),
                      ],
                    )
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.2,
                  child: RaisedButton(

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    color: buttonPressed == false ? HexColor("48a9ac"): Colors.grey,
                    child: Text(
                      "Add",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: ()async{
                     if(_classkey.currentState.validate()){
                       if (buttonPressed== false){
                         setState(() {
                           buttonPressed = true;
                         });
                         _class=classEditingController.text.toString();
                         print(_class);
                         Map<String,dynamic> data={
                           "classname":_class,
                         };
                         final response= await PostRequest().sendData(context,"http://192.168.43.36:8080/addclass", data,widget.token);
                         if(response.statusCode == 200){
                           showSuccess();
                           setState(() {
                             buttonPressed = false;
                           });
                         }else if(response.statusCode==403){
                           showFailed(response.statusCode,"You are not authorized");
                         }
                         else{
                           showFailed(response.statusCode,response.body);
                           setState(() {
                             buttonPressed = false;
                           });
                         }
                         print(response);
                         setState(() {
                           buttonPressed = false;
                         });

                       }
                     }
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    color: Colors.blue,
                    child: Text(
                      "View existing classes",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewExistingClasses(token: widget.token,)));
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
