import 'package:flutter/material.dart';

class NoSpyingApp extends StatelessWidget {
  const NoSpyingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Image.asset(
          "assets/images/NoSpyingApp.png",
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}