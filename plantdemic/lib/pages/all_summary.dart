import 'package:flutter/material.dart';

class AllSummary extends StatefulWidget {
  const AllSummary({super.key});

  @override
  State<AllSummary> createState() => _AllSummaryState();
}

class _AllSummaryState extends State<AllSummary> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(242, 243, 245, 1),
      child: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 25, bottom: 25, top: 20, left: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Detailed summary',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  decoration:
                      TextDecoration.none, // Remove underline decoration
                ),
              ),

              Divider(
                thickness: 2,
                color: Colors.grey[300],
              ),
              const SizedBox(height: 25),

              // Add your widgets below the receipt
            ],
          ),
        ),
      ),
    );
  }
}
