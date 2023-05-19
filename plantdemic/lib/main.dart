import 'package:flutter/material.dart';
//import 'package:hive_flutter/adapters.dart';
import 'package:plantdemic/classes/inventory.dart';
import 'package:plantdemic/classes/delivery.dart';
import 'pages/home_page.dart';
import 'pages/splash.dart';
import 'package:provider/provider.dart';

void main() async {
  //WidgetsFlutterBinding.ensureInitialized();
  //await Hive.initFlutter();
  //await Hive.openBox('plantdemic');

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlantdemicInventory>(
          create: (context) => PlantdemicInventory(),
        ),
        ChangeNotifierProvider<PlantdemicDelivery>(
          create: (context) => PlantdemicDelivery(),
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
