import 'package:educise/Screens/ContactUsPage.dart';
import 'package:educise/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class NavigationDrawer extends StatelessWidget {
  String token;
  NavigationDrawer({this.token});
  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
        key: _innerDrawerKey,
        onTapClose: true, // default false
        swipe: true, // default true
        colorTransitionChild: HexColor("e3ebff"), // default Color.black54
        colorTransitionScaffold: HexColor("ece8ef"), // default Color.black54

        //When setting the vertical offset, be sure to use only top or bottom
        offset: IDOffset.only(bottom: 0.05, right: 0.0, left: 0.0),

        scale: IDOffset.horizontal( 0.8 ), // set the offset in both directions

        proportionalChildArea : true, // default true
        borderRadius: 50, // default 0
        leftAnimationType: InnerDrawerAnimation.static, // default static
        rightAnimationType: InnerDrawerAnimation.quadratic,
        backgroundDecoration: BoxDecoration(color: HexColor("48a9a6") ), // default  Theme.of(context).backgroundColor

        //when a pointer that is in contact with the screen and moves to the right or left
        onDragUpdate: (double val, InnerDrawerDirection direction) {
          // return values between 1 and 0
          print(val);
          // check if the swipe is to the right or to the left
          print(direction==InnerDrawerDirection.start);
        },

        innerDrawerCallback: (a) => print(a), // return  true (open) or false (close)
        leftChild: Scaffold(
          body: Container(
            color: HexColor("48a9a6"),
            width: MediaQuery.of(context).size.width*0.65,
            child: ListView(
              children: [
                Column(
                  children: [
                    CircleAvatar(
                      backgroundImage: AssetImage("asset/avatar.png"),
                      radius: 30,
                    ),
                    SizedBox(height: 20,),
                    Text("Admin",style: GoogleFonts.lato(
                      fontSize: 18,
                      color: Colors.white
                    ),)
                  ],
                ),
                //Contact us
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ContactUsPage(token: token,)));
                  },
                  leading: Icon(
                    Icons.contact_page,
                    color: HexColor("e3ebff"),
                    size: 25,
                  ),
                  title: Text(
                    "Contact us",
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: HexColor("ece8ef")
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: HexColor("e3ebff"),
                    size: 14,
                  ),
                ),
                //About
                ListTile(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  leading: Icon(
                    Icons.contact_page,
                    color: HexColor("e3ebff"),
                    size: 25,
                  ),
                  title: Text(
                    "About",
                    style: GoogleFonts.lato(
                        fontSize: 14,
                        color: HexColor("ece8ef")
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: HexColor("e3ebff"),
                    size: 14,
                  ),
                )
              ],
            )
          ),
        ), // required if rightChild is not set
      //  rightChild: Container(), // required if leftChild is not set

        //  A Scaffold is generally used but you are free to use other widgets
        // Note: use "automaticallyImplyLeading: false" if you do not personalize "leading" of Bar
        scaffold: Home(token: token,),
      /* OR
            CupertinoPageScaffold(
                navigationBar: CupertinoNavigationBar(
                    automaticallyImplyLeading: false
                ),
            ),
            */
    );
  }

  //  Current State of InnerDrawerState
  final GlobalKey<InnerDrawerState> _innerDrawerKey = GlobalKey<InnerDrawerState>();

  void _toggle()
  {
    _innerDrawerKey.currentState.toggle(
      // direction is optional
      // if not set, the last direction will be used
      //InnerDrawerDirection.start OR InnerDrawerDirection.end
        direction: InnerDrawerDirection.end
    );
  }
}
