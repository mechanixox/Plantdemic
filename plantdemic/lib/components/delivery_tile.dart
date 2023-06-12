import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/plant.dart';

// ignore: must_be_immutable
class DeliveryTile extends StatelessWidget {
  final Plant plant;
  void Function()? onTap;
  final Widget trailing;
  final Function(BuildContext)? deleteTapped;

  DeliveryTile({
    Key? key,
    required this.plant,
    required this.onTap,
    required this.trailing,
    required this.deleteTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.35,
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
              borderRadius: BorderRadius.circular(25),
            ),
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromARGB(255, 255, 255, 255),
            borderRadius: BorderRadius.circular(15),
          ),
          margin: EdgeInsets.only(bottom: 12),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          child: Padding(
            padding: const EdgeInsets.only(top: 5.0, left: 0, bottom: 10),
            child: ListTile(
              contentPadding: EdgeInsets.only(right: 10, left: 13),
              title: Text(
                plant.name,
                style: TextStyle(fontSize: 18),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '₱${plant.price}•',
                        style: TextStyle(fontSize: 14),
                      ),
                      SizedBox(
                        width: 0,
                      ),
                      Text(
                        '${plant.sellQuantity}x',
                        style: TextStyle(fontSize: 14),
                      ),
                    ],
                  ),
                  plant.deliveryDate?.isNotEmpty == true
                      ? Text(
                          '${plant.deliveryDate}',
                        )
                      : Text(
                          'No date',
                          style: TextStyle(
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                ],
              ),
              leading: Image.asset(
                plant.imagePath,
                width: 60,
                height: 60,
              ),
              trailing: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(child: trailing),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
