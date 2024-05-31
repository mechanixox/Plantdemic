import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:plantdemic/models/plantdemic.dart';
import 'pages/home_page.dart';
import 'pages/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("plantdemic");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<Plantdemic>(
          create: (context) => Plantdemic(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/homepage': (context) => HomePage(),
        },
        theme: ThemeData(
          useMaterial3: true,
          primarySwatch: Colors.green,
        ),
      ),
    );
  }
}
