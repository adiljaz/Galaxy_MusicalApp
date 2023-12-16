import 'package:flutter/material.dart';
import 'package:galaxy/Screens/Splash.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      title: 'Galaxy',
      home:SplashScreen(
        
      ),
      theme: ThemeData(primarySwatch: Colors.grey,
     

      
      
      ),
      
      
    );
  }
}
