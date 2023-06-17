import 'package:flutter/material.dart';
import '../models/plant.dart';

// ignore: must_be_immutable
class AllSummaryTile extends StatelessWidget {
  final Plant plant;

  AllSummaryTile({
    Key? key,
    required this.plant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int profit = plant.profit?.toInt() ?? 0; // Convert double to int

    return Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 255, 255, 255),
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.only(bottom: 12),
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
      child: Padding(
        padding: const EdgeInsets.only(top: 5.0, left: 0, bottom: 5, right: 10),
        child: ListTile(
          contentPadding: EdgeInsets.only(right: 10, left: 16),
          leading: Image.asset(
            'assets/icons/01peso-currency.png',
            width: 60,
            height: 60,
          ),
          title: Text(
            plant.name,
            style: TextStyle(fontSize: 18),
          ),
          subtitle: Text(
            'Profit: ₱$profit',
            style: TextStyle(fontSize: 14),
          ),
          trailing: Text(
            plant.deliveryDate ?? '',
            style: TextStyle(fontSize: 14),
          ),
        ),
      ),
    );
  }
}
