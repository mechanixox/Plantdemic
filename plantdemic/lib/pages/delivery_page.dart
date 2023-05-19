import 'package:flutter/material.dart';
import 'package:plantdemic/classes/inventory.dart';
//import 'package:plantdemic/components/delivery_tab.dart';
import 'package:plantdemic/components/plant_tile.dart';
import 'package:provider/provider.dart';

import '../classes/plant.dart';
import 'delivery_info_page.dart';

class UserDelivery extends StatefulWidget {
  const UserDelivery({super.key});

  @override
  State<UserDelivery> createState() => _UserDeliverState();
}

class _UserDeliverState extends State<UserDelivery> {
  void removeFromDelivery(Plant plant) {
    Provider.of<PlantdemicInventory>(context, listen: false)
        .removeFromDelivery(plant);
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
    return Consumer<PlantdemicInventory>(
        builder: (context, value, child) => SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 15, bottom: 25, top: 15, left: 15),
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
                          return PlantTile(
                            plant: plant,
                            onTap: () => goToManageDeliveryInfoPage(
                                plant), //go to delivery info page
                            trailing: IconButton(
                              icon: Icon(Icons.check_sharp),
                              onPressed: () => removeFromDelivery(plant),
                            ),
                            deleteTapped: (context) =>
                                removeFromDelivery(plant),
                          );
                        },
                      ),
                    )
                  ],

                  /*
          //NOTE: if you uncomment this, delete the children
          children: [
            Expanded(
              child: TabBarPage(),
            )
          ],*/
                ),
              ),
            ));
  }
}