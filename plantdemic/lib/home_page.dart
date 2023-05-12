import 'package:flutter/material.dart';
import 'package:plantdemic/tabs/delivery.dart';
import 'package:plantdemic/tabs/inventory.dart';
import 'package:plantdemic/tabs/receipt.dart';
import 'package:plantdemic/tabs/records.dart';

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

  final List<String> appBarTitles = [
    'Delivery',
    'Inventory',
    'Receipt',
    'Records',
  ];

  final List<String> appBarLabels = [
    'Track incoming and outgoing plants',
    'Manage your inventory',
    'Capture a receipt',
    'Review financial performance',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            backgroundColor: Color.fromRGBO(106, 136, 86, 1),
            leading: IconButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/leaf2.png',
                width: 20,
                height: 20,
              ),
            ),
            centerTitle: true,
            title: Text(
              appBarTitles[selectedIndex],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
                fontSize: 20,
                color: Colors.white,
              ),
            ),
          ),
          SliverFillRemaining(
            child: tabs[selectedIndex],
          ),
        ],
      ),
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
                textStyle: TextStyle(
                    fontFamily: 'Arial',
                    //fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15),
              ),
              GButton(
                icon: Icons.inventory_2_outlined,
                iconColor: Color.fromARGB(255, 111, 109, 109),
                text: 'Inventory',
                textStyle: TextStyle(
                    fontFamily: 'Arial',
                    //fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15),
              ),
              GButton(
                icon: Icons.receipt_outlined,
                iconColor: Color.fromARGB(255, 111, 109, 109),
                text: 'Receipt',
                textStyle: TextStyle(
                    fontFamily: 'Arial',
                    //fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15),
              ),
              GButton(
                icon: Icons.analytics_outlined,
                iconColor: Color.fromARGB(255, 111, 109, 109),
                text: 'Records',
                textStyle: TextStyle(
                    fontFamily: 'Arial',
                    //fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
