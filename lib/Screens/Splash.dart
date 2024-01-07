

import 'dart:async';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:galaxy/Screens/mianscreens/bodyHome.dart';

import 'package:google_fonts/google_fonts.dart';


class SplashScreen extends StatefulWidget {
  

  
    

  const SplashScreen({super.key,});
 

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

    return SafeArea (
      child: Scaffold(
    
        
        body: Stack(
            children: [
              Container(
                color: const Color.fromARGB(255, 0, 0, 0),
                width: mediaQuerry.size.width*2,
                height: mediaQuerry.size.height*1,
                child: Image.asset('assets/splash.jpeg',fit: BoxFit.cover),
                
        
              ),
               Positioned(
                top: 280 ,
                left: 110,
                

    
                child:AnimatedTextKit(
                  repeatForever: true,

                  isRepeatingAnimation: true,

                  
                  animatedTexts:[ColorizeAnimatedText(' Galaxy ', textStyle: GoogleFonts.josefinSans( color: const Color.fromARGB(255, 190, 188, 188) ,fontSize: 35 ,fontWeight: FontWeight.bold ), colors: [
                  Colors.white,
                  const Color.fromARGB(255, 65, 162, 242) ,
                  

                ])]),
                
                ),

                // Text('Galaxy',style:GoogleFonts.josefinSans( color: Color.fromARGB(255, 190, 188, 188) ,fontSize: 35 ,fontWeight: FontWeight.bold ),)
            ],
          ),
      
      ),
    );
  }

  gotohome() async {
   Timer(const Duration(seconds: 2), () { 
     Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const Home()));
   });
   
  }



}
