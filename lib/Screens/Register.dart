import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:educise/API/Post.dart';
import 'package:educise/Screens/Widget/formDecoration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:steps/steps.dart';
class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
   String _email;
   String _schoolid;
   String _username;
   String _password;
   final _key=GlobalKey<FormState>();
   final TextEditingController emailEditingController=TextEditingController();
   final TextEditingController schoolEditingController=TextEditingController();
   final TextEditingController usernameEditingController=TextEditingController();
   final TextEditingController passwordEditingController=TextEditingController();
   final TextEditingController password2EditingController=TextEditingController();


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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: HexColor("E3EBFF"),
        title: Text(
          "Registeration",
          style: TextStyle(
              color: HexColor("48a9a6"),
              fontSize: 24,
              fontFamily: "Horizon"
          ),
        ),
      ),
      body: Container(
        child: Form(
          key: _key,
          child: Steps(
            direction: Axis.vertical,
            path: {'color':HexColor("48a9a6"),'width':3.0},
            steps: [
              {
                'color':HexColor("8b5fbf"),
                'background':HexColor("ecebff"),
                'label':'1',
                'content': Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Email",
                      style: GoogleFonts.lato(
                        color: HexColor("545652"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: emailEditingController,
                         // initialValue: _email,
                          decoration: inputDecoration.copyWith(hintText: "Email",icon: Icon(Icons.email_outlined,size: 24,)),
                          validator: (val)=>val.isEmpty?"Please enter a valid email":null,
                        )
                      ],
                    )
                  ],
                )
              },
              {
                'color':HexColor("8b5fbf"),
                'background':HexColor("ecebff"),
                'label':'2',
                'content': Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Staff id",
                      style: GoogleFonts.lato(
                        color: HexColor("545652"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        TextFormField(
                          inputFormatters: [new  WhitelistingTextInputFormatter(RegExp("[a-zA-Z0-9]")),],
                          controller: usernameEditingController,
                          decoration: inputDecoration.copyWith(hintText: "Staff id",icon: Icon(Icons.people,size: 24,)),
                          validator: (val)=>val.isEmpty?"Please enter a valid staff id":null,
                        )
                      ],
                    )
                  ],
                )
              },
              {
                'color':HexColor("8b5fbf"),
                'background':HexColor("ecebff"),
                'label':'3',
                'content': Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose a school id",
                      style: GoogleFonts.lato(
                        color: HexColor("545652"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: Colors.red,
                          size: 18,
                        ),
                        SizedBox(width: 10,),
                          Expanded(
                            child: Container(
                              width: MediaQuery.of(context).size.width*0.8,
                              child: Text(
                                "This is a unique id that will be assigned to your school,\n make sure to keep it safe",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.lato(
                                  color: HexColor("545652"),
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: schoolEditingController,
                          decoration: inputDecoration.copyWith(hintText: "school id",icon: Icon(Icons.tag,size: 24,)),
                          validator: (val)=>val.isEmpty?"Please enter a valid school id":null,
                        )
                      ],
                    )
                  ],
                )
              },
              {
                'color':HexColor("8b5fbf"),
                'background':HexColor("ecebff"),
                'label':'4',
                'content': Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Choose a password",
                      style: GoogleFonts.lato(
                        color: HexColor("545652"),
                        fontSize: 23,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.info,
                          color: Colors.red,
                          size: 18,
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Container(
                            width: MediaQuery.of(context).size.width*0.8,
                            child: Text(
                              "password must be greater than 6",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                color: HexColor("545652"),
                                fontSize: 10,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20,),
                        TextFormField(
                          controller: passwordEditingController,
                          decoration: inputDecoration.copyWith(hintText: "password",icon: Icon(Icons.lock,size: 24,)),
                          validator: (val)=>val.length<6?"invalid password":null,
                        ),
                        SizedBox(height: 20,),

                        Text(
                          "Confirm password",
                          style: GoogleFonts.lato(
                            color: HexColor("545652"),
                            fontSize: 23,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          controller: password2EditingController,
                          decoration: inputDecoration.copyWith(hintText: "Confirm password",icon: Icon(Icons.lock,size: 24,)),
                          validator: (val)=>val==passwordEditingController.text.toString()?null:"Password does not match",
                        )
                      ],
                    )
                  ],
                )
              },
              {
                'color':HexColor("8b5fbf"),
                'background':HexColor("ecebff"),
                'label':'5',
                'content': Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                      side: BorderSide(
                        color: Colors.blue
                      )
                    ),
                    color: HexColor("8b5fbf"),
                    child: Text(
                      "Register",
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    onPressed: () async{
                      if(_key.currentState.validate()){

                               _email=emailEditingController.text.toString();
                               _username=usernameEditingController.text.toString();
                               _schoolid=schoolEditingController.text.toString();
                               _password=passwordEditingController.text.toString();
                               Map<String,dynamic> body={
                                 "email":_email,
                                 "staffid":_username,
                                 "password":_password,
                                 "schoolid":_schoolid
                               };
                               final response = await PostRequest().sendData(context,"http://192.168.43.36:8080/registeration", body,null);
                               print(response);
                               if(response.statusCode == 200){
                                 showSuccess();
                               }else{
                                 showFailed(response.statusCode,response.body);
                               }

                      }
                    },
                  ),
                )
              },
            ],
          ),
        ),
      )
    );
  }
}
