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
              'Capture an important receipt',
              style: TextStyle(
                fontSize: 16,
                color: Color.fromRGBO(106, 136, 86, 1),
              ),
            ),
            Divider(
              thickness: 2,
              color: Colors.grey[300],
            ),
            const SizedBox(height: 25),

            //below the receipt
          ],
        ),
      ),
    );
  }
}
