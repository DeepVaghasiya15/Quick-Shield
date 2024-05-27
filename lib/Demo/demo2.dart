import 'package:flutter/material.dart';

class QuickShieldScreen extends StatefulWidget {
  @override
  _QuickShieldScreenState createState() => _QuickShieldScreenState();
}

class _QuickShieldScreenState extends State<QuickShieldScreen> {
  int _safeStatus = 1; // default to "All is Fine"

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            '9:41',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Text(
            'QUICKSHIELD',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              // handle scan tap
            },
            child: Text(
              'Tap to SCAN',
              style: TextStyle(fontSize: 18, color: Colors.blue),
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Your Safe Status',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: _safeStatus,
                onChanged: (value) {
                  setState(() {
                    _safeStatus = value!;
                  });
                },
              ),
              Text('All is Fine'),
              Radio(
                value: 2,
                groupValue: _safeStatus,
                onChanged: (value) {
                  setState(() {
                    _safeStatus = value!;
                  });
                },
              ),
              Text('Suspicious'),
              Radio(
                value: 3,
                groupValue: _safeStatus,
                onChanged: (value) {
                  setState(() {
                    _safeStatus = value!;
                  });
                },
              ),
              Text('Danger'),
            ],
          ),
        ],
      ),
    );
  }
}