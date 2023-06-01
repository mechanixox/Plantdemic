import 'package:flutter/material.dart';
import 'package:plantdemic/models/plantdemic.dart';
import 'package:plantdemic/components/inventory_tile.dart';
import 'package:plantdemic/pages/sell_info_page.dart';
import 'package:provider/provider.dart';

import '../models/plant.dart';
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
      cost: '0',
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
        Provider.of<Plantdemic>(context, listen: false)
            .addToInventory(context, result);
      }
    });
  }

  void removeFromInventory(Plant plant) {
    Provider.of<Plantdemic>(context, listen: false).removeFromInventory(plant);
  }

  void navigateToSellInfoPage(Plant plant) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SellInfoPage(plant: plant)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Plantdemic>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Color.fromRGBO(242, 243, 245, 1),
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Manage your plants',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color.fromRGBO(0, 0, 0, 1),
                  ),
                ),
              ),
              floating: true,
              snap: true,
              backgroundColor: Color.fromRGBO(242, 243, 245, 1),
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
                      sellTapped: (context) =>
                          navigateToSellInfoPage(individualPlant),
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
