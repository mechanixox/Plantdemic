import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/plantdemic_database.dart';

import 'plant.dart';
import 'package:plantdemic/models/profit_item.dart';
import 'package:plantdemic/components/date_time_helper.dart';

class Plantdemic extends ChangeNotifier {
  final db = PlantdemicDatabase();
  void prepareData() {
    if (db.readInventoryData().isNotEmpty) {
      _inventory = db.readInventoryData();
      _delivery = db.readDeliveryData();
      _records = db.readRecordsTileData();
      overallProfitList = db.readRecordsData();
      //db.resetProfitList();
      //overallProfitList = [];
    }
  }

  void resetProfitList() {
    db.resetProfitList();
    overallProfitList = [];
    notifyListeners();
  }

  //list of plants available
  List<Plant> _inventory = [
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
  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  //get plants
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
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(left: 25.0, top: 10, right: 20),
              child: Text(
                'The plant "$newPlantName" is already present in your inventory.',
                textAlign: TextAlign.center,
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
                    'OK',
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
      Provider.of<Plantdemic>(context, listen: false)
          .addPlantToInventorySorted(plant, addToTop: true);
    }
    db.saveInventoryData(_inventory);
  }

  void removeFromInventory(Plant plant) {
    _inventory.remove(plant);
    notifyListeners();
    db.saveInventoryData(_inventory);
  }

  void addPlantToInventorySorted(Plant newPlant, {bool addToTop = false}) {
    if (addToTop) {
      _inventory.insert(0, newPlant); // Add at the beginning of the list
    } else {
      _inventory.add(newPlant);
      sortInventory(
          sortOption); // Sort the inventory based on the current sort option
    }
    notifyListeners();
    db.saveInventoryData(_inventory);
  }

//unused method
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
                    'OK',
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
    db.saveInventoryData(_inventory);
  }

  List<Plant> searchResults = [];

  void searchPlants(String query) {
    String lowercaseQuery = query.toLowerCase();
    searchResults = _inventory
        .where((plant) => plant.name.toLowerCase().contains(lowercaseQuery))
        .toList();
    notifyListeners();
  }

  String _sortOption = 'Default';
  String get sortOption => _sortOption;

  void sortInventory(String sortOption) {
    _sortOption = sortOption;
    if (sortOption == 'Default') {
      notifyListeners();
      return;
    }

    _inventory.sort((a, b) {
      switch (sortOption) {
        case 'Name':
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        case 'Price':
          final double priceA = double.tryParse(a.price) ?? 0;
          final double priceB = double.tryParse(b.price) ?? 0;
          return priceA.compareTo(priceB);
        case 'Quantity':
          final int quantityA = int.tryParse(a.quantity) ?? 0;
          final int quantityB = int.tryParse(b.quantity) ?? 0;
          return quantityA.compareTo(quantityB);
        default:
          return 0;
      }
    });

    notifyListeners();
    db.saveInventoryData(_inventory);
  }

  //list of plants in delivery page
  List<Plant> _delivery = [];

  //get to deliver plants
  List<Plant> get delivery => _delivery;

  //add plant to delivery
  void addToDelivery(Plant plant) {
    _delivery.add(plant);
    notifyListeners();
    db.saveDeliveryData(_delivery);
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
      sortInventory(
          sortOption); // Sort the inventory based on the current sort option
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
      sortInventory(
          sortOption); // Sort the inventory based on the current sort option
      notifyListeners();
    }
    db.saveInventoryData(_inventory);
    db.saveDeliveryData(_delivery);
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
      } else {
        removeFromInventory(_inventory[selectedPlantIndex]);
        notifyListeners();
      }
    }
    db.saveInventoryData(_inventory);
  }

  void removeFromDeliveryToRecords(Plant plant) {
    _delivery.remove(plant);
    notifyListeners();
    db.saveDeliveryData(_delivery);
  }

  List<Plant> _records = [];

  //get to deliver plants
  List<Plant> get records => _records;

  //add plant to delivery
  void addToRecords(Plant plant, double profit) {
    plant.profit = profit;
    _records.add(plant);
    notifyListeners();
    db.saveRecordsData(overallProfitList);
    db.saveRecordsTileData(_records);
  }

  void subtractPlantProfitRecords(Plant plant) {
    final plantIndex =
        overallProfitList.lastIndexWhere((profit) => profit.name == plant.name);

    if (plantIndex != -1) {
      overallProfitList.removeAt(plantIndex);
      notifyListeners();
      db.saveRecordsData(overallProfitList);
    }
  }

  void removeRecordsDialog(BuildContext context, Plant plant) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.green.shade50.withOpacity(0.90),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          contentPadding:
              EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
          content: Stack(
            children: [
              Positioned(
                top: -7,
                right: 0,
                child: IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: 40, left: 0, bottom: 10, right: 0),
                    child: Text(
                      'Remove record',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.grey.shade800,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Do you want to move the plant back to the delivery or only remove from records?',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          child: Text(
                            'Remove',
                            style: TextStyle(
                                fontSize: 16, color: Colors.red.shade400),
                          ),
                          onPressed: () {
                            // User chose not to move the plant to delivery
                            removePlantFromRecords(plant);
                            Navigator.of(context).pop();
                          },
                        ),
                        SizedBox(width: 5),
                        TextButton(
                          child: Text(
                            'Move',
                            style: TextStyle(
                                fontSize: 16, color: Colors.blue.shade600),
                          ),
                          onPressed: () {
                            // User chose to move the plant to delivery
                            movePlantToDelivery(plant);
                            Navigator.of(context).pop();
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void removePlantFromRecords(Plant plant) {
    _records.remove(plant);
    subtractPlantProfitRecords(plant);
    notifyListeners();

    db.saveRecordsTileData(_records);
  }

  void movePlantToDelivery(Plant plant) {
    _records.remove(plant);
    subtractPlantProfitRecords(plant);

    Plant existingPlant = Plant(
      name: plant.name,
      cost: plant.cost,
      price: plant.price,
      quantity: plant.quantity,
      buyer: plant.buyer ?? '',
      sellQuantity: plant.sellQuantity ?? '',
      deliveryDate: plant.deliveryDate ?? '',
      imagePath: plant.imagePath,
    );

    //int currentQuantity = int.tryParse(existingPlant.quantity) ?? 0;
    int recordsQuantity = int.tryParse(plant.sellQuantity ?? '') ?? 0;
    int newQuantity = recordsQuantity;

    existingPlant.sellQuantity = newQuantity.toString();
    _delivery.add(existingPlant);

    notifyListeners();

    db.saveRecordsTileData(_records);
    db.saveDeliveryData(_delivery);
  }

  List<ProfitItem> overallProfitList = [];

  List<ProfitItem> getAllProfitList() {
    return overallProfitList;
  }

  void addNewProfit(ProfitItem newProfit) {
    overallProfitList.add(newProfit);
    notifyListeners();
    db.saveRecordsData(overallProfitList);
  }

  void deleteProfit(ProfitItem profit) {
    overallProfitList.remove(profit);
    notifyListeners();
    db.saveRecordsData(overallProfitList);
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
