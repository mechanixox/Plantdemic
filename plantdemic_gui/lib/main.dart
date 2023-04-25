import 'package:flutter/material.dart';
import 'home_page.dart';
import 'splash.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      '/': (context) => Splash(),
      '/homepage': (context) => HomePage(),
    },
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: HomePage());
  }
}
