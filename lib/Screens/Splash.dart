

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:galaxy/Screens/pageview.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    gotohome();

    // TODO: implement initState
    super.initState();
  }

    

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuerry=MediaQuery.of(context);

    return Scaffold(

      
      body:SafeArea(
        child: Stack(
          children: [
            Container(
              color: Colors.amber,
              width: mediaQuerry.size.width*2,
              height: mediaQuerry.size.height*1,
              child: Image.asset('assets/splash.jpeg',fit: BoxFit.cover),
              
      
            ),
             Positioned(
              top: 280 ,
              left: 110,

              child: Text('Galaxy',style:GoogleFonts.josefinSans( color: Color.fromARGB(255, 190, 188, 188) ,fontSize: 35 ,fontWeight: FontWeight.bold ),))
          ],
        ),
      ),
    );
  }

  gotohome() async {
   await Timer(Duration(seconds: 2), () { 
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Pages( )));
   });
   
  }
}