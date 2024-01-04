import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:galaxy/colors/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class RecentlyPlayed extends StatefulWidget {
  const RecentlyPlayed({super.key});

  @override
  State<RecentlyPlayed> createState() => _RecentlyPlayedState();
}

class _RecentlyPlayedState extends State<RecentlyPlayed> {
  @override
  Widget build(BuildContext context) {
        MediaQueryData mediaQuerry = MediaQuery.of(context); 
    return SafeArea(child: 
    Scaffold(
     
      body: Column(children: [

        

        Container(
          height: mediaQuerry.size.height*0.2,
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [      Padding(
              padding: const EdgeInsets.all(10 ),
              child: GestureDetector(  onTap: (){
                Navigator.of(context).pop();
              },  child: FaIcon(FontAwesomeIcons.circleArrowLeft,color: Colors.white,)),
            ), Row( 
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              Text('Recently Played ',style: GoogleFonts.lato(color: Colormanager.titleText,fontWeight: FontWeight.bold,fontSize:20),)
            ],)],
          ),
          decoration: BoxDecoration( color:Colormanager.container, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(50),bottomRight: Radius.circular(50))),
        ),

        
       
        
      ],
        
      ),

    ));
  }
}