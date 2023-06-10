import 'package:hive_flutter/hive_flutter.dart';

import '../models/plant.dart';

class HiveDatabase {
  //reference box
  final _myBox = Hive.box("plantdemic");

  //write data
  void saveData(List<Plant> inventoryPlant) {
    List<List<dynamic>> allInventoryPlantsFormatted = [];

    for (var dbPlant in inventoryPlant) {
      List<dynamic> inventoryFormatted = [
        dbPlant.name,
        dbPlant.cost,
        dbPlant.price,
        dbPlant.quantity,
        dbPlant.imagePath,
        dbPlant.sellQuantity,
        dbPlant.buyer,
        dbPlant.deliveryDate,
        dbPlant.profit,
      ];
      allInventoryPlantsFormatted.add(inventoryFormatted);
    }
    _myBox.put("INVENTORY_PLANTS", allInventoryPlantsFormatted);
  }

  //read data\
  List<Plant> readData() {
    List savedInventoryPlants = _myBox.get("INVENTORY_PLANTS") ?? [];

    List<Plant> allInventoryPlants = [];

    for (int i = 0; i < savedInventoryPlants.length; i++) {
      String name = savedInventoryPlants[i][0];
      String cost = savedInventoryPlants[i][1];
      String price = savedInventoryPlants[i][2];
      String quantity = savedInventoryPlants[i][3];
      String imagePath = savedInventoryPlants[i][4];
      //String? sellQuantity = savedInventoryPlants[i][5];
      //String? buyer = savedInventoryPlants[i][6];
      //String? deliveryDate = savedInventoryPlants[i][7];
      //double? profit = savedInventoryPlants[i][8];

      Plant plant = Plant(
        name: name,
        cost: cost,
        price: price,
        quantity: quantity,
        imagePath: imagePath,
      );
      allInventoryPlants.add(plant);
    }
    return allInventoryPlants;
  }
}
