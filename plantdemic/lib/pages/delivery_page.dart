import 'dart:async';
import 'dart:ui';
//import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:plantdemic/models/plantdemic.dart';
//import 'package:plantdemic/deliveryTabBar/delivery_tab.dart';
import 'package:provider/provider.dart';

import '../models/plant.dart';
import '../models/profit_item.dart';
import '../components/delivery_tile.dart';
import 'delivery_info_page.dart';

class UserDelivery extends StatefulWidget {
  const UserDelivery({super.key});

  @override
  State<UserDelivery> createState() => _UserDeliverState();
}

class _UserDeliverState extends State<UserDelivery> {
  void removeFromDelivery(Plant plant) {
    Provider.of<Plantdemic>(context, listen: false).removeFromDelivery(plant);
  }

  void addToRecordsWhenCheckPressed(Plant plant) {
    /*final DateFormat inputFormat = DateFormat('M/d/yyyy');
    final DateTime deliveryDate = inputFormat.parse(plant.deliveryDate ?? '');*/
    final DateTime deliveryDate = DateTime.now();
    double profitAmount = plant.calculateProfit();

    final ProfitItem newProfit = ProfitItem(
      name: plant.name,
      date: deliveryDate,
      profitAmount: profitAmount.toStringAsFixed(2),
    );

    Provider.of<Plantdemic>(context, listen: false)
        .addToRecords(plant, profitAmount);
    Provider.of<Plantdemic>(context, listen: false).addNewProfit(newProfit);
    Provider.of<Plantdemic>(context, listen: false)
        .removeFromDeliveryToRecords(plant);
    showDialog(
      context: context,
      builder: (context) {
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 0.2, sigmaY: 0.2), // Apply blur effect
          child: AlertDialog(
            backgroundColor:
                Color.fromARGB(255, 255, 255, 255).withOpacity(0.90),
            title: Column(
              children: [
                SizedBox(height: 0),
                Lottie.asset(
                  'assets/icons/sold.json',
                  height: 170,
                  width: 170,
                ),
                SizedBox(height: 0),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    'Transaction recorded!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade800,
                    ),
                  ),
                ),
                SizedBox(height: 15),
              ],
            ),
          ),
        );
      },
    );
  }

  void goToManageDeliveryInfoPage(Plant plant) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ManageDeliveryPage(
                  plant: plant,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Plantdemic>(
      builder: (context, value, child) => Container(
        color: Color.fromRGBO(242, 243, 245, 1),
        child: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(right: 15, bottom: 1, top: 15, left: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //list of plant(s)
                Expanded(
                  child: ListView.builder(
                    itemCount: value.delivery.length,
                    itemBuilder: (context, index) {
                      //get individual plant from inventory
                      Plant plant = value.delivery[index];
                      //return plant tile
                      return DeliveryTile(
                        plant: plant,
                        onTap: () => goToManageDeliveryInfoPage(
                            plant), //go to delivery info page
                        trailing: IconButton(
                          icon: Icon(Icons.check_rounded,
                              size: 30, color: Colors.green.shade300),
                          onPressed: () => addToRecordsWhenCheckPressed(plant),
                        ),
                        deleteTapped: (context) => removeFromDelivery(plant),
                      );
                    },
                  ),
                ),

                // Add TabBarPage as a child of the Column
                /*Expanded(
                  child: TabBarPage(),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
}
