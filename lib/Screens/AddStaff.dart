import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:educise/API/Post.dart';
import 'package:educise/Screens/AllStaff.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'Widget/formDecoration.dart';
class AddStaff extends StatefulWidget {
  String token;
  AddStaff({this.token});
  @override
  _AddStaffState createState() => _AddStaffState();
}

class _AddStaffState extends State<AddStaff> {
  String _username;
  String _password;
  String _password2;
  final _passwordKey=GlobalKey<FormState>();
  final TextEditingController usernameEditingController=TextEditingController();
  final TextEditingController passwordEditingController=TextEditingController();
  final TextEditingController password2EditingController=TextEditingController();
  List<String> _locations = ['ROLE_TEACHER', 'ROLE_BURSARY']; // Option 2
  String _selectedrole;
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
                    child: Image.asset("asset/undraw_professor_8lrt-removebg-preview.png",fit: BoxFit.contain,),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height*0.25,
                    left: MediaQuery.of(context).size.width*0.3,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      child: Card(
                        elevation: 20,
                        child:Text(
                            "Add staff",
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
                    Expanded(
                      flex:1,
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(width: 10,),
                    Expanded(
                      flex: 5,
                      child: Container(
                        child: AutoSizeText(
                          "Configure software by adding each staff that want to use the software",
                          style: GoogleFonts.lato(
                              color: Colors.black54,
                              fontSize: 14
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10,),
              Container(
                margin: EdgeInsets.all(10),
                child: Form(
                    key: _passwordKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        TextFormField(
                          inputFormatters: [new  WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),],
                          controller: usernameEditingController,
                          decoration: inputDecoration.copyWith(hintText: "Username",icon: Icon(Icons.people,size: 24,)),
                          validator: (val)=>val.isEmpty?"invalid username":null,
                        ),
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: passwordEditingController,
                          decoration: inputDecoration.copyWith(hintText: "password",icon: Icon(Icons.lock,size: 24,)),
                          validator: (val)=>val.length<6?"invalid password":null,
                        ),
                        TextFormField(
                          controller: password2EditingController,
                          decoration: inputDecoration.copyWith(hintText: "Confirm password",icon: Icon(Icons.lock,size: 24,)),
                          validator: (val)=>val!=passwordEditingController.text.toString()?"Password does not match":null,
                        ),
                        DropdownButton(
                          hint: Text('Please select staff role'), // Not necessary for Option 1
                          value: _selectedrole,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedrole= newValue;
                            });
                          },
                          items: _locations.map((location) {
                            return DropdownMenuItem(
                              child: new Text(location),
                              value: location,
                            );
                          }).toList(),
                        ),
                      ],

                    )
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.6,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    color:  buttonPressed == false ? HexColor("48a9ac"): Colors.grey,
                    child: Text(
                      "Add",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: ()async{
                      if(_passwordKey.currentState.validate()&&_selectedrole!=null){
                        _username=usernameEditingController.text.toString();
                        _password=passwordEditingController.text.toString();
                        _password2=password2EditingController.text.toString();
                        print(_username);
                        print(_password);
                        print(_password2);
                        print(_selectedrole);
                        if (buttonPressed== false){
                          setState(() {
                            buttonPressed = true;
                          });}
                        Map<String,dynamic> data={
                          'username':_username,
                          'password':_password,
                          'role':_selectedrole,
                        };
                        final response=await PostRequest().sendData(context,"http://192.168.43.36:8080/addstaff", data, widget.token);
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
                      }
                    },
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width*0.4,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    color: Colors.blue,
                    child: Text(
                      "View all",
                      style: GoogleFonts.lato(
                          color: Colors.white,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AllStaff(token: widget.token,)));
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
