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
    final List<PackageInfo>? infoList = await AndroidPackageManager().getInstalledPackages(flags: flags);
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
    return Scaffold(
      backgroundColor: const Color(0xFF28292E),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScanningScreen(
                      allPermissions: _allPermissions.toList(),
                    ),
                  ),
                );
              },
              child: Image.asset(
                'assets/images/TOSGreen2.png',
                fit: BoxFit.cover,
                height: 600,
                width: 600,
              ),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Tap on scan to check for hidden ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: "spying",
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
          const Padding(
            padding: EdgeInsets.only(top: 25.0),
            child: Text(
              "Powered by Quickshield",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w200,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
