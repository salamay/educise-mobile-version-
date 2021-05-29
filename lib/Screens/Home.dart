import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:educise/API/Get.dart';
import 'package:educise/Screens/QRView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:http/http.dart';

import 'AddClass.dart';
import 'AddStaff.dart';
import 'SignIn.dart';
import 'SubscriptionCustomerInfo.dart';
class Home extends StatelessWidget {
  String token;
  Home({this.token});



  @override
  Widget build(BuildContext context) {
    final WIDTH=MediaQuery.of(context).size.width;
    final HEIGTH=MediaQuery.of(context).size.height;
    showFailed(){
      AwesomeDialog(
          dismissOnTouchOutside: false,
          dismissOnBackKeyPress: false,
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.RIGHSLIDE,
          headerAnimationLoop: false,
          title: 'Error',
          desc:"An error occur while retrieving data",
          btnOkOnPress: () {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => SignIn(),));
          },
          btnOkIcon: Icons.cancel,
          btnOkColor: Colors.red)
        ..show();
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: HexColor("e3ebff"),
        title: Row(
          children: [
            CircleAvatar(
                backgroundColor: Colors.white,
                child: Text(
                  "A",
                  style: TextStyle(color: HexColor("48a9a6")),
                )),
            SizedBox(
              width: 20,
            ),
            Text(
              "Admin",
              style: GoogleFonts.lato(color: HexColor("545c52")),
            ),
          ],
        ),
      ),
      body: FutureBuilder(
        future: Get().getData(context,"http://192.168.43.36:8080/retrievesubcriptioninfo", token),
        builder: (context,snapshot){
          if(snapshot.hasData){
            Response response=snapshot.data;
            print(response.body);
            if(response.statusCode==200){
              Map<String,dynamic> data=jsonDecode(response.body);
              String subscription_status=data['subscription_status'];
              String customer_subcription_amount=data['amount'];
              String next_payment_date=data['next_payment_date'];
              String email=data['email'];
              print(subscription_status);
              print(customer_subcription_amount);
              print(next_payment_date);

              return Stack(
                children: [
                  CustomPaint(
                    size: Size(WIDTH, (HEIGTH).toDouble()),
                    //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainterBackground(),
                  ),
                  CustomPaint(
                    size: Size(WIDTH, (HEIGTH * 0.9).toDouble()),
                    //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainter1(),
                  ),
                  CustomPaint(
                    size: Size(WIDTH, (HEIGTH).toDouble()),
                    //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
                    painter: RPSCustomPainter2(),
                  ),
                 SingleChildScrollView(
                   child: Container(
                     height: MediaQuery.of(context).size.height,
                     width: MediaQuery.of(context).size.width,
                     child: Stack(
                       children: [
                         Positioned(
                             top: MediaQuery.of(context).size.height * 0.001,
                             left: MediaQuery.of(context).size.width * 0.05,
                             child: Container(
                               width: MediaQuery.of(context).size.width * 0.9,
                               height: MediaQuery.of(context).size.height * 0.2,
                               child: Card(
                                 elevation: 0.0,
                                 child: Container(
                                     width: MediaQuery.of(context).size.width * 0.8,
                                     child: Stack(
                                       children: [
                                         Image.asset(
                                           "asset/undraw_subscriptions_re_k7jj-removebg-preview.png",
                                           fit: BoxFit.contain,
                                         ),
                                         Container(
                                           margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.09),
                                           child: ListTile(
                                             leading: Icon(
                                               Icons.add_alert,
                                               color: Colors.blue,
                                             ),
                                             title: Text(
                                               "Subcription status",
                                               style: GoogleFonts.lato(
                                                   color: Colors.blue,
                                                   fontSize: 12
                                               ),
                                             ),
                                             subtitle: Row(
                                               children: [
                                                 Text("Active :"),
                                                 subscription_status=="active"? Icon(
                                                   Icons.done,
                                                   color: Colors.green,
                                                   size: 20,
                                                 ): Icon(
                                                   Icons.cancel,
                                                   color: Colors.red,
                                                   size: 20,
                                                 ),
                                                 FlatButton(
                                                   shape: RoundedRectangleBorder(
                                                     borderRadius: BorderRadius.all(Radius.circular(20)),
                                                   ),
                                                   color: Colors.blue,
                                                   child: Text(
                                                     "Subscribe",
                                                     style: GoogleFonts.lato(
                                                         color: Colors.white,
                                                         fontWeight: FontWeight.bold
                                                     ),
                                                   ),
                                                   onPressed: (){
                                                     if(subscription_status=="active"){
                                                       print("active");
                                                     }else{
                                                       Navigator.push(context,MaterialPageRoute(
                                                           builder: (context)=>SubscriptionCustomerInfo(email: email,amount: customer_subcription_amount,)
                                                       ));
                                                     }

                                                   },
                                                 ),
                                               ],
                                             ),
                                             trailing: Container(
                                               width: 60,
                                               child: Column(
                                                 children: [
                                                   customer_subcription_amount!=null? Text(
                                                     "#"+customer_subcription_amount,
                                                     style: GoogleFonts.lato(fontSize: 16, color: Colors.green),
                                                   ): Text(
                                                     "Nil",
                                                     style: GoogleFonts.lato(fontSize: 18, color: Colors.green),
                                                   ),
                                                   next_payment_date!=null?Text(
                                                     next_payment_date,
                                                     style: GoogleFonts.lato(fontSize: 12, color: Colors.red),
                                                   ):Text(
                                                     "Nil",
                                                     style: GoogleFonts.lato(fontSize: 12, color: Colors.red),
                                                   ),
                                                 ],
                                               ),
                                             ),
                                           ),
                                         ),
                                       ],

                                     )),
                               ),
                             )),
                         Positioned(
                           top: MediaQuery.of(context).size.height * 0.23,
                           child: Row(
                             children: [
                               GestureDetector(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>QRWidget(token:token)));

                                 },
                                 child: Container(
                                   width: MediaQuery.of(context).size.width,
                                   child: Stack(
                                     children: [
                                       Container(
                                         height: 200,
                                         width: 200,
                                         child: Image.asset(
                                             "asset/kisspng-information-qr-code.png",
                                             fit: BoxFit.contain),
                                       ),
                                       Positioned(
                                         left: MediaQuery.of(context).size.width * 0.5,
                                         top: MediaQuery.of(context).size.height * 0.056,
                                         child: Card(
                                           elevation: 20,
                                           child: Container(
                                             margin: EdgeInsets.all(5),
                                             height: MediaQuery.of(context).size.height * 0.12,
                                             width: MediaQuery.of(context).size.width * 0.4,
                                             child: Center(
                                               child: AutoSizeText(
                                                 "Scan student QR code to sign attendance and send message to parent",
                                                 style: GoogleFonts.lato(
                                                     color: Colors.black54, fontSize: 14),
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         Positioned(
                           top: MediaQuery.of(context).size.height * 0.45,
                           child: Row(
                             children: [
                               GestureDetector(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddStaff(token:token)));
                                 },
                                 child: Container(
                                   width: MediaQuery.of(context).size.width,
                                   child: Stack(
                                     children: [
                                       Container(
                                         height: 200,
                                         width: 200,
                                         child: Image.asset(
                                             "asset/undraw_Co_workers_re_1i6i.png",
                                             fit: BoxFit.contain),
                                       ),
                                       Positioned(
                                         left: MediaQuery.of(context).size.width * 0.5,
                                         top: MediaQuery.of(context).size.height * 0.056,
                                         child: Card(
                                           elevation: 20,
                                           child: Container(
                                             margin: EdgeInsets.all(5),
                                             height: MediaQuery.of(context).size.height * 0.12,
                                             width: MediaQuery.of(context).size.width * 0.4,
                                             child: Center(
                                               child: AutoSizeText(
                                                 "Give access to staffs to use our educise software",
                                                 style: GoogleFonts.lato(
                                                     color: Colors.black54, fontSize: 14),
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         ),
                         Positioned(
                           top: MediaQuery.of(context).size.height * 0.7,
                           child: Row(
                             children: [
                               GestureDetector(
                                 onTap: (){
                                   Navigator.push(context, MaterialPageRoute(builder: (context)=>AddClass(token: token,)));
                                 },
                                 child: Container(
                                   width: MediaQuery.of(context).size.width,
                                   child: Stack(
                                     children: [
                                       Container(
                                         height: 200,
                                         width: 200,
                                         child: Image.asset(
                                           "asset/undraw_exams_g4ow-removebg-preview.png",
                                           fit: BoxFit.contain,
                                         ),
                                       ),
                                       Positioned(
                                         left: MediaQuery.of(context).size.width * 0.5,
                                         top: MediaQuery.of(context).size.height * 0.056,
                                         child: Card(
                                           elevation: 20,
                                           child: Container(
                                             margin: EdgeInsets.all(5),
                                             height: MediaQuery.of(context).size.height * 0.12,
                                             width: MediaQuery.of(context).size.width * 0.4,
                                             child: Center(
                                               child: AutoSizeText(
                                                 "Add class to your database use our educise software,"
                                                     " this appears on the desktop version and enable you to work with the particular class ",
                                                 style: GoogleFonts.lato(
                                                     color: Colors.black54, fontSize: 14),
                                               ),
                                             ),
                                           ),
                                         ),
                                       ),
                                     ],
                                   ),
                                 ),
                               ),
                             ],
                           ),
                         )
                       ],
                     ),
                   ),
                 )
                ],
              );
            }else{
              return Scaffold(
                body: Center(
                  child: Container(
                    child: Text(
                      "No data retrieved",
                      style: GoogleFonts.lato(
                          fontSize: 24
                      ),
                    ),
                  ),
                ),
              );
            }

          }
          else{
            return SpinKitFoldingCube(
              size: 40,
              color: Colors.green,
            );
          }

        },
      ),
    );
  }
}



class RPSCustomPainterBackground extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = HexColor("48a9a6")
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(0, size.height * -0.0020000);
    path_0.lineTo(0, size.height);
    path_0.lineTo(size.width * 0.9987500, size.height * 0.9960000);
    path_0.lineTo(size.width * 0.9987500, size.height * 0.0020000);
    path_0.lineTo(0, size.height * -0.0020000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = HexColor("e3ebff")
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.0012500, size.height * 0.9980000);
    path_0.lineTo(size.width * 0.9987500, size.height);
    path_0.lineTo(size.width * 0.9987500, size.height * 0.1960000);
    path_0.quadraticBezierTo(size.width * 0.9431250, size.height * 0.2235000,
        size.width * 0.9362500, size.height * 0.3020000);
    path_0.quadraticBezierTo(size.width * 0.8759375, size.height * 0.3010000,
        size.width * 0.8750000, size.height * 0.2020000);
    path_0.lineTo(size.width * 0.8125000, size.height * 0.2980000);
    path_0.quadraticBezierTo(size.width * 0.7656250, size.height * 0.2260000,
        size.width * 0.7500000, size.height * 0.2020000);
    path_0.quadraticBezierTo(size.width * 0.7496875, size.height * 0.3020000,
        size.width * 0.6887500, size.height * 0.2980000);
    path_0.quadraticBezierTo(size.width * 0.6428125, size.height * 0.2460000,
        size.width * 0.6275000, size.height * 0.2220000);
    path_0.quadraticBezierTo(size.width * 0.5640625, size.height * 0.2195000,
        size.width * 0.5637500, size.height * 0.2960000);
    path_0.lineTo(size.width * 0.5000000, size.height * 0.1980000);
    path_0.quadraticBezierTo(size.width * 0.4406250, size.height * 0.1995000,
        size.width * 0.4375000, size.height * 0.2960000);
    path_0.quadraticBezierTo(size.width * 0.4221875, size.height * 0.2730000,
        size.width * 0.3575000, size.height * 0.2200000);
    path_0.lineTo(size.width * 0.3112500, size.height * 0.3000000);
    path_0.lineTo(size.width * 0.2262500, size.height * 0.2000000);
    path_0.lineTo(size.width * 0.1875000, size.height * 0.2980000);
    path_0.lineTo(size.width * 0.1250000, size.height * 0.2000000);
    path_0.lineTo(size.width * 0.0637500, size.height * 0.3020000);
    path_0.lineTo(0, size.height * 0.2000000);
    path_0.lineTo(size.width * 0.0012500, size.height * 0.9980000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

class RPSCustomPainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint_0 = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill
      ..strokeWidth = 1;

    Path path_0 = Path();
    path_0.moveTo(size.width * 0.9987500, size.height * 0.1980000);
    path_0.quadraticBezierTo(size.width * 0.9987500, size.height * 0.7980000,
        size.width * 0.9987500, size.height * 0.9980000);
    path_0.lineTo(0, size.height * 0.9980000);
    path_0.lineTo(0, size.height * 0.2900000);
    path_0.lineTo(size.width * 0.0612500, size.height * 0.2040000);
    path_0.lineTo(size.width * 0.1237500, size.height * 0.2980000);
    path_0.lineTo(size.width * 0.1875000, size.height * 0.2020000);
    path_0.lineTo(size.width * 0.3125000, size.height * 0.3020000);
    path_0.lineTo(size.width * 0.4375000, size.height * 0.2040000);
    path_0.lineTo(size.width * 0.4987500, size.height * 0.3000000);
    path_0.lineTo(size.width * 0.5625000, size.height * 0.2000000);
    path_0.lineTo(size.width * 0.6262500, size.height * 0.2980000);
    path_0.lineTo(size.width * 0.6887500, size.height * 0.2040000);
    path_0.lineTo(size.width * 0.7475000, size.height * 0.2980000);
    path_0.lineTo(size.width * 0.8125000, size.height * 0.2060000);
    path_0.lineTo(size.width * 0.8712500, size.height * 0.3020000);
    path_0.quadraticBezierTo(size.width * 0.8881250, size.height * 0.2380000,
        size.width * 0.9987500, size.height * 0.1980000);
    path_0.close();

    canvas.drawPath(path_0, paint_0);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}