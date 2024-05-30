import 'package:flutter/material.dart';

class FixedScreen extends StatelessWidget {
  const FixedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          "assets/images/FixedScreen2.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}