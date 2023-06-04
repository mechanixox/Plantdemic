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
  ImageProvider<Object>? selectedImage;
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
      selectedImage: selectedImage,
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
                padding: const EdgeInsets.only(left: 8.0, bottom: 20, top: 5),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30.0),
                      child: Text(
                        'Manage your plants',
                        style: TextStyle(
                          fontSize: 17,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(top: 35.0),
                      child: Text(
                        'Sort by: ',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade800,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 35.0, left: 2, right: 5),
                      child: DropdownButton<String>(
                        value: value.sortOption,
                        underline: Container(),
                        borderRadius: BorderRadius.circular(10),
                        elevation: 1,
                        enableFeedback: true,
                        focusColor: Colors.transparent,
                        icon: Icon(Icons
                            .arrow_drop_down_outlined), // Add an arrow icon
                        iconSize: 24, // Adjust the icon size as desired
                        dropdownColor: Color.fromARGB(248, 246, 250, 251)
                            .withOpacity(0.95),
                        isDense: true,
                        items: <String>['None', 'Name', 'Price', 'Quantity']
                            .map<DropdownMenuItem<String>>(
                          (String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey
                                      .shade800, // Adjust the text size as desired
                                  decoration: TextDecoration
                                      .none, // Remove the underline
                                ),
                              ),
                            );
                          },
                        ).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            value.sortInventory(
                                newValue); // Call the sortInventory method with the selected sort option
                          }
                        },
                      ),
                    ),
                  ],
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
                    child: InventoryTile(
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
                      selectedImage: individualPlant.selectedImage,
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
