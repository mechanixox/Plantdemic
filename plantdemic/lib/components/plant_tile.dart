import 'package:flutter/material.dart';

import '../classes/plant.dart';

// ignore: must_be_immutable
class PlantTile extends StatelessWidget {
  final Plant plant;
  void Function()? onTap;
  final Widget trailing;

  PlantTile({
    Key? key,
    required this.plant,
    required this.onTap,
    required this.trailing,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 217, 237, 233),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
        child: Padding(
          padding: const EdgeInsets.only(top: 5.0, left: 0),
          child: ListTile(
            title: Text(plant.name),
            subtitle: Text(plant.price),
            leading: Image.asset(
              plant.imagePath,
              width: 50,
              height: 50,
            ),
            trailing: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(child: trailing), // Wrap the Column with Expanded
                SizedBox(height: 5),
                Text(
                  plant.quantity,
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
