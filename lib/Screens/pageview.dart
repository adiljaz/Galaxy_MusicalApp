import 'package:flutter/material.dart';
import 'package:galaxy/Screens/home.dart';
import 'package:galaxy/Screens/search.dart';

class Pages extends StatelessWidget {
  const Pages({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        Home(),
        Search() 


      ],
    );
  }
}