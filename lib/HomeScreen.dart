import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:android_package_manager/android_package_manager.dart';
import 'ScanningScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<PackageInfo>? _applicationInfoList;
  Set<String> _allPermissions = {};

  static const int FLAG_SYSTEM = 1 << 0;

  @override
  void initState() {
    super.initState();
    _loadApplicationInfoList();
  }

  Future<void> _loadApplicationInfoList() async {
    final flags = PackageInfoFlags(
      {
        PMFlag.getMetaData,
        PMFlag.getPermissions,
        PMFlag.getReceivers,
        PMFlag.getServices,
        PMFlag.getProviders,
      },
    );
    final List<PackageInfo>? infoList = await AndroidPackageManager()
        .getInstalledPackages(flags: flags);
    final List<PackageInfo>? userInstalledApps = infoList?.where((info) {
      return (info.applicationInfo!.flags & FLAG_SYSTEM) == 0;
    }).toList();

    final Set<String> allPermissions = {};
    for (var app in userInstalledApps ?? []) {
      if (app.requestedPermissions != null) {
        allPermissions.addAll(app.requestedPermissions!);
      }
    }

    setState(() {
      _applicationInfoList = userInstalledApps;
      _allPermissions = allPermissions;
    });
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    return Scaffold(
      backgroundColor: const Color(0xFF28292E),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0), // Increased height of the AppBar
        child: AppBar(
          backgroundColor: const Color(0xFF28292E),
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // SizedBox(width: screenWidth * 0.15,),
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
                  style: TextStyle(color: Colors.green, fontSize: 24), // Adjust font size as needed
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
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ScanningScreen(
                                allPermissions: _allPermissions.toList(),
                              ),
                        ),
                      );
                    },
                    child: Image.asset(
                      'assets/images/TOSGreen3.png',
                      fit: BoxFit.cover,
                      height: screenHeight * 0.6,
                      width: screenWidth * 1,
                    ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.01,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.1),
                  child: RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: "Tap on Scan to detect hidden ",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: "Spying",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 17,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        TextSpan(
                          text: " apps on your phone.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(bottom: screenHeight * 0.03),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "Secured by ",
                        style: TextStyle(
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
                SizedBox(width: 2,),
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: "QuickShield",
                        style: TextStyle(
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
