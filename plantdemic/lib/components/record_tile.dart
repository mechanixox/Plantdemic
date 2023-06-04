import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/plant.dart';

// ignore: must_be_immutable
class RecordsTile extends StatelessWidget {
  final Plant plant;
  final Function(BuildContext)? deleteTapped;

  RecordsTile({
    Key? key,
    required this.plant,
    required this.deleteTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int profit = plant.profit?.toInt() ?? 0; // Convert double to int

    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 0.3,
        motion: Padding(
          padding:
              const EdgeInsets.only(bottom: 20, top: 10, left: 10, right: 10),
          child: StretchMotion(),
        ),
        children: [
          //delete tile
          SlidableAction(
            onPressed: deleteTapped,
            backgroundColor: Colors.red.shade400,
            icon: Icons.delete_rounded,
            borderRadius: BorderRadius.circular(15),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 255, 255, 255),
          borderRadius: BorderRadius.circular(15),
        ),
        margin: EdgeInsets.only(bottom: 12),
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 1),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 5.0, left: 0, bottom: 5, right: 10),
          child: ListTile(
            contentPadding: EdgeInsets.only(right: 10, left: 13),
            title: Text(
              plant.name,
              style: TextStyle(fontSize: 18),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateTime.now().month.toString().padLeft(2, '0')}/${DateTime.now().day.toString().padLeft(2, '0')}/${DateTime.now().year.toString()}',
                ),
              ],
            ),
            leading: Image.asset(
              plant.imagePath,
              width: 60,
              height: 60,
            ),
            trailing: SizedBox(
              width: 50,
              height: 40,
              child: Column(
                children: [
                  Text('Profit'),
                  Text('₱$profit'),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
