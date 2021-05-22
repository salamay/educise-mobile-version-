import 'package:concentric_transition/page_view.dart';
import 'package:educise/Model/IntroScreenModel.dart';
import 'package:educise/Screens/SignIn.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {

  @override
  Widget build(BuildContext context) {
    List<Color> color=[
      HexColor("E3EBFF"),
      HexColor("ECE8EF"),
      HexColor("8BF5BF")
    ];
    List<IntroScreenModel> pageData=[
      IntroScreenModel(assetname:"asset/undraw_back_to_school_inwc-removebg-preview.png",text: "Educise software give you ability to manage your school activities effectively",button: null,textcolor: Colors.black87 ),
      IntroScreenModel(assetname:"asset/undraw_Bookshelves_re_lxoy-removebg-preview.png",text: "Manage the books in the inventory",button: null,textcolor: Colors.black87 ),
      IntroScreenModel(assetname:"asset/undraw_professor_8lrt-removebg-preview.png",text: "Easy student data access",button: null,textcolor: Colors.white ),
      IntroScreenModel(assetname:"asset/undraw_online_payments_luau-removebg-preview.png",text: "Subscribe to use our service",button: RaisedButton(
        color: HexColor("8BF5BF"),
        elevation: 0.0,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            side: BorderSide(
                color: Colors.white
            )
        ),
        child: Text(
          "Get started",
          style: TextStyle(
              color: Colors.black87,
              fontSize: 25
          ),
        ),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context)=>SignIn()
          ));
        },
      ),
          textcolor: Colors.black87
      ),

    ];
    return Scaffold(
      backgroundColor: HexColor("E3EBFF"),
      body: ConcentricPageView(
        colors: color,
        curve: Curves.bounceInOut,
        itemCount: pageData.length,
        duration: Duration(seconds: 1),
        radius: 20,
        itemBuilder: (index,value){
          return Container(
            margin: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  width: MediaQuery.of(context).size.width,
                  child: Image(
                    image: AssetImage(pageData[index].assetname),
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 30,),
                Text(
                  pageData[index].text,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0,
                      color: pageData[index].textcolor
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.2,),
                pageData[index].button==null?Text("Swipe left",style: TextStyle(color: Colors.red),):pageData[index].button
              ],
            ),
          );
        },
      ),
    );
  }
}
