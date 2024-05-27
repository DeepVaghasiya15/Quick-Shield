import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

class AppCheckScreen extends StatelessWidget {
  const AppCheckScreen({super.key});

  final List<String> suspiciousAppNames = const [
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
  //FixMo
  //Mobifix
  //Quick Shield

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check Suspicious Apps'),
      ),
      body: FutureBuilder<List<Application>>(
        future: DeviceApps.getInstalledApplications(
          onlyAppsWithLaunchIntent: true,
          includeSystemApps: false,
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching apps'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No apps found'));
          } else {
            List<Application> apps = snapshot.data!;
            List<Application> suspiciousApps = apps.where((app) => suspiciousAppNames.contains(app.appName)).toList();

            if (suspiciousApps.isEmpty) {
              return const Center(child: Text('No suspicious apps found'));
            } else {
              return Container(
                color: Colors.red,
                child: ListView.builder(
                  itemCount: suspiciousApps.length,
                  itemBuilder: (context, index) {
                    Application app = suspiciousApps[index];
                    return ListTile(
                      leading: app is ApplicationWithIcon
                          ? Image.memory(app.icon, width: 40, height: 40)
                          : null,
                      title: Text(app.appName),
                      // subtitle: Text(app.packageName),
                    );
                  },
                ),
              );
            }
          }
        },
      ),
    );
  }
}
