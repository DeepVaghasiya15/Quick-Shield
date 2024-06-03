import 'package:flutter/material.dart';

class NoSpyingApp extends StatelessWidget {
  const NoSpyingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              "assets/images/NoSpyingApp2.png",
              fit: BoxFit.cover,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Secured by ",
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    'assets/images/QuickShieldLogoMain.png',
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(width: 2,),
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Quickshield",
                          style: TextStyle(
                            fontFamily: 'Manrope',
                            color: Colors.white,
                            fontWeight: FontWeight.w200,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
