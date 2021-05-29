import 'package:auto_size_text/auto_size_text.dart';
import 'package:clay_containers/widgets/clay_container.dart';
import 'package:clay_containers/widgets/clay_text.dart';
import 'package:educise/Screens/CardDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class SubscriptionCustomerInfo extends StatelessWidget {
   String email;
   String amount;
   SubscriptionCustomerInfo({this.email,this.amount});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("e3ebff"),
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
              "Payment",
              style: GoogleFonts.lato(color: HexColor("545c52")),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 0.5,
                    child: Image.asset(
                        "asset/PikPng.com_happy-man-png_1497470.png"),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    margin: EdgeInsets.only(left: 20),
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                          child: ClayContainer(
                            color: Colors.white,
                            child: Padding(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          child: AutoSizeText("Email: $email",
                                            style: GoogleFonts.lato(
                                                color: Colors.black54,
                                                fontSize: 12
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          child: AutoSizeText("Amount: #${amount}",style: GoogleFonts.lato(
                                              color: Colors.black54,
                                              fontSize: 12
                                          ),
                                          ),
                                        ),
                                        SizedBox(height: 5,),
                                        Container(
                                          child: AutoSizeText("Note: By clicking proceed button, you have  agreed to pay the sum of #${amount}",style: GoogleFonts.lato(
                                              color: Colors.green,
                                              fontSize: 10
                                          ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                      ],
                    ),
                  )
                ],
              )
          ),
          Positioned(
            left: MediaQuery.of(context).size.width*0.6,
            top: MediaQuery.of(context).size.height*0.7,
            child: Container(
              width: MediaQuery.of(context).size.width*0.3,
              height: MediaQuery.of(context).size.height*0.08,
              child: RaisedButton(
                elevation: 20,
                color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Text(
                    "Proceed",
                    style: GoogleFonts.lato(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>CardDetailPage(amount: amount,customeremail: email,)));
                  }
                  ),
            ),
          )
        ],
      ),
    );
  }
}
