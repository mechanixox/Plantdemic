import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    _loadFuture =
        Future.delayed(Duration(seconds: 3)); // Simulate a loading delay
    startTimer();
  }

  startTimer() {
    var duration = Duration(seconds: 7);
    return Timer(duration, route);
  }

  route() {
    Navigator.pushReplacementNamed(context, '/homepage');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: content(),
    );
  }

  Widget content() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Lottie.asset(
                'assets/icons/loading.json',
                height: 150,
                width: 150,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 30), // Adjust the height if necessary
            FutureBuilder<void>(
              future: _loadFuture,
              builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(); // Show nothing while waiting
                } else {
                  return ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Colors.green.shade700, Colors.green.shade400],
                      ).createShader(bounds);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Text(
                        'Plantdemic',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
