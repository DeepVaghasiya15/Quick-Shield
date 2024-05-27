import 'package:flutter/material.dart';
import 'package:anti_spy/ScanningScreen.dart';
import 'package:anti_spy/ScannedScreen.dart';

import 'main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ScreenWidth of different phones
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFF28292E),
      appBar: AppBar(
        title: const Text(
          "QUICKSHIELD",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF28292E),
        centerTitle: true,
        // App bar left side logo
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: IconButton(
            icon: SizedBox(
                width: 26,
                height: 26,
                child: Image.asset('assets/images/QuickShieldLogoMain.png')),
            onPressed: () {
              print("Leading image clicked");
            },
          ),
        ),
        // App bar right side setting button
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Image.asset('assets/images/SettingIcon.png'),
              onPressed: () {
                print("Image clicked");
              },
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isSuspicious
                ? Image.asset(
              'assets/images/TapOnScanRed.png',
              width: screenWidth * 0.6,
            )
                : Image.asset(
              'assets/images/TapOnScanGreen2.png',
              width: screenWidth * 0.6,
            ),
            const SizedBox(
              height: 65,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40),
              child: const Text(
                "Tap on Scan to check for hidden spying apps on your phone.",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.normal,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        "Powered by Gfuturetech Pvt Ltd",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ScanningScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSuspicious
                              ? Color(0xFFE9696A)
                              : Color(0xFF00C756),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(300, 50),
                        ),
                        child: const Text(
                          'Scan',
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
