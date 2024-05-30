import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:android_package_manager/android_package_manager.dart';

class _Permissions extends StatelessWidget {
  const _Permissions({required this.permissions});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text('Permissions (${permissions.length})'),
        ),
        TextButton(
          onPressed: () {
            showModalBottomSheet(
              context: context,
              builder: (_) => BottomSheet(
                onClosing: () {},
                builder: (_) {
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      itemBuilder: (_, i) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Text('[${i + 1}] ${permissions[i]}'),
                        );
                      },
                      separatorBuilder: (_, __) => const Divider(height: 16),
                      itemCount: permissions.length,
                    ),
                  );
                },
              ),
            );
          },
          child: const Text(
            'Show',
            style: TextStyle(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  final List<String> permissions;
}

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<PackageInfo>? _applicationInfoList;
  List<PackageInfo>? _filteredApplicationInfoList;
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
    final List<PackageInfo>? infoList = await _pm.getInstalledPackages(flags: flags);
    final List<PackageInfo>? userInstalledApps = infoList?.where((info) {
      return (info.applicationInfo!.flags & FLAG_SYSTEM) == 0;
    }).toList();

    // Extract all permissions
    final Set<String> allPermissions = {};
    for (var app in userInstalledApps ?? []) {
      if (app.requestedPermissions != null) {
        allPermissions.addAll(app.requestedPermissions!);
      }
    }

    setState(() {
      _applicationInfoList = userInstalledApps;
      _filteredApplicationInfoList = userInstalledApps;
      _allPermissions = allPermissions;
    });
  }

  void _showAllPermissions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => BottomSheet(
        onClosing: () {},
        builder: (_) {
          return SizedBox(
            height: MediaQuery.of(context).size.height * 0.5,
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 16),
              itemBuilder: (_, i) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text('[${i + 1}] ${_allPermissions.elementAt(i)}'),
                );
              },
              separatorBuilder: (_, __) => const Divider(height: 16),
              itemCount: _allPermissions.length,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All Apps"),
        actions: [
          IconButton(
            onPressed: () {
              _showAllPermissions(context);
            },
            icon: const Icon(Icons.list),
          ),
        ],
      ),
      body: Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
          itemBuilder: (_, index) {
            final info = _filteredApplicationInfoList![index];
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: _PackageEntry(info: info),
            );
          },
          itemCount: _filteredApplicationInfoList?.length ?? 0,
        ),
      ),
    );
  }

  AndroidPackageManager get _pm => AndroidPackageManager();
}

class _PackageEntry extends StatelessWidget {
  const _PackageEntry({required this.info});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: SizedBox.square(
          dimension: 48.0,
          child: _AppIcon(info: info),
        ),
        title: _AppLabel(info: info),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${info.packageName} (${info.longVersionCode ?? info.versionCode})'),
              Builder(
                builder: (_) {
                  final permissions = info.requestedPermissions;
                  if (permissions == null || permissions.isEmpty) {
                    return const SizedBox.shrink();
                  }
                  return _Permissions(permissions: permissions);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  final PackageInfo info;
}

class _AppIcon extends StatelessWidget {
  const _AppIcon({required this.info});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: info.applicationInfo?.getAppIcon(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final iconBytes = snapshot.data!;
          return Image.memory(
            iconBytes,
            fit: BoxFit.fill,
          );
        }
        if (snapshot.hasError) {
          return const Icon(
            Icons.error,
            color: Colors.red,
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  final PackageInfo info;
}

class _AppLabel extends StatelessWidget {
  const _AppLabel({required this.info});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: AndroidPackageManager().getApplicationLabel(
        packageName: info.packageName!,
      ),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Text(snapshot.data ?? "No Name");
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }

  final PackageInfo info;
}
