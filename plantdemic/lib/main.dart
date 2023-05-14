import 'package:flutter/material.dart';
import 'package:plantdemic/classes/inventory.dart';
import 'pages/home_page.dart';
import 'components/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PlantdemicInventory(),
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
