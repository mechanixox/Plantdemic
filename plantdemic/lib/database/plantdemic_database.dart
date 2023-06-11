import 'package:hive_flutter/hive_flutter.dart';

import '../models/plant.dart';

class PlantdemicDatabase {
  //reference box
  final _myBox = Hive.box("plantdemic");

  //write data
  void saveInventoryData(List<Plant> inventoryPlant) {
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
  List<Plant> readInventoryData() {
    List savedInventoryPlants = _myBox.get("INVENTORY_PLANTS") ??
        [
          Plant(
              name: 'Monstera',
              cost: '400.00',
              price: '550.00',
              quantity: '4',
              imagePath: 'assets/icons/new/monstera.jpg'),
          Plant(
              name: 'Adansonii Albo',
              cost: '600.00',
              price: '850.00',
              quantity: '1',
              imagePath: 'assets/icons/new/adansonii-albo.jpg'),
          Plant(
              name: 'Red Stardust ',
              cost: '800.00',
              price: '950.00',
              quantity: '3',
              imagePath: 'assets/icons/new/red-stardust.jpg'),
          Plant(
              name: 'Tricolor',
              cost: '799.50',
              price: '950.00',
              quantity: '4',
              imagePath: 'assets/icons/new/tricolor.jpg'),
          Plant(
              name: 'Suksom Jaipong',
              cost: '700.00',
              price: '1100.00',
              quantity: '2',
              imagePath: 'assets/icons/new/red-suksom.jpg'),
          Plant(
              name: 'Mahaseti',
              cost: '700.00',
              price: '850.00',
              quantity: '5',
              imagePath: 'assets/icons/new/mahaseti.jpg'),
          Plant(
              name: 'Mutated Pink Emerald',
              cost: '880.00',
              price: '1200.00',
              quantity: '6',
              imagePath: 'assets/icons/new/mutated-pink-emerald.jpg'),
          Plant(
              name: 'Pink Moonlight',
              cost: '1500.00',
              price: '1850.00',
              quantity: '7',
              imagePath: 'assets/icons/new/pink-moon.jpg'),
          Plant(
              name: 'Anthurium Foliage',
              cost: '3150.00',
              price: '3500.00',
              quantity: '8',
              imagePath: 'assets/icons/new/anthurium-foliage.jpg'),
          Plant(
              name: 'Peru Variegated',
              cost: '300.00',
              price: '350.00',
              quantity: '9',
              imagePath: 'assets/icons/new/peru-variegated.jpg'),
          Plant(
              name: 'Epipremnum Marble',
              cost: '400.00',
              price: '550.00',
              quantity: '10',
              imagePath: 'assets/icons/new/Epipremnum-Marble.jpg'),
          Plant(
              name: 'Tineke Rubber Tree',
              cost: '50.00',
              price: '120.00',
              quantity: '11',
              imagePath: 'assets/icons/new/tineke-rubber-tree.jpg'),
          Plant(
              name: 'Samia Fern',
              cost: '150.00',
              price: '200.00',
              quantity: '12',
              imagePath: 'assets/icons/new/Samia-fern.png'),
          Plant(
              name: 'Lucky Bird',
              cost: '150.00',
              price: '200.00',
              quantity: '12',
              imagePath: 'assets/icons/new/lucky-bird.jpg'),
        ];

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

  void saveDeliveryData(List<Plant> deliveryData) {
    List<List<dynamic>> savedDeliveryData = deliveryData.map((plant) {
      return [
        plant.name,
        plant.cost,
        plant.price,
        plant.quantity,
        plant.imagePath,
        plant.sellQuantity,
        plant.buyer,
        plant.deliveryDate,
        plant.profit,
      ];
    }).toList();

    _myBox.put("DELIVERY_PLANTS", savedDeliveryData);
  }

  List<Plant> readDeliveryData() {
    List savedDeliveryPlants = _myBox.get("DELIVERY_PLANTS") ?? [];
    List<Plant> allDeliveryPlants = [];

    for (int i = 0; i < savedDeliveryPlants.length; i++) {
      String name = savedDeliveryPlants[i][0];
      String cost = savedDeliveryPlants[i][1];
      String price = savedDeliveryPlants[i][2];
      String quantity = savedDeliveryPlants[i][3];
      String imagePath = savedDeliveryPlants[i][4];
      String sellQuantity = savedDeliveryPlants[i][5];
      String? buyer = savedDeliveryPlants[i][6];
      String? deliveryDate = savedDeliveryPlants[i][7];
      double? profit = savedDeliveryPlants[i][8];

      Plant plant = Plant(
        name: name,
        cost: cost,
        price: price,
        quantity: quantity,
        imagePath: imagePath,
        sellQuantity: sellQuantity,
        buyer: buyer,
        deliveryDate: deliveryDate,
        profit: profit,
      );
      allDeliveryPlants.add(plant);
    }
    return allDeliveryPlants;
  }
}
