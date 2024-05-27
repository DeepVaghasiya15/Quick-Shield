import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';

import 'AppCheck.dart';

class AppName extends StatefulWidget {
  const AppName({super.key});

  @override
  _AppNameState createState() => _AppNameState();
}

class _AppNameState extends State<AppName> {
  late Future<List<Application>> _appsFuture;

  @override
  void initState() {
    super.initState();
    _appsFuture = DeviceApps.getInstalledApplications(
      onlyAppsWithLaunchIntent: true,
      includeSystemApps: false,  // Only include user-installed apps
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Installed Apps'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const AppCheckScreen()),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Application>>(
        future: _appsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching apps'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No apps found'));
          } else {
            List<Application> apps = snapshot.data!;

            // Print app names to console
            for (var app in apps) {
              print('App Name: ${app.appName}');
            }

            return ListView.builder(
              itemCount: apps.length,
              itemBuilder: (context, index) {
                Application app = apps[index];
                return ListTile(
                  leading: app is ApplicationWithIcon
                      ? Image.memory(app.icon, width: 40, height: 40)
                      : null,
                  title: Text(app.appName),
                  subtitle: Text(app.packageName),
                );
              },
            );
          }
        },
      ),
    );
  }
}
