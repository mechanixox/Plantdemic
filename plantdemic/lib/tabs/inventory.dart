import 'package:flutter/material.dart';

class UserInventory extends StatefulWidget {
  const UserInventory({super.key});

  @override
  State<UserInventory> createState() => _UserInventoryState();
}

class _UserInventoryState extends State<UserInventory> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding:
            const EdgeInsets.only(right: 25, bottom: 25, top: 20, left: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Inventory',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(106, 136, 86, 1),
              ),
            ),
            Text(
              'Manage your inventory',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                color: Color.fromRGBO(142, 162, 129, 1),
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
