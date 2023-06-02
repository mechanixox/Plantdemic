import 'package:flutter/material.dart';
import 'package:plantdemic/components/bottom_nav_bar.dart';
import 'package:plantdemic/pages/delivery_page.dart';
import 'package:plantdemic/pages/inventory_page.dart';
import 'package:plantdemic/pages/receipt_page.dart';
import 'package:plantdemic/pages/records_page.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(242, 243, 245, 1),
        elevation: 0,
        /*
        leading: IconButton(
          onPressed: () {},
          icon: Image.asset(
            'assets/icons/leaf2.png',
            width: 20,
            height: 20,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))],
        */
        centerTitle: true,
        title: Align(
          alignment: AlignmentDirectional.topStart,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 8.0),
            child: Text(
              appBarTitles[selectedIndex],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: 'Arial',
                fontSize: 26,
                color: Colors.grey.shade900,
              ),
            ),
          ),
        ),
      ),
      body: tabs[selectedIndex],
      bottomNavigationBar: MyBottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
    );
  }
}
