import 'package:flutter/material.dart';
//import 'package:flutter_slidable/flutter_slidable.dart';

import '../classes/plant.dart';

// ignore: must_be_immutable
class SellInfoTile extends StatelessWidget {
  final Plant plant;
  final Function(BuildContext)? editTapped;

  SellInfoTile({
    Key? key,
    required this.plant,
    required this.editTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Image.asset(
            width: 200,
            height: 200,
            'assets/icons/earning.png',
          ),
          //
          //
          //
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 229, 233, 229),
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
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Add your onPressed logic here
                  },
                ),
              ),
            ),
          ),
          //
          //
          //
          Container(
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 229, 233, 229),
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
                  '${plant.quantity}x',
                ),
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    // Add your onPressed logic here
                  },
                ),
              ),
            ),
          ),
          //
          //
          //
          
        ],
      ),
    );
  }
}
