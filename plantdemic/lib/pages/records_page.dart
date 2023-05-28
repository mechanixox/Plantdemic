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
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<PlantdemicInventory>(
      builder: (context, value, child) => Container(
        color: Color.fromRGBO(242, 243, 245, 1),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, top: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profit summary chart
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 30),
                  child: Center(
                      child: SizedBox(
                    height: 200,
                    child: ProfitGraph(
                      weeklySummary: weeklySummary,
                    ),
                  )),
                ),
                // List of plant(s)
                Expanded(
                  child: ListView.builder(
                    itemCount: value.records.length,
                    itemBuilder: (context, index) {
                      // Get plant at the desired index
                      Plant plant =
                          value.records[value.records.length - 1 - index];
                      // Return record tile
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
