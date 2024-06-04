import 'package:anti_spy/AppPermissions.dart';
import 'package:anti_spy/Demo/AppName.dart';
import 'package:anti_spy/HomeScreen.dart';
import 'package:anti_spy/ScannedScreen.dart';
import 'package:anti_spy/ScanningScreen.dart';
import 'package:anti_spy/SubscriptionListScreen.dart';
import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'PaymentIntegration.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

bool isSuspicious = false;
final List<String> appNamesScanning = [];
List<String> SuspiciousApp = [];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quickshield',
      home: const AppCheckWrapper(),
      // home: PaymentIntegration(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/scanning': (context) => const ScanningScreen(allPermissions: [],),
        '/scanned': (context) => ScannedScreen(suspiciousApps: [], allPermissions: [],),
        '/subscription': (context) => SubscriptionList(),
      },
    );
  }
}

class AppCheckWrapper extends StatelessWidget {
  const AppCheckWrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Application>>(
      future: DeviceApps.getInstalledApplications(
        onlyAppsWithLaunchIntent: true,
        includeSystemApps: true,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            backgroundColor: Colors.black,
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/images/ic_launcher.png',
                    height: 230,
                    width: 230,
                  ),
                  const SizedBox(height: 20), // Add some space between the image and the text
                  const Text(
                    'QuickShield',
                    style: TextStyle(
                        fontFamily: 'Manrope',
                      color: Colors.green,
                      fontSize: 24,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                ],
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(body: Center(child: Text('Error fetching apps')));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Scaffold(body: Center(child: Text('No apps found')));
        } else {
          List<Application> apps = snapshot.data!;
          List<String> suspiciousAppNames = [
            // 'Gas Leakage',
            'Cocospy',
            'FamiSafe',
            'AirDroid',
            'Sync Service',
            'uMobix Userspace',
            'MMGuardian',
            'FlexiSpy',
            'Wi-Fi',
            'Xnspy',
            'Mobile Spy',
            'Spyic',
            'TheTruthSpy',
            'Highster Mobile',
            'SpyBubble Pro',
            'eyeZy',
            'FamiGuard',
            'Spynger',
            'Phonsee',
            'iKeyMonitor',
            'Spyine',
            'pcTattleTale',
            'Spyier',
            'ISpyoo',
            'Spyx',
            'Qustodio',
            'minspy',
            'Spyzie',
            'Spapp',
            'TeenSafe',
            'Ownspy',
            'SpyHuman',
            'appmia',
            'Cell Tracker',
            'Wspy',
            'CHYLD Monitor',
            'Android Auto',
            'Device Health',
            'Device',
            'Radio',
            'EyeZy',
            'System Update Service',
            'Internet Service',
            'Android',
            'Update service',
            'Qustodio',
            'Play Service Settings',
            'Backup',
            'Wi-Fi',
            'com.android.devicelogs',
            'GPS',
            'Android Service',
            'System Settings',
            'Mobistealth',
            'Playstore setting',
            'System Settings',
            'Android System Manager',
            'Mobistealth',
            'One Monitar',
            'TheWIspy',
            'TheOneSpy',
            'Mspy',
            'Clevguard KidsGuard Pro',
          ];

          appNamesScanning.clear();
          SuspiciousApp.clear();

          for (var app in apps) {
            appNamesScanning.add(app.appName);
            print(app.appName);
          }

          List<Application> suspiciousApps =
          apps.where((app) => suspiciousAppNames.contains(app.appName)).toList();

          if (suspiciousApps.isEmpty) {
            isSuspicious = false;
          } else {
            isSuspicious = true;
            SuspiciousApp = suspiciousApps.map((app) => app.appName).toList();
          }

          print('Suspicious apps: $SuspiciousApp');

          return const HomeScreen();
        }
      },
    );
  }
}
