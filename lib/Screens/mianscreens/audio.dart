import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';


class AudioScreen extends StatefulWidget {

  


  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {

  bool hey=true;



  @override
  Widget build(BuildContext context) {


    
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Recorder',style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.black,
        ),
        body:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
            InkWell(
              
              onTap: (){
                  setState(() {

                    hey=!hey; 
                  });

              },
              child: Center(child: hey?Lottie.asset('assets/an1.json',width: 300,height:300):Lottie.asset('assets/mc.json'))),
    
          ],
        )),
    );
    
  }
}

