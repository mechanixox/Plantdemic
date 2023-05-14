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
              'Review financial performance',
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
          ],
        ),
      ),
    );
  }
}
