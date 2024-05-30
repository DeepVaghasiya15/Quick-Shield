import 'package:anti_spy/PermissionData.dart';
import 'package:anti_spy/SubscriptionListScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

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
      backgroundColor: Color(0xFF28292E),
      appBar: AppBar(
        title: const Text(
          "QUICKSHIELD",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF28292E),
        centerTitle: true,
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
        // actions: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.only(right: 12.0),
        //     child: IconButton(
        //       icon: Image.asset('assets/images/SettingIcon.png'),
        //       onPressed: () {
        //         print("Image clicked");
        //       },
        //     ),
        //   ),
        // ],
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
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  "Permissions taken by this app.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: PermissionData.map((permission) {
                    return Text(
                      '$permission,',
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.only(bottom: 8.0),
            child: Text(
              "Powered by Quickshield",
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SubscriptionList(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFF00C756),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                minimumSize: Size(screenWidth * 0.8, 65 ),
              ),
              child: const Text(
                'Fix Now',
                style: TextStyle(color: Colors.white, fontSize: 24),
                textAlign: TextAlign.center,
              ),
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
      margin: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: 0.0),
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.warning_rounded, size: 40.0, color: Colors.black),
                SizedBox(width: 10.0),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.0),
            Text(
              content,
              style: TextStyle(fontSize: 14.0, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
