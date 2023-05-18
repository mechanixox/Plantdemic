import 'package:flutter/material.dart';
import 'package:plantdemic/pages/manage_plant_page.dart';
import 'package:provider/provider.dart';
import 'package:plantdemic/classes/inventory.dart';

import 'add_plant_page.dart';
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
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ManagePlantPage(
                  plant: plant,
                )));
  }

  void navigateToAddPlantPage() {
    // Create a new Plant object with default values
    Plant newPlant = Plant(
      name: 'Default Plant',
      price: '0',
      quantity: '0',
      imagePath: 'assets/icons/plant.png',
    );

    // Navigate to the AddPlantPage and wait for a result (the new plant)
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPlantPage(
          plant: newPlant,
        ),
      ),
    ).then((result) {
      // Check if a new plant was added
      if (result != null && result is Plant) {
        Provider.of<PlantdemicInventory>(context, listen: false)
            .addToInventory(result);
      }
    });
  }

  void removeFromInventory(Plant plant) {
    Provider.of<PlantdemicInventory>(context, listen: false)
        .removeFromInventory(plant);
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
                          trailing: IconButton(
                            icon: Icon(Icons.arrow_forward),
                            onPressed: () =>
                                goToManagePlantPage(individualPlant),
                          ),
                          deleteTapped: (context) =>
                              removeFromInventory(individualPlant),
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
                    navigateToAddPlantPage();
                  },
                  backgroundColor: Colors.green.shade400,
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
