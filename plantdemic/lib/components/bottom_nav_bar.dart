import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

// ignore: must_be_immutable
class MyBottomNavBar extends StatelessWidget {
  void Function(int)? onTabChange;
  MyBottomNavBar({super.key, required this.onTabChange});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 241, 244, 241),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12),
        child: GNav(
          onTabChange: (value) => onTabChange!(value),
          backgroundColor: Color.fromARGB(255, 241, 244, 241),
          activeColor: Color.fromARGB(255, 255, 255, 255),
          tabBackgroundColor: Colors.green.shade400,
          padding: EdgeInsets.only(left: 15, right: 15, top: 13, bottom: 13),
          tabBorderRadius: 20,
          haptic: true,
          gap: 8,
          tabs: [
            GButton(
              icon: Icons.shopping_basket_outlined,
              iconColor: Color.fromARGB(255, 111, 109, 109),
              text: 'Delivery',
              textStyle: TextStyle(
                  fontFamily: 'Arial',
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
            GButton(
              icon: Icons.inventory_2_outlined,
              iconColor: Color.fromARGB(255, 111, 109, 109),
              text: 'Inventory',
              textStyle: TextStyle(
                  fontFamily: 'Arial',
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
            GButton(
              icon: Icons.receipt_outlined,
              iconColor: Color.fromARGB(255, 111, 109, 109),
              text: 'Receipt',
              textStyle: TextStyle(
                  fontFamily: 'Arial',
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
            GButton(
              icon: Icons.analytics_outlined,
              iconColor: Color.fromARGB(255, 111, 109, 109),
              text: 'Records',
              textStyle: TextStyle(
                  fontFamily: 'Arial',
                  //fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
