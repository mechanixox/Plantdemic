import 'package:flutter/material.dart';
import 'package:plantdemic/components/bottom_nav_bar.dart';
import 'package:plantdemic/tabs/delivery.dart';
import 'package:plantdemic/tabs/inventory.dart';
import 'package:plantdemic/tabs/receipt.dart';
import 'package:plantdemic/tabs/records.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> tabs = [
    UserDelivery(),
    UserInventory(),
    UserReceipt(),
    UserRecords(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      body: tabs[selectedIndex],
    );
  }
}
