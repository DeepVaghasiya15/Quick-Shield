import 'package:flutter/material.dart';

class ScannedScreen extends StatelessWidget {
  final List<String> suspiciousApps;

  ScannedScreen({super.key, required this.suspiciousApps});

  @override
  Widget build(BuildContext context) {
    // ScreenWidth of different phones
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF28292E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF28292E),
        surfaceTintColor: Colors.transparent,
        // App bar left side logo
        leading: Padding(
          padding: const EdgeInsets.only(left: 0.0),
          child: IconButton(
            icon: Image.asset('assets/images/BackButton.png'),
            onPressed: () {
              Navigator.pushNamed(context,'/home');
            },
          ),
        ),
        // App bar right side setting button
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              icon: Image.asset('assets/images/SettingIcon.png'),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
              'assets/images/DangerRed.png',
              width: screenWidth * 0.25,
              height: screenWidth * 0.25,
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: suspiciousApps.length,
              itemBuilder: (context, index) {
                return MyCustomCell(
                  title: suspiciousApps[index],
                  content: 'Detected suspicious app: ${suspiciousApps[index]}',
                );
              },
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

  MyCustomCell({required this.title, required this.content});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF28292E), Colors.black87],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.warning, size: 40.0),
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
                style: TextStyle(fontSize: 14.0, color: Colors.white),
              ),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'TRUST',
                      style: TextStyle(color: Color(0xFFE9696A)),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'DELETE',
                      style: TextStyle(color: Color(0xFF97D065)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
