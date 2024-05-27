import 'dart:async';
import 'dart:math';
import 'package:anti_spy/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:anti_spy/main.dart';

import 'ScannedScreen.dart';

class ScanningScreen extends StatefulWidget {
  const ScanningScreen({Key? key}) : super(key: key);

  @override
  State<ScanningScreen> createState() => _ScanningScreenState();
}

class _ScanningScreenState extends State<ScanningScreen> {
  bool _animationCompleted = false;
  double _progressValue = 0.0;
  late Timer _progressTimer;
  late Timer _appNameTimer;
  final Random _random = Random();
  int _pauseCount = 0;
  late List<double> _pausePoints;
  String _currentAppName = 'Starting';
  bool _animationPaused = false;

  @override
  void initState() {
    super.initState();
    _initializePausePoints();
    _startAnimation();
    _startAppNameRotation();
  }

  @override
  void dispose() {
    _progressTimer.cancel();
    _appNameTimer.cancel();
    super.dispose();
  }

  void _initializePausePoints() {
    const minPausePercentage = 0.2; // Minimum percentage to pause
    const maxPausePercentage = 0.8; // Maximum percentage to pause
    final pauseCount = _random.nextInt(2) + 4; // Random pause count between 2 and 3

    _pausePoints = List.generate(pauseCount, (index) {
      return minPausePercentage + _random.nextDouble() * (maxPausePercentage - minPausePercentage);
    });

    _pausePoints.sort();
  }

  void _startAnimation() {
    const totalDuration = 11000; // Total duration in milliseconds
    final steps = 100;
    final stepDuration = totalDuration ~/ steps;

    int currentStep = (_progressValue * steps).toInt();

    _progressTimer = Timer.periodic(Duration(milliseconds: stepDuration), (timer) {
      if (currentStep < steps) {
        setState(() {
          _progressValue = currentStep / steps;
        });
        currentStep++;
      } else {
        _progressTimer.cancel();
        setState(() {
          _progressValue = 1.0;
        });
        // Set a delay before making the widget disappear and navigate to next screen
        Future.delayed(Duration(seconds: 2), () {
          setState(() {
            _animationCompleted = true;
          });
          _navigateToNextScreen();
        });
      }

      if (_pauseCount < _pausePoints.length && currentStep / steps >= _pausePoints[_pauseCount]) {
        _progressTimer.cancel();
        _pauseCount++;
        _animationPaused = true; // Pause the animation
        Timer(Duration(milliseconds: _random.nextInt(2000)), () {
          _startAnimation();
          _animationPaused = false; // Resume the animation
          _startAppNameRotation(); // Start the app name rotation
        });
      }
    });
  }

  void _startAppNameRotation() {
    int currentStep = 0; // Initialize currentStep here
    const totalDuration = 11000; // Total duration in milliseconds
    const steps = 100;
    final stepDuration = totalDuration ~/ steps;
    final appNamesCount = appNamesScanning.length;

    _appNameTimer = Timer.periodic(Duration(milliseconds: stepDuration), (timer) {
      if (!_animationPaused) { // Check if animation is not paused
        if (currentStep < steps) {
          // Calculate the progress percentage
          final progress = currentStep / steps;

          // Calculate the index of the app name based on progress
          final index = (progress * appNamesCount).floor();

          setState(() {
            _currentAppName = appNamesScanning[index];
          });

          currentStep++;
        } else {
          _appNameTimer.cancel(); // Cancel the timer when all app names have been shown
        }
      } else {
        // Reset currentStep when animation is paused
        currentStep = 0;
      }
    });

    // If the animation is already completed, cancel the timer immediately
    if (_animationCompleted) {
      _appNameTimer.cancel();
    }
  }




  void _navigateToNextScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ScannedScreen(suspiciousApps: SuspiciousApp),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF28292E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF28292E),
        title: const Text('Scanning', style: TextStyle(color: Colors.white)),
        centerTitle: true,

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedOpacity(
                    opacity: _animationCompleted ? 0.0 : 1.0,
                    duration: const Duration(milliseconds: 500),
                    child: Image.asset(
                      'assets/images/CircularLoader.gif',
                      height: 280,
                      width: 280,
                    ),
                  ),
                  if (!_animationCompleted)
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TweenAnimationBuilder(
                          tween: Tween(begin: 0.0, end: 1.0),
                          duration: const Duration(milliseconds: 500),
                          builder: (context, double value, child) {
                            final percentage = (_progressValue * 100).toInt();
                            return RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: '$percentage',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 65, // Larger font size for the number
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  TextSpan(
                                    text: '%',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18, // Smaller font size for the '%' symbol
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Text(
            'Scanning... $_currentAppName',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.normal,
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Text(
                      "Powered by Gfuturetech Pvt Ltd",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w200,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: isSuspicious ? Color(0xFFE9696A).withOpacity(0.5) : Color(0xFF00C756).withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: const Size(300, 50),
                      ),
                      child: const Text(
                        'Stop',
                        style: TextStyle(color: Colors.black, fontSize: 16),
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
