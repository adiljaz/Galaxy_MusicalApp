import 'package:flutter/material.dart';


class AudioScreen extends StatefulWidget {


  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {



  @override
  Widget build(BuildContext context) {


    
    return Scaffold(
      body:Column(
        children: [ 

        ],
      ));
    
  }
}

class VisibilityManager {
  static bool isVisible =false;
}