import 'package:flutter/material.dart';
import 'package:plantdemic/bar%20graph/profit_summary.dart';
import 'package:provider/provider.dart';

import '../models/plantdemic.dart';
import '../models/plant.dart';
import '../components/record_tile.dart';

class UserRecords extends StatefulWidget {
  const UserRecords({Key? key}) : super(key: key);

  @override
  State<UserRecords> createState() => _UserRecordsState();
}

class _UserRecordsState extends State<UserRecords> {
  void removeFromRecords(Plant plant) {
    Provider.of<Plantdemic>(context, listen: false).removeFromRecords(plant);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Plantdemic>(
      builder: (context, value, child) => Container(
        color: Color.fromRGBO(242, 243, 245, 1),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(right: 15, top: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Profit summary chart
                ProfitSummary(startOfWeek: value.startOfWeekDate()),
                SizedBox(height: 20),
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
