import 'dart:async';
import 'package:flutter/material.dart';
import 'package:plantdemic/classes/inventory.dart';
import 'package:provider/provider.dart';

import '../classes/plant.dart';
import '../components/plant_info_tile.dart';
import 'package:plantdemic/textfield_utility/animated_textfield.dart';

class ManagePlantPage extends StatefulWidget {
  final Plant plant;
  const ManagePlantPage({Key? key, required this.plant}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ManagePlantPageState createState() => _ManagePlantPageState();
}

class _ManagePlantPageState extends State<ManagePlantPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.plant.name;
    _priceController.text = widget.plant.price;
    _quantityController.text = widget.plant.quantity;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  void addToDelivery() {
    Provider.of<PlantdemicInventory>(context, listen: false)
        .addToDelivery(widget.plant);
    widget.plant.decrementQuantity();

    Navigator.pop(context);
    showDialog(
      context: context,
      builder: (context) {
        Timer(Duration(seconds: 1), () {
          Navigator.of(context).pop();
        });
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 255, 255, 255).withOpacity(0.90),
          title: Column(
            children: [
              SizedBox(height: 5),
              Icon(Icons.check_circle, size: 80, color: Colors.green),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Text(
                  'Added successfully!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(106, 136, 86, 1),
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
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.green.shade50.withOpacity(0.90),
          title: Row(
            children: [
              Text(
                'Edit Plant',
                style: TextStyle(
                  color: Colors.green.shade800,
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
                        _priceController.clear();
                        _quantityController.clear();
                      },
                      child: Text(
                        'Clear all',
                        style:
                            TextStyle(fontSize: 14, color: Colors.red.shade400),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AnimatedTextField(
                label: "Name",
                suffix: null,
                controller: _nameController,
                keyboardType: TextInputType.text,
              ),
              SizedBox(height: 10),
              AnimatedTextField(
                label: "Price",
                suffix: null,
                controller: _priceController,
                keyboardType: TextInputType.number,
              ),
              SizedBox(height: 10),
              AnimatedTextField(
                label: "Quantity",
                suffix: null,
                controller: _quantityController,
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _nameController.text = widget.plant.name;
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
                setState(() {
                  individualPlant.name = _nameController.text;
                  individualPlant.price = _priceController.text;
                  individualPlant.quantity = _quantityController.text;
                });
                Provider.of<PlantdemicInventory>(context, listen: false)
                    .notifyListeners(); // Notify listeners of the changes
                Navigator.pop(context); // Done
              },
              child: Text(
                'Save',
                style: TextStyle(fontSize: 16, color: Colors.blue.shade400),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PlantdemicInventory>(
      builder: (context, value, child) => Scaffold(
        backgroundColor: Color.fromARGB(255, 216, 248, 216),
        appBar: AppBar(
          title: Text(
            widget.plant.name,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          centerTitle: true, // Add this line to center-align the title
          backgroundColor: Color.fromARGB(255, 216, 248, 216),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset(
                    widget.plant.imagePath,
                    width: 200,
                    height: 200,
                  ),
                  const SizedBox(height: 10),
                  PlantInfoTile(
                    plant: widget.plant,
                    editTapped: (context) => editPlantInfo(widget.plant),
                  ),
                  const SizedBox(height: 60),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Stack(
                      children: <Widget>[
                        Positioned.fill(
                          child: Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: <Color>[
                                  Color.fromRGBO(127, 159, 88, 1),
                                  Color.fromRGBO(145, 177, 106, 1),
                                  Color.fromRGBO(157, 189, 117, 1),
                                ],
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.all(15),
                            textStyle: const TextStyle(fontSize: 16),
                          ),
                          onPressed: () => addToDelivery(),
                          child: const Text('         Sell         '),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
