import 'package:flutter/material.dart';

// void main() {
//   runApp(QuickShieldApp());
// }

class QuickShieldApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shield, color: Colors.grey),
              SizedBox(width: 8),
              Text('QUICKSHIELD', style: TextStyle(color: Colors.white)),
            ],
          ),
          centerTitle: true,
        ),
        body: SafeStatusScreen(),
      ),
    );
  }
}

class SafeStatusScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Spacer(),
          Text(
            'Tap to SCAN',
            style: TextStyle(
              color: Colors.green,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Implement scan functionality
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            ),
            child: Text(
              'SCAN',
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
          Spacer(),
          Text(
            'Your Safe Status',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SafeStatusIcon(
                icon: Icons.sentiment_satisfied,
                label: 'All is Fine',
                color: Colors.green,
              ),
              SafeStatusIcon(
                icon: Icons.sentiment_neutral,
                label: 'Suspicious',
                color: Colors.grey,
              ),
              SafeStatusIcon(
                icon: Icons.sentiment_very_dissatisfied,
                label: 'Danger',
                color: Colors.grey,
              ),
            ],
          ),
          Spacer(),
        ],
      ),
    );
  }
}

class SafeStatusIcon extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;

  SafeStatusIcon({required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 50, color: color),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(color: color),
        ),
      ],
    );
  }
}
