import 'package:flutter/material.dart';
import 'package:plantdemic/classes/inventory.dart';
import 'package:plantdemic/components/plant_tile.dart';
import 'package:provider/provider.dart';

import '../classes/plant.dart';
import 'add_plant_page.dart';
import 'manage_plant_page.dart';

class UserInventory extends StatefulWidget {
  const UserInventory({Key? key}) : super(key: key);

  @override
  State<UserInventory> createState() => _UserInventoryState();
}

class _UserInventoryState extends State<UserInventory> {
  void goToManagePlantPage(Plant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ManagePlantPage(plant: plant),
      ),
    );
  }

  void navigateToAddPlantPage() {
    Plant newPlant = Plant(
      name: 'Default Plant',
      price: '0',
      quantity: '0',
      imagePath: 'assets/icons/plant.png',
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddPlantPage(plant: newPlant),
      ),
    ).then((result) {
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
      builder: (context, value, child) => Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Manage your plants',
                style: TextStyle(
                  fontSize: 16,
                  color: Color.fromRGBO(106, 136, 86, 1),
                ),
              ),
              floating: true,
              snap: true,
              backgroundColor: Colors.white,
              elevation: 0,
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  Plant individualPlant = value.inventory[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15),
                    child: PlantTile(
                      plant: individualPlant,
                      onTap: () => goToManagePlantPage(individualPlant),
                      trailing: IconButton(
                        icon: Icon(Icons.arrow_forward),
                        onPressed: () => goToManagePlantPage(individualPlant),
                      ),
                      deleteTapped: (context) =>
                          removeFromInventory(individualPlant),
                    ),
                  );
                },
                childCount: value.inventory.length,
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => navigateToAddPlantPage(),
          backgroundColor: Colors.green.shade400,
          shape: CircleBorder(),
          child: Icon(Icons.add_rounded, color: Colors.white, size: 32),
        ),
      ),
    );
  }
}
