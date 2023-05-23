import 'package:flutter/material.dart';

import 'plant.dart';

class PlantdemicInventory extends ChangeNotifier {
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
        cost: '232.00',
        price: '25.50',
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

  /*final List<Plant> _intoInventory = [];
  List<Plant> get intoInventory => _intoInventory;*/

  void addToInventory(Plant plant) {
    _inventory.add(plant);
    notifyListeners();
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
  }

  void decrementQuantity(int quantity) {
    for (var plant in _inventory) {
      int currentQuantity = int.tryParse(plant.quantity) ?? 0;
      int newQuantity = currentQuantity - quantity;
      plant.quantity = newQuantity.toString();
    }
    notifyListeners();
  }
}
