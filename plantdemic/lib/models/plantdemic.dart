import 'package:flutter/material.dart';

import 'plant.dart';
import 'package:plantdemic/models/profit_item.dart';
import 'package:plantdemic/components/date_time_helper.dart';

class Plantdemic extends ChangeNotifier {
  //list of plants available
  final List<Plant> _inventory = [
    //Cactus
    Plant(
        name: 'Cactus',
        cost: '50.00',
        price: '70.90',
        quantity: '6',
        imagePath: 'assets/icons/cactus.png'),
    //Caladium
    Plant(
        name: 'Caladium',
        cost: '50.00',
        price: '150.00',
        quantity: '2',
        imagePath: 'assets/icons/caladium.png'),
    //Monstera
    Plant(
        name: 'Monstera',
        cost: '50.00',
        price: '300.00',
        quantity: '3',
        imagePath: 'assets/icons/monstera.png'),

    //Rosemary
    Plant(
        name: 'Rosemary',
        cost: '20.00',
        price: '60.00',
        quantity: '8',
        imagePath: 'assets/icons/rosemary.png'),
    //Sunflower
    Plant(
        name: 'Sunflower',
        cost: '50.00',
        price: '54.95',
        quantity: '4',
        imagePath: 'assets/icons/sunflower.png'),
    Plant(
        name: 'Tanom',
        cost: '50.00',
        price: '124.95',
        quantity: '4',
        imagePath: 'assets/icons/plant.png'),
  ];
  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  //get plants for sale
  List<Plant> get inventory => _inventory;

  void addToInventory(BuildContext context, Plant plant) {
    String newPlantName = plant.name.trim().toLowerCase();

    // Check if a plant with the same name already exists
    bool plantExists = _inventory.any(
      (existingPlant) =>
          existingPlant.name.trim().toLowerCase() == newPlantName,
    );

    if (plantExists) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green.shade50.withOpacity(0.90),
            contentPadding: EdgeInsets.only(
                bottom: 20), // Remove the default content padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Plant exists',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'A plant with the same name already exists in the inventory.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text(
                    'Got it',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      _inventory.add(plant);
      notifyListeners();
    }
  }

  void updatePlantInfo(BuildContext context, Plant plant) {
    String newPlantName = plant.name.trim().toLowerCase();

    // Check if a plant with the same name already exists
    bool plantExists = _inventory.any(
      (existingPlant) =>
          existingPlant.name.trim().toLowerCase() == newPlantName,
    );

    if (plantExists) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.green.shade50.withOpacity(0.90),
            contentPadding: EdgeInsets.only(
                bottom: 20), // Remove the default content padding
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Plant exists',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 25.0),
              child: Text(
                'A plant with the same name already exists in the inventory.',
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text(
                    'Got it!',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
    } else {
      _inventory.add(plant);
      notifyListeners();
    }
  }

  void removeFromInventory(Plant plant) {
    _inventory.remove(plant);
    notifyListeners();
  }

  //list of plants in delivery page
  final List<Plant> _delivery = [];

  //get to deliver plants
  List<Plant> get delivery => _delivery;

  //add plant to delivery
  void addToDelivery(Plant plant) {
    _delivery.add(plant);
    notifyListeners();
  }

  //remove plant from delivery
  void removeFromDelivery(Plant plant) {
    _delivery.remove(plant);
    notifyListeners();

    final selectedPlantIndex =
        _inventory.indexWhere((p) => p.name == plant.name);
    if (selectedPlantIndex != -1) {
      int currentQuantity =
          int.tryParse(_inventory[selectedPlantIndex].quantity) ?? 0;
      int deliveryQuantity = int.tryParse(plant.sellQuantity ?? '') ?? 0;
      int newQuantity = currentQuantity + deliveryQuantity;

      _inventory[selectedPlantIndex].quantity = newQuantity.toString();
      notifyListeners();
    } else {
      Plant newPlant = Plant(
        name: plant.name,
        cost: plant.cost,
        price: plant.price,
        quantity: plant.sellQuantity ?? '',
        imagePath: plant.imagePath,
      );
      _inventory.add(newPlant);
      notifyListeners();
    }
  }

  void removeFromDeliveryToRecords(Plant plant) {
    _delivery.remove(plant);
    notifyListeners();
  }

  final List<Plant> _records = [];

  //get to deliver plants
  List<Plant> get records => _records;

  //add plant to delivery
  void addToRecords(Plant plant, double profit) {
    plant.profit = profit;
    _records.add(plant);
    notifyListeners();
  }

  void removeFromRecords(Plant plant) {
    _records.remove(plant);
    notifyListeners();
  }

  void decrementQuantity(Plant plant, int quantity) {
    final selectedPlantIndex =
        _inventory.indexWhere((p) => p.name == plant.name);

    if (selectedPlantIndex != -1) {
      int currentQuantity =
          int.tryParse(_inventory[selectedPlantIndex].quantity) ?? 0;
      int newQuantity = currentQuantity - quantity;

      if (newQuantity > 0) {
        _inventory[selectedPlantIndex].quantity = newQuantity.toString();
        notifyListeners();
      } else {
        removeFromInventory(_inventory[selectedPlantIndex]);
        notifyListeners();
      }
    }
  }

  List<ProfitItem> overallProfitList = [];

  List<ProfitItem> getAllProfitList() {
    return overallProfitList;
  }

  void addNewProfit(ProfitItem newProfit) {
    overallProfitList.add(newProfit);
  }

  void deleteProfit(ProfitItem profit) {
    overallProfitList.remove(profit);
  }

  String getDayName(DateTime dateTime) {
    switch (dateTime.weekday) {
      case 1:
        return 'Mon';
      case 2:
        return 'Tue';
      case 3:
        return 'Wed';
      case 4:
        return 'Thu';
      case 5:
        return 'Fri';
      case 6:
        return 'Sat';
      case 7:
        return 'Sun';
      default:
        return '';
    }
  }

  DateTime startOfWeekDate() {
    DateTime? startOfWeek;
    DateTime today = DateTime.now();

    for (int i = 0; i < 7; i++) {
      if (getDayName(today.subtract(Duration(days: i))) == 'Sun') {
        startOfWeek = today.subtract(Duration(days: i));
      }
    }

    return startOfWeek!;
  }

  Map<String, double> calculateDailyProfitSummary() {
    Map<String, double> dailyProfitSummary = {};

    for (var profit in overallProfitList) {
      String date = convertDateTimeToString(profit.date);
      double amount = double.parse(profit.profitAmount);

      if (dailyProfitSummary.containsKey(date)) {
        double currentAmount = dailyProfitSummary[date]!;
        currentAmount += amount;
        dailyProfitSummary[date] = currentAmount;
      } else {
        dailyProfitSummary.addAll({date: amount});
      }
    }
    return dailyProfitSummary;
  }
}
