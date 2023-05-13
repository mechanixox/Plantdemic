import 'package:flutter/material.dart';

class UserRecords extends StatefulWidget {
  const UserRecords({super.key});

  @override
  State<UserRecords> createState() => _UserRecordsState();
}

class _UserRecordsState extends State<UserRecords> {
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
              'Records',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Inter',
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(106, 136, 86, 1),
              ),
            ),
            Text(
              'Review financial performance',
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
