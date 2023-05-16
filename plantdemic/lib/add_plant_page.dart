import 'package:flutter/material.dart';
import '../classes/plant.dart';

class AddPlantPage extends StatefulWidget {
  final Plant plant;
  const AddPlantPage({super.key, required this.plant});

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  // Create TextEditingController for text input fields
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the text editing controllers when the widget is disposed
    nameController.dispose();
    priceController.dispose();
    quantityController.dispose();
    super.dispose();
  }

  void addToInventory() {
    String name = nameController.text;
    String price = priceController.text;
    String quantity = quantityController.text;
    String imagePath =
        'assets/icons/plant.png'; // Use the default image path or update it based on your requirement

    // Create a new Plant object with the entered values
    Plant newPlant = Plant(
      name: name,
      price: price,
      quantity: quantity,
      imagePath: imagePath,
    );

    // Pass the new plant back to the previous screen
    Navigator.pop(context, newPlant);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Plant'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(labelText: 'Price'),
            ),
            TextField(
              controller: quantityController,
              decoration: InputDecoration(labelText: 'Quantity'),
            ),
            ElevatedButton(
              onPressed: () => addToInventory(),
              child: Text('Done'),
            ),
          ],
        ),
      ),
    );
  }
}
