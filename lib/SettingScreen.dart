import 'package:flutter/material.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery.of(context).size.height;
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: const Color(0xFF28292E),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0), // Increased height of the AppBar
        child: AppBar(
          backgroundColor: const Color(0xFF28292E),
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white, // Set the color of the back button to white
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(width: screenWidth * 0.14),
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
              const Text(
                "QuickShield",
                textAlign: TextAlign.left,
                style: TextStyle(fontFamily: 'Manrope',color: Colors.green, fontSize: 24),
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                'Subscription',
                style: TextStyle(fontFamily: 'Manrope',color: Colors.white,fontSize: 21),
              ),
              subtitle: const Text(
                'No Plan',
                style: TextStyle(fontFamily: 'Manrope',color: Colors.white70),
              ),
              onTap: () {
                // Action when tapped
                print("Cell 1 tapped");
              },
            ),
          ),
          const Divider(color: Colors.white54), // Divider between the cells
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: const Text(
                'QuickShield',
                style: TextStyle(fontFamily: 'Manrope',color: Colors.white,fontSize: 21),
              ),
              subtitle: const Text(
                'version 1.0.0',
                style: TextStyle(fontFamily: 'Manrope',color: Colors.white70),
              ),
              onTap: () {
                // Action when tapped
                print("Cell 2 tapped");
              },
            ),
          ),
        ],
      ),
    );
  }
}
