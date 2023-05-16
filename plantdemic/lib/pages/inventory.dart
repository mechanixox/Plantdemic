import 'package:flutter/material.dart';
import 'package:plantdemic/pages/manage_plant_page.dart';
import 'package:provider/provider.dart';
import 'package:plantdemic/classes/inventory.dart';

import '../classes/plant.dart';
import '../components/plant_tile.dart';

class UserInventory extends StatefulWidget {
  const UserInventory({super.key});

  @override
  State<UserInventory> createState() => _UserInventoryState();
}

class _UserInventoryState extends State<UserInventory> {
  //go to manage plant page, once user selected a plant

  void goToManagePlantPage(Plant plant) {
    //navigate

    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ManagePlantPage(
                  plant: plant,
                )));
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantdemicInventory>(
      builder: (context, value, child) => SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(right: 15, bottom: 1, top: 20, left: 15),
          child: Stack(
            children: [
              Column(
                children: [
                  //heading text
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Manage your plants',
                      style: TextStyle(
                        fontSize: 16,
                        color: Color.fromRGBO(106, 136, 86, 1),
                      ),
                    ),
                  ),
                  Divider(
                    thickness: 2,
                    color: Colors.grey[300],
                  ),
                  //list of plant
                  Expanded(
                    child: ListView.builder(
                      itemCount: value.inventory.length,
                      itemBuilder: (context, index) {
                        //get individual plant from inventory
                        Plant individualPlant = value.inventory[index];

                        //return plant in the tile
                        return PlantTile(
                          plant: individualPlant,
                          onTap: () => goToManagePlantPage(individualPlant),
                          trailing: Icon(Icons.arrow_forward),
                        );
                      },
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: 16.0,
                right: 10.0,
                child: FloatingActionButton(
                  onPressed: () {
                    // Add your action here
                  },
                  backgroundColor: Color.fromRGBO(124, 194, 134, 1),
                  shape: CircleBorder(),
                  child: Icon(Icons.add_rounded, color: Colors.white, size: 32),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
