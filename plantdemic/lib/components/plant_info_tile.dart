import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/plant.dart';

// ignore: must_be_immutable
class PlantInfoTile extends StatelessWidget {
  final Plant plant;
  final Function(BuildContext)? editTapped;

  PlantInfoTile({
    Key? key,
    required this.plant,
    required this.editTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Slidable(
        endActionPane: ActionPane(
          extentRatio: 0.3,
          motion: Padding(
            padding: const EdgeInsets.only(
                bottom: 120, top: 140, left: 0, right: 30),
            child: StretchMotion(),
          ),
          children: [
            // edit tile
            SlidableAction(
              onPressed: editTapped,
              backgroundColor: Colors.green.shade400.withOpacity(0.9),
              icon: Icons.edit_rounded,
              foregroundColor: Color.fromARGB(250, 250, 250, 250),
              borderRadius: BorderRadius.circular(200),
            ),
          ],
        ),
        child: Column(
          children: [
            //
            //name
            //
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(252, 252, 252, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(top: 30, bottom: 10, left: 20, right: 20),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 10, bottom: 0, right: 10),
                child: ListTile(
                  leading: Text(
                    'Name:',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as desired
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                  title: Text(plant.name, style: TextStyle(fontSize: 17)),
                ),
              ),
            ),
            //
            //cost
            //
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(252, 252, 252, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(top: 2, bottom: 10, left: 20, right: 20),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 10, bottom: 0, right: 10),
                child: ListTile(
                  leading: Text(
                    'Cost:',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as desired
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                  title: Text('₱${plant.cost}', style: TextStyle(fontSize: 17)),
                ),
              ),
            ),
            //
            //price
            //
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(252, 252, 252, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(top: 2, bottom: 10, left: 20, right: 20),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 10, bottom: 0, right: 10),
                child: ListTile(
                  leading: Text(
                    'Price:',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as desired
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                  title:
                      Text('₱${plant.price}', style: TextStyle(fontSize: 17)),
                ),
              ),
            ),
            //
            //quantity
            //
            Container(
              decoration: BoxDecoration(
                color: Color.fromRGBO(252, 252, 252, 1),
                borderRadius: BorderRadius.circular(15),
              ),
              margin: EdgeInsets.only(top: 2, bottom: 10, left: 20, right: 20),
              padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 0, left: 10, bottom: 0, right: 10),
                child: ListTile(
                  leading: Text(
                    'Quantity:',
                    style: TextStyle(
                      fontSize: 18, // Adjust the font size as desired
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                  ),
                  title: Text('${plant.quantity}x',
                      style: TextStyle(fontSize: 17)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
