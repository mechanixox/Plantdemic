import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/plant.dart';

// ignore: must_be_immutable
class DeliveryInfoTile extends StatelessWidget {
  final Plant plant;

  DeliveryInfoTile({
    Key? key,
    required this.plant,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          //
          // price
          //
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(160, 241, 234, 0.6),
                  Color.fromRGBO(234, 214, 239, 0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(top: 20, bottom: 10, left: 20, right: 20),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 10, bottom: 0, right: 0),
              child: ListTile(
                leading: Text(
                  'Price:',
                  style: TextStyle(
                    fontSize: 16, // Adjust the font size as desired
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                ),
                title: Text(
                  '₱${plant.price}',
                ),
              ),
            ),
          ),
          //
          // quantity
          //
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(160, 241, 234, 0.6),
                  Color.fromRGBO(234, 214, 239, 0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(top: 2, bottom: 10, left: 20, right: 20),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 10, bottom: 0, right: 0),
              child: ListTile(
                leading: Text(
                  'Quantity:',
                  style: TextStyle(
                    fontSize: 16, // Adjust the font size as desired
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                ),
                title: Text(
                  // ignore: unrelated_type_equality_checks
                  '${plant.sellQuantity}x',
                ),
              ),
            ),
          ),

          //
          // buyer info
          //
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(160, 241, 234, 0.6),
                  Color.fromRGBO(234, 214, 239, 0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(top: 2, bottom: 10, left: 20, right: 20),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 10, bottom: 0, right: 0),
              child: ListTile(
                leading: Text(
                  'Buyer:',
                  style: TextStyle(
                    fontSize: 16, // Adjust the font size as desired
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                ),
                title: Text(plant.buyer ?? ''),
              ),
            ),
          ),
          //
          // set delivery date
          //
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(160, 241, 234, 0.6),
                  Color.fromRGBO(234, 214, 239, 0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(top: 2, bottom: 10, left: 20, right: 20),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 10, bottom: 0, right: 0),
              child: ListTile(
                leading: Text(
                  'Delivery date:',
                  style: TextStyle(
                    fontSize: 16, // Adjust the font size as desired
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                ),
                title: Text(plant.deliveryDate ?? ''),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 22.0, right: 22, bottom: 4, top: 2),
            child: Divider(
              thickness: 2,
              color: Colors.teal.shade100,
            ),
          ),
          //
          //total
          //
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(160, 241, 234, 0.6),
                  Color.fromRGBO(234, 214, 239, 0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(top: 2, bottom: 10, left: 20, right: 20),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 10, bottom: 0, right: 0),
              child: ListTile(
                leading: Text(
                  'Total:',
                  style: TextStyle(
                    fontSize: 16, // Adjust the font size as desired
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                ),
                title: Text(
                  // ignore: unrelated_type_equality_checks
                  '₱${plant.calculateSellTotal().toStringAsFixed(2)}',
                ),
              ),
            ),
          ),
          //
          //profit
          //
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromRGBO(160, 241, 234, 0.6),
                  Color.fromRGBO(234, 214, 239, 0.6),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: EdgeInsets.only(top: 2, bottom: 10, left: 20, right: 20),
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 0, left: 10, bottom: 0, right: 0),
              child: ListTile(
                leading: Text(
                  'Profit:',
                  style: TextStyle(
                    fontSize: 16, // Adjust the font size as desired
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                ),
                title: Text(
                  // ignore: unrelated_type_equality_checks
                  '₱${plant.calculateProfit().toStringAsFixed(2)}',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
