import 'package:flutter/material.dart';

class Drawyer extends StatelessWidget {
  const Drawyer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: Drawyer()),
    );
  }
}