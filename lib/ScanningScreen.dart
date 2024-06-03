import 'dart:async';
import 'dart:math';
import 'package:animated_progress_bar/animated_progress_bar.dart';
import 'package:anti_spy/FixedScreen.dart';
import 'package:flutter/material.dart';
import 'HomeScreen.dart';
import 'NoSpyingApp.dart';
import 'ScannedScreen.dart';
import 'main.dart';

class ScanningScreen extends StatefulWidget {
  final List<String> allPermissions;

  const ScanningScreen({Key? key, required this.allPermissions}) : super(key: key);

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
    const minPausePercentage = 0.2;
    const maxPausePercentage = 0.8;
    final pauseCount = _random.nextInt(2) + 4;

    _pausePoints = List.generate(pauseCount, (index) {
      return minPausePercentage +
          _random.nextDouble() * (maxPausePercentage - minPausePercentage);
    });

    _pausePoints.sort();
  }

  void _startAnimation() {
    const totalDuration = 8000;
    final steps = 100;
    final stepDuration = totalDuration ~/ steps;

    int currentStep = (_progressValue * steps).toInt();

    _progressTimer =
        Timer.periodic(Duration(milliseconds: stepDuration), (timer) {
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
            Future.delayed(const Duration(seconds: 2), () {
              setState(() {
                _animationCompleted = true;
              });
              _navigateToNextScreen();
            });
          }

          if (_pauseCount < _pausePoints.length &&
              currentStep / steps >= _pausePoints[_pauseCount]) {
            _progressTimer.cancel();
            _pauseCount++;
            _animationPaused = true;
            Timer(Duration(milliseconds: _random.nextInt(2000)), () {
              _startAnimation();
              _animationPaused = false;
              _startAppNameRotation();
            });
          }
        });
  }

  void _startAppNameRotation() {
    int currentStep = 0;
    const totalDuration = 8000;
    const steps = 100;
    final stepDuration = totalDuration ~/ steps;
    final appNamesCount = appNamesScanning.length;

    _appNameTimer =
        Timer.periodic(Duration(milliseconds: stepDuration), (timer) {
          if (!_animationPaused) {
            if (currentStep < steps) {
              final progress = currentStep / steps;
              final index = (progress * appNamesCount).floor();

              setState(() {
                _currentAppName = appNamesScanning[index];
              });

              currentStep++;
            } else {
              _appNameTimer.cancel();
            }
          } else {
            currentStep = 0;
          }
        });

    if (_animationCompleted) {
      _appNameTimer.cancel();
    }
  }

  void _navigateToNextScreen() {
    if (isSuspicious) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ScannedScreen(
            suspiciousApps: SuspiciousApp,
            allPermissions: widget.allPermissions,
          ),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const NoSpyingApp(),
        ),
      );
    }
  }



  @override
  Widget build(BuildContext context) {
    final double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final double screenWidth = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: const Color(0xFF28292E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF28292E),
        title: const Text('Scanning', style: TextStyle(fontFamily: 'Manrope',color: Colors.white)),
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
                                    style: const TextStyle(
                                      fontFamily: 'Manrope',
                                      color: Colors.white,
                                      fontSize: 65,
                                      fontWeight: FontWeight.w300,
                                    ),
                                  ),
                                  const TextSpan(
                                    text: '%',
                                    style: TextStyle(
                                      fontFamily: 'Manrope',
                                      color: Colors.white,
                                      fontSize: 18,
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
          Text.rich(
            TextSpan(
              children: [
                const TextSpan(
                  text: 'Scanning... ',
                  style: TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
                TextSpan(
                  text: _currentAppName,
                  style: const TextStyle(
                    fontFamily: 'Manrope',
                    color: Colors.green,
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 40.0, right: 40),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: "Scanning the ",
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: "Spying",
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.red,
                      fontSize: 25,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  TextSpan(
                    text: " apps on your phone.",
                    style: TextStyle(
                      fontFamily: 'Manrope',
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
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
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context, MaterialPageRoute(builder: (context) =>
                            const HomeScreen()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.withOpacity(0.5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        minimumSize: Size(screenWidth * 0.9, 60),
                      ),
                      child: const Text(
                        'Stop',
                        style: TextStyle(fontFamily: 'Manrope',color: Colors.white, fontSize: 26),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: screenHeight * 0.02),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "Secured by ",
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  color: Colors.white,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Image.asset(
                          'assets/images/QuickShieldLogoMain.png',
                          width: 20, // Adjust the size of the logo as needed
                          height: 20,
                        ),
                        SizedBox(width: 2,),
                        RichText(
                          text: const TextSpan(
                            children: [
                              TextSpan(
                                text: "QuickShield",
                                style: TextStyle(
                                  fontFamily: 'Manrope',
                                  color: Colors.green,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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