import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../bar graph/profit_graph.dart';
import '../classes/inventory.dart';
import '../classes/plant.dart';
import '../components/record_tile.dart';

class UserRecords extends StatefulWidget {
  const UserRecords({Key? key}) : super(key: key);

  @override
  State<UserRecords> createState() => _UserRecordsState();
}

class _UserRecordsState extends State<UserRecords> {
  void removeFromRecords(Plant plant) {
    Provider.of<PlantdemicInventory>(context, listen: false)
        .removeFromRecords(plant);
  }

  List<double> weeklySummary = [
    4.20,
    56.50,
    99.90,
    34.50,
    20.00,
    50.30,
    90.30,
    40.50,
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<PlantdemicInventory>(
      builder: (context, value, child) => Container(
        color: Colors.white,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, top: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profit summary chart
                Padding(
                  padding: const EdgeInsets.only(top: 15.0),
                  child: Center(
                      child: SizedBox(
                    height: 250,
                    child: ProfitGraph(),
                  )),
                ),
                // List of plant(s)
                Expanded(
                  child: ListView.builder(
                    itemCount: value.records.length,
                    itemBuilder: (context, index) {
                      // Get individual plant from inventory
                      Plant plant = value.records[index];
                      // Return plant tile
                      return RecordsTile(
                        plant: plant,
                        deleteTapped: (context) => removeFromRecords(plant),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
