import 'package:flutter/material.dart';

class UserReceipt extends StatefulWidget {
  const UserReceipt({super.key});

  @override
  State<UserReceipt> createState() => _UserReceiptState();
}

class _UserReceiptState extends State<UserReceipt> {
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
              'Receipt',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(106, 136, 86, 1),
              ),
            ),
            Text(
              'Capture an important receipt',
              style: TextStyle(
                fontSize: 15,
                fontFamily: 'Inter',
                color: Color.fromRGBO(142, 162, 129, 1),
              ),
            ),
            const SizedBox(height: 25),

            //below the delivery
          ],
        ),
      ),
    );
  }
}
