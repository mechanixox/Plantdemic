import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  startTimer() {
    var duration = Duration(seconds: 8);
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
      padding: const EdgeInsets.only(left: 1),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              child: Lottie.network(
                'https://assets4.lottiefiles.com/private_files/lf30_gnkqx2xe.json',
                height: 200,
                width: 200,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 0),
            FutureBuilder(
              future: Future.delayed(Duration(seconds: 1)),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(); // You can return a loading spinner or something else here
                } else {
                  return ShaderMask(
                    blendMode: BlendMode.srcIn,
                    shaderCallback: (Rect bounds) {
                      return LinearGradient(
                        colors: [Colors.green.shade700, Colors.green.shade400],
                      ).createShader(bounds);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Text(
                        'Plantdemic',
                        style: TextStyle(
                          fontFamily: 'Arial',
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
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
