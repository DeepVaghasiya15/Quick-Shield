import 'package:anti_spy/FixedScreen.dart';
import 'package:flutter/material.dart';

import 'SettingScreen.dart';

class SubscriptionList extends StatefulWidget {
  const SubscriptionList({super.key});

  @override
  _SubscriptionListState createState() => _SubscriptionListState();
}

class _SubscriptionListState extends State<SubscriptionList> {
  String selectedPlan = "1 Time Fix"; // Default selected plan

  void selectPlan(String plan) {
    setState(() {
      selectedPlan = plan;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      // backgroundColor: const Color(0xFF28292E),
      backgroundColor: Colors.black,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80.0),
        child: AppBar(
          // backgroundColor: const Color(0xFF28292E),
          backgroundColor: Colors.black,
          centerTitle: true,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(width: screenWidth * 0.00,),
              IconButton(
                icon: Image.asset('assets/images/BackButton.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(width: screenWidth * 0.58,),
              IconButton(
                icon: Image.asset('assets/images/SettingIcon.png',
                  height: 40,
                  width: 40,
                ),
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => SettingScreen()));
                  print("Image clicked");
                },
              ),
              SizedBox(width: screenWidth * 0.02,),
            ],
          ),
          automaticallyImplyLeading: false,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Image.asset(
              'assets/images/Premium.png',
              height: 95,
            ),
          ),
          const Text(
            "Pricing Plan",
            style: TextStyle(
                fontFamily: 'Manrope',color: Colors.white, fontSize: 40, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 20,),
          const Padding(
            padding: EdgeInsets.only(left: 8.0, right: 8),
            child: Text(
              "Choose a subscription plan to unlock all the functionality of the application.",
              style: TextStyle(
                  fontFamily: 'Manrope',color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          PricingPlanCard(
            title: "1 Time Fix",
            price: "₹439/ Fix",
            description: "",
            color: selectedPlan == "1 Time Fix" ? const Color(0xFF00C756) : Colors.grey[850]!,
            onTap: () => selectPlan("1 Time Fix"),
          ),
          const SizedBox(height: 40,),
          Stack(
            clipBehavior: Clip.none,
            children: [
              PricingPlanCard(
                title: "1 Year Subscription",
                price: "₹166/mo",
                description: "₹1999 billed for 1 year (Unlimited Scans)",
                color: selectedPlan == "1 year plan" ? const Color(0xFF00C756) : Colors.grey[850]!,
                onTap: () => selectPlan("1 year plan"),
              ),
              Positioned(
                top: -12, // Adjust as needed
                right: 30, // Adjust as needed
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: const Color(0xFF28292E), width: 3),
                  ),
                  child: const Text(
                    "Save 90%",
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Color(0xFF00C756),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // PricingPlanCard(
          //   title: "Monthly plan",
          //   price: "\$19/mo",
          //   description: "",
          //   color: selectedPlan == "Monthly plan" ? Color(0xFF00C756) : Colors.grey[850]!,
          //   onTap: () => selectPlan("Monthly plan"),
          // ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // const Padding(
                  //   padding: const EdgeInsets.only(bottom: 8.0),
                  //   child: Text(
                  //     "Powered by Gfuturetech Pvt Ltd",
                  //     style: TextStyle(
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.w200,
                  //     ),
                  //   ),
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FixedScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF00C756),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(screenWidth * 0.9, 60),
                      ),
                      child: const Text(
                        'Continue',
                        style: TextStyle(fontFamily: 'Manrope',color: Colors.white, fontSize: 24),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class PricingPlanCard extends StatelessWidget {
  final String title;
  final String price;
  final String description;
  final Color color;
  final VoidCallback onTap;

  PricingPlanCard({
    required this.title,
    required this.price,
    required this.description,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double cardWidth = screenWidth * 0.9; // 90% of screen width
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: cardWidth,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: price.split('/')[0], // Extract the price part before "/"
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      TextSpan(
                        text: '/' + price.split('/')[1], // Extract the "/mo" part
                        style: const TextStyle(
                          fontFamily: 'Manrope',
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            if (description.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                description,
                style: const TextStyle(
                  fontFamily: 'Manrope',
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
