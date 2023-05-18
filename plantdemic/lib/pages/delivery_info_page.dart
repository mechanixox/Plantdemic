import 'package:flutter/material.dart';
import 'package:plantdemic/classes/plant.dart';

class ManageDeliveryPage extends StatefulWidget {
  const ManageDeliveryPage({super.key, required Plant plant});

  @override
  State<ManageDeliveryPage> createState() => _ManageDeliveryPageState();
}

class _ManageDeliveryPageState extends State<ManageDeliveryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 216, 248, 216),
    );
  }
}
