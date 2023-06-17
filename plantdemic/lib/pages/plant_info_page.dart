import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:plantdemic/models/plantdemic.dart';
import 'package:plantdemic/pages/sell_info_page.dart';
import 'package:provider/provider.dart';
import 'package:page_transition/page_transition.dart';

import '../database/plantdemic_database.dart';
import '../models/plant.dart';
import '../components/plant_info_tile.dart';
import 'package:plantdemic/textfield_utility/animated_textfield.dart';

class ManagePlantPage extends StatefulWidget {
  final Plant plant;
  const ManagePlantPage({Key? key, required this.plant}) : super(key: key);

  @override
  State<ManagePlantPage> createState() => _ManagePlantPageState();
}

class _ManagePlantPageState extends State<ManagePlantPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _costController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  PlantdemicDatabase db = PlantdemicDatabase();
  List<Plant> inventoryPlants = [];
  @override
  void initState() {
    super.initState();
    fetchInventoryData();
    _nameController.text = widget.plant.name;
    _costController.text = widget.plant.cost;
    _priceController.text = widget.plant.price;
    _quantityController.text = widget.plant.quantity;
  }

  void fetchInventoryData() {
    inventoryPlants = db.readInventoryData();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _costController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void fillFields(BuildContext context, Plant plant) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 5, sigmaY: 5, tileMode: TileMode.mirror),
          child: AlertDialog(
            backgroundColor: Colors.green.shade50.withOpacity(0.90),
            contentPadding: EdgeInsets.only(bottom: 20, left: 24, right: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Empty field(s)',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Please ensure that all fields \nare filled out.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '  OK  ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void restrictName(BuildContext context, Plant plant) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 5, sigmaY: 5, tileMode: TileMode.mirror),
          child: AlertDialog(
            backgroundColor: Colors.green.shade50.withOpacity(0.90),
            contentPadding: EdgeInsets.only(bottom: 20, left: 24, right: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Invalid name',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                'Plant name already exists in your inventory. Please provide a unique one.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '  OK  ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void restrictCost(Plant plant) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 5, sigmaY: 5, tileMode: TileMode.mirror),
          child: AlertDialog(
            backgroundColor: Colors.green.shade50.withOpacity(0.90),
            contentPadding: EdgeInsets.only(bottom: 20, left: 24, right: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Invalid cost',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Please provide a valid input for cost.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '  OK  ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void restrictPrice(Plant plant) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 5, sigmaY: 5, tileMode: TileMode.mirror),
          child: AlertDialog(
            backgroundColor: Colors.green.shade50.withOpacity(0.90),
            contentPadding: EdgeInsets.only(bottom: 20, left: 24, right: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Invalid price',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Please provide a valid input for price.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '  OK  ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void restrictQuantity(Plant plant) {
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter:
              ImageFilter.blur(sigmaX: 5, sigmaY: 5, tileMode: TileMode.mirror),
          child: AlertDialog(
            backgroundColor: Colors.green.shade50.withOpacity(0.90),
            contentPadding: EdgeInsets.only(bottom: 20, left: 24, right: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Text(
              'Invalid quantity',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.grey.shade800,
              ),
            ),
            content: Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Text(
                'Please provide a valid input for quantity.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: [
              Container(
                alignment: Alignment.center,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    '  OK  ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.blue.shade700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void editPlantInfo(Plant individualPlant) {
    List<Plant> inventoryPlants =
        Provider.of<Plantdemic>(context, listen: false).inventory;
    //
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green.shade50.withOpacity(0.90),
          title: Row(
            children: [
              Icon(Icons.edit, color: Colors.grey.shade600),
              Text(
                ' Edit',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        _nameController.clear();
                        _costController.clear();
                        _priceController.clear();
                        _quantityController.clear();
                      },
                      child: Text(
                        'Clear all',
                        style:
                            TextStyle(fontSize: 15, color: Colors.red.shade300),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedTextField(
                  label: "Name",
                  suffix: Icon(
                    Icons.energy_savings_leaf_outlined,
                    size: 20,
                  ),
                  controller: _nameController,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                ),
                SizedBox(height: 10),
                AnimatedTextField(
                  label: "Cost",
                  suffix: Icon(
                    Icons.money_outlined,
                    size: 20,
                  ),
                  controller: _costController,
                  keyboardType: TextInputType.text,
                  inputAction: TextInputAction.next,
                ),
                SizedBox(height: 10),
                AnimatedTextField(
                  label: "Price",
                  suffix: Icon(
                    Icons.sell_outlined,
                    size: 20,
                  ),
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.next,
                ),
                SizedBox(height: 10),
                AnimatedTextField(
                  label: "Quantity",
                  suffix: Icon(
                    Icons.numbers_rounded,
                    size: 20,
                  ),
                  controller: _quantityController,
                  keyboardType: TextInputType.number,
                  inputAction: TextInputAction.next,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                _nameController.text = widget.plant.name;
                _costController.text = widget.plant.cost;
                _priceController.text = widget.plant.price;
                _quantityController.text = widget.plant.quantity;
                Navigator.pop(context);
              }, // Cancel
              child: Text(
                'Cancel',
                style: TextStyle(fontSize: 16, color: Colors.red.shade400),
              ),
            ),
            TextButton(
              onPressed: () {
                String newName = _nameController.text.trim();
                String newCost = _costController.text.trim();
                String newPrice = _priceController.text.trim();
                String newQuantity = _quantityController.text.trim();

                // Validate name
                if (newName == widget.plant.name &&
                    newPrice.isEmpty &&
                    newQuantity.isEmpty &&
                    newCost.isEmpty) {
                  // Name is empty or unchanged
                  fillFields(context, widget.plant);
                  return;
                } else if (newName == widget.plant.name) {
                  if (double.tryParse(newPrice) == null ||
                      double.parse(newPrice) <= 0) {
                    restrictPrice(widget.plant);
                    return;
                  }
                  if (double.tryParse(newCost) == null ||
                      double.parse(newCost) < 0) {
                    restrictCost(widget.plant);
                    return;
                  }

                  // Validate quantity
                  if (int.tryParse(newQuantity) == null ||
                      int.parse(newQuantity) <= 0) {
                    restrictQuantity(widget.plant);
                    return;
                  }
                  setState(() {
                    individualPlant.cost = newCost;
                    individualPlant.price = newPrice;
                    individualPlant.quantity = newQuantity;
                    db.saveInventoryData(inventoryPlants);
                  });
                  Provider.of<Plantdemic>(context, listen: false)
                      .notifyListeners();
                  Navigator.pop(context);
                  return;
                } else if (newName.isEmpty ||
                    newPrice.isEmpty ||
                    newQuantity.isEmpty) {
                  fillFields(context, widget.plant);
                  return;
                }

                // Check if the name already exists in the inventory
                bool plantExists =
                    Provider.of<Plantdemic>(context, listen: false)
                        .inventory
                        .any((existingPlant) =>
                            existingPlant.name.trim().toLowerCase() ==
                            newName.toLowerCase());

                if (plantExists) {
                  restrictName(context, widget.plant);
                  return;
                }
                // Validate cost
                if (double.tryParse(newCost) == null ||
                    double.parse(newCost) <= 0) {
                  restrictPrice(widget.plant);
                  return;
                }
                // Validate price
                if (double.tryParse(newPrice) == null ||
                    double.parse(newPrice) <= 0) {
                  restrictPrice(widget.plant);
                  return;
                }

                // Validate quantity
                if (int.tryParse(newQuantity) == null ||
                    int.parse(newQuantity) <= 0) {
                  restrictQuantity(widget.plant);
                  return;
                }

                // Update plant information
                setState(() {
                  individualPlant.name = newName;
                  individualPlant.cost = newCost;
                  individualPlant.price = newPrice;
                  individualPlant.quantity = newQuantity;
                });

                db.saveInventoryData(inventoryPlants);

                Provider.of<Plantdemic>(context, listen: false)
                    .notifyListeners();
                Navigator.pop(context);
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.blue.shade600),
              ),
            ),
          ],
        );
      },
    );
  }

  void navigateToSellInfoPage() {
    Plant sellPlant = Plant(
      name: widget.plant.name,
      cost: widget.plant.cost,
      price: widget.plant.price,
      quantity: widget.plant.quantity,
      imagePath: widget.plant.imagePath,
    );

    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.rightToLeft,
        child: SellInfoPage(plant: sellPlant),
        curve: Curves.easeInOutExpo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Plantdemic>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              'Plant information',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          centerTitle: true,
          backgroundColor: Color.fromARGB(255, 236, 241, 236),
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, top: 10),
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Colors.grey.shade600,
              ),
            ),
          ),
        ),
        backgroundColor: Color.fromARGB(255, 236, 241, 236),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromARGB(255, 236, 241, 236),
                Color.fromRGBO(235, 237, 238, 1),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 25, bottom: 100),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.center,
                        height: 256,
                        width: 256,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color.fromARGB(255, 255, 255, 255),
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(255, 191, 191, 191),
                                offset: Offset(2.0, 2.0),
                                blurRadius: 10,
                                spreadRadius: 0,
                              ),
                              BoxShadow(
                                color: Color.fromARGB(255, 255, 255, 255),
                                offset: Offset(-4.0, -4.0),
                                blurRadius: 20,
                                spreadRadius: 3,
                              ),
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Image.asset(
                              widget.plant.imagePath,
                              width: 200, // Adjust the width of the image
                              height: 200, // Adjust the height of the image
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 20),
                      //
                      // plant information tile
                      //
                      PlantInfoTile(
                        plant: widget.plant,
                        editTapped: (context) => editPlantInfo(widget.plant),
                      ),
                      //
                      // sell plant -> button
                      //
                      const SizedBox(height: 55), // space
                      Padding(
                        padding: const EdgeInsets.only(left: 90.0, right: 90),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: Stack(
                            children: <Widget>[
                              Positioned.fill(
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.green.shade400,
                                      width: 1.5,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                              ),
                              TextButton(
                                style: TextButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.green.shade500,
                                  padding: const EdgeInsets.only(
                                    top: 15,
                                    bottom: 15,
                                    left: 5,
                                    right: 5,
                                  ),
                                  textStyle: const TextStyle(fontSize: 16),
                                ),
                                onPressed: () => navigateToSellInfoPage(),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text(' Sell plant   ',
                                        style: TextStyle(fontSize: 18)),
                                    Icon(Icons.arrow_forward),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
