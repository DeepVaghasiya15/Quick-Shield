import 'package:anti_spy/PermissionData.dart';
import 'package:anti_spy/SubscriptionListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'SettingScreen.dart';

class ScannedScreen extends StatelessWidget {
  final List<String> suspiciousApps;
  final List<String> allPermissions;

  ScannedScreen({Key? key, required this.suspiciousApps, required this.allPermissions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Strip the prefix "android.permission." from each permission
    List<String> strippedPermissions = allPermissions.map((permission) {
      return permission.replaceFirst('android.permission.', '');
    }).toList();

    return Scaffold(
      // backgroundColor: const Color(0xFF28292E),
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          // backgroundColor: const Color(0xFF28292E),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(width: screenWidth * 0.01,),
              IconButton(
                icon: SizedBox(
                  width: 30, // Increased width
                  height: 40, // Increased height
                  child: Image.asset('assets/images/QuickShieldLogoMain.png'),
                ),
                onPressed: () {
                  print("Leading image clicked");
                },
              ),
              const Expanded(
                child: Text(
                  "QuickShield",
                  textAlign: TextAlign.left,
                  style: TextStyle(fontFamily: 'Manrope',color: Colors.green, fontSize: 24) ,// Adjust font size as needed
                ),
              ),
              SizedBox(width: screenWidth * 0.07,),
              IconButton(
                icon: Image.asset(
                  'assets/images/SettingIcon.png',
                  width: 40, // Adjust width as needed
                  height: 40, // Adjust height as needed
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SettingScreen()));
                  print("Settings icon clicked");
                },
              ),
              SizedBox(width: screenWidth * 0.02,),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          // SizedBox(height: screenHeight * 0.1),
          Center(
            child: Image.asset(
              'assets/images/WarningSign.gif', // Replace with your image asset path
              height: screenHeight * 0.23,
              // width: screenWidth * 0.4,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(height: screenHeight * 0.03),
          Expanded(
            flex: 1,
            child: ListView.builder(
              itemCount: suspiciousApps.length,
              itemBuilder: (context, index) {
                return MyCustomCell(
                  title: suspiciousApps[index],
                  content: 'Detected suspicious app: ${suspiciousApps[index]}',
                  allPermissions: [],
                );
              },
            ),
          ),
          const Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Permissions taken by this App",
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: PermissionData.map((permission) {
                    return Text(
                      '$permission,',
                      style: const TextStyle(
                        fontFamily: 'Manrope',
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const SubscriptionList(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00C756),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(screenWidth * 0.9, 60),
              ),
              child: const Text(
                'Fix Now',
                style: TextStyle(fontFamily: 'Manrope',color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.02),
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
                  width: 20, // Adjust the size of the logo as needed
                  height: 20,
                ),
                const SizedBox(width: 2,),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "QuickShield",
                        style: TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.green,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyCustomCell extends StatelessWidget {
  final String title;
  final String content;
  final List<String> allPermissions;

  MyCustomCell({
    required this.title,
    required this.content,
    required this.allPermissions,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Card(
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 8),
      color: Colors.red,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.warning_rounded, size: 40.0, color: Colors.black),
                const SizedBox(width: 10.0),
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            Text(
              content,
              style: const TextStyle(fontFamily: 'Manrope',fontSize: 14.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
