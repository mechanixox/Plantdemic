import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';

import '../models/plant.dart';

// ignore: must_be_immutable
class SellInfoTile extends StatelessWidget {
  final Plant plant;
  Function(BuildContext)? editPriceTapped;
  Function(BuildContext)? editQuantityTapped;
  Function(BuildContext)? editBuyerTapped;
  Function(BuildContext)? editDateTapped;
  SellInfoTile({
    Key? key,
    required this.plant,
    this.editPriceTapped,
    this.editQuantityTapped,
    this.editBuyerTapped,
    this.editDateTapped,
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
                  Color.fromRGBO(226, 235, 240, 1),
                  Color.fromRGBO(221, 229, 235, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(15),
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
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit_rounded,
                    color: Color.fromRGBO(180, 189, 194, 1),
                    size: 22,
                  ),
                  onPressed: () => editPriceTapped!(context),
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
                  Color.fromRGBO(226, 235, 240, 1),
                  Color.fromRGBO(221, 229, 235, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(15),
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
                  plant.sellQuantity ?? '',
                ),
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit_rounded,
                    color: Color.fromRGBO(180, 189, 194, 1),
                    size: 22,
                  ),
                  onPressed: () => editQuantityTapped!(context),
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
                  Color.fromRGBO(226, 235, 240, 1),
                  Color.fromRGBO(221, 229, 235, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(15),
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
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit_rounded,
                    color: Color.fromRGBO(180, 189, 194, 1),
                    size: 22,
                  ),
                  onPressed: () => editBuyerTapped!(context),
                ),
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
                  Color.fromRGBO(226, 235, 240, 1),
                  Color.fromRGBO(221, 229, 235, 1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              borderRadius: BorderRadius.circular(15),
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
                trailing: IconButton(
                  icon: Icon(
                    Icons.edit_rounded,
                    color: Color.fromRGBO(180, 189, 194, 1),
                    size: 22,
                  ),
                  onPressed: () => editDateTapped!(context),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
