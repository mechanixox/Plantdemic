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
      body: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
          color: Color.fromARGB(255, 255, 255, 255),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              backgroundColor: Color.fromRGBO(54, 145, 236, 1),
              expandedHeight: 80,
              pinned: true,
              floating: true,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  color: Color.fromRGBO(71, 173, 86, 1),
                ),
              ),
              //titleSpacing: 0,
              title: Container(
                padding: EdgeInsets.only(top: 30.0, bottom: 20.0),
                alignment: Alignment.center,
                child: Text(
                  appBarTitles[selectedIndex],
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(40),
                child: Container(
                  height: 40,
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      appBarLabels[selectedIndex],
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverFillRemaining(
              child: tabs[selectedIndex],
            ),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 400,
                  color: Colors.deepPurple,
                ),
              ),
            )),
            SliverToBoxAdapter(
                child: Padding(
              padding: const EdgeInsets.all(20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  height: 400,
                  color: Color.fromARGB(255, 146, 116, 198),
                ),
              ),
            )),
          ],
        ),
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
