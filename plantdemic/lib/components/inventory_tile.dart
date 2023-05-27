import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../classes/plant.dart';

// ignore: must_be_immutable
class PlantTile extends StatelessWidget {
  final Plant plant;
  void Function()? onTap;
  final Widget trailing;
  final Function(BuildContext)? deleteTapped;
  final Function(BuildContext)? sellTapped;

  PlantTile({
    Key? key,
    required this.plant,
    required this.onTap,
    required this.trailing,
    required this.deleteTapped,
    required this.sellTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Expanded(
        child: Slidable(
          endActionPane: ActionPane(
            extentRatio: 0.6,
            motion: Padding(
              padding: const EdgeInsets.only(
                  bottom: 20, top: 10, left: 10, right: 10),
              child: StretchMotion(),
            ),
            children: [
              //sell tile
              SlidableAction(
                onPressed: sellTapped,
                backgroundColor: Colors.teal.shade800,
                icon: Icons.sell_rounded,
                borderRadius: BorderRadius.circular(15),
              ),
              SizedBox(width: 5),
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
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(bottom: 12),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, left: 0, bottom: 10),
              child: ListTile(
                title: Text(
                  plant.name,
                  style: TextStyle(fontSize: 18),
                ),
                subtitle: Text(
                  '₱${plant.price}',
                ),
                leading: Image.asset(
                  plant.imagePath,
                  width: 60,
                  height: 60,
                ),
                trailing: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(child: trailing), // Wrap the Column with Expanded
                    SizedBox(height: 5),
                    Text(
                      '${plant.quantity}x',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
