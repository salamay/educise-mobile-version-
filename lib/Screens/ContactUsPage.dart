import 'dart:convert';

import 'package:clay_containers/clay_containers.dart';
import 'package:educise/API/Get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:slimy_card/slimy_card.dart';
import 'package:url_launcher/url_launcher.dart';
class ContactUsPage extends StatelessWidget {
  String token;
  ContactUsPage({this.token});

  Uri _emailLaunchUri;
  String _url;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Get().getData(context, "http://192.168.43.36:8080/contactus", token),
      builder: (context,snapshot){
        if(snapshot.hasData){
          final response=snapshot.data;
          Map<String,dynamic> data=jsonDecode(response.body);
           _emailLaunchUri=Uri(
               scheme: 'mailto',
               path: data['email'],
               queryParameters: {
                 'subject': 'Add subject'
               });
          _url="whatsapp://send?phone=234${data['whatsappnumber']}&text=Hellothere!";
          return Scaffold(
            body: SafeArea(
              child: Center(
                child: Container(

                  child: ListView(
                    children: <Widget>[
                      SlimyCard(
                        color: HexColor("e3ebff"),
                        width: 600,
                        topCardHeight: 300,
                        bottomCardHeight: 300,
                        borderRadius: 15,
                        topCardWidget: topWidget(context) ,
                        bottomCardWidget: bottomWidget(context),
                        slimeEnabled: true,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }else{
          return Scaffold(
            body: SpinKitFoldingCube(
              size: 40,
              color: Colors.green,
            ),
          );
        }

      }
    );
  }
  Widget topWidget(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height*0.3,
      child: Image.asset("asset/call-us-contact-us-png.png",fit: BoxFit.contain),
    );
  }
  Widget bottomWidget(BuildContext context){
    return Container(
      width: MediaQuery.of(context).size.width*0.9,
      height: MediaQuery.of(context).size.height*0.4,
      child: Row(
        children: [
          Expanded(
              child: SizedBox(
                height: 120,
                width: 100,
                child: GestureDetector(
                  onTap: (){
                    _launchURL();
                  },
                    child: Image.asset("asset/whatsapp_PNG95154.png",fit: BoxFit.contain)
                ),
              ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: (){
                // mailto:smith@example.com?subject=Example+Subject+%26+Symbols+are+allowed%21
                launch(_emailLaunchUri.toString());
              },
              child: SizedBox(
                height: 120,
                width: 100,
                child: Image.asset("asset/gmail-logo-16.png",fit: BoxFit.contain),
              ),
            ),
          ),
        ],
      )
    );
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url) : throw 'Not found $_url';

}
