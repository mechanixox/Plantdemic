import 'package:flutter/material.dart';
import 'package:flutter_dev/tabs/delivery.dart';
import 'package:flutter_dev/tabs/inventory.dart';
import 'package:flutter_dev/tabs/receipt.dart';
import 'package:flutter_dev/tabs/records.dart';
//import 'package:flutter_dev/const.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

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
      body: tabs[selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 241, 244, 241),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 195, 193, 193).withOpacity(0.3),
              offset: Offset(0, -3),
              blurRadius: 5,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 9),
          child: GNav(
            onTabChange: (index) {
              setState(() {
                selectedIndex = index;
              });
            },
            backgroundColor: Color.fromARGB(255, 241, 244, 241),
            activeColor: Color.fromARGB(255, 255, 255, 255),
            tabBackgroundColor: Color.fromRGBO(124, 194, 134, 1.0),
            gap: 8,
            padding: EdgeInsets.all(18),
            tabs: [
              GButton(
                icon: Icons.shopping_basket_outlined,
                iconColor: Color.fromARGB(255, 111, 109, 109),
                text: 'Delivery',
              ),
              GButton(
                icon: Icons.inventory_2_outlined,
                iconColor: Color.fromARGB(255, 111, 109, 109),
                text: 'Inventory',
              ),
              GButton(
                icon: Icons.receipt_outlined,
                iconColor: Color.fromARGB(255, 111, 109, 109),
                text: 'Receipt',
              ),
              GButton(
                icon: Icons.analytics_outlined,
                iconColor: Color.fromARGB(255, 111, 109, 109),
                text: 'Records',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
